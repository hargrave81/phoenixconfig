/*
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

#include "../../common/timer.h"
#include "../../common/utils.h"

#include <string.h>
#include <vector>
#include <math.h>

#include "battleutils.h"
#include "charutils.h"
#include "puppetutils.h"
#include "../grades.h"
#include "../map.h"
#include "petutils.h"
#include "zoneutils.h"
#include "../entities/mobentity.h"
#include "../entities/automatonentity.h"
#include "../ability.h"
#include "../status_effect_container.h"
#include "../latent_effect_container.h"
#include "../mob_spell_list.h"
#include "../enmity_container.h"
#include "../items/item_weapon.h"
#include "../zone_instance.h"

#include "../ai/ai_container.h"
#include "../ai/controllers/mob_controller.h"
#include "../ai/controllers/pet_controller.h"
#include "../ai/controllers/automaton_controller.h"
#include "../ai/states/ability_state.h"

#include "../packets/char_abilities.h"
#include "../packets/char_sync.h"
#include "../packets/char_update.h"
#include "../packets/entity_update.h"
#include "../packets/message_standard.h"
#include "../packets/pet_sync.h"

struct Pet_t
{
    uint16 PetID;               // ID in pet_list.sql
    look_t		look;		// внешний вид
    string_t	name;		// имя
    ECOSYSTEM	EcoSystem;	// эко-система

    uint8		minLevel;	// минимально-возможный  уровень
    uint8		maxLevel;	// максимально-возможный уровень

    uint8       name_prefix;
    uint8		size;		// размер модели
    uint16		m_Family;
    uint32		time;		// время существования (будет использоваться для задания длительности статус эффекта)

    uint8		mJob;
    uint8		m_Element;
    float       HPscale;                             // HP boost percentage
    float       MPscale;                             // MP boost percentage

    uint16      cmbDelay;
    uint8 		speed;
    // stat ranks
    uint8        strRank;
    uint8        dexRank;
    uint8        vitRank;
    uint8        agiRank;
    uint8        intRank;
    uint8        mndRank;
    uint8        chrRank;
    uint8        attRank;
    uint8        defRank;
    uint8        evaRank;
    uint8        accRank;

    uint16       m_MobSkillList;

    // magic stuff
    bool hasSpellScript;
    uint16 spellList;

    // resists
    int16 slashres;
    int16 pierceres;
    int16 hthres;
    int16 impactres;

    int16 firedef;
    int16 icedef;
    int16 winddef;
    int16 earthdef;
    int16 thunderdef;
    int16 waterdef;
    int16 lightdef;
    int16 darkdef;

     int16 fireresSDT;
    int16 iceresSDT;
    int16 windresSDT;
    int16 earthresSDT;
    int16 thunderresSDT;
    int16 waterresSDT;
    int16 lightresSDT;
    int16 darkresSDT;

};

std::vector<Pet_t*> g_PPetList;

namespace petutils
{

    /************************************************************************
    *																		*
    *  Загружаем список прототипов питомцев									*
    *																		*
    ************************************************************************/

    void LoadPetList()
    {
        FreePetList();

        const char* Query =
            "SELECT\
                pet_list.petid,\
                pet_list.name,\
                modelid,\
                minLevel,\
                maxLevel,\
                time,\
                mobsize,\
                systemid,\
                mob_pools.familyid,\
                mob_pools.mJob,\
                pet_list.element,\
                (mob_family_system.HP / 100),\
                (mob_family_system.MP / 100),\
                mob_family_system.speed,\
                mob_family_system.STR,\
                mob_family_system.DEX,\
                mob_family_system.VIT,\
                mob_family_system.AGI,\
                mob_family_system.INT,\
                mob_family_system.MND,\
                mob_family_system.CHR,\
                mob_family_system.DEF,\
                mob_family_system.ATT,\
                mob_family_system.ACC, \
                mob_family_system.EVA, \
                hasSpellScript, spellList, \
                Slash, Pierce, H2H, Impact, \
                Fire, Ice, Wind, Earth, Lightning, Water, Light, Dark, \
                cmbDelay, name_prefix, mob_pools.skill_list_id \
                FROM pet_list, mob_pools, mob_family_system \
                WHERE pet_list.poolid = mob_pools.poolid AND mob_pools.familyid = mob_family_system.familyid";

        if (Sql_Query(SqlHandle, Query) != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
        {
            while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
            {
                Pet_t* Pet = new Pet_t();

                Pet->PetID = (uint16)Sql_GetIntData(SqlHandle, 0);
                Pet->name.insert(0, (const char*)Sql_GetData(SqlHandle, 1));

                memcpy(&Pet->look, Sql_GetData(SqlHandle, 2), 20);
                Pet->minLevel = (uint8)Sql_GetIntData(SqlHandle, 3);
                Pet->maxLevel = (uint8)Sql_GetIntData(SqlHandle, 4);
                Pet->time = Sql_GetUIntData(SqlHandle, 5);
                Pet->size = Sql_GetUIntData(SqlHandle, 6);
                Pet->EcoSystem = (ECOSYSTEM)Sql_GetIntData(SqlHandle, 7);
                Pet->m_Family = (uint16)Sql_GetIntData(SqlHandle, 8);
                Pet->mJob = (uint8)Sql_GetIntData(SqlHandle, 9);
                Pet->m_Element = (uint8)Sql_GetIntData(SqlHandle, 10);

                Pet->HPscale = Sql_GetFloatData(SqlHandle, 11);
                Pet->MPscale = Sql_GetFloatData(SqlHandle, 12);

                Pet->speed = (uint8)Sql_GetIntData(SqlHandle, 13);

                Pet->strRank = (uint8)Sql_GetIntData(SqlHandle, 14);
                Pet->dexRank = (uint8)Sql_GetIntData(SqlHandle, 15);
                Pet->vitRank = (uint8)Sql_GetIntData(SqlHandle, 16);
                Pet->agiRank = (uint8)Sql_GetIntData(SqlHandle, 17);
                Pet->intRank = (uint8)Sql_GetIntData(SqlHandle, 18);
                Pet->mndRank = (uint8)Sql_GetIntData(SqlHandle, 19);
                Pet->chrRank = (uint8)Sql_GetIntData(SqlHandle, 20);
                Pet->defRank = (uint8)Sql_GetIntData(SqlHandle, 21);
                Pet->attRank = (uint8)Sql_GetIntData(SqlHandle, 22);
                Pet->accRank = (uint8)Sql_GetIntData(SqlHandle, 23);
                Pet->evaRank = (uint8)Sql_GetIntData(SqlHandle, 24);

                Pet->hasSpellScript = (bool)Sql_GetIntData(SqlHandle, 25);

                Pet->spellList = (uint8)Sql_GetIntData(SqlHandle, 26);

                // resistances
                Pet->slashres = (uint16)(Sql_GetFloatData(SqlHandle, 27) * 1000);
                Pet->pierceres = (uint16)(Sql_GetFloatData(SqlHandle, 28) * 1000);
                Pet->hthres = (uint16)(Sql_GetFloatData(SqlHandle, 29) * 1000);
                Pet->impactres = (uint16)(Sql_GetFloatData(SqlHandle, 30) * 1000);

                Pet->firedef = 0;
                Pet->icedef = 0;
                Pet->winddef = 0;
                Pet->earthdef = 0;
                Pet->thunderdef = 0;
                Pet->waterdef = 0;
                Pet->lightdef = 0;
                Pet->darkdef = 0;

                Pet->fireresSDT = (uint16)(Sql_GetFloatData(SqlHandle, 31) * 100);
                Pet->iceresSDT = (uint16)(Sql_GetFloatData(SqlHandle, 32) * 100);
                Pet->windresSDT = (uint16)(Sql_GetFloatData(SqlHandle, 33) * 100);
                Pet->earthresSDT = (uint16)(Sql_GetFloatData(SqlHandle, 34) * 100);
                Pet->thunderresSDT = (uint16)(Sql_GetFloatData(SqlHandle, 35) * 100);
                Pet->waterresSDT = (uint16)(Sql_GetFloatData(SqlHandle, 36) * 100);
                Pet->lightresSDT = (uint16)(Sql_GetFloatData(SqlHandle, 37) * 100);
                Pet->darkresSDT = (uint16)(Sql_GetFloatData(SqlHandle, 38) * 100);


                Pet->cmbDelay = (uint16)Sql_GetIntData(SqlHandle, 39);
                Pet->name_prefix = (uint8)Sql_GetUIntData(SqlHandle, 40);
                Pet->m_MobSkillList = (uint16)Sql_GetUIntData(SqlHandle, 41);

                g_PPetList.push_back(Pet);
            }
        }
    }

    /************************************************************************
    *																		*
    *  Освобождаем список прототипов питомцев								*
    *																		*
    ************************************************************************/

    void FreePetList()
    {
        while (!g_PPetList.empty())
        {
            delete *g_PPetList.begin();
            g_PPetList.erase(g_PPetList.begin());
        }
    }

    void AttackTarget(CBattleEntity* PMaster, CBattleEntity* PTarget)
    {
        TPZ_DEBUG_BREAK_IF(PMaster->PPet == nullptr);

        CBattleEntity* PPet = PMaster->PPet;

        if (!PPet->StatusEffectContainer->HasPreventActionEffect())
        {
            PPet->PAI->Engage(PTarget->targid);
        }
    }

    void RetreatToMaster(CBattleEntity* PMaster)
    {
        TPZ_DEBUG_BREAK_IF(PMaster->PPet == nullptr);

        CBattleEntity* PPet = PMaster->PPet;

        if (!PPet->StatusEffectContainer->HasPreventActionEffect())
        {
            PPet->PAI->Disengage();
        }
    }

    uint16 GetJugWeaponDamage(CPetEntity* PPet)
    {
        float MainLevel = PPet->GetMLevel();
        return (uint16)(MainLevel * (MainLevel < 40 ? 1.4 - MainLevel / 100 : 1));
    }
    uint16 GetJugBase(CPetEntity * PMob, uint8 rank)
    {

        uint8 lvl = PMob->GetMLevel();
        if (lvl > 50)
        {
            switch (rank)
        {
            case 1:
                return (uint16)(153 + (lvl - 50) * 5.0f);
            case 2:
                return (uint16)(147 + (lvl - 50) * 4.9f);
            case 3:
                return (uint16)(136 + (lvl - 50) * 4.8f);
            case 4:
                return (uint16)(126 + (lvl - 50) * 4.7f);
            case 5:
                return (uint16)(116 + (lvl - 50) * 4.5f);
            case 6:
                return (uint16)(106 + (lvl - 50) * 4.4f);
            case 7:
                return (uint16)(96 + (lvl - 50) * 4.3f);
            }
        }
        else
        {
            switch (rank)
        {
            case 1:
                return (uint16)(6 + (lvl - 1) * 3.0f);
            case 2:
                return (uint16)(5 + (lvl - 1) * 2.9f);
            case 3:
                return (uint16)(5 + (lvl - 1) * 2.8f);
            case 4:
                return (uint16)(4 + (lvl - 1) * 2.7f);
            case 5:
                return (uint16)(4 + (lvl - 1) * 2.5f);
            case 6:
                return (uint16)(3 + (lvl - 1) * 2.4f);
            case 7:
                return (uint16)(3 + (lvl - 1) * 2.3f);
            }
        }
        return 0;
    }
    uint16 GetBaseToRank(uint8 rank, uint16 lvl)
    {
        switch (rank)
        {
        case 1: return (5 + ((lvl - 1) * 50) / 100);
        case 2: return (4 + ((lvl - 1) * 45) / 100);
        case 3: return (4 + ((lvl - 1) * 40) / 100);
        case 4: return (3 + ((lvl - 1) * 35) / 100);
        case 5: return (3 + ((lvl - 1) * 30) / 100);
        case 6: return (2 + ((lvl - 1) * 25) / 100);
        case 7: return (2 + ((lvl - 1) * 20) / 100);
        }
        return 0;
    }

    void LoadJugStats(CPetEntity* PMob, Pet_t* petStats)
    {
        //follows monster formulas but jugs have no subjob

        float growth = 1.0;
        uint8 lvl = PMob->GetMLevel();

        //give hp boost every 10 levels after 25
        //special boosts at 25 and 50
        if (lvl > 75)
        {
            growth = 1.22f;
        }
        else if (lvl > 65)
        {
            growth = 1.20f;
        }
        else if (lvl > 55)
        {
            growth = 1.18f;
        }
        else if (lvl > 50)
        {
            growth = 1.16f;
        }
        else if (lvl > 45)
        {
            growth = 1.12f;
        }
        else if (lvl > 35)
        {
            growth = 1.09f;
        }
        else if (lvl > 25)
        {
            growth = 1.07f;
        }

        PMob->health.maxhp = (int16)(17.0 * pow(lvl, growth) * petStats->HPscale);

        switch (PMob->GetMJob())
        {
        case JOB_PLD:
        case JOB_WHM:
        case JOB_BLM:
        case JOB_RDM:
        case JOB_DRK:
        case JOB_BLU:
        case JOB_SCH:
            PMob->health.maxmp = (int16)(15.2 * pow(lvl, 1.1075) * petStats->MPscale);
            break;
        default:
            break;
        }

        PMob->speed = petStats->speed;
        PMob->speedsub = petStats->speed;

        PMob->UpdateHealth();
        PMob->health.tp = 0;
        PMob->health.hp = PMob->GetMaxHP();
        PMob->health.mp = PMob->GetMaxMP();

        PMob->setModifier(Mod::DEF, GetJugBase(PMob, petStats->defRank));
        PMob->setModifier(Mod::EVA, GetJugBase(PMob, petStats->evaRank));
        PMob->setModifier(Mod::ATT, GetJugBase(PMob, petStats->attRank));
        PMob->setModifier(Mod::ACC, GetJugBase(PMob, petStats->accRank));

        ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->setDamage(GetJugWeaponDamage(PMob));

        //reduce weapon delay of MNK
        if (PMob->GetMJob() == JOB_MNK)
        {
            ((CItemWeapon*)PMob->m_Weapons[SLOT_MAIN])->resetDelay();
        }

        uint16 fSTR = GetBaseToRank(petStats->strRank, PMob->GetMLevel());
        uint16 fDEX = GetBaseToRank(petStats->dexRank, PMob->GetMLevel());
        uint16 fVIT = GetBaseToRank(petStats->vitRank, PMob->GetMLevel());
        uint16 fAGI = GetBaseToRank(petStats->agiRank, PMob->GetMLevel());
        uint16 fINT = GetBaseToRank(petStats->intRank, PMob->GetMLevel());
        uint16 fMND = GetBaseToRank(petStats->mndRank, PMob->GetMLevel());
        uint16 fCHR = GetBaseToRank(petStats->chrRank, PMob->GetMLevel());

        uint16 mSTR = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(), 2), PMob->GetMLevel());
        uint16 mDEX = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(), 3), PMob->GetMLevel());
        uint16 mVIT = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(), 4), PMob->GetMLevel());
        uint16 mAGI = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(), 5), PMob->GetMLevel());
        uint16 mINT = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(), 6), PMob->GetMLevel());
        uint16 mMND = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(), 7), PMob->GetMLevel());
        uint16 mCHR = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(), 8), PMob->GetMLevel());

        PMob->stats.STR = (uint16)((fSTR + mSTR) * 0.9f);
        PMob->stats.DEX = (uint16)((fDEX + mDEX) * 0.9f);
        PMob->stats.VIT = (uint16)((fVIT + mVIT) * 0.9f);
        PMob->stats.AGI = (uint16)((fAGI + mAGI) * 0.9f);
        PMob->stats.INT = (uint16)((fINT + mINT) * 0.9f);
        PMob->stats.MND = (uint16)((fMND + mMND) * 0.9f);
        PMob->stats.CHR = (uint16)((fCHR + mCHR) * 0.9f);

    }

    void LoadAutomatonStats(CCharEntity* PMaster, CPetEntity* PPet, Pet_t* petStats)
    {
        PPet->WorkingSkills.automaton_melee = std::min(puppetutils::getSkillCap(PMaster, SKILL_AUTOMATON_MELEE), PMaster->GetSkill(SKILL_AUTOMATON_MELEE));
        PPet->WorkingSkills.automaton_ranged = std::min(puppetutils::getSkillCap(PMaster, SKILL_AUTOMATON_RANGED), PMaster->GetSkill(SKILL_AUTOMATON_RANGED));
        PPet->WorkingSkills.automaton_magic = std::min(puppetutils::getSkillCap(PMaster, SKILL_AUTOMATON_MAGIC), PMaster->GetSkill(SKILL_AUTOMATON_MAGIC));

        // Set capped flags
        for (int i = 22; i <= 24; ++i)
            if (PPet->GetSkill(i) == (puppetutils::getSkillCap(PMaster, (SKILLTYPE)i)))
                PPet->WorkingSkills.skill[i] |= 0x8000;

        // Add mods/merits
        int32 meritbonus = PMaster->PMeritPoints->GetMeritValue(MERIT_AUTOMATON_SKILLS, PMaster);
        PPet->WorkingSkills.automaton_melee += PMaster->getMod(Mod::AUTO_MELEE_SKILL) + meritbonus;
        PPet->WorkingSkills.automaton_ranged += PMaster->getMod(Mod::AUTO_RANGED_SKILL) + meritbonus;
        // Share its magic skills to prevent needing separate spells or checks to see which skill to use
        uint16 amaSkill = PPet->WorkingSkills.automaton_magic + PMaster->getMod(Mod::AUTO_MAGIC_SKILL) + meritbonus;
        PPet->WorkingSkills.automaton_magic = amaSkill;
        PPet->WorkingSkills.healing = amaSkill;
        PPet->WorkingSkills.enhancing = amaSkill;
        PPet->WorkingSkills.enfeebling = amaSkill;
        PPet->WorkingSkills.elemental = amaSkill;
        PPet->WorkingSkills.dark = amaSkill;

        // Объявление переменных, нужных для рассчета.
        float raceStat = 0;			// конечное число HP для уровня на основе расы.
        float jobStat = 0;			// конечное число HP для уровня на основе первичной профессии.
        float sJobStat = 0;			// коенчное число HP для уровня на основе вторичной профессии.
        int32 bonusStat = 0;			// бонусное число HP которое добавляется при соблюдении некоторых условий.
        int32 baseValueColumn = 0;	// номер колонки с базовым количеством HP
        int32 scaleTo60Column = 1;	// номер колонки с модификатором до 60 уровня
        int32 scaleOver30Column = 2;	// номер колонки с модификатором после 30 уровня
        int32 scaleOver60Column = 3;	// номер колонки с модификатором после 60 уровня
        int32 scaleOver75Column = 4;	// номер колонки с модификатором после 75 уровня
        int32 scaleOver60 = 2;			// номер колонки с модификатором для расчета MP после 60 уровня
        // int32 scaleOver75 = 3;			// номер колонки с модификатором для расчета Статов после 75-го уровня

        uint8 grade;

        uint8 mlvl = PPet->GetMLevel();
        JOBTYPE mjob = PPet->GetMJob();
        JOBTYPE sjob = PPet->GetSJob();
        // Расчет прироста HP от main job
        int32 mainLevelOver30 = std::clamp(mlvl - 30, 0, 30);			// Расчет условия +1HP каждый лвл после 30 уровня
        int32 mainLevelUpTo60 = (mlvl < 60 ? mlvl - 1 : 59);			// Первый режим рассчета до 60 уровня (Используется так же и для MP)
        int32 mainLevelOver60To75 = std::clamp(mlvl - 60, 0, 15);		// Второй режим расчета после 60 уровня
        int32 mainLevelOver75 = (mlvl < 75 ? 0 : mlvl - 75);			// Третий режим расчета после 75 уровня

        //Расчет бонусного количества HP
        int32 mainLevelOver10 = (mlvl < 10 ? 0 : mlvl - 10);			// +2HP на каждом уровне после 10
        int32 mainLevelOver50andUnder60 = std::clamp(mlvl - 50, 0, 10);	// +2HP на каждом уровне в промежутке от 50 до 60 уровня
        int32 mainLevelOver60 = (mlvl < 60 ? 0 : mlvl - 60);

        // Расчет raceStat jobStat bonusStat sJobStat
        // Расчет по расе

        grade = 4;

        raceStat = grade::GetHPScale(grade, baseValueColumn) +
            (grade::GetHPScale(grade, scaleTo60Column) * mainLevelUpTo60) +
            (grade::GetHPScale(grade, scaleOver30Column) * mainLevelOver30) +
            (grade::GetHPScale(grade, scaleOver60Column) * mainLevelOver60To75) +
            (grade::GetHPScale(grade, scaleOver75Column) * mainLevelOver75);

        // raceStat = (int32)(statScale[grade][baseValueColumn] + statScale[grade][scaleTo60Column] * (mlvl - 1));

        // Расчет по main job
        grade = grade::GetJobGrade(mjob, 0);

        jobStat = grade::GetHPScale(grade, baseValueColumn) +
            (grade::GetHPScale(grade, scaleTo60Column) * mainLevelUpTo60) +
            (grade::GetHPScale(grade, scaleOver30Column) * mainLevelOver30) +
            (grade::GetHPScale(grade, scaleOver60Column) * mainLevelOver60To75) +
            (grade::GetHPScale(grade, scaleOver75Column) * mainLevelOver75);

        // Расчет бонусных HP
        bonusStat = (mainLevelOver10 + mainLevelOver50andUnder60) * 2;
        PPet->health.maxhp = (int32)((raceStat + jobStat + bonusStat + sJobStat) * petStats->HPscale);
        PPet->health.hp = PPet->health.maxhp;

        //Начало расчера MP
        raceStat = 0;
        jobStat = 0;
        sJobStat = 0;

        // Расчет MP расе.
        grade = 4;

        //Если у main job нет МП рейтинга, расчитиваем расовый бонус на основе уровня subjob уровня(при условии, что у него есть МП рейтинг)
        if (!(grade::GetJobGrade(mjob, 1) == 0 && grade::GetJobGrade(sjob, 1) == 0))
        {
            //Расчет нормального расового бонуса
            raceStat = grade::GetMPScale(grade, 0) +
                grade::GetMPScale(grade, scaleTo60Column) * mainLevelUpTo60 +
                grade::GetMPScale(grade, scaleOver60) * mainLevelOver60;
        }

        //Для главной профессии
        grade = grade::GetJobGrade(mjob, 1);
        if (grade > 0)
        {
            jobStat = grade::GetMPScale(grade, 0) +
                grade::GetMPScale(grade, scaleTo60Column) * mainLevelUpTo60 +
                grade::GetMPScale(grade, scaleOver60) * mainLevelOver60;
        }

        grade = grade::GetJobGrade(sjob, 1);
        if (grade > 0)
        {
            sJobStat = grade::GetMPScale(grade, 0) +
                grade::GetMPScale(grade, scaleTo60Column) * mainLevelUpTo60 +
                grade::GetMPScale(grade, scaleOver60) * mainLevelOver60;
        }

        PPet->health.maxmp = (int32)((raceStat + jobStat + sJobStat) * petStats->MPscale);
        PPet->health.mp = PPet->health.maxmp;

        uint16 fSTR = GetBaseToRank(petStats->strRank, PPet->GetMLevel());
        uint16 fDEX = GetBaseToRank(petStats->dexRank, PPet->GetMLevel());
        uint16 fVIT = GetBaseToRank(petStats->vitRank, PPet->GetMLevel());
        uint16 fAGI = GetBaseToRank(petStats->agiRank, PPet->GetMLevel());
        uint16 fINT = GetBaseToRank(petStats->intRank, PPet->GetMLevel());
        uint16 fMND = GetBaseToRank(petStats->mndRank, PPet->GetMLevel());
        uint16 fCHR = GetBaseToRank(petStats->chrRank, PPet->GetMLevel());

        uint16 mSTR = GetBaseToRank(grade::GetJobGrade(PPet->GetMJob(), 2), PPet->GetMLevel());
        uint16 mDEX = GetBaseToRank(grade::GetJobGrade(PPet->GetMJob(), 3), PPet->GetMLevel());
        uint16 mVIT = GetBaseToRank(grade::GetJobGrade(PPet->GetMJob(), 4), PPet->GetMLevel());
        uint16 mAGI = GetBaseToRank(grade::GetJobGrade(PPet->GetMJob(), 5), PPet->GetMLevel());
        uint16 mINT = GetBaseToRank(grade::GetJobGrade(PPet->GetMJob(), 6), PPet->GetMLevel());
        uint16 mMND = GetBaseToRank(grade::GetJobGrade(PPet->GetMJob(), 7), PPet->GetMLevel());
        uint16 mCHR = GetBaseToRank(grade::GetJobGrade(PPet->GetMJob(), 8), PPet->GetMLevel());

        uint16 sSTR = GetBaseToRank(grade::GetJobGrade(PPet->GetSJob(), 2), PPet->GetSLevel());
        uint16 sDEX = GetBaseToRank(grade::GetJobGrade(PPet->GetSJob(), 3), PPet->GetSLevel());
        uint16 sVIT = GetBaseToRank(grade::GetJobGrade(PPet->GetSJob(), 4), PPet->GetSLevel());
        uint16 sAGI = GetBaseToRank(grade::GetJobGrade(PPet->GetSJob(), 5), PPet->GetSLevel());
        uint16 sINT = GetBaseToRank(grade::GetJobGrade(PPet->GetSJob(), 6), PPet->GetSLevel());
        uint16 sMND = GetBaseToRank(grade::GetJobGrade(PPet->GetSJob(), 7), PPet->GetSLevel());
        uint16 sCHR = GetBaseToRank(grade::GetJobGrade(PPet->GetSJob(), 8), PPet->GetSLevel());

        PPet->stats.STR = fSTR + mSTR + sSTR;
        PPet->stats.DEX = fDEX + mDEX + sDEX;
        PPet->stats.VIT = fVIT + mVIT + sVIT;
        PPet->stats.AGI = fAGI + mAGI + sAGI;
        PPet->stats.INT = fINT + mINT + sINT;
        PPet->stats.MND = fMND + mMND + sMND;
        PPet->stats.CHR = fCHR + mCHR + sCHR;

        ((CItemWeapon*)PPet->m_Weapons[SLOT_MAIN])->setSkillType(SKILL_AUTOMATON_MELEE);
        ((CItemWeapon*)PPet->m_Weapons[SLOT_MAIN])->setDelay((uint16)(floor(1000.0f * (petStats->cmbDelay / 60.0f)))); //every pet should use this eventually
        ((CItemWeapon*)PPet->m_Weapons[SLOT_MAIN])->setDamage((PPet->GetSkill(SKILL_AUTOMATON_MELEE) / 9) * 2 + 3);

        ((CItemWeapon*)PPet->m_Weapons[SLOT_RANGED])->setSkillType(SKILL_AUTOMATON_RANGED);
        ((CItemWeapon*)PPet->m_Weapons[SLOT_RANGED])->setDamage((PPet->GetSkill(SKILL_AUTOMATON_RANGED) / 9) * 2 + 3);

        CAutomatonEntity* PAutomaton = (CAutomatonEntity*)PPet;

        // Automatons are hard to interrupt
        PPet->addModifier(Mod::SPELLINTERRUPT, 85);

        switch (PAutomaton->getFrame())
        {
        default: //case FRAME_HARLEQUIN:
            PPet->WorkingSkills.evasion = battleutils::GetMaxSkill(2, PPet->GetMLevel());
            PPet->setModifier(Mod::DEF, battleutils::GetMaxSkill(10, PPet->GetMLevel()));
            break;
        case FRAME_VALOREDGE:
            PPet->m_Weapons[SLOT_SUB]->setShieldSize(3);
            PPet->WorkingSkills.evasion = battleutils::GetMaxSkill(5, PPet->GetMLevel());
            PPet->setModifier(Mod::DEF, battleutils::GetMaxSkill(5, PPet->GetMLevel()));
            break;
        case FRAME_SHARPSHOT:
            PPet->WorkingSkills.evasion = battleutils::GetMaxSkill(1, PPet->GetMLevel());
            PPet->setModifier(Mod::DEF, battleutils::GetMaxSkill(11, PPet->GetMLevel()));
            break;
        case FRAME_STORMWAKER:
            PPet->WorkingSkills.evasion = battleutils::GetMaxSkill(10, PPet->GetMLevel());
            PPet->setModifier(Mod::DEF, battleutils::GetMaxSkill(12, PPet->GetMLevel()));
            break;
        }
    }


    void LoadAvatarStats(CPetEntity* PPet)
    {
        // Объявление переменных, нужных для рассчета.
        float raceStat = 0;			// конечное число HP для уровня на основе расы.
        float jobStat = 0;			// конечное число HP для уровня на основе первичной профессии.
        float sJobStat = 0;			// коенчное число HP для уровня на основе вторичной профессии.
        int32 bonusStat = 0;			// бонусное число HP которое добавляется при соблюдении некоторых условий.
        int32 baseValueColumn = 0;	// номер колонки с базовым количеством HP
        int32 scaleTo60Column = 1;	// номер колонки с модификатором до 60 уровня
        int32 scaleOver30Column = 2;	// номер колонки с модификатором после 30 уровня
        int32 scaleOver60Column = 3;	// номер колонки с модификатором после 60 уровня
        int32 scaleOver75Column = 4;	// номер колонки с модификатором после 75 уровня
        int32 scaleOver60 = 2;			// номер колонки с модификатором для расчета MP после 60 уровня
        int32 scaleOver75 = 3;			// номер колонки с модификатором для расчета Статов после 75-го уровня

        uint8 grade;

        uint8 mlvl = PPet->GetMLevel();
        JOBTYPE mjob = PPet->GetMJob();
        uint8 race = 3;					//Tarutaru

        // Расчет прироста HP от main job
        int32 mainLevelOver30 = std::clamp(mlvl - 30, 0, 30);			// Расчет условия +1HP каждый лвл после 30 уровня
        int32 mainLevelUpTo60 = (mlvl < 60 ? mlvl - 1 : 59);			// Первый режим рассчета до 60 уровня (Используется так же и для MP)
        int32 mainLevelOver60To75 = std::clamp(mlvl - 60, 0, 15);		// Второй режим расчета после 60 уровня
        int32 mainLevelOver75 = (mlvl < 75 ? 0 : mlvl - 75);			// Третий режим расчета после 75 уровня

        //Расчет бонусного количества HP
        int32 mainLevelOver10 = (mlvl < 10 ? 0 : mlvl - 10);			// +2HP на каждом уровне после 10
        int32 mainLevelOver50andUnder60 = std::clamp(mlvl - 50, 0, 10);	// +2HP на каждом уровне в промежутке от 50 до 60 уровня
        int32 mainLevelOver60 = (mlvl < 60 ? 0 : mlvl - 60);

        // Расчет raceStat jobStat bonusStat sJobStat
        // Расчет по расе

        grade = grade::GetRaceGrades(race, 0);

        raceStat = grade::GetHPScale(grade, baseValueColumn) +
            (grade::GetHPScale(grade, scaleTo60Column) * mainLevelUpTo60) +
            (grade::GetHPScale(grade, scaleOver30Column) * mainLevelOver30) +
            (grade::GetHPScale(grade, scaleOver60Column) * mainLevelOver60To75) +
            (grade::GetHPScale(grade, scaleOver75Column) * mainLevelOver75);

        // raceStat = (int32)(statScale[grade][baseValueColumn] + statScale[grade][scaleTo60Column] * (mlvl - 1));

        // Расчет по main job
        grade = grade::GetJobGrade(mjob, 0);

        jobStat = grade::GetHPScale(grade, baseValueColumn) +
            (grade::GetHPScale(grade, scaleTo60Column) * mainLevelUpTo60) +
            (grade::GetHPScale(grade, scaleOver30Column) * mainLevelOver30) +
            (grade::GetHPScale(grade, scaleOver60Column) * mainLevelOver60To75) +
            (grade::GetHPScale(grade, scaleOver75Column) * mainLevelOver75);

        // Расчет бонусных HP
        bonusStat = (mainLevelOver10 + mainLevelOver50andUnder60) * 2;
        if (PPet->m_PetID == PETID_ODIN || PPet->m_PetID == PETID_ALEXANDER)
            bonusStat += 6800;
        PPet->health.maxhp = (int16)(raceStat + jobStat + bonusStat + sJobStat);
        PPet->health.hp = PPet->health.maxhp;

        //Начало расчера MP
        raceStat = 0;
        jobStat = 0;
        sJobStat = 0;

        // Расчет MP расе.
        grade = grade::GetRaceGrades(race, 1);

        //Если у main job нет МП рейтинга, расчитиваем расовый бонус на основе уровня subjob уровня(при условии, что у него есть МП рейтинг)
        if (grade::GetJobGrade(mjob, 1) == 0)
        {
            // empty
        }
        else
        {
            //Расчет нормального расового бонуса
            raceStat = grade::GetMPScale(grade, 0) +
                grade::GetMPScale(grade, scaleTo60Column) * mainLevelUpTo60 +
                grade::GetMPScale(grade, scaleOver60) * mainLevelOver60;
        }

        //Для главной профессии
        grade = grade::GetJobGrade(mjob, 1);
        if (grade > 0)
        {
            jobStat = grade::GetMPScale(grade, 0) +
                grade::GetMPScale(grade, scaleTo60Column) * mainLevelUpTo60 +
                grade::GetMPScale(grade, scaleOver60) * mainLevelOver60;
        }

        PPet->health.maxmp = (int16)(raceStat + jobStat + sJobStat); // результат расчета MP
        PPet->health.mp = PPet->health.maxmp;
        //add in evasion from skill
        int16 evaskill = PPet->GetSkill(SKILL_EVASION);
        int16 eva = evaskill;
        if (evaskill > 200){ //Evasion skill is 0.9 evasion post-200
            eva = (int16)(200 + (evaskill - 200) * 0.9);
        }
        PPet->setModifier(Mod::EVA, eva);


        //Начало расчета характеристик
        uint8 counter = 0;
        for (uint8 StatIndex = 2; StatIndex <= 8; ++StatIndex)
        {
            // расчет по расе
            grade = grade::GetRaceGrades(race, StatIndex);
            raceStat = grade::GetStatScale(grade, 0) + grade::GetStatScale(grade, scaleTo60Column) * mainLevelUpTo60;

            if (mainLevelOver60 > 0)
            {
                raceStat += grade::GetStatScale(grade, scaleOver60) * mainLevelOver60;
                if (mainLevelOver75 > 0)
                {
                    raceStat += grade::GetStatScale(grade, scaleOver75) * mainLevelOver75 - (mlvl >= 75 ? 0.01f : 0);
                }
            }

            // расчет по профессии
            grade = grade::GetJobGrade(mjob, StatIndex);
            jobStat = grade::GetStatScale(grade, 0) + grade::GetStatScale(grade, scaleTo60Column) * mainLevelUpTo60;

            if (mainLevelOver60 > 0)
            {
                jobStat += grade::GetStatScale(grade, scaleOver60) * mainLevelOver60;

                if (mainLevelOver75 > 0)
                {
                    jobStat += grade::GetStatScale(grade, scaleOver75) * mainLevelOver75 - (mlvl >= 75 ? 0.01f : 0);
                }
            }

            jobStat = jobStat * 1.5f; //stats from subjob (assuming BLM/BLM for avatars)

            // Вывод значения
            ref<uint16>(&PPet->stats, counter) = (uint16)(raceStat + jobStat);
            counter += 2;
        }
    }

    /************************************************************************
    *																		*
    *																		*
    *																		*
    ************************************************************************/

    void SpawnPet(CBattleEntity* PMaster, uint32 PetID, bool spawningFromZone)
    {
        TPZ_DEBUG_BREAK_IF(PMaster->PPet != nullptr);
        if (PMaster->objtype == TYPE_PC && (PetID == PETID_HARLEQUINFRAME || PetID == PETID_VALOREDGEFRAME || PetID == PETID_SHARPSHOTFRAME || PetID == PETID_STORMWAKERFRAME))
        {
            puppetutils::LoadAutomaton(static_cast<CCharEntity*>(PMaster));
            PMaster->PPet = static_cast<CCharEntity*>(PMaster)->PAutomaton;
        }
        else
        {
            LoadPet(PMaster, PetID, spawningFromZone);
        }

        CPetEntity* PPet = (CPetEntity*)PMaster->PPet;
        if (PPet)
        {
            PPet->allegiance = PMaster->allegiance;
            PMaster->StatusEffectContainer->CopyConfrontationEffect(PPet);

            PPet->PMaster = PMaster;

            if (PMaster->PBattlefield)
            {
                PPet->PBattlefield = PMaster->PBattlefield;
            }

            if (PMaster->PInstance)
            {
                PPet->PInstance = PMaster->PInstance;
            }

            PMaster->loc.zone->InsertPET(PPet);

            PPet->Spawn();
            if (PMaster->objtype == TYPE_PC)
            {
                charutils::BuildingCharAbilityTable((CCharEntity*)PMaster);
                charutils::BuildingCharPetAbilityTable((CCharEntity*)PMaster, PPet, PetID);
                ((CCharEntity*)PMaster)->pushPacket(new CCharUpdatePacket((CCharEntity*)PMaster));
                ((CCharEntity*)PMaster)->pushPacket(new CPetSyncPacket((CCharEntity*)PMaster));

                // check latents affected by pets
                ((CCharEntity*)PMaster)->PLatentEffectContainer->CheckLatentsPetType();
                PMaster->ForParty([](CBattleEntity* PMember)
                {
                    ((CCharEntity*)PMember)->PLatentEffectContainer->CheckLatentsPartyAvatar();
                });
            }
            // apply stats from previous zone if this pet is being transfered
            if (spawningFromZone == true)
            {
                PPet->health.tp = (int16)((CCharEntity*)PMaster)->petZoningInfo.petTP;
                PPet->health.hp = ((CCharEntity*)PMaster)->petZoningInfo.petHP;
                PPet->health.mp = ((CCharEntity*)PMaster)->petZoningInfo.petMP;
            }
        }
        else if (PMaster->objtype == TYPE_PC)
        {
            static_cast<CCharEntity*>(PMaster)->resetPetZoningInfo();
        }
    }

    void SpawnMobPet(CBattleEntity* PMaster, uint32 PetID)
    {
        // this is ONLY used for mob smn elementals / avatars
        /*
        This should eventually be merged into one big spawn pet method.
        At the moment player pets and mob pets are totally different. We need a central place
        to manage pet families and spawn them.
        */

        // grab pet info
        Pet_t* petData = g_PPetList.at(PetID);
        CMobEntity* PPet = (CMobEntity*)PMaster->PPet;

        PPet->look = petData->look;
        PPet->name = petData->name;
        PPet->SetMJob(petData->mJob);
        PPet->m_EcoSystem = petData->EcoSystem;
        PPet->m_Family = petData->m_Family;
        PPet->m_Element = petData->m_Element;
        PPet->HPscale = petData->HPscale;
        PPet->MPscale = petData->MPscale;
        PPet->m_HasSpellScript = petData->hasSpellScript;

        PPet->allegiance = PMaster->allegiance;
        PMaster->StatusEffectContainer->CopyConfrontationEffect(PPet);

        if (PPet->m_EcoSystem == SYSTEM_AVATAR || PPet->m_EcoSystem == SYSTEM_ELEMENTAL)
        {
            // assuming elemental spawn
            PPet->setModifier(Mod::DMGPHYS, -50); //-50% PDT
        }

        PPet->m_SpellListContainer = mobSpellList::GetMobSpellList(petData->spellList);

        PPet->setModifier(Mod::SLASHRES, petData->slashres);
        PPet->setModifier(Mod::PIERCERES, petData->pierceres);
        PPet->setModifier(Mod::HTHRES, petData->hthres);
        PPet->setModifier(Mod::IMPACTRES, petData->impactres);

        PPet->setModifier(Mod::FIREDEF, petData->firedef); // These are stored as floating percentages
        PPet->setModifier(Mod::ICEDEF, petData->icedef); // and need to be adjusted into modifier units.
        PPet->setModifier(Mod::WINDDEF, petData->winddef); // Higher DEF = lower damage.
        PPet->setModifier(Mod::EARTHDEF, petData->earthdef); // Negatives signify increased damage.
        PPet->setModifier(Mod::THUNDERDEF, petData->thunderdef); // Positives signify reduced damage.
        PPet->setModifier(Mod::WATERDEF, petData->waterdef); // Ex: 125% damage would be 1.25, 50% damage would be 0.50
        PPet->setModifier(Mod::LIGHTDEF, petData->lightdef); // (1.25 - 1) * -1000 = -250 DEF
        PPet->setModifier(Mod::DARKDEF, petData->darkdef); // (0.50 - 1) * -1000 = 500 DEF

        PPet->setModifier(Mod::SDT_FIRE, petData->fireresSDT);
        PPet->setModifier(Mod::SDT_ICE, petData->iceresSDT);
        PPet->setModifier(Mod::SDT_WIND, petData->windresSDT);
        PPet->setModifier(Mod::SDT_EARTH, petData->earthresSDT);
        PPet->setModifier(Mod::SDT_THUNDER, petData->thunderresSDT);
        PPet->setModifier(Mod::SDT_WATER, petData->waterresSDT);
        PPet->setModifier(Mod::SDT_LIGHT, petData->lightresSDT);
        PPet->setModifier(Mod::SDT_DARK, petData->darkresSDT);

        if (PPet->m_EcoSystem == SYSTEM_AVATAR || PPet->m_EcoSystem == SYSTEM_ELEMENTAL)
        {
            // assuming elemental spawn
            PPet->setModifier(Mod::SLASHRES, 500);
            PPet->setModifier(Mod::PIERCERES, 500);
            PPet->setModifier(Mod::IMPACTRES, 500);
            PPet->setModifier(Mod::HTHRES, 500);
        }
    }

    void DetachPet(CBattleEntity* PMaster)
    {
        TPZ_DEBUG_BREAK_IF(PMaster->PPet == nullptr);
        TPZ_DEBUG_BREAK_IF(PMaster->objtype != TYPE_PC);

        CBattleEntity* PPet = PMaster->PPet;
        CCharEntity* PChar = (CCharEntity*)PMaster;


        if (PPet->objtype == TYPE_MOB)
        {
            CMobEntity* PMob = (CMobEntity*)PPet;

            if (!PMob->isDead())
            {
                PMob->PAI->Disengage();

                // charm time is up, mob attacks player now
                if (PMob->PEnmityContainer->IsWithinEnmityRange(PMob->PMaster))
                {
                    PMob->PEnmityContainer->UpdateEnmity(PChar, 0, 0);
                }
                else
                {
                    PMob->m_OwnerID.clean();
                    PMob->updatemask |= UPDATE_STATUS;
                }

                // dirty exp if not full
                PMob->m_giveExp = PMob->GetHPP() == 100;

                //master using leave command
                auto state = dynamic_cast<CAbilityState*>(PMaster->PAI->GetCurrentState());
                if ((state && state->GetAbility()->getID() == ABILITY_LEAVE) || PChar->loc.zoning || PChar->isDead())
                {
                    PMob->PEnmityContainer->Clear();
                    PMob->m_OwnerID.clean();
                    PMob->updatemask |= UPDATE_STATUS;
                }

            }
            else
            {
                PMob->m_OwnerID.clean();
                PMob->updatemask |= UPDATE_STATUS;
            }

            PMob->isCharmed = false;
            PMob->allegiance = ALLEGIANCE_MOB;
            PMob->charmTime = time_point::min();
            PMob->PMaster = nullptr;

            PMob->PAI->SetController(std::make_unique<CMobController>(PMob));
        }
        else if (PPet->objtype == TYPE_PET)
        {
            if (!PPet->isDead())
                PPet->Die();
            CPetEntity* PPetEnt = (CPetEntity*)PPet;

            if (PPetEnt->getPetType() == PETTYPE_AVATAR)
                PMaster->setModifier(Mod::AVATAR_PERPETUATION, 0);

            ((CCharEntity*)PMaster)->PLatentEffectContainer->CheckLatentsPetType();
            PMaster->ForParty([](CBattleEntity* PMember)
            {
                ((CCharEntity*)PMember)->PLatentEffectContainer->CheckLatentsPartyAvatar();
            });

            if (PPetEnt->getPetType() != PETTYPE_AUTOMATON)
            {
                PPetEnt->PMaster = nullptr;
            }
            else
            {
                PPetEnt->PAI->SetController(nullptr);
            }
            PChar->removePetModifiers(PPetEnt);
            charutils::BuildingCharPetAbilityTable(PChar, PPetEnt, 0);// blank the pet commands
        }

        charutils::BuildingCharAbilityTable(PChar);
        PChar->PPet = nullptr;
        PChar->pushPacket(new CCharUpdatePacket(PChar));
        PChar->pushPacket(new CCharAbilitiesPacket(PChar));
        PChar->pushPacket(new CPetSyncPacket(PChar));
    }

    /************************************************************************
    *																		*
    *																		*
    *																		*
    ************************************************************************/

    void DespawnPet(CBattleEntity* PMaster)
    {
        TPZ_DEBUG_BREAK_IF(PMaster->PPet == nullptr);

        petutils::DetachPet(PMaster);
    }

    int16 PerpetuationCost(uint32 id, uint8 level)
    {
        int16 cost = 0;
        if (id >= 0 && id <= 7)
        {
            if (level < 19)
                cost = 1;
            else if (level < 38)
                cost = 2;
            else if (level < 57)
                cost = 3;
            else if (level < 75)
                cost = 4;
            else if (level < 81)
                cost = 5;
            else if (level < 91)
                cost = 6;
            else
                cost = 7;
        }
        else if (id == 8)
        {
            if (level < 10)
                cost = 1;
            else if (level < 18)
                cost = 2;
            else if (level < 27)
                cost = 3;
            else if (level < 36)
                cost = 4;
            else if (level < 45)
                cost = 5;
            else if (level < 54)
                cost = 6;
            else if (level < 63)
                cost = 7;
            else if (level < 72)
                cost = 8;
            else if (level < 81)
                cost = 9;
            else if (level < 91)
                cost = 10;
            else
                cost = 11;
        }
        else if (id == 9)
        {
            if (level < 8)
                cost = 1;
            else if (level < 15)
                cost = 2;
            else if (level < 22)
                cost = 3;
            else if (level < 30)
                cost = 4;
            else if (level < 37)
                cost = 5;
            else if (level < 45)
                cost = 6;
            else if (level < 51)
                cost = 7;
            else if (level < 59)
                cost = 8;
            else if (level < 66)
                cost = 9;
            else if (level < 73)
                cost = 10;
            else if (level < 81)
                cost = 11;
            else if (level < 91)
                cost = 12;
            else
                cost = 13;
        }
        else if (id <= 16)
        {
            if (level < 10)
                cost = 3;
            else if (level < 19)
                cost = 4;
            else if (level < 28)
                cost = 5;
            else if (level < 38)
                cost = 6;
            else if (level < 47)
                cost = 7;
            else if (level < 56)
                cost = 8;
            else if (level < 65)
                cost = 9;
            else if (level < 68)
                cost = 10;
            else if (level < 71)
                cost = 11;
            else if (level < 74)
                cost = 12;
            else if (level < 81)
                cost = 13;
            else if (level < 91)
                cost = 14;
            else
                cost = 15;
        }

        return cost;
    }

    /*
    Familiars a pet.
    */
    void Familiar(CBattleEntity* PPet)
    {

        /*
            Boost HP by 10%
            Increase charm duration up to 30 mins
            boost stats by 10%
            */

        // only increase time for charmed mobs
        if (PPet->objtype == TYPE_MOB && PPet->isCharmed)
        {
            // increase charm duration
            // 30 mins - 1-5 mins
            PPet->charmTime += 30min - std::chrono::milliseconds(tpzrand::GetRandomNumber(300000u));
        }

        float rate = 0.10f;

        // boost hp by 10%
        uint16 boost = (uint16)(PPet->health.maxhp * rate);

        PPet->health.maxhp += boost;
        PPet->health.hp += boost;
        PPet->UpdateHealth();

        // boost stats by 10%
        PPet->addModifier(Mod::ATTP, (int16)(rate * 100.0f));
        PPet->addModifier(Mod::ACC, (int16)(rate * 100.0f));
        PPet->addModifier(Mod::EVA, (int16)(rate * 100.0f));
        PPet->addModifier(Mod::DEFP, (int16)(rate * 100.0f));

    }

    void LoadPet(CBattleEntity* PMaster, uint32 PetID, bool spawningFromZone)
    {
        TPZ_DEBUG_BREAK_IF(PMaster == nullptr);
        TPZ_DEBUG_BREAK_IF(PetID >= MAX_PETID);

        Pet_t* PPetData = new Pet_t();

        PPetData = *std::find_if(g_PPetList.begin(), g_PPetList.end(), [PetID](Pet_t* t) { return t->PetID == PetID; });

        if (PMaster->GetMJob() != JOB_DRG && PetID == PETID_WYVERN)
        {
            return;
        }

        if (PMaster->objtype == TYPE_PC)
        {
            ((CCharEntity*)PMaster)->petZoningInfo.petID = PetID;
        }

        PETTYPE petType = PETTYPE_JUG_PET;

        if (PetID <= PETID_CAIT_SITH)
        {
            petType = PETTYPE_AVATAR;
        }
        //TODO: move this out of modifying the global pet list
        else if (PetID == PETID_WYVERN)
        {
            petType = PETTYPE_WYVERN;

            const char* Query =
                "SELECT\
                pet_name.name,\
                char_pet.wyvernid\
                FROM pet_name, char_pet\
                WHERE pet_name.id = char_pet.wyvernid AND \
                char_pet.charid = %u";

            if (Sql_Query(SqlHandle, Query, PMaster->id) != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
            {
                while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
                {
                    uint16 wyvernid = (uint16)Sql_GetIntData(SqlHandle, 1);

                    if (wyvernid != 0)
                    {
                        PPetData->name.clear();
                        PPetData->name.insert(0, (const char*)Sql_GetData(SqlHandle, 0));
                    }
                }
            }
        }
        /*
        else if (PetID==PETID_ADVENTURING_FELLOW)
        {
            petType = PETTYPE_ADVENTURING_FELLOW;

            const char* Query =
            "SELECT\
            pet_name.name,\
            char_pet.adventuringfellowid\
            FROM pet_name, char_pet\
            WHERE pet_name.id = char_pet.adventuringfellowid";

            if ( Sql_Query(SqlHandle, Query) != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
            {
                while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
                {
                    uint16 adventuringfellowid = (uint16)Sql_GetIntData(SqlHandle, 1);

                    if (adventuringfellowid != 0)
                    {
                        g_PPetList.at(PetID)->name.clear();
                        g_PPetList.at(PetID)->name.insert(0, Sql_GetData(SqlHandle, 0));
                    }
                }
            }
        }
        */
        else if (PetID == PETID_CHOCOBO)
        {
            petType = PETTYPE_CHOCOBO;

            const char* Query =
                "SELECT\
                char_pet.chocoboid\
                FROM char_pet\
                char_pet.charid = %u";

            if (Sql_Query(SqlHandle, Query, PMaster->id) != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
            {
                while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
                {
                    uint32 chocoboid = (uint32)Sql_GetIntData(SqlHandle, 0);

                    if (chocoboid != 0)
                    {
                        uint16 chocoboname1 = chocoboid & 0x0000FFFF;
                        uint16 chocoboname2 = chocoboid >>= 16;

                        PPetData->name.clear();

                        Query =
                            "SELECT\
                            pet_name.name\
                            FROM pet_name\
                            WHERE pet_name.id = %u OR pet_name.id = %u";

                        if (Sql_Query(SqlHandle, Query, chocoboname1, chocoboname2) != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
                        {
                            while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
                            {
                                if (chocoboname1 != 0 && chocoboname2 != 0)
                                {
                                    PPetData->name.insert(0, (const char*)Sql_GetData(SqlHandle, 0));
                                }
                            }
                        }
                    }
                }
            }
        }
        else if (PetID == PETID_HARLEQUINFRAME || PetID == PETID_VALOREDGEFRAME || PetID == PETID_SHARPSHOTFRAME || PetID == PETID_STORMWAKERFRAME)
        {
            petType = PETTYPE_AUTOMATON;
        }
        else if (PetID == PETID_LUOPAN)
        {
            petType = PETTYPE_LUOPAN;
        }

        CPetEntity* PPet = nullptr;
        if (petType == PETTYPE_AUTOMATON && PMaster->objtype == TYPE_PC)
        {
            PPet = ((CCharEntity*)PMaster)->PAutomaton;
            PPet->PAI->SetController(std::make_unique<CAutomatonController>(static_cast<CAutomatonEntity*>(PPet)));
        }
        else
        {
            PPet = new CPetEntity(petType);
        }

        PPet->loc = PMaster->loc;
        if (petType != PETTYPE_LUOPAN)
        {
            // spawn me randomly around master
            PPet->loc.p = nearPosition(PMaster->loc.p, CPetController::PetRoamDistance, (float)M_PI);
        }

        if (petType != PETTYPE_AUTOMATON)
        {
            PPet->look = PPetData->look;
            PPet->name = PPetData->name;
        }
        else
        {
            PPet->look.size = MODEL_AUTOMATON;
        }
        PPet->m_name_prefix = PPetData->name_prefix;
        PPet->m_Family = PPetData->m_Family;
        PPet->m_MobSkillList = PPetData->m_MobSkillList;
        PPet->SetMJob(JOB_DRK);
        PPet->SetSJob(JOB_BLM);
        PPet->m_Element = PPetData->m_Element;
        PPet->m_PetID = PPetData->PetID;

        if (PPet->getPetType() == PETTYPE_AVATAR)
        {
            if (PMaster->GetMJob() == JOB_SMN)
            {
                PPet->SetMLevel(PMaster->GetMLevel());
            }
            else if (PMaster->GetSJob() == JOB_SMN)
            {
                PPet->SetMLevel(PMaster->GetSLevel());
            }
            else{ //should never happen
                ShowDebug("%s summoned an avatar but is not SMN main or SMN sub! Please report. \n", PMaster->GetName());
                PPet->SetMLevel(1);
            }
            LoadAvatarStats(PPet); //follows PC calcs (w/o SJ)

            PPet->m_SpellListContainer = mobSpellList::GetMobSpellList(PPetData->spellList);

            // All pets have MAB equal to main job BLM
            if (PPet->GetMLevel() >= 70)
            {
                PPet->setModifier(Mod::MATT, 32);
            }
            else if (PPet->GetMLevel() >= 50)
            {
                PPet->setModifier(Mod::MATT, 28);
            }
            else if (PPet->GetMLevel() >= 30)
            {
                PPet->setModifier(Mod::MATT, 24);
            }
            else if (PPet->GetMLevel() >= 10)
            {
                PPet->setModifier(Mod::MATT, 20);
            }

            // -50% DR to all physical attacks
            PPet->setModifier(Mod::SLASHRES, 500);
            PPet->setModifier(Mod::PIERCERES, 500);
            PPet->setModifier(Mod::IMPACTRES, 500);
            PPet->setModifier(Mod::HTHRES, 500);

            // High refresh so Elementals don't oom
            PPet->setModifier(Mod::REFRESH, 500);

            ((CItemWeapon*)PPet->m_Weapons[SLOT_MAIN])->setDelay((uint16)(floor(1000.0f * (320.0f / 60.0f))));

            if (PetID == PETID_FENRIR || PetID == PETID_DIABOLOS)
            {
                ((CItemWeapon*)PPet->m_Weapons[SLOT_MAIN])->setDelay((uint16)(floor(1000.0 * (280.0f / 60.0f))));
            }

            // In a 2014 update SE updated Avatar base damage
            // Based on testing this value appears to be Level now instead of Level * 0.74f
            uint16 weaponDamage = static_cast<uint16>(floor(PPet->GetMLevel() * 0.5f) + 10.0f);
            if (PetID == PETID_CARBUNCLE || PetID == PETID_CAIT_SITH)
            {
                weaponDamage = static_cast<uint16>(floor(PPet->GetMLevel() * 0.5f) + 3.0f);
            }

            // Carbuncle and Cait Sith are a WHM
            if (PetID == PETID_CARBUNCLE || PetID == PETID_CAIT_SITH)
            {
                PPet->SetMJob(JOB_WHM);
            }

            // Elemetal Spirits are BLM/RDM Light is WHM/RDM and Dark is DRK/RDM
            if (PetID >= PETID_FIRESPIRIT && PetID < PETID_LIGHTSPIRIT)
            {
                PPet->SetMJob(JOB_BLM);
                PPet->SetSJob(JOB_RDM);
                // No elemental staff. Need bonus Macc or they struggle to land spells.
                PPet->addModifier(Mod::MACC, 30);
            }

            // Set generic SDT
            PPet->setModifier(Mod::SDT_FIRE, 130);
            PPet->setModifier(Mod::SDT_EARTH, 130);
            PPet->setModifier(Mod::SDT_WATER, 130);
            PPet->setModifier(Mod::SDT_WIND, 130);
            PPet->setModifier(Mod::SDT_ICE, 130);
            PPet->setModifier(Mod::SDT_THUNDER, 130);
            PPet->setModifier(Mod::SDT_LIGHT, 130);
            PPet->setModifier(Mod::SDT_DARK, 130);

            // Set global avatar mods
            PPet->addModifier(Mod::SUBTLE_BLOW, 25);

            uint16 petRegen = PPet->GetMLevel() / 3;
            uint16 petCrit = PPet->GetMLevel() / 3;
            uint16 petDA = PPet->GetMLevel() / 3;
            uint16 petMAB = PPet->GetMLevel() / 7;

            // Specific stats and SDT for each Avatar / Elemental
            switch (PetID)
            {
                default:
                    PPet->setModifier(Mod::SDT_FIRE, 100);
                    PPet->setModifier(Mod::SDT_EARTH, 100);
                    PPet->setModifier(Mod::SDT_WATER, 100);
                    PPet->setModifier(Mod::SDT_WIND, 100);
                    PPet->setModifier(Mod::SDT_ICE, 100);
                    PPet->setModifier(Mod::SDT_THUNDER, 100);
                    PPet->setModifier(Mod::SDT_LIGHT, 100);
                    PPet->setModifier(Mod::SDT_DARK, 100);
                    break;
                case PETID_FIRESPIRIT:
                    PPet->setModifier(Mod::SDT_WATER, 150);
                    PPet->setModifier(Mod::SDT_ICE, 20);
                    PPet->setModifier(Mod::SDT_FIRE, 20);
                    break;
                case PETID_ICESPIRIT:
                    PPet->setModifier(Mod::SDT_FIRE, 150);
                    PPet->setModifier(Mod::SDT_ICE, 20);
                    PPet->setModifier(Mod::SDT_WIND, 20);
                    break;
                case PETID_AIRSPIRIT:
                    PPet->setModifier(Mod::SDT_ICE, 150);
                    PPet->setModifier(Mod::SDT_WIND, 20);
                    PPet->setModifier(Mod::SDT_EARTH, 20);
                    break;
                case PETID_EARTHSPIRIT:
                    PPet->setModifier(Mod::SDT_WIND, 150);
                    PPet->setModifier(Mod::SDT_EARTH, 20);
                    PPet->setModifier(Mod::SDT_THUNDER, 20);
                    break;
                case PETID_THUNDERSPIRIT:
                    PPet->setModifier(Mod::SDT_EARTH, 150);
                    PPet->setModifier(Mod::SDT_THUNDER, 20);
                    PPet->setModifier(Mod::SDT_WATER, 20);
                    break;
                case PETID_WATERSPIRIT:
                    PPet->setModifier(Mod::SDT_THUNDER, 150);
                    PPet->setModifier(Mod::SDT_WATER, 20);
                    PPet->setModifier(Mod::SDT_FIRE, 20);
                    PPet->m_Element = 0; // Water ie 0 ElementID for some reason
                    break;
                case PETID_LIGHTSPIRIT:
                    PPet->setModifier(Mod::SDT_DARK, 150);
                    PPet->setModifier(Mod::SDT_LIGHT, 20);
                    PPet->SetMJob(JOB_WHM);
                    PPet->SetSJob(JOB_RDM);
                    break;
                case PETID_DARKSPIRIT:
                    PPet->setModifier(Mod::SDT_LIGHT, 150);
                    PPet->setModifier(Mod::SDT_DARK, 20);
                    PPet->SetMJob(JOB_DRK);
                    PPet->SetSJob(JOB_RDM);
                    PPet->m_Element = 6; // Dark is 6 ElementID for some reason
                    break;
                case PETID_CARBUNCLE:
                    PPet->addModifier(Mod::REGEN, petRegen);
                    PPet->setModifier(Mod::SDT_DARK, 150);
                    PPet->setModifier(Mod::SDT_LIGHT, 20);
                    break;
                case PETID_FENRIR:
                    PPet->addModifier(Mod::ATTP, 30);
                    PPet->setModifier(Mod::SDT_LIGHT, 150);
                    PPet->setModifier(Mod::SDT_DARK, 20);
                    PPet->m_Element = 6; // Dark is 6 ElementID for some reason
                    break;
                case PETID_IFRIT:
                    PPet->addModifier(Mod::DOUBLE_ATTACK, petDA);
                    PPet->setModifier(Mod::SDT_WATER, 150);
                    PPet->setModifier(Mod::SDT_ICE, 20);
                    PPet->setModifier(Mod::SDT_FIRE, 20);
                    break;
                case PETID_TITAN:
                    PPet->addModifier(Mod::ENMITY, 30);
                    PPet->addModifier(Mod::UDMGPHYS, -50);
                    PPet->setModifier(Mod::SDT_WIND, 150);
                    PPet->setModifier(Mod::SDT_EARTH, 20);
                    PPet->setModifier(Mod::SDT_THUNDER, 20);
                    break;
                case PETID_LEVIATHAN:
                    PPet->addModifier(Mod::ENMITY, 30);
                    PPet->addModifier(Mod::UDMGMAGIC, -50);
                    PPet->setModifier(Mod::SDT_THUNDER, 150);
                    PPet->setModifier(Mod::SDT_WATER, 20);
                    PPet->setModifier(Mod::SDT_FIRE, 20);
                    PPet->m_Element = 0; // Water ie 0 ElementID for some reason
                    break;
                case PETID_GARUDA:
                    PPet->addModifier(Mod::EVA, 50);
                    PPet->setModifier(Mod::SDT_ICE, 150);
                    PPet->setModifier(Mod::SDT_WIND, 20);
                    PPet->setModifier(Mod::SDT_EARTH, 20);
                    break;
                case PETID_SHIVA:
                    PPet->addModifier(Mod::MATT, petMAB);
                    PPet->setModifier(Mod::SDT_FIRE, 150);
                    PPet->setModifier(Mod::SDT_ICE, 20);
                    PPet->setModifier(Mod::SDT_WIND, 20);
                    break;
                case PETID_RAMUH:
                    PPet->addModifier(Mod::ACC, 50);
                    PPet->setModifier(Mod::SDT_EARTH, 150);
                    PPet->setModifier(Mod::SDT_THUNDER, 20);
                    PPet->setModifier(Mod::SDT_WATER, 20);
                    break;
                case PETID_DIABOLOS:
                    PPet->addModifier(Mod::MDEF, 24);
                    PPet->setModifier(Mod::DEFP, 30);
                    PPet->setModifier(Mod::SDT_LIGHT, 150);
                    PPet->setModifier(Mod::SDT_DARK, 20);
                    PPet->m_Element = 6; // Dark is 6 ElementID for some reason
                    break;
                case PETID_CAIT_SITH:
                    PPet->addModifier(Mod::REGEN, petRegen);
                    PPet->setModifier(Mod::SDT_DARK, 150);
                    PPet->setModifier(Mod::SDT_LIGHT, 20);
                    break;
            }

            ((CItemWeapon*)PPet->m_Weapons[SLOT_MAIN])->setDamage(weaponDamage);

            // Set B+ weapon skill (assumed capped for level derp)
            // attack is madly high for avatars (roughly x2)
            // B attack, A+ acc
            PPet->setModifier(Mod::ATT, 2 * battleutils::GetMaxSkill(SKILL_CLUB, JOB_WHM, PPet->GetMLevel()));
            PPet->setModifier(Mod::RATT, 2 * battleutils::GetMaxSkill(SKILL_CLUB, JOB_WHM, PPet->GetMLevel()));
            PPet->setModifier(Mod::ACC, battleutils::GetMaxSkill(SKILL_HEALING_MAGIC, JOB_WHM, PPet->GetMLevel()));
            PPet->setModifier(Mod::RACC, battleutils::GetMaxSkill(SKILL_HEALING_MAGIC, JOB_WHM, PPet->GetMLevel()));
            // Set C evasion and def
            PPet->setModifier(Mod::EVA, battleutils::GetMaxSkill(SKILL_ENFEEBLING_MAGIC, JOB_WHM, PPet->GetMLevel()));
            PPet->setModifier(Mod::DEF, battleutils::GetMaxSkill(SKILL_ENFEEBLING_MAGIC, JOB_WHM, PPet->GetMLevel()));

            // cap all magic skills so they play nice with spell scripts
            for (int i = SKILL_DIVINE_MAGIC; i <= SKILL_BLUE_MAGIC; i++)
            {
                uint16 maxSkill = battleutils::GetMaxSkill((SKILLTYPE)i, PPet->GetMJob(), PPet->GetMLevel());
                if (maxSkill != 0)
                {
                    PPet->WorkingSkills.skill[i] = maxSkill;
                }
                else //if the mob is WAR/BLM and can cast spell
                {
                    // set skill as high as main level, so their spells won't get resisted
                    uint16 maxSubSkill = battleutils::GetMaxSkill((SKILLTYPE)i, PPet->GetSJob(), PPet->GetMLevel());

                    if (maxSubSkill != 0)
                    {
                        PPet->WorkingSkills.skill[i] = maxSubSkill;
                    }
                }
            }

            // Stats from "masters" gear/merits
            if (PMaster->objtype == TYPE_PC)
            {
                CCharEntity* PChar = (CCharEntity*)PMaster;
                // Avatar only stats
                // PPet->addModifier(Mod::ATT, PChar->getMod(Mod::AVATAR_ATT));
                // PPet->addModifier(Mod::ACC, PChar->getMod(Mod::AVATAR_ACC));
                // PPet->addModifier(Mod::RATT, PChar->getMod(Mod::AVATAR_ATT));
                // PPet->addModifier(Mod::RACC, PChar->getMod(Mod::AVATAR_ACC));
                // PPet->addModifier(Mod::EVA, PChar->getMod(Mod::AVATAR_EVASION));
                // PPet->addModifier(Mod::CRITHITRATE, PChar->getMod(Mod::AVATAR_CRIT));
                // PPet->addModifier(Mod::AVATAR_ENMITY, PChar->getMod(Mod::AVATAR_ENMITY));
                // Gear
                // PPet->addModifier(Mod::DEF, PChar->getMod(Mod::DEF));
                // PPet->addModifier(Mod::ATT, PChar->getMod(Mod::ATT));
                // PPet->addModifier(Mod::RATT, PChar->getMod(Mod::RATT));
                // PPet->addModifier(Mod::ACC, PChar->getMod(Mod::ACC));
                // PPet->addModifier(Mod::RACC, PChar->getMod(Mod::RACC));
                // PPet->addModifier(Mod::MACC, PChar->getMod(Mod::MACC));
                // PPet->addModifier(Mod::MATT, PChar->getMod(Mod::MATT));
                // PPet->addModifier(Mod::STR, PChar->getMod(Mod::STR));
                // PPet->addModifier(Mod::DEX, PChar->getMod(Mod::DEX));
                // PPet->addModifier(Mod::VIT, PChar->getMod(Mod::VIT));
                // PPet->addModifier(Mod::AGI, PChar->getMod(Mod::AGI));
                // PPet->addModifier(Mod::INT, PChar->getMod(Mod::INT));
                // PPet->addModifier(Mod::MND, PChar->getMod(Mod::MND));
                // PPet->addModifier(Mod::CHR, PChar->getMod(Mod::CHR));
                // PPet->addModifier(Mod::ENMITY, PChar->getMod(Mod::ENMITY));
                // PPet->addModifier(Mod::MDEF, PChar->getMod(Mod::MDEF));
                // PPet->addModifier(Mod::ATTP, PChar->getMod(Mod::ATTP));
                // PPet->addModifier(Mod::DEFP, PChar->getMod(Mod::DEFP));
                // PPet->addModifier(Mod::EVA, PChar->getMod(Mod::EVA));
                // PPet->addModifier(Mod::STORETP, PChar->getMod(Mod::STORETP));
                // PPet->addModifier(Mod::DMG, PChar->getMod(Mod::DMG));
                // PPet->addModifier(Mod::DMGPHYS, PChar->getMod(Mod::DMGPHYS));
                // PPet->addModifier(Mod::DMGPHYS_II, PChar->getMod(Mod::DMGPHYS_II));
                // PPet->addModifier(Mod::DMGBREATH, PChar->getMod(Mod::DMGBREATH));
                // PPet->addModifier(Mod::DMGMAGIC, PChar->getMod(Mod::DMGMAGIC));
                // PPet->addModifier(Mod::DMGMAGIC_II, PChar->getMod(Mod::DMGMAGIC_II));
                // PPet->addModifier(Mod::DMGRANGE, PChar->getMod(Mod::DMGRANGE));
                // PPet->addModifier(Mod::UDMGPHYS, PChar->getMod(Mod::UDMGPHYS));
                // PPet->addModifier(Mod::UDMGBREATH, PChar->getMod(Mod::UDMGBREATH));
                // PPet->addModifier(Mod::UDMGMAGIC, PChar->getMod(Mod::UDMGMAGIC));
                // PPet->addModifier(Mod::UDMGRANGE, PChar->getMod(Mod::UDMGRANGE));
                // PPet->addModifier(Mod::CRITHITRATE, PChar->getMod(Mod::CRITHITRATE));
                // PPet->addModifier(Mod::CRIT_DMG_INCREASE, PChar->getMod(Mod::CRIT_DMG_INCREASE));
                // PPet->addModifier(Mod::ENEMYCRITRATE, PChar->getMod(Mod::ENEMYCRITRATE));
                // PPet->addModifier(Mod::CRIT_DEF_BONUS, PChar->getMod(Mod::CRIT_DEF_BONUS));
                // PPet->addModifier(Mod::FENCER_TP_BONUS, PChar->getMod(Mod::FENCER_TP_BONUS));
                // PPet->addModifier(Mod::FENCER_CRITHITRATE, PChar->getMod(Mod::FENCER_CRITHITRATE));
                // PPet->addModifier(Mod::FENCER_JA_HASTE, PChar->getMod(Mod::FENCER_JA_HASTE));
                // PPet->addModifier(Mod::HASTE_MAGIC, PChar->getMod(Mod::HASTE_MAGIC));
                // PPet->addModifier(Mod::HASTE_ABILITY, PChar->getMod(Mod::HASTE_ABILITY));
                // PPet->addModifier(Mod::HASTE_GEAR, PChar->getMod(Mod::HASTE_GEAR));
                // PPet->addModifier(Mod::FASTCAST, PChar->getMod(Mod::FASTCAST));
                // PPet->addModifier(Mod::UFASTCAST, PChar->getMod(Mod::UFASTCAST));
                // PPet->addModifier(Mod::SKILLCHAINBONUS, PChar->getMod(Mod::SKILLCHAINBONUS));
                // PPet->addModifier(Mod::SKILLCHAINDMG, PChar->getMod(Mod::SKILLCHAINDMG));
                // PPet->addModifier(Mod::DOUBLE_ATTACK, PChar->getMod(Mod::DOUBLE_ATTACK));
                // PPet->addModifier(Mod::TRIPLE_ATTACK, PChar->getMod(Mod::TRIPLE_ATTACK));
                // PPet->addModifier(Mod::QUAD_ATTACK, PChar->getMod(Mod::QUAD_ATTACK));
                // PPet->addModifier(Mod::REGAIN, PChar->getMod(Mod::REGAIN));
                // PPet->addModifier(Mod::REGEN, PChar->getMod(Mod::REGEN));
                // PPet->addModifier(Mod::CURE_POTENCY, PChar->getMod(Mod::CURE_POTENCY));
                // PPet->addModifier(Mod::CURE_POTENCY_II, PChar->getMod(Mod::CURE_POTENCY_II));
                // PPet->addModifier(Mod::CURE_POTENCY_RCVD, PChar->getMod(Mod::CURE_POTENCY_RCVD));
                // PPet->addModifier(Mod::MAGIC_ABSORB, PChar->getMod(Mod::MAGIC_ABSORB));
                // PPet->addModifier(Mod::MAGIC_NULL, PChar->getMod(Mod::MAGIC_NULL));
                // PPet->addModifier(Mod::PHYS_ABSORB, PChar->getMod(Mod::PHYS_ABSORB));

                // Merits
                PPet->addModifier(Mod::ATT, PChar->PMeritPoints->GetMeritValue(MERIT_AVATAR_PHYSICAL_ATTACK, PChar));
                PPet->addModifier(Mod::ACC, PChar->PMeritPoints->GetMeritValue(MERIT_AVATAR_PHYSICAL_ACCURACY, PChar));
                PPet->addModifier(Mod::MATT, PChar->PMeritPoints->GetMeritValue(MERIT_AVATAR_MAGICAL_ATTACK, PChar));
                PPet->addModifier(Mod::MACC, PChar->PMeritPoints->GetMeritValue(MERIT_AVATAR_MAGICAL_ACCURACY, PChar));
                // PPet->addModifier(Mod::CRITHITRATE, PChar->PMeritPoints->GetMeritValue(MERIT_CRIT_HIT_RATE, PChar));
                // PPet->addModifier(Mod::ENEMYCRITRATE, PChar->PMeritPoints->GetMeritValue(MERIT_ENEMY_CRIT_RATE, PChar));
            }

            PMaster->addModifier(Mod::AVATAR_PERPETUATION, PerpetuationCost(PetID, PPet->GetMLevel()));
        }
        else if (PPet->getPetType() == PETTYPE_JUG_PET)
        {
            ((CItemWeapon*)PPet->m_Weapons[SLOT_MAIN])->setDelay((uint16)(floor(1000.0f*(240.0f / 60.0f))));

            //Get the Jug pet cap level
            uint8 highestLvl = PPetData->maxLevel;

            // Increase the pet's level cal by the bonus given by BEAST AFFINITY merits.
            CCharEntity* PChar = (CCharEntity*)PMaster;
            highestLvl += PChar->PMeritPoints->GetMeritValue(MERIT_BEAST_AFFINITY, PChar);

            // And cap it to the master's level or weapon ilvl, whichever is greater
            auto capLevel = std::max(PMaster->GetMLevel(), PMaster->m_Weapons[SLOT_MAIN]->getILvl());
            if (highestLvl > capLevel)
            {
                highestLvl = capLevel;
            }

            // Randomize: 0-2 lvls lower, less Monster Gloves(+1/+2) bonus
            highestLvl -= tpzrand::GetRandomNumber(3 - std::clamp<int16>(PChar->getMod(Mod::JUG_LEVEL_RANGE), 0, 2));

            PPet->SetMLevel(highestLvl);
            LoadJugStats(PPet, PPetData); //follow monster calcs (w/o SJ)
        }
        else if (PPet->getPetType() == PETTYPE_WYVERN)
        {
            LoadWyvernStatistics(PMaster, PPet, false);
        }
        else if (PPet->getPetType() == PETTYPE_AUTOMATON && PMaster->objtype == TYPE_PC)
        {
            CAutomatonEntity* PAutomaton = (CAutomatonEntity*)PPet;
            switch (PAutomaton->getFrame())
            {
            default: //case FRAME_HARLEQUIN:
                PPet->SetMJob(JOB_WAR);
                PPet->SetSJob(JOB_RDM);
                break;
            case FRAME_VALOREDGE:
                PPet->SetMJob(JOB_PLD);
                PPet->SetSJob(JOB_WAR);
                break;
            case FRAME_SHARPSHOT:
                PPet->SetMJob(JOB_RNG);
                PPet->SetSJob(JOB_PUP);
                break;
            case FRAME_STORMWAKER:
                PPet->SetMJob(JOB_RDM);
                PPet->SetSJob(JOB_WHM);
                break;
            }
            //TEMP: should be MLevel when unsummoned, and PUP level when summoned
            if (PMaster->GetMJob() == JOB_PUP)
            {
                PPet->SetMLevel(PMaster->GetMLevel());
                PPet->SetSLevel(PMaster->GetMLevel() / 2);
            }
            else
            {
                PPet->SetMLevel(PMaster->GetSLevel());
                PPet->SetSLevel(PMaster->GetSLevel() / 2);
            }
            LoadAutomatonStats((CCharEntity*)PMaster, PPet, g_PPetList.at(PetID)); //temp
            if (PMaster->objtype == TYPE_PC)
            {
                CCharEntity* PChar = (CCharEntity*)PMaster;
                PPet->addModifier(Mod::ATTP, PChar->PMeritPoints->GetMeritValue(MERIT_OPTIMIZATION, PChar));
                PPet->addModifier(Mod::DEFP, PChar->PMeritPoints->GetMeritValue(MERIT_OPTIMIZATION, PChar));
                PPet->addModifier(Mod::MATT, PChar->PMeritPoints->GetMeritValue(MERIT_OPTIMIZATION, PChar));
                PPet->addModifier(Mod::ACC, PChar->PMeritPoints->GetMeritValue(MERIT_FINE_TUNING, PChar));
                PPet->addModifier(Mod::RACC, PChar->PMeritPoints->GetMeritValue(MERIT_FINE_TUNING, PChar));
                PPet->addModifier(Mod::EVA, PChar->PMeritPoints->GetMeritValue(MERIT_FINE_TUNING, PChar));
                PPet->addModifier(Mod::MDEF, PChar->PMeritPoints->GetMeritValue(MERIT_FINE_TUNING, PChar));
            }
        }
        else if (PPet->getPetType() == PETTYPE_LUOPAN && PMaster->objtype == TYPE_PC)
        {
            PPet->SetMLevel(PMaster->GetMLevel());
            PPet->health.maxhp = (uint32)floor((250 * PPet->GetMLevel()) / 15);
            PPet->health.hp = PPet->health.maxhp;

            // Just sit, do nothing
            PPet->speed = 0;
        }
        FinalizePetStatistics(PMaster, PPet);
        PPet->status = STATUS_NORMAL;
        PPet->m_ModelSize = PPetData->size;
        PPet->m_EcoSystem = PPetData->EcoSystem;

        PMaster->PPet = PPet;
    }

   
    void LoadWyvernStatistics(CBattleEntity* PMaster, CPetEntity* PPet, bool finalize)
    {
        //set the wyvern job based on master's SJ
        if (PMaster->GetSJob() != JOB_NON)
            PPet->SetSJob(PMaster->GetSJob());

        PPet->SetMJob(JOB_DRG);
        PPet->SetMLevel(PMaster->GetMLevel());

        LoadAvatarStats(PPet); //follows PC calcs (w/o SJ)
        ((CItemWeapon*)PPet->m_Weapons[SLOT_MAIN])->setDelay((uint16)(floor(1000.0f * (320.0f / 60.0f)))); //320 delay
        ((CItemWeapon*)PPet->m_Weapons[SLOT_MAIN])->setDamage((uint16)(1 + floor(PPet->GetMLevel() * 0.9f)));
        //Set A+ weapon skill
        PPet->setModifier(Mod::ATT, battleutils::GetMaxSkill(SKILL_GREAT_AXE, JOB_WAR, PPet->GetMLevel()));
        PPet->setModifier(Mod::ACC, battleutils::GetMaxSkill(SKILL_GREAT_AXE, JOB_WAR, PPet->GetMLevel()));
        //Set D evasion and def
        PPet->setModifier(Mod::EVA, battleutils::GetMaxSkill(SKILL_HAND_TO_HAND, JOB_WAR, PPet->GetMLevel()));
        PPet->setModifier(Mod::DEF, battleutils::GetMaxSkill(SKILL_HAND_TO_HAND, JOB_WAR, PPet->GetMLevel()));

        if (finalize)
            FinalizePetStatistics(PMaster, PPet);
    }

    void FinalizePetStatistics(CBattleEntity* PMaster, CPetEntity* PPet)
    {
        //set C magic evasion
        PPet->setModifier(Mod::MEVA, battleutils::GetMaxSkill(SKILL_ELEMENTAL_MAGIC, JOB_RDM, PPet->GetMLevel()));
        PPet->health.tp = 0;
        PMaster->applyPetModifiers(PPet);
        PPet->UpdateHealth();
        PPet->health.hp = PPet->GetMaxHP();
        PPet->health.mp = PPet->GetMaxMP();

        // Stout Servant - Can't really tie it ot a real mod since it applies to the pet
        if (CCharEntity* PCharMaster = dynamic_cast<CCharEntity*>(PMaster))
        {
            if (charutils::hasTrait(PCharMaster, TRAIT_STOUT_SERVANT))
            {
                for (CTrait* trait : PCharMaster->TraitList)
                {
                    if (trait->getID() == TRAIT_STOUT_SERVANT)
                    {
                        PPet->addModifier(Mod::DMG, -trait->getValue());
                        break;
                    }
                }
            }
        }
    }

    bool CheckPetModType(CBattleEntity* PPet, PetModType petmod)
    {
        if (petmod == PetModType::All)
            return true;

        if (auto PPetEntity = dynamic_cast<CPetEntity*>(PPet))
        {
            if (petmod == PetModType::Avatar && PPetEntity->getPetType() == PETTYPE_AVATAR)
            {
                return true;
            }
            if (petmod == PetModType::Wyvern && PPetEntity->getPetType() == PETTYPE_WYVERN)
            {
                return true;
            }
            if (petmod >= PetModType::Automaton && petmod <= PetModType::Stormwaker && PPetEntity->getPetType() == PETTYPE_AUTOMATON)
            {
                if (petmod == PetModType::Automaton || (uint16)petmod + 28 == (uint16)static_cast<CAutomatonEntity*>(PPetEntity)->getFrame())
                {
                    return true;
                }
            }
        }
        else
        {
            return true;
        }
        return false;
    }
}; // namespace petutils
