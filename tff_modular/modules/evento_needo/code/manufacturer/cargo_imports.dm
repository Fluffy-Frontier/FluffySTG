/*
*
*					CLIP LANCHESTER
*
*/

/datum/armament_entry/company_import/clip_lanchester
	category = "Clip Lanchester"
	company_bitflag = CARGO_COMPANY_CLIP_LANCHESTER
	restricted = TRUE

//BALLISTICS

/datum/armament_entry/company_import/clip_lanchester/ballistic
	subcategory = "Ballistic Weaponry"

/datum/armament_entry/company_import/clip_lanchester/ballistic/cm23
	cost = 500
	item_type = /obj/item/gun/ballistic/automatic/pistol/cm23

/datum/armament_entry/company_import/clip_lanchester/ballistic/cm70
	cost = 500
	item_type = /obj/item/gun/ballistic/automatic/pistol/cm70

/datum/armament_entry/company_import/clip_lanchester/ballistic
	cost = 500
	item_type = /obj/item/gun/ballistic/automatic/pistol/cm357

/datum/armament_entry/company_import/clip_lanchester/ballistic/cm5
	cost = 850
	item_type = /obj/item/gun/ballistic/automatic/smg/cm5

/datum/armament_entry/company_import/clip_lanchester/ballistic/cm5/compact
	cost = 800
	item_type = /obj/item/gun/ballistic/automatic/smg/cm5/compact

/datum/armament_entry/company_import/clip_lanchester/ballistic/f4
	cost = 1200
	item_type = /obj/item/gun/ballistic/automatic/marksman/f4

/datum/armament_entry/company_import/clip_lanchester/ballistic/f90
	cost = 1200
	item_type = /obj/item/gun/ballistic/automatic/marksman/f90

/datum/armament_entry/company_import/clip_lanchester/ballistic/cm82
	cost = 1200
	item_type = /obj/item/gun/ballistic/automatic/assault/cm82

/datum/armament_entry/company_import/clip_lanchester/ballistic/cm24
	cost = 1200
	item_type = /obj/item/gun/ballistic/automatic/assault/skm/cm24

/datum/armament_entry/company_import/clip_lanchester/ballistic/cm40
	cost = 1600
	item_type = /obj/item/gun/ballistic/automatic/hmg/cm40

/datum/armament_entry/company_import/clip_lanchester/ballistic/rottweiler
	cost = 1850
	item_type = /obj/item/gun/ballistic/automatic/hmg/rottweiler

/datum/armament_entry/company_import/clip_lanchester/ballistic/cm15
	cost = 1000
	item_type = /obj/item/gun/ballistic/shotgun/cm15

// LASERS

/datum/armament_entry/company_import/clip_lanchester/lasers
	subcategory = "Laser Weaponry"

/datum/armament_entry/company_import/clip_lanchester/lasers/kalix
	cost = 1200
	item_type = /obj/item/gun/energy/kalix/clip

/datum/armament_entry/company_import/clip_lanchester/lasers/e50
	cost = 1300
	item_type = /obj/item/gun/energy/laser/e50/clip

//AMMO

/datum/armament_entry/company_import/clip_lanchester/ammunition
	subcategory = "Ammunition"

/datum/armament_entry/company_import/clip_lanchester/ammunition/cm23
	cost = 70
	item_type = /obj/item/ammo_box/magazine/cm23

/datum/armament_entry/company_import/clip_lanchester/ammunition/cm70
	cost = 70
	item_type = /obj/item/ammo_box/magazine/m9mm_cm70

/datum/armament_entry/company_import/clip_lanchester/ammunition/cm357
	cost = 150
	item_type = /obj/item/ammo_box/magazine/cm357

/datum/armament_entry/company_import/clip_lanchester/ammunition/cm5
	cost = 90
	item_type = /obj/item/ammo_box/magazine/cm5_9mm

/datum/armament_entry/company_import/clip_lanchester/ammunition/f4
	cost = 100
	item_type = /obj/item/ammo_box/magazine/f4_308

/datum/armament_entry/company_import/clip_lanchester/ammunition/f90
	cost = 100
	item_type = /obj/item/ammo_box/magazine/f90

/datum/armament_entry/company_import/clip_lanchester/ammunition/p16
	cost = 100
	item_type = /obj/item/ammo_box/magazine/p16

/datum/armament_entry/company_import/clip_lanchester/ammunition/skm762
	cost = 100
	item_type = /obj/item/ammo_box/magazine/skm_762_40

/datum/armament_entry/company_import/clip_lanchester/ammunition/cm40
	cost = 150
	item_type = /obj/item/ammo_box/magazine/cm40_762_40_box

/datum/armament_entry/company_import/clip_lanchester/ammunition/rottweiler
	cost = 150
	item_type = /obj/item/ammo_box/magazine/rottweiler_308_box

/datum/armament_entry/company_import/clip_lanchester/ammunition/cm15
	cost = 90
	item_type = /obj/item/ammo_box/magazine/cm15_12g

/*
*
*					EOEHOMA
*
*/

/datum/armament_entry/company_import/eoehoma
	category = "Eoehoma"
	company_bitflag = CARGO_COMPANY_EOEHOMA
	restricted = TRUE

//LASERS

/datum/armament_entry/company_import/eoehoma/lasers
	subcategory = "Laser Weaponry"

/datum/armament_entry/company_import/eoehoma/lasers/e10
	cost = 2000
	item_type = /obj/item/gun/energy/laser/e10

/datum/armament_entry/company_import/eoehoma/lasers/e11
	cost = 1200
	item_type = /obj/item/gun/energy/e_gun/e11

/datum/armament_entry/company_import/eoehoma/lasers/e50
	cost = 1500
	item_type = /obj/item/gun/energy/laser/e50

/datum/armament_entry/company_import/eoehoma/lasers/e60
	cost = 500
	item_type = /obj/item/gun/energy/disabler/e60

/*
*
*					ETHERBOR
*
*/

/datum/armament_entry/company_import/etherbor
	category = "Etherbor"
	company_bitflag = CARGO_COMPANY_ETHERBOR
	restricted = TRUE

//LASER

/datum/armament_entry/company_import/etherbor/lasers
	subcategory = "Laser Weaponry"

/datum/armament_entry/company_import/etherbor/lasers/kalix
	cost = 1200
	item_type = /obj/item/gun/energy/kalix

/datum/armament_entry/company_import/etherbor/lasers/pistol
	cost = 650
	item_type = /obj/item/gun/energy/kalix/pistol

/datum/armament_entry/company_import/etherbor/lasers/pgf
	cost = 1500
	item_type = /obj/item/gun/energy/kalix/pgf

/datum/armament_entry/company_import/etherbor/lasers/pgfmedium
	cost = 1600
	item_type = /obj/item/gun/energy/kalix/pgf/medium

/datum/armament_entry/company_import/etherbor/lasers/heavy
	cost = 1800
	item_type = /obj/item/gun/energy/kalix/pgf/heavy

/datum/armament_entry/company_import/etherbor/lasers/sniper
	cost = 2000
	item_type = /obj/item/gun/energy/kalix/pgf/heavy/sniper

/*
*
*					FRONTIER
*
*/

/datum/armament_entry/company_import/frontier
	category = "Frontier"
	company_bitflag = CARGO_COMPANY_FRONTIER_IMPORT
	restricted = TRUE

/datum/armament_entry/company_import/frontier/ballistic
	subcategory = "Ballistic Weaponry"

/datum/armament_entry/company_import/frontier/ballistic/mauler
	cost = 450
	item_type = /obj/item/gun/ballistic/automatic/pistol/mauler

/datum/armament_entry/company_import/frontier/ballistic/spitter
	cost = 650
	item_type = /obj/item/gun/ballistic/automatic/pistol/spitter

/datum/armament_entry/company_import/frontier/ballistic/pounder
	cost = 950
	item_type = /obj/item/gun/ballistic/automatic/smg/pounder

/datum/armament_entry/company_import/frontier/ballistic/shredder
	cost = 2000
	item_type = /obj/item/gun/ballistic/automatic/hmg/shredder
	contraband = TRUE

/datum/armament_entry/company_import/frontier/ammunition
	subcategory = "Ammunition"

/datum/armament_entry/company_import/frontier/ammunition/mauler
	cost = 75
	item_type = /obj/item/ammo_box/magazine/m9mm_mauler

/datum/armament_entry/company_import/frontier/ammunition/spitter
	cost = 75
	item_type = /obj/item/ammo_box/magazine/spitter_9mm

/datum/armament_entry/company_import/frontier/ammunition/pounder
	cost = 150
	item_type = /obj/item/ammo_box/magazine/c22lr_pounder_pan

/datum/armament_entry/company_import/frontier/ammunition/shredder
	cost = 350
	item_type = /obj/item/ammo_box/magazine/m12_shredder
	contraband = TRUE


/*
*
*					HUNTER PRIDE
*
*/

/datum/armament_entry/company_import/hunter_pride
	category = "Hunter Pride"
	company_bitflag = CARGO_COMPANY_HUNTER_PRIDE
	restricted = TRUE

//BALLISTICS

/datum/armament_entry/company_import/hunter_pride/ballistic
	subcategory = "Ballistic Weaponry"

/datum/armament_entry/company_import/hunter_pride/ballistic/montagne
	cost = 550
	item_type = /obj/item/gun/ballistic/revolver/montagne

/datum/armament_entry/company_import/hunter_pride/ballistic/ashhand
	cost = 550
	item_type = /obj/item/gun/ballistic/revolver/ashhand

/datum/armament_entry/company_import/hunter_pride/ballistic/firebrand
	cost = 550
	item_type = /obj/item/gun/ballistic/revolver/firebrand

/datum/armament_entry/company_import/hunter_pride/ballistic/shadow
	cost = 550
	item_type = /obj/item/gun/ballistic/revolver/shadow

/datum/armament_entry/company_import/hunter_pride/ballistic/detective
	cost = 550
	item_type = /obj/item/gun/ballistic/revolver/detective/shiptest

/datum/armament_entry/company_import/hunter_pride/ballistic/candor
	cost = 450
	item_type = /obj/item/gun/ballistic/automatic/pistol/candor

/datum/armament_entry/company_import/hunter_pride/ballistic/firestorm
	cost = 700
	item_type = /obj/item/gun/ballistic/automatic/smg/firestorm

/datum/armament_entry/company_import/hunter_pride/ballistic/doublebarrel
	cost = 650
	item_type = /obj/item/gun/ballistic/shotgun/doublebarrel/shiptest

/datum/armament_entry/company_import/hunter_pride/ballistic/brimstone
	cost = 750
	item_type = /obj/item/gun/ballistic/shotgun/brimstone

/datum/armament_entry/company_import/hunter_pride/ballistic/hellfire
	cost = 750
	item_type = /obj/item/gun/ballistic/shotgun/hellfire

/datum/armament_entry/company_import/hunter_pride/ballistic/conflagration
	cost = 800
	item_type = /obj/item/gun/ballistic/shotgun/flamingarrow/conflagration

/datum/armament_entry/company_import/hunter_pride/ballistic/illestren
	cost = 1300
	item_type = /obj/item/gun/ballistic/rifle/illestren

/datum/armament_entry/company_import/hunter_pride/ballistic/flamingarrow
	cost = 1500
	item_type = /obj/item/gun/ballistic/shotgun/flamingarrow

/datum/armament_entry/company_import/hunter_pride/ballistic/vickland
	cost = 1500
	item_type = /obj/item/gun/ballistic/automatic/marksman/vickland

/datum/armament_entry/company_import/hunter_pride/ballistic/scout
	cost = 1500
	item_type = /obj/item/gun/ballistic/rifle/scout

//AMMO

/datum/armament_entry/company_import/hunter_pride/ammunition
	subcategory = "Ammunition"

/datum/armament_entry/company_import/hunter_pride/ammunition/m45
	cost = 75
	item_type = /obj/item/ammo_box/magazine/m45

/datum/armament_entry/company_import/hunter_pride/ammunition/c44
	cost = 100
	item_type = /obj/item/ammo_box/magazine/c44_firestorm_mag

/datum/armament_entry/company_import/hunter_pride/ammunition/a850r
	cost = 100
	item_type = /obj/item/ammo_box/magazine/illestren_a850r

/*
*
*					OUTSIDE IMPORTS
*
*/

/datum/armament_entry/company_import/outside_imports
	category = "OUTSIDERS"
	company_bitflag = CARGO_COMPANY_IMPORTED_WEAPON
	restricted = TRUE

//BALLISTICS

/datum/armament_entry/company_import/outside_imports/ballistic
	subcategory = "Ballistic Weaponry"

/datum/armament_entry/company_import/outside_imports/ballistic/comissar
	cost = 700
	item_type = /obj/item/gun/ballistic/automatic/pistol/commissar

/datum/armament_entry/company_import/outside_imports/ballistic/derringer
	cost = 550
	item_type = /obj/item/gun/ballistic/derringer

/datum/armament_entry/company_import/outside_imports/ballistic/skm
	cost = 1250
	item_type = /obj/item/gun/ballistic/automatic/assault/skm

/datum/armament_entry/company_import/outside_imports/ballistic/skm/pirate
	contraband = TRUE
	item_type = /obj/item/gun/ballistic/automatic/assault/skm/pirate

/datum/armament_entry/company_import/outside_imports/ballistic/skm/inteq
	contraband = TRUE
	item_type = /obj/item/gun/ballistic/automatic/assault/skm/inteq

/datum/armament_entry/company_import/outside_imports/ballistic/swiss_cheese
	cost = 1250
	item_type = /obj/item/gun/ballistic/automatic/assault/swiss_cheese

/datum/armament_entry/company_import/outside_imports/ballistic/vector
	cost = 1100
	item_type = /obj/item/gun/ballistic/automatic/smg/vector

/datum/armament_entry/company_import/outside_imports/ballistic/skm_carbine
	cost = 1100
	item_type = /obj/item/gun/ballistic/automatic/smg/skm_carbine

/datum/armament_entry/company_import/outside_imports/ballistic/skm_carbine/inteq
	contraband = TRUE
	item_type = /obj/item/gun/ballistic/automatic/smg/skm_carbine/inteq

/datum/armament_entry/company_import/outside_imports/ballistic/skm_carbine/saber
	item_type = /obj/item/gun/ballistic/automatic/smg/skm_carbine/saber


//LASERS

/datum/armament_entry/company_import/outside_imports/lasers
	subcategory = "Laser Weaponry"

/datum/armament_entry/company_import/outside_imports/lasers/hades
	cost = 900
	item_type = /obj/item/gun/energy/e_gun/hades

/datum/armament_entry/company_import/outside_imports/lasers/nuclear
	cost = 900
	item_type = /obj/item/gun/energy/e_gun/nuclear/shiptest

/datum/armament_entry/company_import/outside_imports/lasers/adv_stopping
	cost = 1000
	item_type = /obj/item/gun/energy/e_gun/adv_stopping

/datum/armament_entry/company_import/outside_imports/lasers/smg
	cost = 900
	item_type = /obj/item/gun/energy/e_gun/smg

/datum/armament_entry/company_import/outside_imports/lasers/iot
	cost = 1200
	item_type = /obj/item/gun/energy/e_gun/iot

//AMMO

/datum/armament_entry/company_import/outside_imports/ammunition
	subcategory = "Ammunition"

/datum/armament_entry/company_import/outside_imports/ammunition/co9mm
	cost = 100
	item_type = /obj/item/ammo_box/magazine/co9mm

/datum/armament_entry/company_import/outside_imports/ammunition/skm762
	cost = 100
	item_type = /obj/item/ammo_box/magazine/skm_762_40

/datum/armament_entry/company_import/outside_imports/ammunition/smgm9mm
	cost = 100
	item_type = /obj/item/ammo_box/magazine/smgm9mm

/datum/armament_entry/company_import/outside_imports/ammunition/skm46
	cost = 100
	item_type = /obj/item/ammo_box/magazine/skm_46_30

/*
*
*					SCARBOROUGH
*
*/

/datum/armament_entry/company_import/scarborough
	category = "Scarborough"
	company_bitflag = CARGO_COMPANY_SCARBOROUGH
	restricted = TRUE

//BALLISTICS

/datum/armament_entry/company_import/scarborough/ballistic
	subcategory = "Ballistic Weaponry"

/datum/armament_entry/company_import/scarborough/ballistic/ringneck
	cost = 550
	item_type = /obj/item/gun/ballistic/automatic/pistol/ringneck

/datum/armament_entry/company_import/scarborough/ballistic/ringneck/indie
	contraband = TRUE
	item_type = /obj/item/gun/ballistic/automatic/pistol/ringneck/indie

/datum/armament_entry/company_import/scarborough/ballistic/asp
	cost = 650
	item_type = /obj/item/gun/ballistic/automatic/pistol/asp

/datum/armament_entry/company_import/scarborough/ballistic/viper
	cost = 750
	item_type = /obj/item/gun/ballistic/revolver/viper

/datum/armament_entry/company_import/scarborough/ballistic/rattlesnake
	cost = 650
	item_type = /obj/item/gun/ballistic/automatic/pistol/rattlesnake

/datum/armament_entry/company_import/scarborough/ballistic/rattlesnake/inteq
	contraband = TRUE
	item_type = /obj/item/gun/ballistic/automatic/pistol/rattlesnake/inteq

/datum/armament_entry/company_import/scarborough/ballistic/himehabu
	cost = 500
	item_type = /obj/item/gun/ballistic/automatic/pistol/himehabu

/datum/armament_entry/company_import/scarborough/ballistic/cobra
	cost = 950
	item_type = /obj/item/gun/ballistic/automatic/smg/cobra

/datum/armament_entry/company_import/scarborough/ballistic/cobra/indie
	contraband = TRUE
	item_type = /obj/item/gun/ballistic/automatic/smg/cobra/indie

/datum/armament_entry/company_import/scarborough/ballistic/sidewinder
	cost = 700
	item_type = /obj/item/gun/ballistic/automatic/smg/sidewinder

/datum/armament_entry/company_import/scarborough/ballistic/boomslang
	cost = 1800
	item_type = /obj/item/gun/ballistic/automatic/marksman/boomslang
	contraband = TRUE

/datum/armament_entry/company_import/scarborough/ballistic/taipan
	cost = 3000
	item_type = /obj/item/gun/ballistic/automatic/marksman/taipan
	contraband = TRUE

/datum/armament_entry/company_import/scarborough/ballistic/hydra
	cost = 1300
	item_type = /obj/item/gun/ballistic/automatic/assault/hydra

/datum/armament_entry/company_import/scarborough/ballistic/hydra/lmg
	cost = 1500
	item_type = /obj/item/gun/ballistic/automatic/assault/hydra/lmg

/datum/armament_entry/company_import/scarborough/ballistic/hydra/dmr
	cost = 1500
	item_type = /obj/item/gun/ballistic/automatic/assault/hydra/dmr

//AMMO

/datum/armament_entry/company_import/scarborough/ammunition
	subcategory = "Ammunition"

/datum/armament_entry/company_import/scarborough/ammunition/m10mm_ringneck
	cost = 100
	item_type = /obj/item/ammo_box/magazine/m10mm_ringneck

/datum/armament_entry/company_import/scarborough/ammunition/m57_39_asp
	cost = 75
	item_type = /obj/item/ammo_box/magazine/m57_39_asp

/datum/armament_entry/company_import/scarborough/ammunition/m9mm_rattlesnake
	cost = 100
	item_type = /obj/item/ammo_box/magazine/m9mm_rattlesnake

/datum/armament_entry/company_import/scarborough/ammunition/m22lr_himehabu
	cost = 75
	item_type = /obj/item/ammo_box/magazine/m22lr_himehabu

/datum/armament_entry/company_import/scarborough/ammunition/m45_cobra
	cost = 125
	item_type = /obj/item/ammo_box/magazine/m45_cobra

/datum/armament_entry/company_import/scarborough/ammunition/m57_39_sidewinder
	cost = 125
	item_type = /obj/item/ammo_box/magazine/m57_39_sidewinder

/datum/armament_entry/company_import/scarborough/ammunition/boomslang
	cost = 250
	item_type = /obj/item/ammo_box/magazine/boomslang
	contraband = TRUE

/datum/armament_entry/company_import/scarborough/ammunition/sniper_rounds
	cost = 300
	item_type = /obj/item/ammo_box/magazine/sniper_rounds
	contraband = TRUE

/datum/armament_entry/company_import/scarborough/ammunition/m556_42_hydra
	cost = 150
	item_type = /obj/item/ammo_box/magazine/m556_42_hydra

/datum/armament_entry/company_import/scarborough/ammunition/m556_42_hydra/extended
	cost = 200
	item_type = /obj/item/ammo_box/magazine/m556_42_hydra/extended

/datum/armament_entry/company_import/scarborough/ammunition/m556_42_hydra/casket
	cost = 200
	item_type = /obj/item/ammo_box/magazine/m556_42_hydra/casket

/*
*
*					SERENE SPORTING
*
*/

/datum/armament_entry/company_import/serene_sporting
	category = "Serene Sporting"
	company_bitflag = CARGO_COMPANY_SERENE_SPORTING
	restricted = TRUE

//BALLISTICS

/datum/armament_entry/company_import/serene_sporting/ballistic
	subcategory = "Ballistic Weaponry"

/datum/armament_entry/company_import/serene_sporting/ballistic/m17
	cost = 450
	item_type = /obj/item/gun/ballistic/automatic/pistol/m17

/datum/armament_entry/company_import/serene_sporting/ballistic/m20_auto_elite
	cost = 650
	item_type = /obj/item/gun/ballistic/automatic/pistol/m20_auto_elite

/datum/armament_entry/company_import/serene_sporting/ballistic/m12_sporter
	cost = 1250
	item_type = /obj/item/gun/ballistic/automatic/m12_sporter

/datum/armament_entry/company_import/serene_sporting/ballistic/m12_sporter/mod
	cost = 1550
	item_type = /obj/item/gun/ballistic/automatic/m12_sporter/mod

/datum/armament_entry/company_import/serene_sporting/ballistic/woodsman
	cost = 1550
	item_type = /obj/item/gun/ballistic/automatic/marksman/woodsman

/datum/armament_entry/company_import/serene_sporting/ballistic/m15
	cost = 1200
	item_type = /obj/item/gun/ballistic/automatic/m15

/datum/armament_entry/company_import/serene_sporting/ballistic/m11
	cost = 1500
	item_type = /obj/item/gun/ballistic/shotgun/automatic/m11

//AMMO

/datum/armament_entry/company_import/serene_sporting/ammunition
	subcategory = "Ammunition"

/datum/armament_entry/company_import/serene_sporting/ammunition/m17
	cost = 75
	item_type = /obj/item/ammo_box/magazine/m17

/datum/armament_entry/company_import/serene_sporting/ammunition/m20
	cost = 90
	item_type = /obj/item/ammo_box/magazine/m20_auto_elite

/datum/armament_entry/company_import/serene_sporting/ammunition/m12
	cost = 120
	item_type = /obj/item/ammo_box/magazine/m12_sporter

/datum/armament_entry/company_import/serene_sporting/ammunition/m23
	cost = 120
	item_type = /obj/item/ammo_box/magazine/m23

/datum/armament_entry/company_import/serene_sporting/ammunition/m15
	cost = 120
	item_type = /obj/item/ammo_box/magazine/m15

/*

/*
*
*					SOLAR ARMORIES
*
*/

/datum/armament_entry/company_import/solar_armories
	category = "Solar Armories"
	company_bitflag = CARGO_COMPANY_SOLAR_ARMORIES
	restricted = TRUE

//BALLISTIC

/datum/armament_entry/company_import/solar_armories/ballistic
	subcategory = "Ballistic Weaponry"

/datum/armament_entry/company_import/solar_armories/ballistic/modelh
	cost = 700
	item_type = /obj/item/gun/ballistic/automatic/powered/gauss/modelh

/datum/armament_entry/company_import/solar_armories/ballistic/pistol
	cost = 550
	item_type = /obj/item/gun/ballistic/automatic/pistol/solgov

/datum/armament_entry/company_import/solar_armories/ballistic/claris
	cost = 850
	item_type = /obj/item/gun/ballistic/automatic/powered/gauss/claris

/datum/armament_entry/company_import/solar_armories/ballistic/gar
	cost = 850
	item_type = /obj/item/gun/ballistic/automatic/powered/gauss/gar

/datum/armament_entry/company_import/solar_armories/ballistic/solgov
	cost = 750
	item_type = /obj/item/gun/ballistic/rifle/solgov

//AMMO

/datum/armament_entry/company_import/solar_armories/ammunition
	cost = 150
	subcategory = "Ammunition"

/datum/armament_entry/company_import/solar_armories/ammunition/modelh
	item_type = /obj/item/ammo_box/magazine/modelh

/datum/armament_entry/company_import/solar_armories/ammunition/pistol556mm
	item_type = /obj/item/ammo_box/magazine/pistol556mm

/datum/armament_entry/company_import/solar_armories/ammunition/gar
	item_type = /obj/item/ammo_box/magazine/gar
*/
/*
*
*					ATTACHMENTS
*
*/

/* Временно выключено. Нуждается в доработке для других оружий
/datum/armament_entry/company_import/attachments
	category = "Weaponry Attachments"
	company_bitflag = CARGO_COMPANY_ATTACHMENTS
	subcategory = "Attachments"
	cost = 100

/datum/armament_entry/company_import/attachments/alof
	item_type = /obj/item/attachment/alof

/datum/armament_entry/company_import/attachments/ammo_counter
	item_type = /obj/item/attachment/ammo_counter

/datum/armament_entry/company_import/attachments/bayonet
	item_type = /obj/item/attachment/bayonet

/datum/armament_entry/company_import/attachments/energy_bayonet
	cost = 120
	item_type = /obj/item/attachment/energy_bayonet

/datum/armament_entry/company_import/attachments/laser_sight
	item_type = /obj/item/attachment/laser_sight

/datum/armament_entry/company_import/attachments/long_scope
	item_type = /obj/item/attachment/long_scope

/datum/armament_entry/company_import/attachments/m17_barrel
	item_type = /obj/item/attachment/m17_barrel

/datum/armament_entry/company_import/attachments/rail_sight
	item_type = /obj/item/attachment/rail_light

/datum/armament_entry/company_import/attachments/short_scope
	item_type = /obj/item/attachment/scope

/datum/armament_entry/company_import/attachments/shoulder_slider
	item_type = /obj/item/attachment/sling

/datum/armament_entry/company_import/attachments/silencer
	item_type = /obj/item/attachment/silencer

/datum/armament_entry/company_import/attachments/stock
	item_type = /obj/item/attachment/foldable_stock
*/
