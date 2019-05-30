require("scripts/globals/keyitems");
require("scripts/globals/status");
require("scripts/globals/titles")

cmdprops =
{
    permission = 1,
    parameters = "s"
};

function onTrigger(player,target)
    
    player:PrintToPlayer("!magethem is giving spells");
    local targ = GetPlayerByName( target );
    targ:PrintToPlayer("you are getting spells on your character!");
    if player:getGMLevel() < 5 then
        -- reduce abuse
        local spellDepth = 0
        if target:canLearnSpell(90) then
            spellDepth = spellDepth + 1
        end
        if target:canLearnSpell(258) then
            spellDepth = spellDepth + 1
        end
        if target:canLearnSpell(39) then
            spellDepth = spellDepth + 1
        end
        if target:canLearnSpell(109) then
            spellDepth = spellDepth + 1
        end
        if target:canLearnSpell(478) then
            spellDepth = spellDepth + 1
        end
        if target:canLearnSpell(339) then
            spellDepth = spellDepth + 1
        end
        if target:canLearnSpell(618) then
            spellDepth = spellDepth + 1
        end
        if target:canLearnSpell(275) then
            spellDepth = spellDepth + 1
        end
        if target:canLearnSpell(288) then
            spellDepth = spellDepth + 1
        end
        if target:canLearnSpell(444) then
            spellDepth = spellDepth + 1
        end        
        if spellDepth > 2 then
            player:PrintToPlayer("You cannot boost that many jobs")
            return
        end
    end
    if targ:getMainJob() == dsp.job.COR then
        if targ:canLearnAbility(104) then -- corsair roll
            target:addLearnedAbility(104)
        end
        if targ:canLearnAbility(94) then -- ninja roll
            target:addLearnedAbility(94)
        end
        if targ:canLearnAbility(92) then -- hunter roll
            target:addLearnedAbility(92)
        end
        if targ:canLearnAbility(89) then -- chaos roll
            target:addLearnedAbility(89)
        end
        if targ:canLearnAbility(97) then -- magus roll
            target:addLearnedAbility(97)
        end
        if targ:canLearnAbility(84) then -- healer roll
            target:addLearnedAbility(84)
        end
        if targ:canLearnAbility(95) then -- drachen roll
            target:addLearnedAbility(95)
        end
        if targ:canLearnAbility(91) then -- choral roll
            target:addLearnedAbility(91)
        end
        if targ:canLearnAbility(83) then -- monks roll
            target:addLearnedAbility(83)
        end
        if targ:canLearnAbility(90) then -- beast roll
            target:addLearnedAbility(90)
        end
        if targ:canLearnAbility(93) then -- samurai roll
            target:addLearnedAbility(93)
        end        
    end
    if targ:getMainJob() == dsp.job.BLM then
        learnSpell(targ,1)  -- cure
        
        learnSpell(targ,159)  -- stone
        learnSpell(targ,160)  -- stone II        

        learnSpell(targ,169)  -- water
        learnSpell(targ,170)  -- water II

        learnSpell(targ,154)  -- aero
        learnSpell(targ,155)  -- aero II

        learnSpell(targ,144)  -- fire
        learnSpell(targ,145)  -- fire II

        learnSpell(targ,149)  -- blizzard        
        learnSpell(targ,150)  -- blizzard II

        learnSpell(targ,164)  -- thunder
        learnSpell(targ,165)  -- thunder II        

        learnSpell(targ,253)  -- sleep
        learnSpell(targ,259)  -- sleep II

        learnSpell(targ,220)  -- poison
        learnSpell(targ,221)  -- poison II

        learnSpell(targ,230)  -- bio
        learnSpell(targ,231)  -- bio II

        learnSpell(targ,254)  -- blind
        learnSpell(targ,258)  -- bind    
        
        learnSpell(targ,189)  -- stonega
        learnSpell(targ,190)  -- stonega II
        
        learnSpell(targ,199)  -- waterga
        learnSpell(targ,200)  -- waterga II
        
        learnSpell(targ,258)  -- aeroga
        learnSpell(targ,258)  -- aeroga II
        
        learnSpell(targ,174)  -- firega
        
        learnSpell(targ,179)  -- blizga
        
        learnSpell(targ,194)  -- thundga

        learnSpell(targ,206)  -- freeze

        learnSpell(targ,225)  -- poisonga

        learnSpell(targ,252)  -- stun

        learnSpell(targ,249) -- blaze spikes
        
        learnSpell(targ,239) -- shock
        learnSpell(targ,238) -- rasp
        learnSpell(targ,237) -- choke
        learnSpell(targ,236) -- frost
        learnSpell(targ,235) -- burn
        learnSpell(targ,240) -- drown
        learnSpell(targ,262) -- warp 2
        
    end
    if targ:getMainJob() == dsp.job.WHM then
        learnSpell(targ,1)  -- cure
        learnSpell(targ,2)  -- cure 2
        learnSpell(targ,3)  -- cure 3
        learnSpell(targ,4)  -- cure 4
        
        learnSpell(targ,7) -- curaga
        learnSpell(targ,8) -- curaga II
        
        learnSpell(targ,12)  -- raise

        learnSpell(targ,48)  -- shell        
        learnSpell(targ,49)  -- shell II
        learnSpell(targ,130)  -- shellra    
        learnSpell(targ,131)  -- shellra II   
        
        learnSpell(targ,43)  -- protect        
        learnSpell(targ,44)  -- protect II        
        learnSpell(targ,45)  -- protect III     

        learnSpell(targ,125)  -- protectra
        learnSpell(targ,126)  -- protectra II  
        learnSpell(targ,127)  -- protectra III
        

        learnSpell(targ,108)  -- regen
        learnSpell(targ,110)  -- regen II

        learnSpell(targ,23)  -- dia
        learnSpell(targ,24)  -- dia 2
        learnSpell(targ,58)  -- paralyze
        learnSpell(targ,28)  -- banish
        learnSpell(targ,69)  -- barstonra
        learnSpell(targ,14)  -- poisona
        learnSpell(targ,86)  -- barsleepra        
        learnSpell(targ,71)  -- barwatera
        learnSpell(targ,15)  -- paralyna
        learnSpell(targ,55)  -- aquavail
        learnSpell(targ,87)  -- barpoisonra
        learnSpell(targ,88)  -- barparalyzra
        learnSpell(targ,68)  -- baraera
        learnSpell(targ,56)  -- slow
        learnSpell(targ,16)  -- blindna
        learnSpell(targ,38)  -- banishga
        learnSpell(targ,59)  -- silence
        learnSpell(targ,66)  -- barfira
        learnSpell(targ,89)  -- barblindra
        learnSpell(targ,33)  -- diaga
        learnSpell(targ,53)  -- blink
        learnSpell(targ,17)  -- silena
        learnSpell(targ,137)  -- sneak
        learnSpell(targ,67)  -- barblizzara        
        learnSpell(targ,90)  -- barsilencera
        learnSpell(targ,70)  -- barthundara
        learnSpell(targ,136)  -- invisible
        learnSpell(targ,135)  -- reraise
        learnSpell(targ,54)  -- stoneskin
        learnSpell(targ,20)  -- cursna
        learnSpell(targ,29)  -- banish II
        learnSpell(targ,19)  -- viruna
        learnSpell(targ,24)  -- dia II
        learnSpell(targ,92)  -- barvira
        learnSpell(targ,18)  -- Stona
        learnSpell(targ,39)  -- banishga II
        learnSpell(targ,57)  -- haste
        learnSpell(targ,93)  -- cura
        learnSpell(targ,91)  -- barpetra        
        learnSpell(targ,112)  -- flash
        learnSpell(targ,98)  -- repose
        learnSpell(targ,21)  -- holy

        learnSpell(targ,123)  -- tele-dem
        learnSpell(targ,124)  -- tele-mea
        learnSpell(targ,122)  -- tele-holla
        learnSpell(targ,121)  -- tele-altep
        learnSpell(targ,120)  -- tele-yhoat
        learnSpell(targ,139)  -- tele-vahzl
    end
    if targ:getMainJob() == dsp.job.RDM then
        learnSpell(targ,1)  -- cures
        learnSpell(targ,2)
        learnSpell(targ,3)
        learnSpell(targ,12) -- raise

        learnSpell(targ,58)  -- paralyze
        learnSpell(targ,55)  -- aquavail
        learnSpell(targ,56)  -- slow
        learnSpell(targ,59)  -- silence
        learnSpell(targ,53)  -- blink
        learnSpell(targ,137)  -- sneak
        learnSpell(targ,136)  -- invisible
        learnSpell(targ,54)  -- stoneskin
        learnSpell(targ,57)  -- haste            

        learnSpell(targ,34)  -- diaga II

        learnSpell(targ,48)  -- shell        
        learnSpell(targ,49)  -- shell II

        learnSpell(targ,43)  -- protect        
        learnSpell(targ,44)  -- protect II        
        learnSpell(targ,45)  -- protect III     
        
        learnSpell(targ,60)  -- barfire
        learnSpell(targ,61)  -- barbliz
        learnSpell(targ,62)  -- barzero
        learnSpell(targ,63)  -- barstone
        learnSpell(targ,64)  -- barthund
        learnSpell(targ,65)  -- barwater

        learnSpell(targ,72)  -- barsleep
        learnSpell(targ,73)   -- bar poisn
        learnSpell(targ,74)   -- barparalyze
        learnSpell(targ,75)   -- barblind
        learnSpell(targ,76)   -- barsilence
        learnSpell(targ,77)   -- barpetrify
        learnSpell(targ,78)   -- barvirus
        learnSpell(targ,3)   --
        
        learnSpell(targ,100)  -- enfire
        learnSpell(targ,101)  -- enbliz
        learnSpell(targ,102)  -- enero
        learnSpell(targ,103)  -- enstone
        learnSpell(targ,104)  -- enthund
        learnSpell(targ,105)  -- enwater

        learnSpell(targ,108)  -- regen

        learnSpell(targ,109)  -- refresh

        learnSpell(targ,159)  -- stone
        learnSpell(targ,160)  -- stone II

        learnSpell(targ,169)  -- water
        learnSpell(targ,170)  -- water II

        learnSpell(targ,154)  -- aero
        learnSpell(targ,155)  -- aero II

        learnSpell(targ,144)  -- fire
        learnSpell(targ,145)  -- fire II

        learnSpell(targ,149)  -- blizzard        

        learnSpell(targ,164)  -- thunder        

        learnSpell(targ,253)  -- sleep
        learnSpell(targ,259)  -- sleep II

        learnSpell(targ,220)  -- poison
        learnSpell(targ,221)  -- poison II

        learnSpell(targ,230)  -- bio
        learnSpell(targ,231)  -- bio II

        learnSpell(targ,254)  -- blind
        learnSpell(targ,258)  -- bind        
    end  
    if targ:getMainJob() == dsp.job.SCH then
        learnSpell(targ,159)  -- stone
        learnSpell(targ,160)  -- stone II

        learnSpell(targ,169)  -- water
        learnSpell(targ,170)  -- water II

        learnSpell(targ,154)  -- aero
        learnSpell(targ,155)  -- aero II

        learnSpell(targ,144)  -- fire
        learnSpell(targ,145)  -- fire II

        learnSpell(targ,149)  -- blizzard        
        learnSpell(targ,150)  -- blizzard II

        learnSpell(targ,164)  -- thunder        

        learnSpell(targ,253)  -- sleep

        learnSpell(targ,16)  -- blindna

        learnSpell(targ,48)  -- shell        
        learnSpell(targ,49)  -- shell II

        learnSpell(targ,43)  -- protect        
        learnSpell(targ,44)  -- protect II        
        learnSpell(targ,45)  -- protect III  

        learnSpell(targ,54)  -- stoneskin

        learnSpell(targ,53)  -- blink
        learnSpell(targ,137)  -- sneak
        learnSpell(targ,136)  -- invisible

        learnSpell(targ,55)  -- aquavail

        learnSpell(targ,1)  -- cures
        learnSpell(targ,2)  -- cure 2
        learnSpell(targ,3)  -- cure 3
        learnSpell(targ,12) -- raise
        learnSpell(targ,135)  -- reraise
        learnSpell(targ,20)  -- cursna
        learnSpell(targ,19)  -- viruna
        learnSpell(targ,18)  -- Stona
        learnSpell(targ,17)  -- silena
        learnSpell(targ,15)  -- paralyna
        learnSpell(targ,14)  -- poisona

        learnSpell(targ,108)  -- regen
        learnSpell(targ,110)  -- regen II        

        learnSpell(targ,478) -- embrava
        learnSpell(targ,502) -- kaustra
        learnSpell(targ,278) -- geohelix
        learnSpell(targ,279) -- hydrohelix
        learnSpell(targ,280) -- anemohelix
        learnSpell(targ,281) -- pyrohelix
        learnSpell(targ,282) -- cryohelix
        learnSpell(targ,283) -- ionohelix
        learnSpell(targ,284) -- noctohelix
        learnSpell(targ,285) -- luminohelix
        learnSpell(targ,249) -- blaze spikes
    end
    if targ:getMainJob() == dsp.job.BRD then
        learnSpell(targ,389) -- Knights minne 1
        learnSpell(targ,390) -- Knights minne 2
        learnSpell(targ,391) -- Knights minne 3
        
        learnSpell(targ,394) -- Valor Minuet 1
        learnSpell(targ,395) -- Valor Minuet 2
        learnSpell(targ,396) -- Valor Minuet 3

        learnSpell(targ,386) -- mages ballad
        
        learnSpell(targ,378) -- armys paeon 1
        learnSpell(targ,379) -- armys paeon 2
        learnSpell(targ,380) -- armys paeon 3
        learnSpell(targ,381) -- armys paeon 4
        
        learnSpell(targ,368) -- foe requiem 1
        learnSpell(targ,369) -- foe requiem 2
        learnSpell(targ,370) -- foe requiem 3
        learnSpell(targ,371) -- foe requiem 4

        learnSpell(targ,403) -- sheepfo mambo

        learnSpell(targ,399) -- sword madrigal
        
        learnSpell(targ,409) -- scops Operetta
        learnSpell(targ,415) -- goblin gavotte

        learnSpell(targ,421) -- battlefield elegy

        learnSpell(targ,467) -- raptor mazurka

        learnSpell(targ,430) -- enchanting etude
        learnSpell(targ,429) -- spirited etude
        learnSpell(targ,428) -- learned etude
        learnSpell(targ,427) -- quick etude
        learnSpell(targ,426) -- vivacious etude
        learnSpell(targ,401) -- hunter's prelude
        learnSpell(targ,425) -- dextrous etude
        learnSpell(targ,424) -- sinewy etude

        learnSpell(targ,405) -- fowl aubade
        

        learnSpell(targ,419) -- advancing march


        learnSpell(targ,406) -- herb pastoral

        learnSpell(targ,460) -- light threnody
        learnSpell(targ,461) -- dark threnody
        learnSpell(targ,457) -- earth threnody
        learnSpell(targ,459) -- water threnody
        learnSpell(targ,456) -- wind threnody
        learnSpell(targ,454) -- fire threnody
        learnSpell(targ,455) -- ice threnody
        learnSpell(targ,458) -- lightning threnody

        learnSpell(targ,444) -- light carol        
        learnSpell(targ,441) -- earth carol
        learnSpell(targ,443) -- water carol
        learnSpell(targ,440) -- wind carol
        learnSpell(targ,438) -- fire carol
        learnSpell(targ,439) -- ice carol
        learnSpell(targ,442) -- lightning carol
        learnSpell(targ,445) -- dark carol
        
    end
    if targ:getMainJob() == dsp.job.SMN then
        learnSpell(targ,288) -- fire spirit
        learnSpell(targ,306) -- alexander
    end
    if targ:getMainJob() == dsp.job.PLD then
        learnSpell(targ,1)  -- cures
        learnSpell(targ,2)  -- cure 2
        learnSpell(targ,3)  -- cure 3
        learnSpell(targ,12) -- raise

        learnSpell(targ,48)  -- shell        
        learnSpell(targ,49)  -- shell II

        learnSpell(targ,43)  -- protect        
        learnSpell(targ,44)  -- protect II        
        learnSpell(targ,45)  -- protect III  

        learnSpell(targ,28)  -- banish
        learnSpell(targ,29)  -- banish II     
        learnSpell(targ,112)  -- flash        
        learnSpell(targ,21)  -- holy


    end
    if targ:getMainJob() == dsp.job.DRK then
        learnSpell(targ,159)  -- stone
        learnSpell(targ,160)  -- stone II        

        learnSpell(targ,169)  -- water
        learnSpell(targ,170)  -- water II

        learnSpell(targ,154)  -- aero

        learnSpell(targ,144)  -- fire

        learnSpell(targ,149)  -- blizzard        

        learnSpell(targ,164)  -- thunder

        learnSpell(targ,253)  -- sleep

        learnSpell(targ,220)  -- poison
        learnSpell(targ,221)  -- poison II

        learnSpell(targ,225)  -- poisonga

        learnSpell(targ,230)  -- bio
        learnSpell(targ,231)  -- bio II

        learnSpell(targ,258)  -- bind        
        
        learnSpell(targ,252)  -- stun

        learnSpell(targ,271)  -- absorb MND
        learnSpell(targ,272)  -- absorb CHR
        learnSpell(targ,268)  -- absorb VIT
        learnSpell(targ,269)  -- absorb AGI
        learnSpell(targ,270)  -- absorb INT
        learnSpell(targ,267)  -- absorb DEX
        learnSpell(targ,266)  -- absorb STR
        learnSpell(targ,275)  -- absorb TP

    end
    if targ:getMainJob() == dsp.job.BLU then
        learnSpell(targ,549) -- pollen
        learnSpell(targ,524) -- sandspin
        learnSpell(targ,577) -- foot kick
        learnSpell(targ,597) -- sprout smack
        learnSpell(targ,603) -- wild oats
        learnSpell(targ,551) -- power attack
        learnSpell(targ,547) -- cocoon
        learnSpell(targ,517) -- metallic body
        learnSpell(targ,599) -- queasyshroom
        learnSpell(targ,620) -- battle dance
        learnSpell(targ,638) -- feather storm
        learnSpell(targ,623) -- headbutt
        learnSpell(targ,581) -- healing breeze
        learnSpell(targ,584) -- sheep song
        learnSpell(targ,567) -- helldive
        learnSpell(targ,544) -- cursed sphere
        learnSpell(targ,618) -- blastbomb
        learnSpell(targ,529) -- bludgeon
        learnSpell(targ,570) -- blood drain
        learnSpell(targ,587) -- claw cyclone

    end
    if targ:getMainJob() == dsp.job.NIN then
        learnSpell(targ,353) -- tonko 1
        learnSpell(targ,338) -- utsusemi 1
        
        learnSpell(targ,320) -- katon 1
        learnSpell(targ,323) -- hyoton 1
        learnSpell(targ,326) -- huton 1
        learnSpell(targ,329) -- doton 1
        learnSpell(targ,332) -- raiton 1
        learnSpell(targ,335) -- suiton 1
        
        learnSpell(targ,347) -- kurayami 1
        
        learnSpell(targ,344) -- hojo 1
        
        learnSpell(targ,318) -- monomi 1
        
        learnSpell(targ,350) -- dokumori 1
        
        learnSpell(targ,341) -- jubaku 1
        
        learnSpell(targ,354) -- tonko 2
        
        learnSpell(targ,339) -- utsusemi 2
        
        learnSpell(targ,321) -- katon 2
        learnSpell(targ,324) -- hyoton 2        
        learnSpell(targ,327) -- huton 2        
        learnSpell(targ,330) -- doton 2        
        learnSpell(targ,333) -- raiton 2        
        learnSpell(targ,336) -- suiton 2        
        
        learnSpell(targ,348) -- kurayami 2
        
        learnSpell(targ,346) -- hojo 2                                                    
    end

end;


function learnSpell(target, spellId)
    if target:canLearnSpell(spellId) then
        target:addSpell(spellId, false, true) 
    end
end
