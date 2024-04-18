-----------------------------------
-- LOGIN SERVER SETTINGS
-----------------------------------
-- All settings are attached to the `xi.settings` object. This is published globally, and be accessed from C++ and any script.
--
-- This file is concerned mainly with logging into the game, and managing login sessions.
-----------------------------------

xi = xi or {}
xi.settings = xi.settings or {}

xi.settings.login =
{
    -- Expected Client version (wrong version cannot log in)
    CLIENT_VER = "30230905_0",

    -- 0 - disabled (every version allowed)
    -- 1 - enabled - strict (only exact CLIENT_VER allowed)
    -- 2 - enabled - greater than or equal  (matching or greater than CLIENT_VER allowed, default)
    --
    -- WE STRONGLY ADVISE AGAINST LOCKING THE SERVER TO OLDER VERSIONS. IT IS A UNIVERSALLY BAD IDEA.
    VER_LOCK = 2,

    -- 0 - disabled (normal operation)
    -- 1 - enabled (only GM characters allowed online, no new character creation)
    MAINT_MODE = 0,

    -- Logging of user IP address to database (true/false)
    LOG_USER_IP = true,

    -- Allow account creation via the loader (true/false)
    ACCOUNT_CREATION = true,

    -- Allow character deletion through the lobby (true/false)
    CHARACTER_DELETION = true,

    -- Allow character creation through the lobby (true/false)
    CHARACTER_CREATION = true,
    
    -- Number of simultaneous game sessions per IP (0 for no limit)
    LOGIN_LIMIT = 6,

    -- Expansion display on the client's login screen. This does NOT effect in game content whatsoever!
    RISE_OF_ZILART          = true,
    CHAINS_OF_PROMATHIA     = true,
    TREASURES_OF_AHT_URGHAN = true,
    WINGS_OF_THE_GODDESS    = false,
    A_CRYSTALLINE_PROPHECY  = false,
    A_MOOGLE_KUPOD_ETAT     = false,
    A_SHANTOTTO_ASCENSION   = false,
    VISIONS_OF_ABYSSEA      = false,
    SCARS_OF_ABYSSEA        = false,
    HEROES_OF_ABYSSEA       = false,
    SEEKERS_OF_ADOULIN      = false,

    -- Feature display on client's login screen. This does NOT effect in game content whatsoever!
    -- Mog wardrobes are per character, so anything custom will not be able to reflect per-account login screen.
    SECURE_TOKEN   = false, -- 2FA not supported yet
    MOG_WARDROBE_3 = true,
    MOG_WARDROBE_4 = false,
    MOG_WARDROBE_5 = false,
    MOG_WARDROBE_6 = false,
    MOG_WARDROBE_7 = false,
    MOG_WARDROBE_8 = false,

    -- If true, blocks character creation with names of NPCs and Mobs in the database (Fafnir, Shantotto, etc.)
    DISABLE_MOB_NPC_CHAR_NAMES = true,

    -- Character names with any of these words in, in any position, will be rejected
    --
    -- Examples that will be rejected (using "badword"):
    -- "badword"
    -- "imbadword"
    -- "badwordisme"
    -- "lolbadwordlol"
    --
    -- WARNING:
    -- Be aware of the "Scunthorpe problem"!
    --
    -- NOTE:
    -- You can Google for "bad word list txt" to find lists of words to populate this table, if you'd like
    BANNED_WORDS_LIST =
    {
        "badword",
    }
}
