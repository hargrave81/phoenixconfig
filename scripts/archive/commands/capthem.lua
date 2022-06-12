require("scripts/globals/keyitems");
require("scripts/globals/status");
require("scripts/globals/titles")

cmdprops =
{
    permission = 1,
    parameters = "s"
};

function onTrigger(player,target)
    
    player:PrintToPlayer("!capthem is capping a player "..target);
    local targ = GetPlayerByName( target );
    if player:getGMLevel() < 5 and targ:getMainJob() > 50 then
        player:PrintToPlayer("You cannot cap other players above lv50")
        return
    end
    targ:PrintToPlayer("you are getting your skills capped!");
    targ:capSkill( tpz.skill.EVASION );    
    if targ:getMainJob() == tpz.job.BLM then
        targ:capSkill( tpz.skill.STAFF );
        targ:capSkill( tpz.skill.CLUB );        
        targ:capSkill( tpz.skill.SCYTHE );
        targ:capSkill( tpz.skill.DAGGER );
        targ:capSkill( tpz.skill.THROWING );
        targ:capSkill( tpz.skill.ENFEEBLING_MAGIC );  
        targ:capSkill( tpz.skill.ENHANCING_MAGIC );  
        targ:capSkill( tpz.skill.ELEMENTAL_MAGIC );  
        targ:capSkill( tpz.skill.DARK_MAGIC );          
    elseif targ:getMainJob() == tpz.job.RDM then
        targ:capSkill( tpz.skill.SWORD );
        targ:capSkill( tpz.skill.DAGGER );
        targ:capSkill( tpz.skill.CLUB );        
        targ:capSkill( tpz.skill.ARCHERY );        
        targ:capSkill( tpz.skill.THROWING );        
        targ:capSkill( tpz.skill.SHIELD );        
        targ:capSkill( tpz.skill.PARRY );        
        targ:capSkill( tpz.skill.ENFEEBLING_MAGIC );  
        targ:capSkill( tpz.skill.ENHANCING_MAGIC );  
        targ:capSkill( tpz.skill.ELEMENTAL_MAGIC );  
        targ:capSkill( tpz.skill.DARK_MAGIC );  
        targ:capSkill( tpz.skill.HEALING_MAGIC ); 
        targ:capSkill( tpz.skill.DIVINE_MAGIC );           
    elseif targ:getMainJob() == tpz.job.WAR then
        targ:capSkill( tpz.skill.MARKSMANSHIP );
        targ:capSkill( tpz.skill.ARCHERY );
        targ:capSkill( tpz.skill.THROWING );
        targ:capSkill( tpz.skill.SWORD );
        targ:capSkill( tpz.skill.DAGGER );
        targ:capSkill( tpz.skill.CLUB );        
        targ:capSkill( tpz.skill.HAND_TO_HAND );                
        targ:capSkill( tpz.skill.GREAT_SWORD );        
        targ:capSkill( tpz.skill.GREAT_AXE );        
        targ:capSkill( tpz.skill.AXE );        
        targ:capSkill( tpz.skill.POLEARM );        
        targ:capSkill( tpz.skill.SCYTHE );                
        targ:capSkill( tpz.skill.STAFF );        
        targ:capSkill( tpz.skill.PARRY );        
        targ:capSkill( tpz.skill.SHIELD );        
    elseif targ:getMainJob() == tpz.job.WHM then
        targ:capSkill( tpz.skill.STAFF );
        targ:capSkill( tpz.skill.CLUB );        
        targ:capSkill( tpz.skill.THROWING );        
        targ:capSkill( tpz.skill.SHIELD );        
        targ:capSkill( tpz.skill.ENFEEBLING_MAGIC );  
        targ:capSkill( tpz.skill.ENHANCING_MAGIC );          
        targ:capSkill( tpz.skill.HEALING_MAGIC );  
        targ:capSkill( tpz.skill.DIVINE_MAGIC ); 
    elseif targ:getMainJob() == tpz.job.NIN then
        targ:capSkill( tpz.skill.KATANA );
        targ:capSkill( tpz.skill.DAGGER );
        targ:capSkill( tpz.skill.SWORD );
        targ:capSkill( tpz.skill.ARCHERY );
        targ:capSkill( tpz.skill.CLUB );
        targ:capSkill( tpz.skill.HAND_TO_HAND );
        targ:capSkill( tpz.skill.GREAT_KATANA );        
        targ:capSkill( tpz.skill.MARKSMANSHIP );
        targ:capSkill( tpz.skill.THROWING );
        targ:capSkill( tpz.skill.PARRY );        
        targ:capSkill( tpz.skill.NINJUTSU );
    elseif targ:getMainJob() == tpz.job.THF then
        targ:capSkill( tpz.skill.SWORD );
        targ:capSkill( tpz.skill.HAND_TO_HAND );
        targ:capSkill( tpz.skill.CLUB );
        targ:capSkill( tpz.skill.ARCHERY );
        targ:capSkill( tpz.skill.THROWING );
        targ:capSkill( tpz.skill.MARKSMANSHIP );
        targ:capSkill( tpz.skill.DAGGER );
        targ:capSkill( tpz.skill.PARRY );
        targ:capSkill( tpz.skill.SHIELD );        
    elseif targ:getMainJob() == tpz.job.SMN then
        targ:capSkill( tpz.skill.STAFF );
        targ:capSkill( tpz.skill.CLUB );        
        targ:capSkill( tpz.skill.DAGGER );        
        targ:capSkill( tpz.skill.SUMMONING_MAGIC );  
    elseif targ:getMainJob() == tpz.job.MNK then
        targ:capSkill( tpz.skill.STAFF );
        targ:capSkill( tpz.skill.CLUB );        
        targ:capSkill( tpz.skill.HAND_TO_HAND );                
        targ:capSkill( tpz.skill.THROWING );  
        targ:capSkill( tpz.skill.GUARD );          
    elseif targ:getMainJob() == tpz.job.DRK then
        targ:capSkill( tpz.skill.DAGGER );
        targ:capSkill( tpz.skill.SWORD );        
        targ:capSkill( tpz.skill.SCYTHE );        
        targ:capSkill( tpz.skill.GREAT_SWORD );        
        targ:capSkill( tpz.skill.AXE );        
        targ:capSkill( tpz.skill.GREAT_AXE );        
        targ:capSkill( tpz.skill.CLUB );        
        targ:capSkill( tpz.skill.MARKSMANSHIP );        
        targ:capSkill( tpz.skill.DARK_MAGIC );  
        targ:capSkill( tpz.skill.ELEMENTAL_MAGIC );  
        targ:capSkill( tpz.skill.ENFEEBLING_MAGIC );  
    elseif targ:getMainJob() == tpz.job.BST then
        targ:capSkill( tpz.skill.SWORD );
        targ:capSkill( tpz.skill.CLUB );        
        targ:capSkill( tpz.skill.DAGGER );        
        targ:capSkill( tpz.skill.AXE );        
        targ:capSkill( tpz.skill.SCYTHE );        
        targ:capSkill( tpz.skill.SHIELD );        
        targ:capSkill( tpz.skill.PARRY );                
    elseif targ:getMainJob() == tpz.job.BRD then
        targ:capSkill( tpz.skill.STAFF );
        targ:capSkill( tpz.skill.DAGGER );        
        targ:capSkill( tpz.skill.CLUB );        
        targ:capSkill( tpz.skill.THROWING );        
        targ:capSkill( tpz.skill.PARRY );        
        targ:capSkill( tpz.skill.STRING_INSTRUMENT );  
        targ:capSkill( tpz.skill.WIND_INSTRUMENT );  
        targ:capSkill( tpz.skill.SINGING );  
    elseif targ:getMainJob() == tpz.job.RNG then
        targ:capSkill( tpz.skill.DAGGER );
        targ:capSkill( tpz.skill.CLUB );        
        targ:capSkill( tpz.skill.AXE );        
        targ:capSkill( tpz.skill.SWORD );        
        targ:capSkill( tpz.skill.ARCHERY );        
        targ:capSkill( tpz.skill.MARKSMANSHIP );        
        targ:capSkill( tpz.skill.THROWING );          
    elseif targ:getMainJob() == tpz.job.DRG then
        targ:capSkill( tpz.skill.DAGGER );
        targ:capSkill( tpz.skill.CLUB );        
        targ:capSkill( tpz.skill.STAFF );        
        targ:capSkill( tpz.skill.POLEARM );        
        targ:capSkill( tpz.skill.SWORD );        
        targ:capSkill( tpz.skill.PARRY );                
    elseif targ:getMainJob() == tpz.job.SAM then
        targ:capSkill( tpz.skill.SWORD );
        targ:capSkill( tpz.skill.CLUB );        
        targ:capSkill( tpz.skill.DAGGER );        
        targ:capSkill( tpz.skill.POLEARM );        
        targ:capSkill( tpz.skill.GREAT_KATANA );        
        targ:capSkill( tpz.skill.ARCHERY );        
        targ:capSkill( tpz.skill.THROWING );        
        targ:capSkill( tpz.skill.PARRY );                
    elseif targ:getMainJob() == tpz.job.BLU then
        targ:capSkill( tpz.skill.SWORD );
        targ:capSkill( tpz.skill.CLUB );        
        targ:capSkill( tpz.skill.BLUE_MAGIC );
        targ:capSkill( tpz.skill.PARRY );
    elseif targ:getMainJob() == tpz.job.COR then
        targ:capSkill( tpz.skill.SWORD );
        targ:capSkill( tpz.skill.DAGGER );        
        targ:capSkill( tpz.skill.MARKSMANSHIP );  
        targ:capSkill( tpz.skill.THROWING );  
        targ:capSkill( tpz.skill.PARRY );  
    elseif targ:getMainJob() == tpz.job.PUP then
        targ:capSkill( tpz.skill.HAND_TO_HAND );
        targ:capSkill( tpz.skill.DAGGER );        
        targ:capSkill( tpz.skill.CLUB );       
        targ:capSkill( tpz.skill.THROWING );       
        targ:capSkill( tpz.skill.PARRY );       
        targ:capSkill( tpz.skill.GUARD );       
    elseif targ:getMainJob() == tpz.job.DNC then
        targ:capSkill( tpz.skill.DAGGER );
        targ:capSkill( tpz.skill.HAND_TO_HAND );        
        targ:capSkill( tpz.skill.SWORD );        
        targ:capSkill( tpz.skill.THROWING );        
        targ:capSkill( tpz.skill.PARRY );                
    elseif targ:getMainJob() == tpz.job.SCH then
        targ:capSkill( tpz.skill.STAFF );
        targ:capSkill( tpz.skill.CLUB );        
        targ:capSkill( tpz.skill.DAGGER );        
        targ:capSkill( tpz.skill.THROWING );        
        targ:capSkill( tpz.skill.DIVINE_MAGIC );   
        targ:capSkill( tpz.skill.HEALING_MAGIC );   
        targ:capSkill( tpz.skill.ENHANCING_MAGIC );   
        targ:capSkill( tpz.skill.ENFEEBLING_MAGIC );   
        targ:capSkill( tpz.skill.ELEMENTAL_MAGIC );   
        targ:capSkill( tpz.skill.DARK_MAGIC );   
    elseif targ:getMainJob() == tpz.job.PLD then                    
        targ:capSkill( tpz.skill.SWORD );
        targ:capSkill( tpz.skill.DAGGER );
        targ:capSkill( tpz.skill.CLUB );                        
        targ:capSkill( tpz.skill.GREAT_SWORD );                        
        targ:capSkill( tpz.skill.POLEARM );
        targ:capSkill( tpz.skill.STAFF );        

        targ:capSkill( tpz.skill.PARRY );        
        targ:capSkill( tpz.skill.SHIELD );    
        targ:capSkill( tpz.skill.DIVINE_MAGIC );   
        targ:capSkill( tpz.skill.HEALING_MAGIC );    
        targ:capSkill( tpz.skill.ENHANCING_MAGIC );    
    end    
    
end;

