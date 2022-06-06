﻿/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see http://www.gnu.org/licenses/

  This file is part of DarkStar-server source code.

===========================================================================
*/

#include "mobentity.h"

#include <string.h>
#include "../../common/timer.h"
#include "../../common/utils.h"
#include "../ai/ai_container.h"
#include "../ai/controllers/mob_controller.h"
#include "../ai/controllers/player_controller.h"
#include "../ai/helpers/pathfind.h"
#include "../ai/helpers/targetfind.h"
#include "../ai/states/attack_state.h"
#include "../ai/states/weaponskill_state.h"
#include "../ai/states/mobskill_state.h"
#include "../entities/charentity.h"
#include "../packets/action.h"
#include "../packets/entity_update.h"
#include "../packets/pet_sync.h"
#include "../utils/battleutils.h"
#include "../utils/blueutils.h"
#include "../utils/charutils.h"
#include "../utils/itemutils.h"
#include "../utils/mobutils.h"
#include "../utils/petutils.h"
#include "../status_effect_container.h"
#include "../enmity_container.h"
#include "../mob_spell_container.h"
#include "../mob_spell_list.h"
#include "../mob_modifier.h"
#include "../weapon_skill.h"
#include "../mobskill.h"
#include "../roe.h"
#include "../treasure_pool.h"
#include "../conquest_system.h"
#include "../utils/zoneutils.h"

CMobEntity::CMobEntity()
{
    objtype = TYPE_MOB;

    m_DropID = 0;

    m_minLevel = 1;
    m_maxLevel = 1;

    HPscale = 1.0;
    MPscale = 1.0;
    m_flags = 0;

    allegiance = ALLEGIANCE_MOB;

    // default to normal roaming
    m_roamFlags = ROAMFLAG_NONE;
    m_specialFlags = SPECIALFLAG_NONE;
    m_name_prefix = 0;
    m_MobSkillList = 0;

    m_AllowRespawn = 0;
    m_DropItemTime = 0;
    m_Family = 0;
    m_Type = MOBTYPE_NORMAL;
    m_Behaviour = BEHAVIOUR_NONE;
    m_SpawnType = SPAWNTYPE_NORMAL;
    m_EcoSystem = SYSTEM_UNCLASSIFIED;
    m_Element = 0;
    m_HiPCLvl = 0;
    m_HiPartySize = 0;
    m_THLvl = 0;
    m_ItemStolen = false;
    m_autoTargetReady = true;
    m_autoTargetKiller = nullptr;


    strRank = 3;
    vitRank = 3;
    agiRank = 3;
    intRank = 3;
    mndRank = 3;
    chrRank = 3;
    attRank = 3;
    defRank = 3;
    accRank = 3;
    evaRank = 3;

    m_dmgMult = 100;

    m_giveExp = false;
    m_neutral = false;
    m_Aggro = false;
    m_TrueDetection = false;
    m_Detects = DETECT_NONE;
    m_Link = 0;

    m_battlefieldID = 0;
    m_bcnmID = 0;

    m_maxRoamDistance = 50.0f;
    m_disableScent = false;

    memset(&m_SpawnPoint, 0, sizeof(m_SpawnPoint));

    m_SpellListContainer = nullptr;
    PEnmityContainer = new CEnmityContainer(this);
    SpellContainer = new CMobSpellContainer(this);

    // For Dyna Stats
    m_StatPoppedMobs = false;

    PAI = std::make_unique<CAIContainer>(this, std::make_unique<CPathFind>(this), std::make_unique<CMobController>(this),
        std::make_unique<CTargetFind>(this));
}

uint32 CMobEntity::getEntityFlags()
{
    return m_flags;
}

void CMobEntity::setEntityFlags(uint32 EntityFlags)
{
    m_flags = EntityFlags;
}

CMobEntity::~CMobEntity()
{
    delete PEnmityContainer;
    delete SpellContainer;
}

/************************************************************************
*                                                                       *
*  Время исчезновения монстра в секундах                                *
*                                                                       *
************************************************************************/

time_point CMobEntity::GetDespawnTime()
{
    return m_DespawnTimer;
}

void CMobEntity::SetDespawnTime(duration _duration)
{
    if (_duration > 0s)
    {
        m_DespawnTimer = server_clock::now() + _duration;
    }
    else
    {
        m_DespawnTimer = time_point::min();
    }
}

uint32 CMobEntity::GetRandomGil()
{

    int16 min = getMobMod(MOBMOD_GIL_MIN);
    int16 max = getMobMod(MOBMOD_GIL_MAX);

    if (min && max)
    {
        // make sure divide won't crash server
        if (max <= min)
        {
            max = min + 2;
        }

        if (max - min < 2)
        {
            max = min + 2;
            ShowWarning("CMobEntity::GetRandomGil Max value is set too low, defauting\n");
        }

        return tpzrand::GetRandomNumber(min, max);
    }

    float gil = (float)pow(GetMLevel(), 1.05f);

    if (gil < 1) {
        gil = 1;
    }

    uint16 highGil = (uint16)(gil / 3 + 4);

    if (max)
    {
        highGil = max;
    }

    if (highGil < 2) {
        highGil = 2;
    }

    // randomize it
    gil += tpzrand::GetRandomNumber(highGil);

    if (min && gil < min)
    {
        gil = min;
    }

    if (getMobMod(MOBMOD_GIL_BONUS) != 0)
    {
        gil *= (getMobMod(MOBMOD_GIL_BONUS) / 100.0f);
    }

    return (uint32)gil;
}

bool CMobEntity::CanDropGil()
{
    // smaller than 0 means drop no gil
    if (getMobMod(MOBMOD_GIL_MAX) < 0) return false;

    if (getMobMod(MOBMOD_GIL_MIN) > 0 || getMobMod(MOBMOD_GIL_MAX))
    {
        return true;
    }

    return getMobMod(MOBMOD_GIL_BONUS) > 0;
}

bool CMobEntity::CanStealGil()
{
    // TODO: Some mobs cannot be mugged
    return CanDropGil();
}

void CMobEntity::ResetGilPurse()
{
    uint32 purse = GetRandomGil() / ((tpzrand::GetRandomNumber(4, 7)));
    if (purse == 0)
        purse = GetRandomGil();
    setMobMod(MOBMOD_MUG_GIL, purse);
}

bool CMobEntity::CanRoamHome()
{
    if ((speed == 0 && !(m_roamFlags & ROAMFLAG_WORM)) || getMobMod(MOBMOD_NO_MOVE) > 0) return false;

    if (getMobMod(MOBMOD_NO_DESPAWN) != 0 ||
        map_config.mob_no_despawn)
    {
        return true;
    }

    return distance(m_SpawnPoint, loc.p) < roam_home_distance;
}

bool CMobEntity::CanRoam()
{
    return !(m_roamFlags & ROAMFLAG_EVENT) && PMaster == nullptr && (speed > 0 || (m_roamFlags & ROAMFLAG_WORM)) && getMobMod(MOBMOD_NO_MOVE) == 0;
}

bool CMobEntity::CanLink(position_t* pos, int16 superLink)
{
    // handle super linking
    if (superLink && getMobMod(MOBMOD_SUPERLINK) == superLink)
    {
        return true;
    }

    // can't link right now
    if (m_neutral)
    {
        return false;
    }

    // Don't link I'm an underground worm
    if ((m_roamFlags & ROAMFLAG_WORM) && IsNameHidden())
    {
        return false;
    }

    // Don't link I'm an underground antlion
    if ((m_roamFlags & ROAMFLAG_AMBUSH) && IsNameHidden())
    {
        return false;
    }

    // link only if I see him
    if (m_Detects & DETECT_SIGHT) {

        if (!facing(loc.p, *pos, 64))
        {
            return false;
        }
    }

    if (distance(loc.p, *pos) > getMobMod(MOBMOD_LINK_RADIUS))
    {
        return false;
    }

    if (getMobMod(MOBMOD_NO_LINK) > 0)
    {
        return false;
    }

    if (!PAI->PathFind->CanSeePoint(*pos))
    {
        return false;
    }
    return true;
}

/************************************************************************
*                                                                       *
*                                                                       *
*                                                                       *
************************************************************************/

bool CMobEntity::CanDeaggro()
{
    return !(m_Type & MOBTYPE_NOTORIOUS || m_Type & MOBTYPE_BATTLEFIELD);
}

bool CMobEntity::IsFarFromHome()
{
    return distance(loc.p, m_SpawnPoint) > m_maxRoamDistance;
}

bool CMobEntity::CanBeNeutral()
{
    return !(m_Type & MOBTYPE_NOTORIOUS);
}

uint16 CMobEntity::TPUseChance()
{
    auto& MobSkillList = battleutils::GetMobSkillList(getMobMod(MOBMOD_SKILL_LIST));
    if (StatusEffectContainer->HasStatusEffect(EFFECT_MEIKYO_SHISUI) && health.tp >= 1000)
    {
        return 10000;
    }
    else
    {
        if (health.tp < 1000 || MobSkillList.empty() || !static_cast<CMobController*>(PAI->GetController())->IsWeaponSkillEnabled())
        {
            return 0;
        }

        if (health.tp == 3000 || (GetHPP() <= 25 && health.tp >= 1000))
        {
            return 10000;
        }
        else if (health.tp > 1999)
        {
            return 45;
        }
        else
        {
            return 20;
        }
    }

    return (uint16)getMobMod(MOBMOD_TP_USE_CHANCE);
}

void CMobEntity::setMobMod(uint16 type, int16 value)
{
    m_mobModStat[type] = value;
}

int16 CMobEntity::getMobMod(uint16 type)
{
    return m_mobModStat[type];
}

void CMobEntity::addMobMod(uint16 type, int16 value)
{
    m_mobModStat[type] += value;
}

void CMobEntity::defaultMobMod(uint16 type, int16 value)
{
    if (m_mobModStat[type] == 0)
    {
        m_mobModStat[type] = value;
    }
}

void CMobEntity::resetMobMod(uint16 type)
{
    m_mobModStat[type] = m_mobModStatSave[type];
}

int32 CMobEntity::getBigMobMod(uint16 type)
{
    return getMobMod(type) * 1000;
}

void CMobEntity::saveMobModifiers()
{
    m_mobModStatSave = m_mobModStat;
}

void CMobEntity::restoreMobModifiers()
{
    m_mobModStat = m_mobModStatSave;
}

void CMobEntity::HideHP(bool hide)
{
    if (hide)
    {
        m_flags |= FLAG_HIDE_HP;
    }
    else
    {
        m_flags &= ~FLAG_HIDE_HP;
    }
    updatemask |= UPDATE_HP;
}

bool CMobEntity::IsHPHidden()
{
    return m_flags & FLAG_HIDE_HP;
}


void CMobEntity::CallForHelp(bool call)
{
    if (call)
    {
        m_flags |= FLAG_CALL_FOR_HELP;
        m_OwnerID.clean();
    }
    else
    {
        m_flags &= ~FLAG_CALL_FOR_HELP;
    }
    updatemask |= UPDATE_COMBAT;
}

bool CMobEntity::CalledForHelp()
{
    return m_flags & FLAG_CALL_FOR_HELP;
}

void CMobEntity::Untargetable(bool untargetable)
{
    if (untargetable)
    {
        m_flags |= FLAG_UNTARGETABLE;
    }
    else
    {
        m_flags &= ~FLAG_UNTARGETABLE;
    }
    updatemask |= UPDATE_HP;
}

bool CMobEntity::IsUntargetable()
{
    return m_flags & FLAG_UNTARGETABLE;
}

void CMobEntity::DoAutoTarget()
{
    if (!m_autoTargetReady)
        return;
    m_autoTargetReady = false;

    // logic walk-thru:
    // check each alliance-member of mob claimer if they were engaged with this mob when it died
    // person who landed the final blow designates a new target for the alliance (closest mob to that person)
    // which is a mob that is trying to attack a player and can be attacked by the alliance (white or red name mob)
    // this way, when auto-target triggers, the entire alliance/party will always engage on the same mob together
    // it is no longer a requirement for players to face towards a mob in order to auto-target it

    CCharEntity* POwner = nullptr;
    if (this->m_autoTargetKiller)
        POwner = m_autoTargetKiller;
    else if (this->m_OwnerID.id)
        POwner = zoneutils::GetChar(m_OwnerID.id);
    if (!POwner)
        return;
    CZone* PZone = zoneutils::GetZone(POwner->getZone());
    if (!PZone)
        return;

    if (PZone->GetType() != ZONETYPE_DYNAMIS)
    {
        POwner->ForAlliance(
            [](CBattleEntity* PMemberBE)
            {
                if (PMemberBE && PMemberBE->objtype == TYPE_PC)
                    ((CCharEntity*)PMemberBE)->m_autoTargetOverride = nullptr;
            });

        POwner->ForAlliance(
            [this, POwner](CBattleEntity* PMemberBE)
            {
                bool success = false;

                if (PMemberBE && PMemberBE->objtype == TYPE_PC && PMemberBE->loc.zone->GetID() == this->loc.zone->GetID() &&
                    ((CCharEntity*)PMemberBE)->m_LastEngagedTargID == this->targid && ((CCharEntity*)PMemberBE)->m_hasAutoTarget)
                {
                    CCharEntity* PMember = (CCharEntity*)PMemberBE;
                    std::unique_ptr<CBasicPacket> errMsg;
                    if (PMember->m_autoTargetOverride)
                    {
                        if (PMember->m_autoTargetOverride->allegiance == ALLEGIANCE_MOB && PMember->IsMobOwner(PMember->m_autoTargetOverride) &&
                            !((CBattleEntity*)(PMember->m_autoTargetOverride)->IsNameHidden()) &&
                            distanceSquared(PMember->loc.p, PMember->m_autoTargetOverride->loc.p) < 29.0f * 29.0f)
                        {
                            auto controller{ static_cast<CPlayerController*>(PMember->PAI->GetController()) };
                            success = controller->ChangeTarget(PMember->m_autoTargetOverride->targid);
                        }
                    }
                    else
                    {
                        auto controller{ static_cast<CPlayerController*>(PMember->PAI->GetController()) };
                        CMobEntity* PWinner = nullptr;
                        for (auto&& PPotentialTarget : PMember->SpawnMOBList)
                        {
                            CBattleEntity* PMob = (CBattleEntity*)PPotentialTarget.second;
                            CBattleEntity* PMobTarget = (CBattleEntity*)(PMob->GetEntity(PMob->GetBattleTargetID()));

                            if ((PMob->objtype == TYPE_MOB || PMob->objtype == TYPE_PET) && PMob->animation == ANIMATION_ATTACK &&
                                PMob->allegiance == ALLEGIANCE_MOB && PMember->IsMobOwner(PMob) && !PMob->IsNameHidden() && PMob->id != this->id &&
                                distanceSquared(PMember->loc.p, PMob->loc.p) < 29 * 29 && !PMember->m_autoTargetOverride &&
                                ((PMobTarget->objtype == TYPE_PC && PMember->IsPartiedWith((CCharEntity*)PMobTarget)) ||
                                 (PMobTarget->objtype == TYPE_PET && PMobTarget->PMaster && PMobTarget->PMaster->objtype == TYPE_PC &&
                                  PMember->IsPartiedWith((CCharEntity*)(PMobTarget->PMaster)))))
                            {
                                if (PWinner)
                                {
                                    if (distanceSquared(PMob->loc.p, POwner->loc.p) < distanceSquared(PWinner->loc.p, POwner->loc.p))
                                        PWinner = (CMobEntity*)PMob;
                                }
                                else
                                {
                                    PWinner = (CMobEntity*)PMob;
                                }
                            }
                        }
                        if (PWinner)
                        {
                            success = controller->ChangeTarget(PWinner->targid);
                            PMember->ForAlliance(
                                [PMember, PWinner](CBattleEntity* PMembermember)
                                {
                                    if (PMembermember->objtype == TYPE_PC && PMembermember->loc.zone->GetID() == PMember->loc.zone->GetID() &&
                                        PMembermember->animation == ANIMATION_ATTACK)
                                        ((CCharEntity*)PMembermember)->m_autoTargetOverride = (CBattleEntity*)PWinner;
                                });
                        }
                    }
                }

                if (!success && PMemberBE && PMemberBE->objtype == TYPE_PC)
                    ((CCharEntity*)PMemberBE)->m_LastEngagedTargID = 0;
            });
    }
    else // use dynamis version of checking all nearby players, not just alliance
    {
        PZone->ForEachChar(
            [](CCharEntity* PChar)
            {
                if (PChar && PChar->objtype == TYPE_PC)
                    PChar->m_autoTargetOverride = nullptr;
            });

        PZone->ForEachChar(
            [this, POwner, PZone](CCharEntity* PChar)
            {
                bool success = false;

                if (PChar && PChar->objtype == TYPE_PC && PChar->loc.zone->GetID() == this->loc.zone->GetID() && PChar->m_LastEngagedTargID == this->targid &&
                    PChar->m_hasAutoTarget)
                {
                    CCharEntity* PMember = PChar;
                    std::unique_ptr<CBasicPacket> errMsg;
                    if (PMember->m_autoTargetOverride)
                    {
                        if (PMember->m_autoTargetOverride->allegiance == ALLEGIANCE_MOB && PMember->IsMobOwner(PMember->m_autoTargetOverride) &&
                            !((CBattleEntity*)(PMember->m_autoTargetOverride)->IsNameHidden()) &&
                            distanceSquared(PMember->loc.p, PMember->m_autoTargetOverride->loc.p) < 29.0f * 29.0f)
                        {
                            auto controller{ static_cast<CPlayerController*>(PMember->PAI->GetController()) };
                            success = controller->ChangeTarget(PMember->m_autoTargetOverride->targid);
                        }
                    }
                    else
                    {
                        auto controller{ static_cast<CPlayerController*>(PMember->PAI->GetController()) };
                        CMobEntity* PWinner = nullptr;
                        for (auto&& PPotentialTarget : PMember->SpawnMOBList)
                        {
                            CBattleEntity* PMob = (CBattleEntity*)PPotentialTarget.second;

                            if ((PMob->objtype == TYPE_MOB || PMob->objtype == TYPE_PET) && PMob->animation == ANIMATION_ATTACK &&
                                PMob->allegiance == ALLEGIANCE_MOB && PMember->IsMobOwner(PMob) && !PMob->IsNameHidden() && PMob->id != this->id &&
                                distanceSquared(PMember->loc.p, PMob->loc.p) < 29 * 29 && !PMember->m_autoTargetOverride)
                            {
                                if (PWinner)
                                {
                                    if (distanceSquared(PMob->loc.p, POwner->loc.p) < distanceSquared(PWinner->loc.p, POwner->loc.p))
                                        PWinner = (CMobEntity*)PMob;
                                }
                                else
                                {
                                    PWinner = (CMobEntity*)PMob;
                                }
                            }
                        }
                        if (PWinner)
                        {
                            success = controller->ChangeTarget(PWinner->targid);
                            PZone->ForEachChar(
                                [PMember, PWinner](CCharEntity* PMembermember)
                                {
                                    if (PMembermember->objtype == TYPE_PC && PMembermember->loc.zone->GetID() == PMember->loc.zone->GetID() &&
                                        PMembermember->animation == ANIMATION_ATTACK)
                                        PMembermember->m_autoTargetOverride = (CBattleEntity*)PWinner;
                                });
                        }
                    }
                }

                if (!success && PChar && PChar->objtype == TYPE_PC)
                    PChar->m_LastEngagedTargID = 0;
            });
    }
}


void CMobEntity::PostTick()
{
    CBattleEntity::PostTick();
    if (loc.zone && updatemask)
    {
        loc.zone->PushPacket(this, CHAR_INRANGE, new CEntityUpdatePacket(this, ENTITY_UPDATE, updatemask));

        // If this mob is charmed, it should sync with its master
        if (PMaster && PMaster->PPet == this && PMaster->objtype == TYPE_PC)
        {
            ((CCharEntity*)PMaster)->pushPacket(new CPetSyncPacket((CCharEntity*)PMaster));
        }

        updatemask = 0;
    }
}

float CMobEntity::GetRoamDistance()
{
    return (float)getMobMod(MOBMOD_ROAM_DISTANCE) / 10.0f;
}

float CMobEntity::GetRoamRate()
{
    return (float)getMobMod(MOBMOD_ROAM_RATE) / 10.0f;
}

bool CMobEntity::ValidTarget(CBattleEntity* PInitiator, uint16 targetFlags)
{
    if (StatusEffectContainer->GetConfrontationEffect() != PInitiator->StatusEffectContainer->GetConfrontationEffect())
    {
        return false;
    }
    if (CBattleEntity::ValidTarget(PInitiator, targetFlags))
    {
        return true;
    }
    if (targetFlags & TARGET_PLAYER_DEAD && (m_Behaviour & BEHAVIOUR_RAISABLE)
        && isDead())
    {
        return true;
    }

    if ((targetFlags & TARGET_PLAYER) && allegiance == PInitiator->allegiance && !isCharmed)
    {
        return true;
    }

    if (targetFlags & TARGET_NPC)
    {
        if (allegiance == PInitiator->allegiance && !(m_Behaviour & BEHAVIOUR_NOHELP) && !isCharmed)
        {
            return true;
        }
    }

    return false;
}

void CMobEntity::Spawn()
{
    CBattleEntity::Spawn();
    m_giveExp = true;
    m_HiPCLvl = 0;
    m_HiPartySize = 0;
    m_THLvl = 0;
    m_ItemStolen = false;
    m_autoTargetReady = true;
    m_autoTargetKiller = nullptr;
    m_DropItemTime = 1000;
    animationsub = (uint8)getMobMod(MOBMOD_SPAWN_ANIMATIONSUB);
    CallForHelp(false);

    PEnmityContainer->Clear();

    uint8 level = m_minLevel;

    // Generate a random level between min and max level
    if (m_maxLevel > m_minLevel)
    {
        level += tpzrand::GetRandomNumber(0, m_maxLevel - m_minLevel + 1);
    }

    SetMLevel(level);
    SetSLevel(level);//calculated in function

    mobutils::CalculateStats(this);
    mobutils::GetAvailableSpells(this);

    // spawn somewhere around my point
    loc.p = m_SpawnPoint;

    if (m_roamFlags & ROAMFLAG_STEALTH)
    {
        HideName(true);
        Untargetable(true);
    }

    // add people to my posse
    if (getMobMod(MOBMOD_ASSIST))
    {
        for (int8 i = 1; i < getMobMod(MOBMOD_ASSIST) + 1; i++)
        {
            CMobEntity* PMob = (CMobEntity*)GetEntity(targid + i, TYPE_MOB);

            if (PMob != nullptr)
            {
                PMob->setMobMod(MOBMOD_SUPERLINK, targid);
            }
        }
    }

    //CBattleEntity* _target = (CBattleEntity*)PMob->GetEntity(PMob->id, TYPE_PC | TYPE_MOB | TYPE_PET);
    // note base resists
    setMobMod(100+(int)Mod::FIRERES,CBattleEntity::getMod(Mod::FIRERES));
    setMobMod(100+(int)Mod::ICERES,CBattleEntity::getMod(Mod::ICERES));
    setMobMod(100+(int)Mod::WINDRES,CBattleEntity::getMod(Mod::WINDRES));
    setMobMod(100+(int)Mod::EARTHRES,CBattleEntity::getMod(Mod::EARTHRES));
    setMobMod(100+(int)Mod::THUNDERRES,CBattleEntity::getMod(Mod::THUNDERRES));
    setMobMod(100+(int)Mod::WATERRES,CBattleEntity::getMod(Mod::WATERRES));
    setMobMod(100+(int)Mod::LIGHTRES,CBattleEntity::getMod(Mod::LIGHTRES));
    setMobMod(100+(int)Mod::DARKRES,CBattleEntity::getMod(Mod::DARKRES));
    setMobMod((int)Mod::SLEEPRES,CBattleEntity::getMod(Mod::SLEEPRES));
    setMobMod((int)Mod::POISONRES,CBattleEntity::getMod(Mod::POISONRES));
    setMobMod((int)Mod::PARALYZERES,CBattleEntity::getMod(Mod::PARALYZERES));
    setMobMod((int)Mod::BLINDRES,CBattleEntity::getMod(Mod::BLINDRES));
    setMobMod((int)Mod::SILENCERES,CBattleEntity::getMod(Mod::SILENCERES));
    setMobMod((int)Mod::BINDRES,CBattleEntity::getMod(Mod::BINDRES));
    setMobMod((int)Mod::GRAVITYRES,CBattleEntity::getMod(Mod::GRAVITYRES));
    setMobMod((int)Mod::SLOWRES,CBattleEntity::getMod(Mod::SLOWRES));
    setMobMod((int)Mod::STUNRES,CBattleEntity::getMod(Mod::STUNRES));
    setMobMod((int)Mod::CHARMRES,CBattleEntity::getMod(Mod::CHARMRES));
    setMobMod((int)Mod::LULLABYRES,CBattleEntity::getMod(Mod::LULLABYRES));

    m_DespawnTimer = time_point::min();
    luautils::OnMobSpawn(this);
}

void CMobEntity::OnWeaponSkillFinished(CWeaponSkillState& state, action_t& action)
{
    CBattleEntity::OnWeaponSkillFinished(state, action);

    static_cast<CMobController*>(PAI->GetController())->TapDeaggroTime();
}


void CMobEntity::OnMobSkillFinished(CMobSkillState& state, action_t& action)
{
    auto PSkill = state.GetSkill();
    auto PTarget = static_cast<CBattleEntity*>(state.GetTarget());

    static_cast<CMobController*>(PAI->GetController())->TapDeaggroTime();

    // store the skill used
    m_UsedSkillIds[PSkill->getID()] = GetMLevel();

    PAI->TargetFind->reset();

    float distance = PSkill->getDistance();
    uint8 findFlags = 0;
    if (PSkill->getFlag() & SKILLFLAG_HIT_ALL)
    {
        findFlags |= FINDFLAGS_HIT_ALL;
    }

    // Mob buff abilities also hit monster's pets
    if (PSkill->getValidTargets() == TARGET_SELF)
    {
        findFlags |= FINDFLAGS_PET;
    }

    action.id = id;
    if (objtype == TYPE_PET && static_cast<CPetEntity*>(this)->getPetType() == PETTYPE_AVATAR)
        action.actiontype = ACTION_PET_MOBABILITY_FINISH;
    else if (PSkill->isJobAbility())
        action.actiontype = ACTION_JOBABILITY_FINISH;
    else if (PSkill->getID() < 256)
        action.actiontype = ACTION_WEAPONSKILL_FINISH;
    else
        action.actiontype = ACTION_MOBABILITY_FINISH;
    action.actionid = PSkill->getID();

    if (PTarget && PAI->TargetFind->isWithinRange(&PTarget->loc.p, distance))
    {
        if (PSkill->isAoE())
        {
            PAI->TargetFind->findWithinArea(PTarget, (AOERADIUS)PSkill->getAoe(), PSkill->getRadius(), findFlags);
        }
        else if (PSkill->isConal())
        {
            float angle = 45.0f;
            PAI->TargetFind->findWithinCone(PTarget, distance, angle, findFlags);
        }
        else
        {
            if (this->objtype == TYPE_MOB && PTarget->objtype == TYPE_PC)
            {
                CBattleEntity* PCoverAbilityUser = battleutils::GetCoverAbilityUser(PTarget, this);
                if (PCoverAbilityUser != nullptr)
                {
                    PTarget = PCoverAbilityUser;
                }
            }

            PAI->TargetFind->findSingleTarget(PTarget, findFlags);
        }
    }

    uint16 targets = (uint16)PAI->TargetFind->m_targets.size();

    if (!PTarget || targets == 0)
    {
        action.actiontype = ACTION_MOBABILITY_INTERRUPT;
        actionList_t& actionList = action.getNewActionList();
        actionList.ActionTargetID = id;

        actionTarget_t& actionTarget = actionList.getNewActionTarget();
        actionTarget.animation = PSkill->getID();
        return;
    }

    PSkill->setTotalTargets(targets);
    PSkill->setTP(state.GetSpentTP());
    PSkill->setHPP(GetHPP());

    uint16 msg = 0;
    uint16 defaultMessage = PSkill->getMsg();

    bool first {true};
    for (auto&& PTarget : PAI->TargetFind->m_targets)
    {
        actionList_t& list = action.getNewActionList();

        list.ActionTargetID = PTarget->id;

        actionTarget_t& target = list.getNewActionTarget();

        list.ActionTargetID = PTarget->id;
        target.reaction = REACTION_HIT;
        target.speceffect = SPECEFFECT_HIT;
        target.animation = PSkill->getAnimationID();
        target.messageID = PSkill->getMsg();


        // reset the skill's message back to default
        PSkill->setMsg(defaultMessage);

        if (objtype == TYPE_PET && static_cast<CPetEntity*>(this)->getPetType() != PETTYPE_JUG_PET)
        {
            if(static_cast<CPetEntity*>(this)->getPetType() == PETTYPE_AVATAR || static_cast<CPetEntity*>(this)->getPetType() == PETTYPE_WYVERN)
            {
                target.animation = PSkill->getPetAnimationID();
            }
            target.param = luautils::OnPetAbility(PTarget, this, PSkill, PMaster, &action);
        }
        else
        {
            target.param = luautils::OnMobWeaponSkill(PTarget, this, PSkill, &action);
            this->PAI->EventHandler.triggerListener("WEAPONSKILL_USE", this, PTarget, PSkill->getID(), state.GetSpentTP(), &action);
            PTarget->PAI->EventHandler.triggerListener("WEAPONSKILL_TAKE", PTarget, this, PSkill->getID(), state.GetSpentTP(), &action);
        }

        if (objtype == TYPE_PET && PMaster && PMaster->objtype == TYPE_PC )
        {
            auto mob = dynamic_cast<CMobEntity *>(PTarget);
            if (mob && !mob->CalledForHelp())
            {
                mob->m_OwnerID.id = PMaster->id;
                mob->m_OwnerID.targid = PMaster->targid;
                mob->updatemask |= UPDATE_STATUS; //This can go here because we only wanna call the updatemask if this happens
            }
        }

        if (msg == 0)
        {
            msg = PSkill->getMsg();
        }
        else
        {
            msg = PSkill->getAoEMsg();
        }

        target.messageID = msg;

        if (PSkill->hasMissMsg())
        {
            target.reaction = REACTION_MISS;
            target.speceffect = SPECEFFECT_NONE;
            if (msg == PSkill->getAoEMsg())
                msg = 282;
        }
        else
        {
            target.reaction = REACTION_HIT;
        }

        if (target.speceffect & SPECEFFECT_HIT)
        {
            target.speceffect = SPECEFFECT_RECOIL;
            target.knockback = PSkill->getKnockback();
            if (first && (PSkill->getPrimarySkillchain() != 0))
            {
                if (PSkill->getPrimarySkillchain())
                {
                    SUBEFFECT effect = battleutils::GetSkillChainEffect(PTarget, PSkill->getPrimarySkillchain(),
                        PSkill->getSecondarySkillchain(), PSkill->getTertiarySkillchain());
                    if (effect != SUBEFFECT_NONE)
                    {
                        int32 skillChainDamage = battleutils::TakeSkillchainDamage(this, PTarget, target.param, nullptr);
                        if (skillChainDamage < 0)
                        {
                            target.addEffectParam = -skillChainDamage;
                            target.addEffectMessage = 384 + effect;
                        }
                        else
                        {
                            target.addEffectParam = skillChainDamage;
                            target.addEffectMessage = 287 + effect;
                        }
                        target.additionalEffect = effect;
                    }
                }
                first = false;
            }
        }
        PTarget->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_DETECTABLE);
        if (PTarget->isDead())
        {
            battleutils::ClaimMob(PTarget, this);
        }
        battleutils::DirtyExp(PTarget, this);
    }
    PTarget = static_cast<CBattleEntity*>(state.GetTarget());
    if (PTarget->objtype == TYPE_MOB && (PTarget->isDead() || (objtype == TYPE_PET && static_cast<CPetEntity*>(this)->getPetType() == PETTYPE_AVATAR)))
    {
        battleutils::ClaimMob(PTarget, this);
    }
    battleutils::DirtyExp(PTarget, this);
}

void CMobEntity::DistributeRewards()
{
    CCharEntity* PChar = (CCharEntity*)GetEntity(m_OwnerID.targid, TYPE_PC);

    if (PChar != nullptr && PChar->id == m_OwnerID.id)
    {
        PChar->setWeaponSkillKill(false);
        StatusEffectContainer->KillAllStatusEffect();

        // NOTE: this is called for all alliance / party members!
        luautils::OnMobDeath(this, PChar);

        if (!CalledForHelp())
        {
            blueutils::TryLearningSpells(PChar, this);
            m_UsedSkillIds.clear();

            if (m_giveExp && !PChar->StatusEffectContainer->HasStatusEffect(EFFECT_BATTLEFIELD))
            {
                charutils::DistributeExperiencePoints(PChar, this);
            }

            // check for gil (beastmen drop gil, some NMs drop gil)
            if ((map_config.mob_gil_multiplier > 0 && CanDropGil()) || (map_config.all_mobs_gil_bonus > 0 && getMobMod(MOBMOD_GIL_MAX) >= 0)) // Negative value of MOBMOD_GIL_MAX is used to prevent gil drops in Dynamis/Limbus.
            {
                charutils::DistributeGil(PChar, this); // TODO: REALISATION MUST BE IN TREASUREPOOL
            }

            // RoE Mob kill event for all party members
            PChar->ForAlliance(
                [this, PChar](CBattleEntity* PMember)
                {
                    if (PMember->getZone() == PChar->getZone())
                    {
                        roeutils::event(ROE_MOBKILL, (CCharEntity*)PMember, RoeDatagram("mob", (CMobEntity*)this));
                    }
                });

            DropItems(PChar);
        }

    }
    else
    {
        luautils::OnMobDeath(this, nullptr);
    }
}

void CMobEntity::DropItems(CCharEntity* PChar)
{
    //Adds an item to the treasure pool and returns true if the pool has been filled
    auto AddItemToPool = [this, PChar](uint16 ItemID, uint8 dropCount)
    {
        PChar->PTreasurePool->AddItem(ItemID, this);
        return dropCount >= TREASUREPOOL_SIZE;
    };

    //Limit number of items that can drop to the treasure pool size
    uint8 dropCount = 0;

    DropList_t* DropList = itemutils::GetDropList(m_DropID);
    //ShowDebug(CL_CYAN"DropID: %u dropping with TH Level: %u\n" CL_RESET, PMob->m_DropID, PMob->m_THLvl);

    uint16 gDropBase[7][15] = { { 2400, 4800, 5600, 6000, 6400, 6666, 6800, 6900, 7050, 7200, 7350, 7400, 7600, 7800, 8000 },
                                { 1500, 3000, 4000, 4250, 4500, 4750, 5000, 5250, 5500, 5750, 6000, 6250, 6500, 6750, 7000 },
                                { 1000, 1200, 1500, 1650, 1800, 1900, 2000, 2100, 2250, 2400, 2650, 2800, 2950, 3100, 3250 },
                                { 0500, 0600, 0700, 0750, 800, 850, 900, 950, 1050, 1150, 1250, 1350, 1550, 1750, 2000 },
                                { 0100, 0150, 0200, 0225, 0250, 0300, 0350, 0400, 0475, 0550, 0650, 0750, 825, 900, 1000 },
                                { 0050, 0075, 0100, 0120, 0140, 0160, 180, 0200, 0230, 0260, 0300, 0350, 0400, 0450, 0500 },
                                { 0010, 0020, 0030, 0035, 0040, 0045, 0050, 0060, 0070, 80, 90, 0100, 0115, 0130, 0150 } };

    if (DropList != nullptr && !getMobMod(MOBMOD_NO_DROPS) && (DropList->Items.size() || DropList->Groups.size()))
    {
        uint16 th = m_THLvl;
        if (th > 14)
            th = 14;
        for (const DropGroup_t& group : DropList->Groups)
        {
            uint16 rate = group.GroupRate;
            uint16 category = 7;
            if (rate < 5)
                category = 6;
            else if (rate < 10)
                category = 5;
            else if (rate < 50)
                category = 4;
            else if (rate < 100)
                category = 3;
            else if (rate < 150)
                category = 2;
            else if (rate < 240)
                category = 1;
            else if (rate < 1000)
                category = 0;

            if ((category == 7) || (tpzrand::GetRandomNumber(10000) < gDropBase[category][th]))
            {
                // Each item in the group is given its own weight range which is the previous value to the previous value + item.DropRate
                // Such as 2 items with drop rates of 200 and 800 would be 0-199 and 200-999 respectively
                uint16 previousRateValue = 0;
                uint16 itemRoll = tpzrand::GetRandomNumber(1000);
                for (const DropItem_t& item : group.Items)
                {
                    if (previousRateValue + item.DropRate > itemRoll)
                    {
                        if (AddItemToPool(item.ItemID, ++dropCount))
                            return;
                        break;
                    }
                    previousRateValue += item.DropRate;
                }
            }
        }

        for (const DropItem_t& item : DropList->Items)
        {
            uint16 rate = item.DropRate;
            uint16 category = 7;
            if (rate < 5)
                category = 6;
            else if (rate < 10)
                category = 5;
            else if (rate < 50)
                category = 4;
            else if (rate < 100)
                category = 3;
            else if (rate < 150)
                category = 2;
            else if (rate < 240)
                category = 1;
            else if (rate < 1000)
                category = 0;

            if ((category == 7) || (tpzrand::GetRandomNumber(10000) < gDropBase[category][th]))
            {
                if (AddItemToPool(item.ItemID, ++dropCount))
                    return;
            }
        }
    }
    uint16 Pzone = PChar->getZone();

    bool validZone =
        ((Pzone > 0 && Pzone < 31) || (Pzone > 44 && Pzone < 55) || (Pzone > 56 && Pzone < 63) || (Pzone > 64 && Pzone < 66) || (Pzone > 66 && Pzone < 69) ||
         (Pzone > 69 && Pzone < 73) || (Pzone > 78 && Pzone < 134) || (Pzone > 135 && Pzone < 185) || (Pzone > 188 && Pzone < 294));

    if (validZone && charutils::CheckMob(m_HiPCLvl, GetMLevel()) > EMobDifficulty::TooWeak)
    {
        // check for seal drops
        /* MobLvl >= 1 = Beastmen Seals ID=1126
        >= 50 = Kindred Seals ID=1127
        >= 75 = Kindred Crests ID=2955
        >= 90 = High Kindred Crests
         * ID=2956
        */
        if (tpzrand::GetRandomNumber(100) < 90 && PChar->PTreasurePool->CanAddSeal() && !getMobMod(MOBMOD_NO_DROPS))
        {
            // RULES: Only 1 kind may drop per mob
            // if (GetMLevel() >= 75 && luautils::IsContentEnabled("ABYSSEA")) //all 4 types
            if (GetMLevel() >= 190 && luautils::IsContentEnabled("ABYSSEA")) // all 4 types
            {
                switch (tpzrand::GetRandomNumber(4))
                {
                    case 0:

                        if (AddItemToPool(1126, ++dropCount))
                            return;
                        break;
                    case 1:
                        if (AddItemToPool(1127, ++dropCount))
                            return;
                        break;
                    case 2:
                        if (AddItemToPool(2955, ++dropCount))
                            return;
                        break;
                    case 3:
                        if (AddItemToPool(2956, ++dropCount))
                            return;
                        break;
                }
            }
            // else if (GetMLevel() >= 70 && luautils::IsContentEnabled("ABYSSEA")) //b.seal & k.seal & k.crest
            else if (GetMLevel() >= 80 && luautils::IsContentEnabled("ABYSSEA")) // b.seal & k.seal & k.crest
            {
                switch (tpzrand::GetRandomNumber(3))
                {
                    case 0:
                        if (AddItemToPool(1127, ++dropCount))
                            return;
                        break;
                    case 1:
                        if (AddItemToPool(1127, ++dropCount))
                            return;
                        break;
                    case 2:
                        if (AddItemToPool(1127, ++dropCount))
                            return;
                        break;
                }
            }
            else if (GetMLevel() >= 50) // b.seal & k.seal only
            {
                if (tpzrand::GetRandomNumber(2) == 0)
                {
                    if (AddItemToPool(1126, ++dropCount))
                        return;
                }
                else
                {
                    if (AddItemToPool(1127, ++dropCount))
                        return;
                }
            }
            else
            {
                // b.seal only
                if (AddItemToPool(1126, ++dropCount))
                    return;
            }
        }
        // Todo: Avatarite and Geode drops during day/weather. Much higher chance during weather than day.
        // Item element matches day/weather element, not mob crystal. Lv80+ xp mobs can drop Avatarite.
        // Wiki's have conflicting info on mob lv required for Geodes. One says 50 the other 75. I think 50 is correct.

        uint8 effect = 0; // Begin Adding Crystals

        if (m_Element > 0)
        {
            uint8 regionID = PChar->loc.zone->GetRegionID();
            switch (regionID)
            {
                // Sanction Regions
                case REGION_WEST_AHT_URHGAN:
                case REGION_MAMOOL_JA_SAVAGE:
                case REGION_HALVUNG:
                case REGION_ARRAPAGO:
                    effect = 2;
                    break;
                // Sigil Regions
                case REGION_RONFAURE_FRONT:
                case REGION_NORVALLEN_FRONT:
                case REGION_GUSTABERG_FRONT:
                case REGION_DERFLAND_FRONT:
                case REGION_SARUTA_FRONT:
                case REGION_ARAGONEAU_FRONT:
                case REGION_FAUREGANDI_FRONT:
                case REGION_VALDEAUNIA_FRONT:
                    effect = 3;
                    break;
                // Signet Regions
                default:
                    effect = (conquest::GetRegionOwner(PChar->loc.zone->GetRegionID()) <= 2) ? 1 : 0;
                    break;
            }
        }
        uint8 crystalRolls = 0;
        PChar->ForParty(
            [this, &crystalRolls, &effect](CBattleEntity* PMember)
            {
                switch (effect)
                {
                    case 1:
                        if (PMember->StatusEffectContainer->HasStatusEffect(EFFECT_SIGNET) && PMember->getZone() == getZone() &&
                            distance(PMember->loc.p, loc.p) < 100)
                        {
                            crystalRolls++;
                        }
                        break;
                    case 2:
                        if (PMember->StatusEffectContainer->HasStatusEffect(EFFECT_SANCTION) && PMember->getZone() == getZone() &&
                            distance(PMember->loc.p, loc.p) < 100)
                        {
                            crystalRolls++;
                        }
                        break;
                    case 3:
                        if (PMember->StatusEffectContainer->HasStatusEffect(EFFECT_SIGIL) && PMember->getZone() == getZone() &&
                            distance(PMember->loc.p, loc.p) < 100)
                        {
                            crystalRolls++;
                        }
                        break;
                    default:
                        break;
                }
            });
        for (uint8 i = 0; i < crystalRolls; i++)
        {
            if (tpzrand::GetRandomNumber(100) < 20 && AddItemToPool(4095 + m_Element, ++dropCount))
            {
                return;
            }
        }
    }
}


bool CMobEntity::CanAttack(CBattleEntity* PTarget, std::unique_ptr<CBasicPacket>& errMsg)
{
    auto skill_list_id {getMobMod(MOBMOD_ATTACK_SKILL_LIST)};
    if (skill_list_id)
    {
        auto attack_range {GetMeleeRange()};
        auto skillList {battleutils::GetMobSkillList(skill_list_id)};
        if (!skillList.empty())
        {
            auto skill {battleutils::GetMobSkill(skillList.front())};
            if (skill)
            {
                attack_range = (uint8)skill->getDistance();
            }
        }
        if ((distance(loc.p, PTarget->loc.p) - PTarget->m_ModelSize) > attack_range ||
            !PAI->GetController()->IsAutoAttackEnabled())
        {
            return false;
        }
        return true;
    }
    else
    {
        return CBattleEntity::CanAttack(PTarget, errMsg);
    }
}

void CMobEntity::OnEngage(CAttackState& state)
{
    CBattleEntity::OnEngage(state);
    luautils::OnMobEngaged(this, state.GetTarget());
    unsigned int range = this->getMobMod(MOBMOD_ALLI_HATE);
    if (range != 0)
    {
        CBaseEntity* PTarget = state.GetTarget();
        CBaseEntity* PPet = nullptr;
        if (PTarget->objtype == TYPE_PET)
        {
            PPet = state.GetTarget();
            PTarget = ((CPetEntity*)PTarget)->PMaster;
        }
        if (PTarget->objtype == TYPE_PC)
        {
            ((CCharEntity*)PTarget)->ForAlliance([this, PTarget, range](CBattleEntity* PMember)
            {
                auto currentDistance = distance(PMember->loc.p, PTarget->loc.p);
                if (currentDistance < range)
                    this->PEnmityContainer->AddBaseEnmity(PMember);
            });
            this->PEnmityContainer->UpdateEnmity((PPet ? (CBattleEntity*)PPet : (CBattleEntity*)PTarget), 0, 1); // Set VE so target doesn't change
        }
    }

    static_cast<CMobController*>(PAI->GetController())->TapDeaggroTime();
}

void CMobEntity::FadeOut()
{
    CBaseEntity::FadeOut();
    PEnmityContainer->Clear();
}

void CMobEntity::OnDeathTimer()
{
    if (!(m_Behaviour & BEHAVIOUR_RAISABLE))
        PAI->Despawn();
}

void CMobEntity::OnDespawn(CDespawnState&)
{
    FadeOut();
    PAI->Internal_Respawn(std::chrono::milliseconds(m_RespawnTime));
    luautils::OnMobDespawn(this);
    //#event despawn
    PAI->EventHandler.triggerListener("DESPAWN", this);
}

void CMobEntity::Die()
{
    DoAutoTarget();
    m_THLvl = PEnmityContainer->GetHighestTH();
    PEnmityContainer->Clear();
    PAI->ClearStateStack();
    if (PPet != nullptr && PPet->isAlive() && GetMJob() == JOB_SMN)
    {
        PPet->Die();
    }
    PAI->Internal_Die(15s);
    CBattleEntity::Die();
    PAI->QueueAction(queueAction_t(std::chrono::milliseconds(m_DropItemTime), false, [this](CBaseEntity* PEntity) {
        if (static_cast<CMobEntity*>(PEntity)->isDead())
        {
            if (PLastAttacker)
                loc.zone->PushPacket(this, CHAR_INRANGE, new CMessageBasicPacket(PLastAttacker, this, 0, 0, MSGBASIC_DEFEATS_TARG));
            else
                loc.zone->PushPacket(this, CHAR_INRANGE, new CMessageBasicPacket(this, this, 0, 0, MSGBASIC_FALLS_TO_GROUND));

            DistributeRewards();
            m_OwnerID.clean();
        }
    }));
    if (PMaster && PMaster->PPet == this && PMaster->objtype == TYPE_PC)
    {
        petutils::DetachPet(PMaster);
    }
}

void CMobEntity::OnDisengage(CAttackState& state)
{
    PAI->PathFind->Clear();
    PEnmityContainer->Clear();

    if (getMobMod(MOBMOD_IDLE_DESPAWN))
    {
        SetDespawnTime(std::chrono::seconds(getMobMod(MOBMOD_IDLE_DESPAWN)));
    }
    // this will let me decide to walk home or despawn
    m_neutral = true;

    m_OwnerID.clean();

    CBattleEntity::OnDisengage(state);

    luautils::OnMobDisengage(this);
}

void CMobEntity::OnCastFinished(CMagicState& state, action_t& action)
{
    CBattleEntity::OnCastFinished(state, action);

    static_cast<CMobController*>(PAI->GetController())->TapDeaggroTime();
}

bool CMobEntity::OnAttack(CAttackState& state, action_t& action)
{
    static_cast<CMobController*>(PAI->GetController())->TapDeaggroTime();
    auto PTarget = static_cast<CBattleEntity*>(state.GetTarget());

    if (getMobMod(MOBMOD_ATTACK_SKILL_LIST))
    {
        return static_cast<CMobController*>(PAI->GetController())->MobSkill(getMobMod(MOBMOD_ATTACK_SKILL_LIST));
    }
    else
    {
        return CBattleEntity::OnAttack(state, action);
    }
}
