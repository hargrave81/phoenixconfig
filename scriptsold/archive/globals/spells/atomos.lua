-----------------------------------------
-- Spell: Fenrir
-- Summons Fenrir to fight by your side
-----------------------------------------
require("scripts/globals/summon")
require("scripts/globals/bcnm")
require("scripts/globals/pets")
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------------

function onMagicCastingCheck(caster,target,spell)
    if (not caster:canUseMisc(xi.zoneMisc.PET)) then
        return xi.msg.basic.CANT_BE_USED_IN_AREA
    elseif (caster:hasPet()) then
        return xi.msg.basic.ALREADY_HAS_A_PET
    elseif (caster:getObjType() == xi.objType.PC) then
        return avatarMiniFightCheck(caster)
    end
    return 0
end

function onSpellCast(caster,target,spell)
    caster:spawnPet(xi.pet.id.ATOMOS)
    return 0
end
