-----------------------------------------------
-------------   GLOBAL SETTINGS   -------------
-----------------------------------------------

-- This is to allow server operators to further customize their servers.  As more features are added to pXI, the list will surely expand.
-- Anything scripted can be customized with proper script editing.

-- PLEASE REQUIRE THIS SCRIPT IN ANY SCRIPTS YOU DO: ADD THIS LINE TO THE TOP!!!!
-- require("scripts/globals/settings");
-- With this script added to yours, you can pull variables from it!!

-- Always include status.lua, which defines mods
-- require("scripts/globals/status");

-- Common functions
require("scripts/globals/common");

-- Enable Expansion (1= yes 0= no)
ENABLE_COP     = 1;
ENABLE_TOAU    = 1;
ENABLE_WOTG    = 1;
ENABLE_ACP     = 0;
ENABLE_AMK     = 0;
ENABLE_ASA     = 0;
ENABLE_ABYSSEA = 0;
ENABLE_SOA     = 0;
ENABLE_ROV     = 0;

ENABLE_VOIDWATCH = 0; -- Not an expansion, but has its own storyline.

-- FIELDS OF VALOR/Grounds of Valor settings
ENABLE_FIELD_MANUALS  = 1; -- Enables Fields of Valor
ENABLE_GROUNDS_TOMES  = 1; -- Enables Grounds of Valor
REGIME_WAIT = 0; -- Make people wait till 00:00 game time as in retail. If it's 0, there is no wait time.
LOW_LEVEL_REGIME = 0; -- Allow people to kill regime targets even if they give no exp, allowing people to farm regime targets at 75 in low level areas.

-- Setting to lock content more accurately to the content you have defined above
-- This generally results in a more accurate presentation of your selected expansions
-- as well as a less confusing player experience for things that are disabled (things that are disabled are not loaded)
-- This feature correlates to the content_tag column in the SQL files
RESTRICT_CONTENT = 1;

-- CHARACTER CONFIG
INITIAL_LEVEL_CAP = 50; -- The initial level cap for new players.  There seems to be a hardcap of 255.
MAX_LEVEL = 75; -- Level max of the server, lowers the attainable cap by disabling Limit Break quests.
NORMAL_MOB_MAX_LEVEL_RANGE_MIN = 86; -- Lower Bound of Max Level Range for Normal Mobs (0 = Uncapped)
NORMAL_MOB_MAX_LEVEL_RANGE_MAX = 92; -- Upper Bound of Max Level Range for Normal Mobs (0 = Uncapped)
START_GIL = 500; -- Amount of gil given to newly created characters.
START_INVENTORY = 80; -- Starting inventory and satchel size.  Ignores values < 30.  Do not set above 80!
OPENING_CUTSCENE_ENABLE = 0; -- Set to 1 to enable opening cutscenes, 0 to disable.
SUBJOB_QUEST_LEVEL = 18; -- Minimum level to accept either subjob quest.  Set to 0 to start the game with subjobs unlocked.
ADVANCED_JOB_LEVEL = 30; -- Minimum level to accept advanced job quests.  Set to 0 to start the game with advanced jobs.
ALL_MAPS = 1; -- Set to 1 to give starting characters all the maps.
UNLOCK_OUTPOST_WARPS = 1; -- Set to 1 to give starting characters all outpost warps.  2 to add Tu'Lia and Tavnazia.

SHOP_PRICE      = 1.000; -- Multiplies prices in NPC shops.
GIL_RATE        = 1.100; -- Multiplies gil earned from quests.  Won't always display in game.
BAYLD_RATE      = 1.300; -- Multiples bayld earned from quests.
EXP_RATE        = 1.000; -- Multiplies exp earned from fov and quests.
TABS_RATE       = 1.500; -- Multiplies tabs earned from fov.
CURE_POWER      = 1.250; -- Multiplies amount healed from Healing Magic, including the relevant Blue Magic.
ELEMENTAL_POWER = 0.950; -- Multiplies damage dealt by Elemental and non-drain Dark Magic.
DIVINE_POWER    = 1.500; -- Multiplies damage dealt by Divine Magic.
NINJUTSU_POWER  = 1.700; -- Multiplies damage dealt by Ninjutsu Magic.
BLUE_POWER      = 1.800; -- Multiplies damage dealt by Blue Magic.
DARK_POWER      = 1.500; -- Multiplies amount drained by Dark Magic.
ITEM_POWER      = 1.500; -- Multiplies the effect of items such as Potions and Ethers.
WEAPON_SKILL_POWER  = 1.400; -- Multiplies damage dealt by Weapon Skills.
WEAPON_SKILL_POINTS = 5.000; -- Multiplies points earned during weapon unlocking.
USE_ADOULIN_WEAPON_SKILL_CHANGES = false; -- true/false. Change to toggle new Adoulin weapon skill damage calculations

HARVESTING_BREAK_CHANCE = 10; -- % chance for the sickle to break during harvesting.  Set between 0 and 100.
EXCAVATION_BREAK_CHANCE = 10; -- % chance for the pickaxe to break during excavation.  Set between 0 and 100.
LOGGING_BREAK_CHANCE    = 10; -- % chance for the hatchet to break during logging.  Set between 0 and 100.
MINING_BREAK_CHANCE     = 10; -- % chance for the pickaxe to break during mining.  Set between 0 and 100.
HARVESTING_RATE         = 50; -- % chance to recieve an item from haresting.  Set between 0 and 100.
EXCAVATION_RATE         = 50; -- % chance to recieve an item from excavation.  Set between 0 and 100.
LOGGING_RATE            = 50; -- % chance to recieve an item from logging.  Set between 0 and 100.
MINING_RATE             = 50; -- % chance to recieve an item from mining.  Set between 0 and 100.
DIGGING_RATE            = 85; -- % chance to receive an item from chocbo digging during favorable weather.  Set between 0 and 100.

HEALING_TP_CHANGE       = -25; -- Change in TP for each healing tick. Default is -100

-- SE implemented coffer/chest illusion time in order to prevent coffer farming. No-one in the same area can open a chest or coffer for loot (gil, gems & items)
-- till a random time between MIN_ILLSION_TIME and MAX_ILLUSION_TIME. During this time players can loot keyitem and item related to quests (AF, maps... etc.)
COFFER_MAX_ILLUSION_TIME = 1800;  -- 1 hour
COFFER_MIN_ILLUSION_TIME = 600;  -- 30 minutes
CHEST_MAX_ILLUSION_TIME  = 1800;  -- 1 hour
CHEST_MIN_ILLUSION_TIME  = 600;  -- 30 minutes

-- Sets spawn type for: Behemoth, Fafnir, Adamantoise, King Behemoth, Nidhog, Aspidochelone.
-- Use 0 for timed spawns, 1 for force pop only, 2 for both
LandKingSystem_NQ = 2;
LandKingSystem_HQ = 1;

-- DYNAMIS SETTINGS
    BETWEEN_2DYNA_WAIT_TIME = 12;       -- Hours before player can re-enter Dynamis. Default is 1 Earthday (24 hours).
        DYNA_MIDNIGHT_RESET = false;     -- if true, makes the wait time count by number of server midnights instead of full 24 hour intervals
             DYNA_LEVEL_MIN = 65;       -- level min for entering in Dynamis
    TIMELESS_HOURGLASS_COST = 50000;   -- refund for the timeless hourglass for Dynamis.
   PRISMATIC_HOURGLASS_COST = 10000;    -- cost of the prismatic hourglass for Dynamis.
     CURRENCY_EXCHANGE_RATE = 100;      -- X Tier 1 ancient currency -> 1 Tier 2, and so on.  Certain values may conflict with shop items.  Not designed to exceed 198.
RELIC_2ND_UPGRADE_WAIT_TIME = 3600;     -- wait time for 2nd relic upgrade (stage 2 -> stage 3) in seconds. 7200s = 2 hours.
RELIC_3RD_UPGRADE_WAIT_TIME = 1800;     -- wait time for 3rd relic upgrade (stage 3 -> stage 4) in seconds. 3600s = 1 hour.
FREE_COP_DYNAMIS = 0 ; -- Authorize player to entering inside COP Dynamis without completing COP mission ( 1 = enable 0= disable)

-- QUEST/MISSION SPECIFIC SETTINGS
AF1_QUEST_LEVEL = 40; -- Minimum level to start AF1 quest
AF2_QUEST_LEVEL = 50; -- Minimum level to start AF2 quest
AF3_QUEST_LEVEL = 50; -- Minimum level to start AF3 quest
AF1_FAME = 20; -- base fame for completing an AF1 quest
AF2_FAME = 40; -- base fame for completing an AF2 quest
AF3_FAME = 60; -- base fame for completing an AF3 quest
OldSchoolG1 = true; -- Set to true to require farming Exoray Mold, Bombd Coal, and Ancient Papyrus drops instead of allowing key item method.
OldSchoolG2 = true; -- Set true to require the NMs for "Atop the Highest Mountains" be dead to get KI like before SE changed it.
FrigiciteDuration = 60; -- When OldSChoolG2 is enabled, this is the time (in seconds) you have from killing Boreal NMs to click the "???" target.

-- SPELL SPECIFIC SETTINGS
DIA_OVERWRITE = 1; --Set to 1 to allow Bio to overwrite same tier Dia.  Default is 1.
BIO_OVERWRITE = 0; --Set to 1 to allow Dia to overwrite same tier Bio.  Default is 0.
STONESKIN_CAP = 350; -- soft cap for hp absorbed by stoneskin
BLINK_SHADOWS = 2;   -- number of shadows supplied by Blink spell
SPIKE_EFFECT_DURATION = 180; -- the duration of RDM, BLM spikes effects (not Reprisal)
ELEMENTAL_DEBUFF_DURATION = 120; -- base duration of elemental debuffs
AQUAVEIL_COUNTER = 1;  -- Base amount of hits Aquaveil absorbs to prevent spell interrupts. Retail is 1.
ABSORB_SPELL_AMOUNT = 8; -- how much of a stat gets absorbed by DRK absorb spells - expected to be a multiple of 8.
ABSORB_SPELL_TICK = 9; -- duration of 1 absorb spell tick
SNEAK_INVIS_DURATION_MULTIPLIER = 1.5; -- multiplies duration of sneak,invis,deodorize to reduce player torture. 1 = retail behavior.
USE_OLD_CURE_FORMULA = false; -- true/false. if true, uses older cure formula (3*MND + VIT + 3*(healing skill/5)) // cure 6 will use the newer formula
USE_OLD_MAGIC_DAMAGE = false; -- true/false. if true, uses older magic damage formulas

-- CELEBRATIONS
EXPLORER_MOOGLE = 1; -- Enables Explorer Moogle teleports
EXPLORER_MOOGLE_LEVELCAP = 10;
HALLOWEEN_2005 = 1; -- Set to 1 to Enable the 2005 version of Harvest Festival, will start on Oct. 20 and end Nov. 1.
HALLOWEEN_YEAR_ROUND = 0; -- Set to 1 to have Harvest Festival initialize outside of normal times.

-- MISC
HOMEPOINT_HEAL = 1; --Set to 1 if you want Home Points to heal you like in single-player Final Fantasy games.
RIVERNE_PORTERS = 240; -- Time in seconds that Unstable Displacements in Cape Riverne stay open after trading a scale.
LANTERNS_STAY_LIT = 2400; -- time in seconds that lanterns in the Den of Rancor stay lit.
ENABLE_COP_ZONE_CAP = 1; -- enable or disable lvl cap
TIMEZONE_OFFSET = -5.0; -- Offset from UTC used to determine when "JP Midnight" is for the server.  Default is JST (+9.0).
ALLOW_MULTIPLE_EXP_RINGS = 0; -- Set to 1 to remove ownership restrictions on the Chariot/Empress/Emperor Band trio.
BYPASS_EXP_RING_ONE_PER_WEEK = 1; -- -- Set to 1 to bypass the limit of one ring per Conquest Tally Week.
NUMBER_OF_DM_EARRINGS = 2; -- Number of earrings players can simultaneously own from Divine Might before scripts start blocking them (Default: 1)
HOMEPOINT_TELEPORT = 1; -- Enables the homepoint teleport system
DIG_ABUNDANCE_BONUS = 450; -- Increase chance of digging up an item (450  = item digup chance +45)
DIG_FATIGUE = 1; -- Set to 0 to disable Dig Fatigue
DIG_GRANT_BURROW = 1; -- Set to 1 to grant burrow ability
DIG_GRANT_BORE = 1; -- Set to 1 to grant bore ability
ENM_COOLDOWN = 12;  -- Number of hours before a player can obtain same KI for ENMs (default: 5 days)
FORCE_SPAWN_QM_RESET_TIME = 90; -- Number of seconds the ??? remains hidden for after the despawning of the mob it force spawns.

-- LIMBUS
BETWEEN_2COSMOCLEANSE_WAIT_TIME = 10; -- Hours before player can re-enter Limbus. Default is 20 hrs.
DIMENSIONAL_PORTAL_UNLOCK = false; -- Set true to bypass requirements for using dimensional portals to reach sea for Limbus

-- ABYSSEA
VISITANT_BONUS = 1.50; -- Default: 1.00 - (retail) - Multiplies the base time value of each Traverser Stone.