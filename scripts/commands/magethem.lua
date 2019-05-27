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
    if targ:getMainJob() == dsp.job.BLM then
        targ:addSpell(1, false, true);  -- cure
        
        targ:addSpell(159, false, true);  -- stone
        targ:addSpell(160, false, true);  -- stone II        

        targ:addSpell(169, false, true);  -- water
        targ:addSpell(170, false, true);  -- water II

        targ:addSpell(154, false, true);  -- aero
        targ:addSpell(155, false, true);  -- aero II

        targ:addSpell(144, false, true);  -- fire
        targ:addSpell(145, false, true);  -- fire II

        targ:addSpell(149, false, true);  -- blizzard        
        targ:addSpell(150, false, true);  -- blizzard II

        targ:addSpell(164, false, true);  -- thunder
        targ:addSpell(165, false, true);  -- thunder II        

        targ:addSpell(253, false, true);  -- sleep
        targ:addSpell(259, false, true);  -- sleep II

        targ:addSpell(220, false, true);  -- poison
        targ:addSpell(221, false, true);  -- poison II

        targ:addSpell(230, false, true);  -- bio
        targ:addSpell(231, false, true);  -- bio II

        targ:addSpell(254, false, true);  -- blind
        targ:addSpell(258, false, true);  -- bind    
        
        targ:addSpell(189, false, true);  -- stonega
        targ:addSpell(190, false, true);  -- stonega II
        
        targ:addSpell(199, false, true);  -- waterga
        targ:addSpell(200, false, true);  -- waterga II
        
        targ:addSpell(258, false, true);  -- aeroga
        targ:addSpell(258, false, true);  -- aeroga II
        
        targ:addSpell(174, false, true);  -- firega
        
        targ:addSpell(179, false, true);  -- blizga
        
        targ:addSpell(194, false, true);  -- thundga

        targ:addSpell(206, false, true);  -- freeze

        targ:addSpell(225, false, true);  -- poisonga
    end
    if targ:getMainJob() == dsp.job.WHM then
        targ:addSpell(1, false, true);  -- cure
        targ:addSpell(2, false, true);
        targ:addSpell(3, false, true);
        targ:addSpell(4, false, true);
        
        targ:addSpell(7, false, true); -- curaga
        targ:addSpell(8, false, true);
        
        targ:addSpell(12, false, true);  -- raise

        targ:addSpell(48, false, true);  -- shell        
        targ:addSpell(49, false, true);  -- shell II
        targ:addSpell(130, false, true);  -- shellra    
        targ:addSpell(131, false, true);  -- shellra II   
        
        targ:addSpell(43, false, true);  -- protect        
        targ:addSpell(44, false, true);  -- protect II        
        targ:addSpell(45, false, true);  -- protect III     

        targ:addSpell(125, false, true);  -- protectra
        targ:addSpell(126, false, true);  -- protectra II  
        targ:addSpell(127, false, true);  -- protectra III
        

        targ:addSpell(108, false, true);  -- regen
        targ:addSpell(110, false, true);  -- regen II

        targ:addSpell(23, false, true);  -- dia
        targ:addSpell(58, false, true);  -- paralyze
        targ:addSpell(28, false, true);  -- banish
        targ:addSpell(69, false, true);  -- barstonra
        targ:addSpell(14, false, true);  -- poisona
        targ:addSpell(86, false, true);  -- barsleepra        
        targ:addSpell(71, false, true);  -- barwatera
        targ:addSpell(15, false, true);  -- paralyna
        targ:addSpell(55, false, true);  -- aquavail
        targ:addSpell(87, false, true);  -- barpoisonra
        targ:addSpell(88, false, true);  -- barparalyzra
        targ:addSpell(68, false, true);  -- baraera
        targ:addSpell(56, false, true);  -- slow
        targ:addSpell(16, false, true);  -- blindna
        targ:addSpell(38, false, true);  -- banishga
        targ:addSpell(59, false, true);  -- silence
        targ:addSpell(66, false, true);  -- barfira
        targ:addSpell(89, false, true);  -- barblindra
        targ:addSpell(33, false, true);  -- diaga
        targ:addSpell(53, false, true);  -- blink
        targ:addSpell(17, false, true);  -- silena
        targ:addSpell(137, false, true);  -- sneak
        targ:addSpell(67, false, true);  -- barblizzara        
        targ:addSpell(90, false, true);  -- barsilencera
        targ:addSpell(70, false, true);  -- barthundara
        targ:addSpell(136, false, true);  -- invisible
        targ:addSpell(135, false, true);  -- reraise
        targ:addSpell(54, false, true);  -- stoneskin
        targ:addSpell(20, false, true);  -- cursna
        targ:addSpell(29, false, true);  -- banish II
        targ:addSpell(19, false, true);  -- viruna
        targ:addSpell(24, false, true);  -- dia II
        targ:addSpell(92, false, true);  -- barvira
        targ:addSpell(18, false, true);  -- Stona
        targ:addSpell(39, false, true);  -- banishga II
        targ:addSpell(57, false, true);  -- haste
        -- targ:addSpell(93, false, true);  -- cura
        targ:addSpell(91, false, true);  -- barpetra        
        targ:addSpell(112, false, true);  -- flash
        -- targ:addSpell(98, false, true);  -- repose
        targ:addSpell(21, false, true);  -- holy
    end
    if targ:getMainJob() == dsp.job.RDM then
        targ:addSpell(1, false, true);  -- cures
        targ:addSpell(2, false, true);
        targ:addSpell(3, false, true);
        targ:addSpell(12, false, true); -- raise

        targ:addSpell(58, false, true);  -- paralyze
        targ:addSpell(55, false, true);  -- aquavail
        targ:addSpell(56, false, true);  -- slow
        targ:addSpell(59, false, true);  -- silence
        targ:addSpell(53, false, true);  -- blink
        targ:addSpell(137, false, true);  -- sneak
        targ:addSpell(136, false, true);  -- invisible
        targ:addSpell(54, false, true);  -- stoneskin
        targ:addSpell(57, false, true);  -- haste
        
        targ:addSpell(34, false, true);  -- diaga II

        targ:addSpell(48, false, true);  -- shell        
        targ:addSpell(49, false, true);  -- shell II

        targ:addSpell(43, false, true);  -- protect        
        targ:addSpell(44, false, true);  -- protect II        
        targ:addSpell(45, false, true);  -- protect III     
        
        targ:addSpell(60, false, true);  -- barfire
        targ:addSpell(61, false, true);  -- barbliz
        targ:addSpell(62, false, true);  -- barzero
        targ:addSpell(63, false, true);  -- barstone
        targ:addSpell(64, false, true);  -- barthund
        targ:addSpell(65, false, true);  -- barwater

        targ:addSpell(72, false, true);  -- barsleep
        targ:addSpell(73, false, true);   -- bar poisn
        targ:addSpell(74, false, true);   -- barparalyze
        targ:addSpell(75, false, true);   -- barblind
        targ:addSpell(76, false, true);   -- barsilence
        targ:addSpell(77, false, true);   -- barpetrify
        targ:addSpell(78, false, true);   -- barvirus
        targ:addSpell(3, false, true);   --
        
        targ:addSpell(100, false, true);  -- enfire
        targ:addSpell(101, false, true);  -- enbliz
        targ:addSpell(102, false, true);  -- enero
        targ:addSpell(103, false, true);  -- enstone
        targ:addSpell(104, false, true);  -- enthund
        targ:addSpell(105, false, true);  -- enwater

        targ:addSpell(108, false, true);  -- regen

        targ:addSpell(109, false, true);  -- refresh

        targ:addSpell(159, false, true);  -- stone
        targ:addSpell(160, false, true);  -- stone II

        targ:addSpell(169, false, true);  -- water
        targ:addSpell(170, false, true);  -- water II

        targ:addSpell(154, false, true);  -- aero
        targ:addSpell(155, false, true);  -- aero II

        targ:addSpell(144, false, true);  -- fire
        targ:addSpell(145, false, true);  -- fire II

        targ:addSpell(149, false, true);  -- blizzard        

        targ:addSpell(164, false, true);  -- thunder        

        targ:addSpell(253, false, true);  -- sleep
        targ:addSpell(259, false, true);  -- sleep II

        targ:addSpell(220, false, true);  -- poison
        targ:addSpell(221, false, true);  -- poison II

        targ:addSpell(230, false, true);  -- bio
        targ:addSpell(231, false, true);  -- bio II

        targ:addSpell(254, false, true);  -- blind
        targ:addSpell(258, false, true);  -- bind        
    end    
end;

