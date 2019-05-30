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
    targ:capSkill( dsp.skill.EVASION );    
    if targ:getMainJob() == dsp.job.BLM then
        targ:capSkill( dsp.skill.STAFF );
        targ:capSkill( dsp.skill.CLUB );        
        targ:capSkill( dsp.skill.SCYTHE );
        targ:capSkill( dsp.skill.DAGGER );
        targ:capSkill( dsp.skill.THROWING );
        targ:capSkill( dsp.skill.ENFEEBLING_MAGIC );  
        targ:capSkill( dsp.skill.ENHANCING_MAGIC );  
        targ:capSkill( dsp.skill.ELEMENTAL_MAGIC );  
        targ:capSkill( dsp.skill.DARK_MAGIC );          
    elseif targ:getMainJob() == dsp.job.RDM then
        targ:capSkill( dsp.skill.SWORD );
        targ:capSkill( dsp.skill.DAGGER );
        targ:capSkill( dsp.skill.CLUB );        
        targ:capSkill( dsp.skill.ARCHERY );        
        targ:capSkill( dsp.skill.THROWING );        
        targ:capSkill( dsp.skill.SHIELD );        
        targ:capSkill( dsp.skill.PARRY );        
        targ:capSkill( dsp.skill.ENFEEBLING_MAGIC );  
        targ:capSkill( dsp.skill.ENHANCING_MAGIC );  
        targ:capSkill( dsp.skill.ELEMENTAL_MAGIC );  
        targ:capSkill( dsp.skill.DARK_MAGIC );  
        targ:capSkill( dsp.skill.HEALING_MAGIC ); 
        targ:capSkill( dsp.skill.DIVINE_MAGIC );           
    elseif targ:getMainJob() == dsp.job.WAR then
        targ:capSkill( dsp.skill.MARKSMANSHIP );
        targ:capSkill( dsp.skill.ARCHERY );
        targ:capSkill( dsp.skill.THROWING );
        targ:capSkill( dsp.skill.SWORD );
        targ:capSkill( dsp.skill.DAGGER );
        targ:capSkill( dsp.skill.CLUB );        
        targ:capSkill( dsp.skill.HAND_TO_HAND );                
        targ:capSkill( dsp.skill.GREAT_SWORD );        
        targ:capSkill( dsp.skill.GREAT_AXE );        
        targ:capSkill( dsp.skill.AXE );        
        targ:capSkill( dsp.skill.POLEARM );        
        targ:capSkill( dsp.skill.SCYTHE );                
        targ:capSkill( dsp.skill.STAFF );        
        targ:capSkill( dsp.skill.PARRY );        
        targ:capSkill( dsp.skill.SHIELD );        
    elseif targ:getMainJob() == dsp.job.WHM then
        targ:capSkill( dsp.skill.STAFF );
        targ:capSkill( dsp.skill.CLUB );        
        targ:capSkill( dsp.skill.THROWING );        
        targ:capSkill( dsp.skill.SHIELD );        
        targ:capSkill( dsp.skill.ENFEEBLING_MAGIC );  
        targ:capSkill( dsp.skill.ENHANCING_MAGIC );          
        targ:capSkill( dsp.skill.HEALING_MAGIC );  
        targ:capSkill( dsp.skill.DIVINE_MAGIC ); 
    elseif targ:getMainJob() == dsp.job.NIN then
        targ:capSkill( dsp.skill.KATANA );
        targ:capSkill( dsp.skill.DAGGER );
        targ:capSkill( dsp.skill.SWORD );
        targ:capSkill( dsp.skill.ARCHERY );
        targ:capSkill( dsp.skill.CLUB );
        targ:capSkill( dsp.skill.HAND_TO_HAND );
        targ:capSkill( dsp.skill.GREAT_KATANA );        
        targ:capSkill( dsp.skill.MARKSMANSHIP );
        targ:capSkill( dsp.skill.THROWING );
        targ:capSkill( dsp.skill.PARRY );        
        targ:capSkill( dsp.skill.NINJUTSU );
    elseif targ:getMainJob() == dsp.job.THF then
        targ:capSkill( dsp.skill.SWORD );
        targ:capSkill( dsp.skill.HAND_TO_HAND );
        targ:capSkill( dsp.skill.CLUB );
        targ:capSkill( dsp.skill.ARCHERY );
        targ:capSkill( dsp.skill.THROWING );
        targ:capSkill( dsp.skill.MARKSMANSHIP );
        targ:capSkill( dsp.skill.DAGGER );
        targ:capSkill( dsp.skill.PARRY );
        targ:capSkill( dsp.skill.SHIELD );        
    elseif targ:getMainJob() == dsp.job.SMN then
        targ:capSkill( dsp.skill.STAFF );
        targ:capSkill( dsp.skill.CLUB );        
        targ:capSkill( dsp.skill.DAGGER );        
        targ:capSkill( dsp.skill.SUMMONING_MAGIC );  
    elseif targ:getMainJob() == dsp.job.MNK then
        targ:capSkill( dsp.skill.STAFF );
        targ:capSkill( dsp.skill.CLUB );        
        targ:capSkill( dsp.skill.HAND_TO_HAND );                
        targ:capSkill( dsp.skill.THROWING );  
        targ:capSkill( dsp.skill.GUARD );          
    elseif targ:getMainJob() == dsp.job.DRK then
        targ:capSkill( dsp.skill.DAGGER );
        targ:capSkill( dsp.skill.SWORD );        
        targ:capSkill( dsp.skill.SCYTHE );        
        targ:capSkill( dsp.skill.GREAT_SWORD );        
        targ:capSkill( dsp.skill.AXE );        
        targ:capSkill( dsp.skill.GREAT_AXE );        
        targ:capSkill( dsp.skill.CLUB );        
        targ:capSkill( dsp.skill.MARKSMANSHIP );        
        targ:capSkill( dsp.skill.DARK_MAGIC );  
        targ:capSkill( dsp.skill.ELEMENTAL_MAGIC );  
        targ:capSkill( dsp.skill.ENFEEBLING_MAGIC );  
    elseif targ:getMainJob() == dsp.job.BST then
        targ:capSkill( dsp.skill.SWORD );
        targ:capSkill( dsp.skill.CLUB );        
        targ:capSkill( dsp.skill.DAGGER );        
        targ:capSkill( dsp.skill.AXE );        
        targ:capSkill( dsp.skill.SCYTHE );        
        targ:capSkill( dsp.skill.SHIELD );        
        targ:capSkill( dsp.skill.PARRY );                
    elseif targ:getMainJob() == dsp.job.BRD then
        targ:capSkill( dsp.skill.STAFF );
        targ:capSkill( dsp.skill.DAGGER );        
        targ:capSkill( dsp.skill.CLUB );        
        targ:capSkill( dsp.skill.THROWING );        
        targ:capSkill( dsp.skill.PARRY );        
        targ:capSkill( dsp.skill.STRING_INSTRUMENT );  
        targ:capSkill( dsp.skill.WIND_INSTRUMENT );  
        targ:capSkill( dsp.skill.SINGING );  
    elseif targ:getMainJob() == dsp.job.RNG then
        targ:capSkill( dsp.skill.DAGGER );
        targ:capSkill( dsp.skill.CLUB );        
        targ:capSkill( dsp.skill.AXE );        
        targ:capSkill( dsp.skill.SWORD );        
        targ:capSkill( dsp.skill.ARCHERY );        
        targ:capSkill( dsp.skill.MARKSMANSHIP );        
        targ:capSkill( dsp.skill.THROWING );          
    elseif targ:getMainJob() == dsp.job.DRG then
        targ:capSkill( dsp.skill.DAGGER );
        targ:capSkill( dsp.skill.CLUB );        
        targ:capSkill( dsp.skill.STAFF );        
        targ:capSkill( dsp.skill.POLEARM );        
        targ:capSkill( dsp.skill.SWORD );        
        targ:capSkill( dsp.skill.PARRY );                
    elseif targ:getMainJob() == dsp.job.SAM then
        targ:capSkill( dsp.skill.SWORD );
        targ:capSkill( dsp.skill.CLUB );        
        targ:capSkill( dsp.skill.DAGGER );        
        targ:capSkill( dsp.skill.POLEARM );        
        targ:capSkill( dsp.skill.GREAT_KATANA );        
        targ:capSkill( dsp.skill.ARCHERY );        
        targ:capSkill( dsp.skill.THROWING );        
        targ:capSkill( dsp.skill.PARRY );                
    elseif targ:getMainJob() == dsp.job.BLU then
        targ:capSkill( dsp.skill.SWORD );
        targ:capSkill( dsp.skill.CLUB );        
        targ:capSkill( dsp.skill.BLUE_MAGIC );
        targ:capSkill( dsp.skill.PARRY );
    elseif targ:getMainJob() == dsp.job.COR then
        targ:capSkill( dsp.skill.SWORD );
        targ:capSkill( dsp.skill.DAGGER );        
        targ:capSkill( dsp.skill.MARKSMANSHIP );  
        targ:capSkill( dsp.skill.THROWING );  
        targ:capSkill( dsp.skill.PARRY );  
    elseif targ:getMainJob() == dsp.job.PUP then
        targ:capSkill( dsp.skill.HAND_TO_HAND );
        targ:capSkill( dsp.skill.DAGGER );        
        targ:capSkill( dsp.skill.CLUB );       
        targ:capSkill( dsp.skill.THROWING );       
        targ:capSkill( dsp.skill.PARRY );       
        targ:capSkill( dsp.skill.GUARD );       
    elseif targ:getMainJob() == dsp.job.DNC then
        targ:capSkill( dsp.skill.DAGGER );
        targ:capSkill( dsp.skill.HAND_TO_HAND );        
        targ:capSkill( dsp.skill.SWORD );        
        targ:capSkill( dsp.skill.THROWING );        
        targ:capSkill( dsp.skill.PARRY );                
    elseif targ:getMainJob() == dsp.job.SCH then
        targ:capSkill( dsp.skill.STAFF );
        targ:capSkill( dsp.skill.CLUB );        
        targ:capSkill( dsp.skill.DAGGER );        
        targ:capSkill( dsp.skill.THROWING );        
        targ:capSkill( dsp.skill.DIVINE_MAGIC );   
        targ:capSkill( dsp.skill.HEALING_MAGIC );   
        targ:capSkill( dsp.skill.ENHANCING_MAGIC );   
        targ:capSkill( dsp.skill.ENFEEBLING_MAGIC );   
        targ:capSkill( dsp.skill.ELEMENTAL_MAGIC );   
        targ:capSkill( dsp.skill.DARK_MAGIC );   
    elseif targ:getMainJob() == dsp.job.PLD then                    
        targ:capSkill( dsp.skill.SWORD );
        targ:capSkill( dsp.skill.DAGGER );
        targ:capSkill( dsp.skill.CLUB );                        
        targ:capSkill( dsp.skill.GREAT_SWORD );                        
        targ:capSkill( dsp.skill.POLEARM );
        targ:capSkill( dsp.skill.STAFF );        

        targ:capSkill( dsp.skill.PARRY );        
        targ:capSkill( dsp.skill.SHIELD );    
        targ:capSkill( dsp.skill.DIVINE_MAGIC );   
        targ:capSkill( dsp.skill.HEALING_MAGIC );    
        targ:capSkill( dsp.skill.ENHANCING_MAGIC );    
    end    
    
end;

