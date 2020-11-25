----------------------------------------------------------------------------------------
--  __  __           _                     __   _____                        _
-- |  \/  |         | |                   / _| |  __ \                      | |
-- | \  / | __ _ ___| |_ ___ _ __    ___ | |_  | |__) |   _ _ __  _ __   ___| |_ ___
-- | |\/| |/ _` / __| __/ _ \ '__|  / _ \|  _| |  ___/ | | | '_ \| '_ \ / _ \ __/ __|
-- | |  | | (_| \__ \ ||  __/ |    | (_) | |   | |   | |_| | |_) | |_) |  __/ |_\__ \
-- |_|  |_|\__,_|___/\__\___|_|     \___/|_|   |_|    \__,_| .__/| .__/ \___|\__|___/
--                                                         | |   | |
--                                                         |_|   |_|
-----------------------------------------------------------------------------------------
--[[

    Originally Created By: Faloun
    Programmers: Arrchie, Kuroganashi, Byrne, Tuna
    Testers:Arrchie, Kuroganashi, Haxetc, Patb, Whirlin, Petsmart
    Contributors: Xilkk, Byrne, Blackhalo714

    ASCII Art Generator: http://www.network-science.de/ascii/
    
]]

-- Initialization function for this job file.
-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include("Mote-Include.lua")
end

function user_setup()
    -- Alt-F10 - Toggles Kiting Mode.

    --[[
        F9 - Cycle Offense Mode (the offensive half of all 'hybrid' melee modes).
        
        These are for when you are fighting with or without Pet
        When you are IDLE and Pet is ENGAGED that is handled by the Idle Sets
    ]]
    state.OffenseMode:options("MasterPet", "Master", "Trusts")

    --[[
        Ctrl-F9 - Cycle Hybrid Mode (the defensive half of all 'hybrid' melee modes).
        
        Used when you are Engaged with Pet
        Used when you are Idle and Pet is Engaged
    ]]
    state.HybridMode:options("Normal", "PETDA", "TP", "DT", "OD", "ACC")

    --[[
        Alt-F12 - Turns off any emergency mode
        
        Ctrl-F10 - Cycle type of Physical Defense Mode in use.
        F10 - Activate emergency Physical Defense Mode. Replaces Magical Defense Mode, if that was active.
    ]]
    state.PhysicalDefenseMode:options("PetDT", "MasterDT")

    --[[
        Alt-F12 - Turns off any emergency mode

        F11 - Activate emergency Magical Defense Mode. Replaces Physical Defense Mode, if that was active.
    ]]
    state.MagicalDefenseMode:options("PetMDT")

    --[[ IDLE Mode Notes:

        F12 - Update currently equipped gear, and report current status.
        Ctrl-F12 - Cycle Idle Mode.
        
        Will automatically set IdleMode to Idle when Pet becomes Engaged and you are Idle
    ]]
    state.IdleMode:options("Idle", "MasterDT")

    --Various Cycles for the different types of PetModes
    state.PetStyleCycleTank = M {"NORMAL", "DD", "MAGIC", "SPAM"}
    state.PetStyleCycleMage = M {"NORMAL", "HEAL", "SUPPORT", "MB", "DD"}
    state.PetStyleCycleDD = M {"NORMAL", "BONE", "SPAM", "OD"}

    --The actual Pet Mode and Pet Style cycles
    --Default Mode is Tank
    state.PetModeCycle = M {"TANK", "DD", "MAGE"}
    --Default Pet Cycle is Tank
    state.PetStyleCycle = state.PetStyleCycleTank

    --Toggles
    --[[
        Alt + E will turn on or off Auto Maneuver
    ]]
    state.AutoMan = M(false, "Auto Maneuver")

    --[[
        //gs c toggle autodeploy
    ]]
    state.AutoDeploy = M(false, "Auto Deploy")

    --[[
        Alt + D will turn on or off Lock Pet DT
        (Note this will block all gearswapping when active)
    ]]
    state.LockPetDT = M(false, "Lock Pet DT")

    --[[
        Alt + (tilda) will turn on or off the Lock Weapon
    ]]
    state.LockWeapon = M(false, "Lock Weapon")

    --[[
        //gs c toggle setftp
    ]]
    state.SetFTP = M(false, "Set FTP")

   --[[
        This will hide the entire HUB
        //gs c hub all
    ]]
    state.textHideHUB = M(false, "Hide HUB")

    --[[
        This will hide the Mode on the HUB
        //gs c hub mode
    ]]
    state.textHideMode = M(false, "Hide Mode")

    --[[
        This will hide the State on the HUB
        //gs c hub state
    ]]
    state.textHideState = M(false, "Hide State")

    --[[
        This will hide the Options on the HUB
        //gs c hub options
    ]]
    state.textHideOptions = M(false, "Hide Options")

    --[[
        This will toggle the HUB lite mode
        //gs c hub lite
    ]]  
    state.useLightMode = M(false, "Toggles Lite mode")

    --[[
        This will toggle the default Keybinds set up for any changeable command on the window
        //gs c hub keybinds
    ]]
    state.Keybinds = M(false, "Hide Keybinds")

    --[[ 
        This will toggle the CP Mode 
        //gs c toggle CP 
    ]] 
    state.CP = M(false, "CP") 
    CP_CAPE = "Aptitude Mantle +1" 

    --[[
        Enter the slots you would lock based on a custom set up.
        Can be used in situation like Salvage where you don't want
        certain pieces to change.

        //gs c toggle customgearlock
        ]]
    state.CustomGearLock = M(false, "Custom Gear Lock")
    --Example customGearLock = T{"head", "waist"}
    customGearLock = T{}

    send_command("bind !f7 gs c cycle PetModeCycle")
    send_command("bind ^f7 gs c cycleback PetModeCycle")
    send_command("bind !f8 gs c cycle PetStyleCycle")
    send_command("bind ^f8 gs c cycleback PetStyleCycle")
    send_command("bind !e gs c toggle AutoMan")
    send_command("bind !d gs c toggle LockPetDT")
    send_command("bind !f6 gs c predict")
    send_command("bind ^` gs c toggle LockWeapon")
    send_command("bind home gs c toggle setftp")
    send_command("bind PAGEUP gs c toggle autodeploy")
    send_command("bind PAGEDOWN gs c hide keybinds")
    send_command("bind end gs c toggle CP") 
    send_command("bind = gs c clear")

    select_default_macro_book()
	send_command('@wait 4;input /lockstyleset 4')

    -- Adjust the X (horizontal) and Y (vertical) position here to adjust the window
    pos_x = 1400
    pos_y = 100
    setupTextWindow(pos_x, pos_y)
    
end

function file_unload()
    send_command("unbind !f7")
    send_command("unbind ^f7")
    send_command("unbind !f8")
    send_command("unbind ^f8")
    send_command("unbind !e")
    send_command("unbind !d")
    send_command("unbind !f6")
    send_command("unbind ^`")
    send_command("unbind home")
    send_command("unbind PAGEUP")
    send_command("unbind PAGEDOWN")       
    send_command("unbind end")
    send_command("unbind =")
end

function job_setup()
    include("PUP-LIB.lua")
end

function init_gear_sets()
    --Table of Contents
    ---Gear Variables
    ---Master Only Sets
    ---Hybrid Only Sets
    ---Pet Only Sets
    ---Misc Sets

    -------------------------------------------------------------------------
    --  _____                  __      __        _       _     _
    -- / ____|                 \ \    / /       (_)     | |   | |
    --| |  __  ___  __ _ _ __   \ \  / /_ _ _ __ _  __ _| |__ | | ___  ___
    --| | |_ |/ _ \/ _` | '__|   \ \/ / _` | '__| |/ _` | '_ \| |/ _ \/ __|
    --| |__| |  __/ (_| | |       \  / (_| | |  | | (_| | |_) | |  __/\__ \
    -- \_____|\___|\__,_|_|        \/ \__,_|_|  |_|\__,_|_.__/|_|\___||___/
    -------------------------------------------------------------------------
    --[[
        This section is best ultilized for defining gear that is used among multiple sets
        You can simply use or ignore the below
    ]]
    Animators = {}
    Animators.Range = "Animator P II"
    Animators.Melee = "Animator P +1"

    --Adjust to your reforge level
    --Sets up a Key, Value Pair
    Artifact_Foire = {}
    Artifact_Foire.Head_PRegen = "Foire Taj +1"
    Artifact_Foire.Body_WSD_PTank = "Foire Tobe +1"
    Artifact_Foire.Hands_Mane_Overload = "Foire Dastanas +1"
    Artifact_Foire.Legs_PCure = "Foire Churidars +1"
    Artifact_Foire.Feet_Repair_PMagic = "Foire Babouches +1"

    Relic_Pitre = {}
    Relic_Pitre.Head_PRegen = "Pitre Taj +2" --Enhances Optimization
    Relic_Pitre.Body_PTP = "Pitre Tobe +1" --Enhances Overdrive
    Relic_Pitre.Hands_WSD = "Pitre Dastanas +2" --Enhances Fine-Tuning
    Relic_Pitre.Legs_PMagic = "Pitre Churidars +2" --Enhances Ventriloquy
    Relic_Pitre.Feet_PMagic = "Pitre Babouches +1" --Role Reversal

    Empy_Karagoz = {}
    Empy_Karagoz.Head_PTPBonus = "Karagoz Capello +1"
    Empy_Karagoz.Body_Overload = "Karagoz Farsetto"
    Empy_Karagoz.Hands = "Karagoz Guanti"
    Empy_Karagoz.Legs_Combat = "Karagoz Pantaloni +1"
    Empy_Karagoz.Feet_Tatical = "Karagoz Scarpe +1"

    Visucius = {}
    Visucius.PetDT = {
        name = "Visucius's Mantle",
        augments = {
            "Pet: Phys. dmg. taken -10%"
        },
    }
    Visucius.PetMagic = {
        name = "Visucius's Mantle",
        augments = {
            "Pet: Phys. dmg. taken -10%"
        }
    }
	Visucius.TP = {
        name = "Visucius's Mantle",
        augments = {
			'Pet: Haste+10%',
            "Pet: Phys. dmg. taken -10%"
        }
    }
	
	PET_TP_GEAR={
		head={name="Herculean Helm", augments={'Pet: "Store TP+10"'}},
		legs={name="Herculean Trousers", augments={'Pet: "Store TP"+9'}},
		body={name=Relic_Pitre.Body_PTP},
		hands={name="Herculean Gloves", augments={'Pet: "Store TP"+11'}},
		feet={name="Herculean Boots", augments={'Pet: "Store TP"+10'}},
		ring1="Cath Palug Ring",
		ring2="Thurandaut Ring",
		ear1="Domes. Earring",
		ear2="Rimeice Earring",
		neck="Shulmanu Collar",
		back=Visucius.TP,
		waist="Klouskap Sash +1"
	}
	
	PET_DA_GEAR = set_combine(PET_TP_GEAR, {
		head={name="Taeon Chapeau",},
		body={name="Taeon Tabard"},
		hands={name="Taeon Gloves"},
		legs={name="Taeon Tights"},
		feet={name="Taeon Boots"},
	})
	
	OD_GEAR=set_combine(PET_TP_GEAR, {
		
	})
	
	DT_GEAR = {
       	head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs={name="Herculean Trousers", augments={'"Triple Atk."+4'}},
		feet="Malignance Boots",
		ring1="Cath Palug Ring",
		ring2="Thurandaut Ring",
		ear1="Domes. Earring",
		ear2="Rimeice Earring",
		waist="Moonbow Belt +1",
		neck="Shulmanu Collar",
    }
	
	sets.DD = {}
	sets.DD.BONE = set_combine(PET_DA_GEAR, {
		back=Visucius.TP,
		ear2="Kyrene's Earring",
		waist="Incarnation Sash",
	})	

    --------------------------------------------------------------------------------
    --  __  __           _               ____        _          _____      _
    -- |  \/  |         | |             / __ \      | |        / ____|    | |
    -- | \  / | __ _ ___| |_ ___ _ __  | |  | |_ __ | |_   _  | (___   ___| |_ ___
    -- | |\/| |/ _` / __| __/ _ \ '__| | |  | | '_ \| | | | |  \___ \ / _ \ __/ __|
    -- | |  | | (_| \__ \ ||  __/ |    | |__| | | | | | |_| |  ____) |  __/ |_\__ \
    -- |_|  |_|\__,_|___/\__\___|_|     \____/|_| |_|_|\__, | |_____/ \___|\__|___/
    --                                                  __/ |
    --                                                 |___/
    ---------------------------------------------------------------------------------
    --This section is best utilized for Master Sets
    --[[
        Will be activated when Pet is not active, otherwise refer to sets.idle.Pet
    ]]
    sets.idle = set_combine(DT_GEAR, {})

    -------------------------------------Fastcast
    sets.precast.FC = {
       head="Herculean Helmet"
    }

    -------------------------------------Midcast
    sets.midcast = {} --Can be left empty

    sets.midcast.FastRecast = {
       -- Add your set here 
    }

    -------------------------------------Kiting
    sets.Kiting = {feet = "Hermes' Sandals"}

    -------------------------------------JA
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck = "Magoraga Beads", body = "Passion Jacket"})

    -- Precast sets to enhance JAs
    sets.precast.JA = {} -- Can be left empty

    sets.precast.JA["Tactical Switch"] = {feet = Empy_Karagoz.Feet_Tatical}

    sets.precast.JA["Ventriloquy"] = {legs = Relic_Pitre.Legs_PMagic}

    sets.precast.JA["Role Reversal"] = {feet = Relic_Pitre.Feet_PMagic}

    sets.precast.JA["Overdrive"] = {body = Relic_Pitre.Body_PTP}

    sets.precast.JA["Repair"] = {
		head="Rao Kabuto +1",
		body="Rao Togi +1",
		hands="Rao Kote +1",
		feet="Rao Sune-Ate +1",
        ammo = "Automat. Oil +3",
        feet = Artifact_Foire.Feet_Repair_PMagic
    }

    sets.precast.JA["Maintenance"] = set_combine(sets.precast.JA["Repair"], {})

    sets.precast.JA.Maneuver = {
        neck = "Buffoon's Collar +1",
        body = "Karagoz Farsetto +1",
        hands = Artifact_Foire.Hands_Mane_Overload,
        back = "Visucius's Mantle",
        ear1 = "Burana Earring"
    }

    sets.precast.JA["Activate"] = {back = "Visucius's Mantle"}

    sets.precast.JA["Deus Ex Automata"] = sets.precast.JA["Activate"]

    sets.precast.JA["Provoke"] = {}

    --Waltz set (chr and vit)
    sets.precast.Waltz = {
       -- Add your set here 
    }

    sets.precast.Waltz["Healing Waltz"] = {}
	
	sets.multi_attack = {
		legs={name="Herculean Trousers", augments={'"Triple Attack"+4'}},
		feet={name="Herculean Boots", augments={'"Triple Attack"+3'}},
		left_ear="Mache Earring +1",
		right_ear="Mache Earring +1",
		body="Tali'ah Manteel +2",
		waist="Moonbow Belt +1",
	}

    -------------------------------------WS
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
       	head="Heyoka Cap",
		hands="Heyoka Mittens",
		--legs="Heyoka Subligar",
		--feet="Heyoka Leggings",
		ring1="Petrov Ring",
		ring2="Gere Ring",
		neck="Fotia Gorget",
		
		legs={name="Herculean Trousers", augments={'"Triple Attack"+4'}},
		feet={name="Herculean Boots", augments={'"Triple Attack"+3'}},
		left_ear="Mache Earring +1",
		right_ear="Mache Earring +1",
		body="Tali'ah Manteel +2",
		waist="Moonbow Belt +1",
    }

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS["Stringing Pummel"] = set_combine(sets.precast.WS, {})

    sets.precast.WS["Stringing Pummel"].Mod = set_combine(sets.precast.WS, {})

    sets.precast.WS["Victory Smite"] = set_combine(sets.precast.WS, {})

    sets.precast.WS["Shijin Spiral"] = set_combine(sets.precast.WS, {})

    sets.precast.WS["Howling Fist"] = set_combine(sets.precast.WS, {})
	
	sets.precast.WS["Raging Fists"] = set_combine(sets.precast.WS, {})

    -------------------------------------Idle
    --[[
        Pet is not active
        Idle Mode = MasterDT
    ]]
    sets.idle.MasterDT = set_combine(DT_GEAR, {})

    -------------------------------------Engaged
    --[[
        Offense Mode = Master
        Hybrid Mode = Normal
    ]]
    sets.engaged.Master = {
       	head="Tali'ah Turban +1",
		body="Tali'ah Manteel +2",
		hands="Heyoka Mittens",
		legs="Heyoka Subligar",
		feet="Heyoka Leggings",
		ring1="Rajas Ring",
		ring2="Defending Ring",
		ear1="Cessance Earring",
		ear2="Domes. Earring",
		waist="Moonbow Belt +1"
    }

    -------------------------------------Acc
    --[[
        Offense Mode = Master
        Hybrid Mode = Acc
    ]]
    sets.engaged.Master.Acc = {
       -- Add your set here 
    }

    -------------------------------------TP
    --[[
        Offense Mode = Master
        Hybrid Mode = TP
    ]]
    sets.engaged.Master.TP = set_combine(DT_GEAR, {
		body="Tali'ah Manteel +2",
		ring1="Gere Ring",
		ring2="Chirich Ring",
		ear1="Cessance Earring",
		ear2="Mache Earring +1",
		ring1="Cath Palug Ring",
		ring2="Thurandaut Ring",
	})

    -------------------------------------DT
    --[[
        Offense Mode = Master
        Hybrid Mode = DT
    ]]
    sets.engaged.Master.DT = set_combine(DT_GEAR, {})

    ----------------------------------------------------------------------------------
    --  __  __         _           ___     _     ___      _
    -- |  \/  |__ _ __| |_ ___ _ _| _ \___| |_  / __| ___| |_ ___
    -- | |\/| / _` (_-<  _/ -_) '_|  _/ -_)  _| \__ \/ -_)  _(_-<
    -- |_|  |_\__,_/__/\__\___|_| |_| \___|\__| |___/\___|\__/__/
    -----------------------------------------------------------------------------------

    --[[
        These sets are designed to be a hybrid of player and pet gear for when you are
        fighting along side your pet. Basically gear used here should benefit both the player
        and the pet.
    ]]
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = Normal
    ]]
    sets.engaged.MasterPet = {
       	head="Tali'ah Turban +1",
		neck="Shulmanu Collar",
		body=Relic_Pitre.Body_PTP,
		hands={name="Herculean Gloves", augments={'Pet: "Store TP"+11'}},
		legs="Heyoka Subligar",
		feet={name="Herculean Boots", augments={'Pet: "Store TP"+10'}},
		ring1="Thurandaut Ring",
		ring2="C. Palug Ring",
		ear1="Cessance Earring",
		ear2="Mache Earring +1",
		waist="Klouskap Sash +1"
    }
	
	--[[
        Offense Mode = Trusts
        Hybrid Mode = Normal
    ]]
	sets.engaged.Trusts = set_combine(PET_TP_GEAR, {
		main="Pitre Fists",
		head=Empy_Karagoz.Head_PTPBonus,
		back="Dispersal Mantle"
	})

    -------------------------------------Acc
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = Acc
    ]]
    sets.engaged.MasterPet.Acc = set_combine(sets.engaged.MasterPet, {
		hands="Heyoka Mittens",
		feet="Heyoka Leggings"
	})

    -------------------------------------TP
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = TP
    ]]
    sets.engaged.MasterPet.TP = sets.engaged.Master.TP
	
	sets.engaged.MasterPet.PETDA = PET_DA_GEAR

    -------------------------------------DT
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = DT
    ]]
    sets.engaged.MasterPet.DT = set_combine(DT_GEAR, {})
	
	-------------------------------------OD
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = OD
    ]]
    sets.engaged.MasterPet.OD = set_combine(OD_Gear, {})

    -------------------------------------Regen
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = Regen
    ]]
    sets.engaged.MasterPet.Regen = {
       -- Add your set here 
    }

    ----------------------------------------------------------------
    --  _____     _      ____        _          _____      _
    -- |  __ \   | |    / __ \      | |        / ____|    | |
    -- | |__) |__| |_  | |  | |_ __ | |_   _  | (___   ___| |_ ___
    -- |  ___/ _ \ __| | |  | | '_ \| | | | |  \___ \ / _ \ __/ __|
    -- | |  |  __/ |_  | |__| | | | | | |_| |  ____) |  __/ |_\__ \
    -- |_|   \___|\__|  \____/|_| |_|_|\__, | |_____/ \___|\__|___/
    --                                  __/ |
    --                                 |___/
    ----------------------------------------------------------------

    -------------------------------------Magic Midcast
    sets.midcast.Pet = {
       -- Add your set here 
    }

    sets.midcast.Pet.Cure = {
       -- Add your set here 
    }

    sets.midcast.Pet["Healing Magic"] = {
       -- Add your set here 
    }

    sets.midcast.Pet["Elemental Magic"] = {
       -- Add your set here 
    }

    sets.midcast.Pet["Enfeebling Magic"] = {
       -- Add your set here 
    }

    sets.midcast.Pet["Dark Magic"] = {
       -- Add your set here 
    }

    sets.midcast.Pet["Divine Magic"] = {
       -- Add your set here 
    }

    sets.midcast.Pet["Enhancing Magic"] = {
       -- Add your set here 
    }

    -------------------------------------Idle
    --[[
        This set will become default Idle Set when the Pet is Active 
        and sets.idle will be ignored
        Player = Idle and not fighting
        Pet = Idle and not fighting

        Idle Mode = Idle
    ]]
    sets.idle.Pet = PET_DA_GEAR

    --[[
        If pet is active and you are idle and pet is idle
        Player = idle and not fighting
        Pet = idle and not fighting

        Idle Mode = MasterDT
    ]]
    sets.idle.MasterDT = set_combine(DT_GEAR, {})

    -------------------------------------Enmity
    sets.pet = {} -- Not Used

    --Equipped automatically
    sets.pet.Enmity = {
		head="Heyoka Cap",
		body="Heyoka Harness",
       	hands="Heyoka Mittens",
	   	legs="Heyoka Subligar",
	   	feet="Heyoka Leggings",
	   	left_ear="Rimeice Earring",
		right_ear="Domes. Earring",
		neck="Shulmanu Collar",
    }

    --[[
        Activated by Alt+D or
        F10 if Physical Defense Mode = PetDT
    ]]
    sets.pet.EmergencyDT = {
       -- Add your set here 
    }

    -------------------------------------Engaged for Pet Only
    --[[
      For Technical Users - This is layout of below
      sets.idle[idleScope][state.IdleMode][ Pet[Engaged] ][CustomIdleGroups] 

      For Non-Technical Users:
      If you the player is not fighting and your pet is fighting the first set that will activate is sets.idle.Pet.Engaged
      You can further adjust this by changing the HyrbidMode using Ctrl+F9 to activate the Acc/TP/DT/Regen/Ranged sets
    ]]
    --[[
        Idle Mode = Idle
        Hybrid Mode = Normal
    ]]
    sets.idle.Pet.Engaged = set_combine(PET_TP_GEAR, {})

    --[[
        Idle Mode = Idle
        Hybrid Mode = Acc
    ]]
    sets.idle.Pet.Engaged.Acc = set_combine(PET_TP_GEAR, {
		legs="Heyoka Subligar"
	})

    --[[
        Idle Mode = Idle
        Hybrid Mode = TP
    ]]
    sets.idle.Pet.Engaged.TP = set_combine(PET_TP_GEAR, {})

    --[[
        Idle Mode = Idle
        Hybrid Mode = DT
    ]]
    sets.idle.Pet.Engaged.DT = set_combine(PET_TP_GEAR, {
       	head="Rao Kabuto +1",
		body="Rao Togi +1",
		hands="Rao Kote +1",
		legs="Tali'ah Sera. +1",
		feet="Rao Sune-Ate +1",
		left_ear="Rimeice Earring",
		right_ear="Domes. Earring"
    })
	
	sets.idle.Pet.Engaged.PETDA = PET_DA_GEAR
	
	sets.idle.Pet.Engaged.OD = set_combine(OD_GEAR, {})
	
	sets.idle.Pet.Engaged.ODSOLO = set_combine(OD_GEAR, {
		head=Empy_Karagoz.Head_PTPBonus,
		back="Dispersal Mantle"
	})

    --[[
        Idle Mode = Idle
        Hybrid Mode = Regen
    ]]
    sets.idle.Pet.Engaged.Regen = {
       -- Add your set here 
    }

    --[[
        Idle Mode = Idle
        Hybrid Mode = Ranged
    ]]
    sets.idle.Pet.Engaged.Ranged =
        set_combine(
        sets.idle.Pet.Engaged,
        {
            legs = Empy_Karagoz.Legs_Combat
        }
    )

    -------------------------------------WS
    --[[
        WSNoFTP is the default weaponskill set used
    ]]
    sets.midcast.Pet.WSNoFTP = {
        head="Tali'ah Turban +1",
		body="Tali'ah Manteel +2",
		hands="Karagoz Guanti +1",
		legs="Kara. Pantaloni +1",
		feet="Naga Kyahan",
		back=Visucius.TP,
		ear2="Kyrene's Earring",
		ring1="Thurandaut Ring",
		ring2="C. Palug Ring",
		--left_ring="Varar Ring",
		--right_ring="Thurandaut Ring"
       -- Add your set here
    }

    --[[
        If we have a pet weaponskill that can benefit from WSFTP
        then this set will be equipped
    ]]
    sets.midcast.Pet.WSFTP = set_combine(sets.midcast.Pet.WSNoFTP, {
		head=Empy_Karagoz.Head_PTPBonus,
		back="Dispersal Mantle",
	})

    --[[
        Base Weapon Skill Set
        Used by default if no modifier is found
    ]]
    sets.midcast.Pet.WS = set_combine(sets.midcast.Pet.WSNoFTP, {})

    --Chimera Ripper, String Clipper
    sets.midcast.Pet.WS["STR"] = set_combine(PET_DA_GEAR, {
		ear2="Kyrene's Earring",
		hands="Karagoz Guanti +1",
	})

    -- Bone crusher, String Shredder
    sets.midcast.Pet.WS["VIT"] =
        set_combine(
        PET_DA_GEAR,
        {
            -- Add your gear here that would be different from sets.midcast.Pet.WSNoFTP
            --head = Empy_Karagoz.Head_PTPBonus
			ear2="Kyrene's Earring",
			waist="Incarnation Sash",
        }
    )

    -- Cannibal Blade
    sets.midcast.Pet.WS["MND"] = set_combine(sets.midcast.Pet.WSNoFTP, {})

    -- Armor Piercer, Armor Shatterer
    sets.midcast.Pet.WS["DEX"] = set_combine(sets.midcast.Pet.WSFTP, {
		ear2="Kyrene's Earring",
		legs="Kara. Pantaloni +1",
		hands="Karagoz Guanti +1",
	})

    -- Arcuballista, Daze
    sets.midcast.Pet.WS["DEXFTP"] =
        set_combine(
        sets.midcast.Pet.WSFTP,
        {
            -- Add your gear here that would be different from sets.midcast.Pet.WSFTP
            head = Empy_Karagoz.Head_PTPBonus,
			hands="Karagoz Guanti +1",
			legs="Kara. Pantaloni +1",
			ear2="Kyrene's Earring"
        }
    )

    ---------------------------------------------
    --  __  __ _             _____      _
    -- |  \/  (_)           / ____|    | |
    -- | \  / |_ ___  ___  | (___   ___| |_ ___
    -- | |\/| | / __|/ __|  \___ \ / _ \ __/ __|
    -- | |  | | \__ \ (__   ____) |  __/ |_\__ \
    -- |_|  |_|_|___/\___| |_____/ \___|\__|___/
    ---------------------------------------------
    -- Town Set
    sets.idle.Town = {
       -- Add your set here
    }

    -- Resting sets
    sets.resting = {
       -- Add your set here
    }

    sets.defense.MasterDT = sets.idle.MasterDT

    sets.defense.PetDT = sets.pet.EmergencyDT

    sets.defense.PetMDT = set_combine(sets.pet.EmergencyDT, {})
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 8)
end
