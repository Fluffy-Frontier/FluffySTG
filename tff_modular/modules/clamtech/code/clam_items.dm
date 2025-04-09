//Ballistics

/obj/projectile/bullet/lmg/clam
	damage = 25
	armour_penetration = 25
	speed = 1.4

/obj/projectile/bullet/lmg/clam/rapid
	damage = 12
	armour_penetration = 10
	speed = 1.6

/obj/projectile/bullet/scattershot/clam
	damage = 28
	armour_penetration = 10
	speed = 1.2

//SRMs

/obj/projectile/bullet/rocket/clam
	name = "\improper HEAP missile"
	damage = 40
	anti_armour_damage = 80
	random_crits_enabled = FALSE //CLAMTECH - TOTALLY FAIR AND BALANCED - so no gibbing!

/obj/projectile/bullet/rocket/clam/do_boom(atom/target, blocked=0)
	explosion(target, heavy_impact_range = 0, light_impact_range = 2, flame_range = 1, flash_range = 3, explosion_cause = src)

/obj/projectile/bullet/rocket/clam/fire
	name = "\improper TB missile"
	desc = "Shhhhh!"
	damage = 60
	damage_type = BURN
	anti_armour_damage = 20
	dismemberment = 5

/obj/projectile/bullet/rocket/clam/fire/do_boom(atom/target, blocked=0)
	explosion(target, light_impact_range = 1, flame_range = 3, flash_range = 5, explosion_cause = src)

//Energy

/obj/projectile/ion/weak/clam
	damage = 40
	armour_penetration = 80
	speed = 1.8 //I mean, they should be reasonably long-range

/obj/projectile/beam/laser/heavylaser/clam
	damage = 40
	armour_penetration = 15
	speed = 2.2 //Almost hitscan for extra long-range capabilities :bless:

//Ammo? Sadly enough, I had to allow clammers use of station-printed ammo

//The guns

//Ballistics
/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/lmg/clam
	equip_cooldown = 10
	name = "\improper Clam UAC 2"
	projectile = /obj/projectile/bullet/lmg/clam
	variance = 2
	fire_sound = 'tff_modular/modules/clamtech/sounds/clam_ac2.ogg'
	mech_flags = EXOSUIT_MODULE_CLAM

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/lmg/clam/rapid
	equip_cooldown = 5
	name = "\improper Clam MG"
	desc = "A weapon for combat exosuits.This one shoots a hailstorm of low caliber bullets."
	projectiles = 500
	projectiles_cache = 500
	projectiles_cache_max = 2000
	projectiles_per_shot = 5
	projectile_delay = 1
	variance = 10
	projectile = /obj/projectile/bullet/lmg/clam/rapid
	fire_sound = 'tff_modular/modules/clamtech/sounds/clam_mg.ogg'

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/scattershot/clam
	equip_cooldown = 18
	name = "\improper Clam LB-10X AC"
	variance = 7
	projectile = /obj/projectile/bullet/scattershot/clam
	fire_sound = 'tff_modular/modules/clamtech/sounds/clam_lb10.ogg'
	mech_flags = EXOSUIT_MODULE_CLAM

//Rockets
/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/missile_rack/clam
	equip_cooldown = 40
	name = "\improper CSRM-1 missile launcher"
	desc = "A weapon for combat exosuits. Launches high explosive missiles. Extra powerful against exosuits, walls and borgs."
	projectile = /obj/projectile/bullet/rocket/clam
	fire_sound = 'tff_modular/modules/clamtech/sounds/clam_srm.ogg'
	projectiles = 2
	projectiles_cache = 8
	projectiles_cache_max = 16 //It is autofilled on clam chassis, BUT will require nukie SRM ammo - so no more than 16 shots
	disabledreload = FALSE
	mech_flags = EXOSUIT_MODULE_CLAM

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/missile_rack/clam/fire
	name = "\improper F-CSRM-1 missile launcher"
	desc = "A weapon for combat exosuits. Launches incendiary missiles."
	projectile = /obj/projectile/bullet/rocket/clam/fire

//Energy
/obj/item/mecha_parts/mecha_equipment/weapon/energy/ion/clam
	equip_cooldown = 15
	name = "\improper ER Particle Cannon"
	desc = "A weapon for combat exosuits. Shoots harmful technology-disabling particle clouds. Basically, an ion canon with bullets."
	projectile = /obj/projectile/ion/weak/clam
	fire_sound = 'tff_modular/modules/clamtech/sounds/clam_ion.ogg'
	mech_flags = EXOSUIT_MODULE_CLAM

/obj/item/mecha_parts/mecha_equipment/weapon/energy/ion/clam/twinlink
	equip_cooldown = 35
	name = "\improper Double ER Particle Cannon"
	desc = "A weapon for combat exosuits. Shoots harmful technology-disabling particle clouds. A bit slower than a single-shot ER Ion, but it sends two projectiles. Double the trouble!"
	energy_drain = 240
	projectiles_per_shot = 2
	projectile_delay = 5

/obj/item/mecha_parts/mecha_equipment/weapon/energy/laser/clam
	equip_cooldown = 5
	name = "\improper Rapid Cycle Laser"
	desc = "A weapon for combat exosuits. Shoots basic lasers... three times as fast."
	energy_drain = 20
	projectiles_per_shot = 2
	projectile_delay = 2
	fire_sound = 'tff_modular/modules/clamtech/sounds/clam_rapidlaser.ogg'
	mech_flags = EXOSUIT_MODULE_CLAM

/obj/item/mecha_parts/mecha_equipment/weapon/energy/laser/heavy/clam
	name = "\improper ER Laser"
	desc = "A weapon for combat exosuits."
	projectile = /obj/projectile/beam/laser/heavylaser/clam
	fire_sound = 'tff_modular/modules/clamtech/sounds/clam_laser.ogg'
	mech_flags = EXOSUIT_MODULE_CLAM

//MELEE!! Or, rather, the clamp. Beware, it really IS powerfull.

/obj/item/mecha_parts/mecha_equipment/hydraulic_clamp/clam
	name = "hydraulic hand"
	desc = "Equipment for combat exosuits. Allows cargo pickups under enemy fire! Fast."
	equip_cooldown = 10
	clamp_damage = 30
	clampsound = 'tff_modular/modules/clamtech/sounds/dezgra_melee.ogg'
	mech_flags = EXOSUIT_MODULE_CLAM

//Mech base type. Regulates custom FX and some basic balancing decisions.
/obj/vehicle/sealed/mecha/clam
	icon = 'tff_modular/modules/clamtech/icons/clam.dmi'
	icon_state = "default"
	stepsound = 'tff_modular/modules/clamtech/sounds/clam_footstep1.ogg'
	brute_attack_sound = 'tff_modular/modules/clamtech/sounds/dezgra_melee.ogg'
	exit_delay = 10
	internal_damage_probability = 10
	internal_damage_threshold = 30
	destruction_sleep_duration = 40
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	mecha_flags = CAN_STRAFE | IS_ENCLOSED | HAS_LIGHTS //| MMI_COMPATIBLE - so no blake-ist shit is possible
	accesses = list(ACCESS_SYNDICATE) //So our merc rando can't hijack it like a kodiak (DOES NOT WORK??? Fine by me)
	one_access = FALSE
	bumpsmash = FALSE

/obj/structure/mecha_wreckage/clam
	icon = 'tff_modular/modules/clamtech/icons/clam.dmi'
	welder_salvage = list(/obj/item/stack/sheet/mineral/plastitanium, /obj/item/stack/sheet/mineral/diamond, /obj/item/stack/sheet/iron, /obj/item/stack/rods)

//Custom KelpWulp HUD. Weird-looking!
/atom/movable/screen/fullscreen/ivanov_display/clam
	icon = 'tff_modular/modules/clamtech/icons/hud.dmi'
	icon_state = "lurm"
	alpha = 180

//Outfits and sleepers
/datum/outfit/pirate/clam
	name = "Clam Exowarrior"
	glasses = /obj/item/clothing/glasses/hud/diagnostic/ballistic
	ears = /obj/item/radio/headset/syndicate/alt
	suit = /obj/item/clothing/suit/armor/riot/skinsuit_armor
	head = /obj/item/clothing/head/helmet/space/skinsuit_helmet
	uniform = /obj/item/clothing/under/skinsuit
	gloves = /obj/item/clothing/gloves/combat
	shoes = /obj/item/clothing/shoes/combat
	id = /obj/item/card/id/clam
	id_trim = /datum/id_trim/clam
	back = /obj/item/storage/backpack/satchel/leather
	backpack_contents = list(/obj/item/storage/box/donkpockets = 1, /obj/item/weldingtool/largetank=1,)
	suit_store = /obj/item/gun/energy/e_gun/mini
	l_pocket = /obj/item/stack/cable_coil/thirty
	r_pocket = /obj/item/tank/internals/emergency_oxygen/engi

/datum/outfit/pirate/clam/captain
	name = "Clam Pentaglyph Commander"
	ears = /obj/item/radio/headset/syndicate/alt/leader
	id = /obj/item/card/id/clam/command

/obj/effect/mob_spawn/ghost_role/human/clam
	// /pirate
	name = "exowarrior sleeper"
	desc = "A sturdy sleeper pod. Now's not the time to sleep! TO BATTLE!"
	prompt_name = "a Clam exowarrior"
	var/rank = "Exowarrior"
	mob_species = /datum/species/akula
	outfit = /datum/outfit/pirate/clam
	var/fluff_spawn = /obj/effect/particle_effect/fluid/smoke/quick
	show_flavor = TRUE
	you_are_text = "a Clam warrior"
	flavour_text = "You are a warrior, that fights in an exosuit. An exo-warrior. The station has to be captured, so that your crusade can continue."
	important_text = "You are extra-destructive. Make sure you hit the targets that pose a threat - randomly firing at crew is not your goal here."

/obj/effect/mob_spawn/ghost_role/human/clam/captain
	name = "pentaglyph commander sleeper"
	rank = "Pentaglyph Commander"
	desc = "A sturdy sleeper pod. Now's not the time to sleep! All points, form on me!"
	outfit = /datum/outfit/pirate/clam/captain
	you_are_text = "a Clam commander"
	flavour_text = "You are a commander of a small strike team of exosuits. Take command of the station and bring it under Clam's control."

//Misc stuff - clothes, maybe?
/datum/id_trim/clam
	access = list(ACCESS_SYNDICATE, ACCESS_ROBOTICS, ACCESS_MAINT_TUNNELS)

/obj/item/card/id/clam
	assignment = "Exowarrior"
	name = "\improper Codex"
	desc = "At a glance, it looks like a simple dogtag. In reality, it is a lot like an ID card - it stores accesses, gene information, blood type, history of service, etc."
	icon_state = "whistle"
	worn_icon_state = "whistle"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	trim = /datum/id_trim/clam

/obj/item/card/id/clam/command
	assignment = "Pentaglyph Commander"
