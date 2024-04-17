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
    targ:capSkill( xi.skill.EVASION );    
    if targ:getMainJob() == xi.job.BLM then
        targ:capSkill( xi.skill.STAFF );
        targ:capSkill( xi.skill.CLUB );        
        targ:capSkill( xi.skill.SCYTHE );
        targ:capSkill( xi.skill.DAGGER );
        targ:capSkill( xi.skill.THROWING );
        targ:capSkill( xi.skill.ENFEEBLING_MAGIC );  
        targ:capSkill( xi.skill.ENHANCING_MAGIC );  
        targ:capSkill( xi.skill.ELEMENTAL_MAGIC );  
        targ:capSkill( xi.skill.DARK_MAGIC );          
    elseif targ:getMainJob() == xi.job.RDM then
        targ:capSkill( xi.skill.SWORD );
        targ:capSkill( xi.skill.DAGGER );
        targ:capSkill( xi.skill.CLUB );        
        targ:capSkill( xi.skill.ARCHERY );        
        targ:capSkill( xi.skill.THROWING );        
        targ:capSkill( xi.skill.SHIELD );        
        targ:capSkill( xi.skill.PARRY );        
        targ:capSkill( xi.skill.ENFEEBLING_MAGIC );  
        targ:capSkill( xi.skill.ENHANCING_MAGIC );  
        targ:capSkill( xi.skill.ELEMENTAL_MAGIC );  
        targ:capSkill( xi.skill.DARK_MAGIC );  
        targ:capSkill( xi.skill.HEALING_MAGIC ); 
        targ:capSkill( xi.skill.DIVINE_MAGIC );           
    elseif targ:getMainJob() == xi.job.WAR then
        targ:capSkill( xi.skill.MARKSMANSHIP );
        targ:capSkill( xi.skill.ARCHERY );
        targ:capSkill( xi.skill.THROWING );
        targ:capSkill( xi.skill.SWORD );
        targ:capSkill( xi.skill.DAGGER );
        targ:capSkill( xi.skill.CLUB );        
        targ:capSkill( xi.skill.HAND_TO_HAND );                
        targ:capSkill( xi.skill.GREAT_SWORD );        
        targ:capSkill( xi.skill.GREAT_AXE );        
        targ:capSkill( xi.skill.AXE );        
        targ:capSkill( xi.skill.POLEARM );        
        targ:capSkill( xi.skill.SCYTHE );                
        targ:capSkill( xi.skill.STAFF );        
        targ:capSkill( xi.skill.PARRY );        
        targ:capSkill( xi.skill.SHIELD );        
    elseif targ:getMainJob() == xi.job.WHM then
        targ:capSkill( xi.skill.STAFF );
        targ:capSkill( xi.skill.CLUB );        
        targ:capSkill( xi.skill.THROWING );        
        targ:capSkill( xi.skill.SHIELD );        
        targ:capSkill( xi.skill.ENFEEBLING_MAGIC );  
        targ:capSkill( xi.skill.ENHANCING_MAGIC );          
        targ:capSkill( xi.skill.HEALING_MAGIC );  
        targ:capSkill( xi.skill.DIVINE_MAGIC ); 
    elseif targ:getMainJob() == xi.job.NIN then
        targ:capSkill( xi.skill.KATANA );
        targ:capSkill( xi.skill.DAGGER );
        targ:capSkill( xi.skill.SWORD );
        targ:capSkill( xi.skill.ARCHERY );
        targ:capSkill( xi.skill.CLUB );
        targ:capSkill( xi.skill.HAND_TO_HAND );
        targ:capSkill( xi.skill.GREAT_KATANA );        
        targ:capSkill( xi.skill.MARKSMANSHIP );
        targ:capSkill( xi.skill.THROWING );
        targ:capSkill( xi.skill.PARRY );        
        targ:capSkill( xi.skill.NINJUTSU );
    elseif targ:getMainJob() == xi.job.THF then
        targ:capSkill( xi.skill.SWORD );
        targ:capSkill( xi.skill.HAND_TO_HAND );
        targ:capSkill( xi.skill.CLUB );
        targ:capSkill( xi.skill.ARCHERY );
        targ:capSkill( xi.skill.THROWING );
        targ:capSkill( xi.skill.MARKSMANSHIP );
        targ:capSkill( xi.skill.DAGGER );
        targ:capSkill( xi.skill.PARRY );
        targ:capSkill( xi.skill.SHIELD );        
    elseif targ:getMainJob() == xi.job.SMN then
        targ:capSkill( xi.skill.STAFF );
        targ:capSkill( xi.skill.CLUB );        
        targ:capSkill( xi.skill.DAGGER );        
        targ:capSkill( xi.skill.SUMMONING_MAGIC );  
    elseif targ:getMainJob() == xi.job.MNK then
        targ:capSkill( xi.skill.STAFF );
        targ:capSkill( xi.skill.CLUB );        
        targ:capSkill( xi.skill.HAND_TO_HAND );                
        targ:capSkill( xi.skill.THROWING );  
        targ:capSkill( xi.skill.GUARD );          
    elseif targ:getMainJob() == xi.job.DRK then
        targ:capSkill( xi.skill.DAGGER );
        targ:capSkill( xi.skill.SWORD );        
        targ:capSkill( xi.skill.SCYTHE );        
        targ:capSkill( xi.skill.GREAT_SWORD );        
        targ:capSkill( xi.skill.AXE );        
        targ:capSkill( xi.skill.GREAT_AXE );        
        targ:capSkill( xi.skill.CLUB );        
        targ:capSkill( xi.skill.MARKSMANSHIP );        
        targ:capSkill( xi.skill.DARK_MAGIC );  
        targ:capSkill( xi.skill.ELEMENTAL_MAGIC );  
        targ:capSkill( xi.skill.ENFEEBLING_MAGIC );  
    elseif targ:getMainJob() == xi.job.BST then
        targ:capSkill( xi.skill.SWORD );
        targ:capSkill( xi.skill.CLUB );        
        targ:capSkill( xi.skill.DAGGER );        
        targ:capSkill( xi.skill.AXE );        
        targ:capSkill( xi.skill.SCYTHE );        
        targ:capSkill( xi.skill.SHIELD );        
        targ:capSkill( xi.skill.PARRY );                
    elseif targ:getMainJob() == xi.job.BRD then
        targ:capSkill( xi.skill.STAFF );
        targ:capSkill( xi.skill.DAGGER );        
        targ:capSkill( xi.skill.CLUB );        
        targ:capSkill( xi.skill.THROWING );        
        targ:capSkill( xi.skill.PARRY );        
        targ:capSkill( xi.skill.STRING_INSTRUMENT );  
        targ:capSkill( xi.skill.WIND_INSTRUMENT );  
        targ:capSkill( xi.skill.SINGING );  
    elseif targ:getMainJob() == xi.job.RNG then
        targ:capSkill( xi.skill.DAGGER );
        targ:capSkill( xi.skill.CLUB );        
        targ:capSkill( xi.skill.AXE );        
        targ:capSkill( xi.skill.SWORD );        
        targ:capSkill( xi.skill.ARCHERY );        
        targ:capSkill( xi.skill.MARKSMANSHIP );        
        targ:capSkill( xi.skill.THROWING );          
    elseif targ:getMainJob() == xi.job.DRG then
        targ:capSkill( xi.skill.DAGGER );
        targ:capSkill( xi.skill.CLUB );        
        targ:capSkill( xi.skill.STAFF );        
        targ:capSkill( xi.skill.POLEARM );        
        targ:capSkill( xi.skill.SWORD );        
        targ:capSkill( xi.skill.PARRY );                
    elseif targ:getMainJob() == xi.job.SAM then
        targ:capSkill( xi.skill.SWORD );
        targ:capSkill( xi.skill.CLUB );        
        targ:capSkill( xi.skill.DAGGER );        
        targ:capSkill( xi.skill.POLEARM );        
        targ:capSkill( xi.skill.GREAT_KATANA );        
        targ:capSkill( xi.skill.ARCHERY );        
        targ:capSkill( xi.skill.THROWING );        
        targ:capSkill( xi.skill.PARRY );                
    elseif targ:getMainJob() == xi.job.BLU then
        targ:capSkill( xi.skill.SWORD );
        targ:capSkill( xi.skill.CLUB );        
        targ:capSkill( xi.skill.BLUE_MAGIC );
        targ:capSkill( xi.skill.PARRY );
    elseif targ:getMainJob() == xi.job.COR then
        targ:capSkill( xi.skill.SWORD );
        targ:capSkill( xi.skill.DAGGER );        
        targ:capSkill( xi.skill.MARKSMANSHIP );  
        targ:capSkill( xi.skill.THROWING );  
        targ:capSkill( xi.skill.PARRY );  
    elseif targ:getMainJob() == xi.job.PUP then
        targ:capSkill( xi.skill.HAND_TO_HAND );
        targ:capSkill( xi.skill.DAGGER );        
        targ:capSkill( xi.skill.CLUB );       
        targ:capSkill( xi.skill.THROWING );       
        targ:capSkill( xi.skill.PARRY );       
        targ:capSkill( xi.skill.GUARD );       
    elseif targ:getMainJob() == xi.job.DNC then
        targ:capSkill( xi.skill.DAGGER );
        targ:capSkill( xi.skill.HAND_TO_HAND );        
        targ:capSkill( xi.skill.SWORD );        
        targ:capSkill( xi.skill.THROWING );        
        targ:capSkill( xi.skill.PARRY );                
    elseif targ:getMainJob() == xi.job.SCH then
        targ:capSkill( xi.skill.STAFF );
        targ:capSkill( xi.skill.CLUB );        
        targ:capSkill( xi.skill.DAGGER );        
        targ:capSkill( xi.skill.THROWING );        
        targ:capSkill( xi.skill.DIVINE_MAGIC );   
        targ:capSkill( xi.skill.HEALING_MAGIC );   
        targ:capSkill( xi.skill.ENHANCING_MAGIC );   
        targ:capSkill( xi.skill.ENFEEBLING_MAGIC );   
        targ:capSkill( xi.skill.ELEMENTAL_MAGIC );   
        targ:capSkill( xi.skill.DARK_MAGIC );   
    elseif targ:getMainJob() == xi.job.PLD then                    
        targ:capSkill( xi.skill.SWORD );
        targ:capSkill( xi.skill.DAGGER );
        targ:capSkill( xi.skill.CLUB );                        
        targ:capSkill( xi.skill.GREAT_SWORD );                        
        targ:capSkill( xi.skill.POLEARM );
        targ:capSkill( xi.skill.STAFF );        

        targ:capSkill( xi.skill.PARRY );        
        targ:capSkill( xi.skill.SHIELD );    
        targ:capSkill( xi.skill.DIVINE_MAGIC );   
        targ:capSkill( xi.skill.HEALING_MAGIC );    
        targ:capSkill( xi.skill.ENHANCING_MAGIC );    
    end    
    
end;

