//Ballistics

/obj/projectile/bullet/lmg/clam
	damage = 25
	armour_penetration = 25
	speed = 1.5

/obj/projectile/bullet/lmg/clam/rapid
	damage = 10
	armour_penetration = 10
	speed = 1.2

/obj/projectile/bullet/scattershot/clam
	damage = 28
	armour_penetration = 10
	speed = 1.2

/obj/projectile/bullet/p50/gauss
	name ="gauss slug"
	speed = 3 //Gotta go fast
	damage = 60
	paralyze = 50
	dismemberment = 5
	catastropic_dismemberment = FALSE
	armour_penetration = 70
	ignore_range_hit_prone_targets = TRUE
	object_damage = 50
	mecha_damage = 50

//SRMs

/obj/projectile/bullet/rocket/clam
	name = "\improper HEAP missile"
	damage = 40
	anti_armour_damage = 80
	random_crits_enabled = TRUE //I hate you, respawning crew guy

/obj/projectile/bullet/rocket/clam/do_boom(atom/target, blocked=0)
	explosion(target, heavy_impact_range = 1, light_impact_range = 2, flame_range = 1, flash_range = 3, explosion_cause = src)

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

//A small reward for killing clams
/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/carbine/gauss
	name = "\improper Ancient Gauss Carbine"
	desc = "An old weapon for combat exosuits. Shoots high-speed ferro-magnetic slugs. Once it symbolized the power of some old star empire. This one is so old by Clam standarts that it may as well be oldsuit compatible. Still, Clams hold them as a reminder of what they fight for."
	//icon = 'tff_modular/modules/clamtech/icons/clam.dmi'
	//icon_state = "mecha_gauss" //Sadly, custom textures in mecha UI can't be done non-modularly.
	fire_sound = 'tff_modular/modules/clamtech/sounds/clam_gauss.ogg'
	equip_cooldown = 25
	projectile = /obj/projectile/bullet/p50/gauss
	projectiles = 10
	projectiles_cache = 10
	projectiles_cache_max = 50
	mech_flags = EXOSUIT_MODULE_COMBAT

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
	projectile_delay = 4

/obj/item/mecha_parts/mecha_equipment/weapon/energy/laser/clam
	equip_cooldown = 8
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
	mech_flags = EXOSUIT_MODULE_STRIKEREEL //Others dun have the ejector module and should NOT recieve this clamp

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
	mech_type = EXOSUIT_MODULE_CLAM
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
	backpack_contents = list(/obj/item/storage/box/donkpockets = 1, /obj/item/weldingtool/largetank=1, /obj/item/book/manual/clam_pilot_manual = 1,)
	suit_store = /obj/item/gun/energy/e_gun/mini
	l_pocket = /obj/item/stack/cable_coil/thirty
	r_pocket = /obj/item/tank/internals/emergency_oxygen/engi

/datum/outfit/pirate/clam/captain
	name = "Clam Pentaglyph Commander"
	ears = /obj/item/radio/headset/syndicate/alt/leader
	id = /obj/item/card/id/clam/command

/obj/effect/mob_spawn/ghost_role/human/clam
	name = "exowarrior sleeper"
	desc = "A sturdy sleeper pod. Now's not the time to sleep! TO BATTLE!"
	prompt_name = "a Clam exowarrior"
	var/rank = "Exowarrior"
	mob_species = /datum/species/akula
	outfit = /datum/outfit/pirate/clam
	var/fluff_spawn = /obj/effect/particle_effect/fluid/smoke/quick
	show_flavor = TRUE
	you_are_text = "You are a Clam warrior"
	flavour_text = "You are a warrior that fights in an exosuit. An exo-warrior, if you wish. The station has to be captured, so that your crusade can continue."
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
	trim = /datum/id_trim/clam

/obj/item/card/id/clam/command
	assignment = "Pentaglyph Commander"

//Clamtech Manual
/obj/item/book/manual/clam_pilot_manual
	name = "ClamCadet ExoSuit Operation Manual"
	icon = 'tff_modular/modules/clamtech/icons/clam.dmi'
	icon_state ="manual"
	starting_author = "Clam High Command"
	starting_title = "ClamCadet ExoSuit Operation Manual"
	starting_content = {"<html>
				<head>
				<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
				<style>
				h1 {font-size: 18px; margin: 15px 0px 5px;}
				h2 {font-size: 15px; margin: 15px 0px 5px;}
				li {margin: 2px 0px 2px 15px;}
				ul {list-style: none; margin: 5px; padding: 0px;}
				ol {margin: 5px; padding: 0px 15px;}
				</style>
				</head>
				<body>
				<h2>Foreword:</h2>
				- We may not return to the High Frontier just now. Too different are our ideologies from those we left behind. The violence that unfolded as the Great Corporations started the Privatization Wars is the one we seek to repeat no more, We shall live apart, conserving all the good of Humanity, ridding ourselves of the bad in our souls and bodies, so that when we return, and return we shall, our shining moral character will be as much our shield as our ExoSuits and fighters.
				<li>Exempt from <i>Founding Father Karibbsky</i>'s <b>'Hidden Cope Doctrine'</b></li>
				<b></b>
				<h1>On 'suits</h1>
				An ExoSuit is a venerable design of a mobile weapons platform, usually no more than 3 meters tall. Almost made obsolete by the time the Grand Migration was initiated by Oleksanya Karibbsky, it is, however, still a potent weapon, perfected by our industrial caste in the time since our exile. And yet, only in skilled hands do the 'suits really shine.
				This book covers the basics of its operation and maintenance.
				<b></b>
				<h2>Glossary:</h2>
				<ul>
				<li>RMB - Right Mount Battlemodule control interface - a joystick to the right of viewport; controls firing and targeting for right arm weapons</li>
				<li>LMB - Left Mount Battlemodule control interface - a joystick to the left of viewport; controls firing and targeting for left arm weapons</li>
				<li>MMB - Middle Mount Battlemodule control interface - a button located on the highest section of both joysticks; foolproof and toggles safety</li>
				<li>B key - BAIL button, also known as EJECT - a dim-lit yellow button located below the upper hatch; controls the ejection procedure</li>
				<li>ALT key - Alternative control mode toggle button - a joystick-mounted button responsible for toggling strafe mode</li>
				<li>WASD - Walk Assistant System Display - a direct neural interface that, when coupled with propulsion controlling pedals, allows control over mech movement</li>
				<li>Battlemodule - a system comprised of a mount, a hardpoint and an attached weapon; capable of changing azimuth and elevation of a weapon</li>
				<li>ER - Extended Range - Clam improved weapon, which is extra effective at long range</li>
				<li>PC - Particle Cannon - a cannon which fires a tight cloud of heavy particles, capable of delivering a powerfull punch through armor; disables electronics</li>
				<li>SRM - Short Range Missile - a rocket-propelled explosive/incendiary (F-SRM) payload; № in SRM-№ stands for amount of missiles in a salvo</li>
				<li>AC - AutoCannon - a ballistic weapon, firing diffirent kinds of projectiles</li>
				<li>'Suit - short for ExoSuit</li>
				</ul>
				<b></b>
				<h2>CH1. Movement.</h2>
				A 'suit is capable of omnidirectional movement. The pilot uses WASD and pedals to move the suit to reach a position and or to change the direction.
				In normal mode, the inbuilt autocourse system forces the 'suit to always face the direction its going in. In order to face in a new direction, the 'suit has to turn. Usually, a turn takes as much time as an entire meter of 'suit movement.
				Pressing the TOGGLE STRAFE key will disable autocourse system and force the 'suit into strafing mode. In strafing mode, the suit only turns in the direction of movement to avoid falling, and so it may freely move backwards and sideways as well as forwards. Beware: pressing ALT while in strafe mode will allow you to change facing for the duration of button press.
				A competent pilot has to always consider the current mode, direction and speed of a 'suit, as all of them matter when firing and recieving damage.
				Some 'suits come equped with additional movement options:
				<li>Myomer Overclock Module - boosts 'suit's speed at the cost of energy use. Safeties are optional; they may be overriden as to not autodisable overclock for the price of 'suit damage.</li>
				<li>Pivot Step System - Enables the 'suit to make a sharp turn, effectively nullifying turn time and overall smoothing the controls.</li>
				<li>Jumpjet Propulsion System - Enables the 'suit to make a rocket-powered jump above obstacles, devastating everything in its' landing zone.</li>
				<li>Ionjet Propulsion System - Enables the 'suit to move in a zero-G enviroment such as space. DO NOT FORGET to seal the cabin in space.</li>
				<b></b>
				<h2>CH2. Firing.</h2>
				A 'suit is capable of firing its' weapons in the 160 degree arc in front of it, and the 'suit's weapon is loaded and powered. Any other locations are unreachable by the battlemodule mountpoints. In order to fire a weapon, one must ensure the safety is offline (if needed, press MMB), move the targeting reticle above the target	and press either LMB or RMB. The weapon in this battlemodule will fire in the desired direction. Weapons may not be fired simultaniously or when safety is ON. Different weapons have different reloading times.
				It is crucial for a pilot to know that solid projectile based weapons such as ACs and SRM launchers require both ammunition and commands in order to reload. Commands are given through a heads up display.
				<b></b>
				<h2>CH3. Damage, field repairs, maintenance and HUD.</h2>
				A 'suit may take damage during the course of its deployment. It is the job of a pilot to ensure the 'suit is fully utilized and not wasted irresponsibly. In order to better utilize the 'suit's resource, a pilot must master its' armor, maintenance and repairs.
				Upon loosing all integrity, the 'suit will auto-eject and will be effectively destroyed. In order to prevent this, a pilot may need not to recieve an industrial caste member's help, but urgently make field repairs with a welder. 'Suit parts (battery) can be replaced by opening the cover with a screwdriver, removing any component with a crowbar, replacing it and closing the lid.
				<b></b>
				<b>Damage.</b>
				The 'suit may be damaged upon contacting with a physical and or chemical factor of outside enviroment. Then, depending on the direction, from which the factor acted, the armor may or may not protect the internals. Statisticaly, front armor absorbs about half of a factor's initial energy BEFORE transfering it to inner layers, side armor lets absorbs zero percent of factor's energy and rear armor usually connects with internals directly and, as such, effectively boosts incoming damage. Upon recieving damage, the 'suit may suffer a critical hit, if impact was powerfull enough. Ion and PC bolts also may inflict critical hits without penetrating armor in addition to their battery-draining properties.
				<b></b>
				<b><i>Critical hit types:</i></b>
				<li>Short Circuit - 'suit slowly looses power and battery capacity.</li>
				<li>Motor Malfunction - 'suit is unable to move in a given direction, randomly wanders when given a movement order with WASD</li>
				<li>Airtank Breach - a breach forces a big amount of air into the cabin.</li>
				<li>Internal Fire - heats internals. May force other crits if not dealt with.</li>
				<li>Thermal Regulator Failure - disables automatic fire supression.</li>
				<li>Component Hit - a piece of equipment suffers a hit. Unless destroyed, it will remain working.</li>
				<b></b>
				<b>HUD</b>
				In order to change 'suit modules and repair internal damage, one must access the HUD, labeled as VIEW STATS button. This menu contains information on mech status, its' modules and critical hits. It also allows for control over advanced functions.
				<b>Rename</b>: changes 'suit IFF beacon name. <b>Safety protocols</b>: allows for advanced 'suit maintenance, see more in appropriate manual. <b>Equipment</b>: allows detaching, reloading and tuning equipment in its' submenu. <b>Integrity</b> and <b>charge</b>: show the 'suit's condition. <b>Lights</b>: toggles lights. <b>Cabin air</b>: toggles sealing the cabin. <b>DNA lock</b>: allows to lock a 'suit with your DNA. <b>ID lock</b>: allows restricting access to 'suit to just CLAM ID systems. <b>Status</b>: shows current critical hits and allows to fix them.
				<b></b>
				<b>Salvage.</b>
				If an allied 'suit fell in combat, you may salvage some parts with crowbar and wirecutters.
				<b></b>
				<h2>CH4. Miscelanious features.</h2>
				<b>Refitting.</b>
				In order to maximize combat effectiveness, pilots are encouraged to try different loadouts. To equip another weapon, one must open HUD, choose a battlemodule to discard, press "Detach" and then attach a new one to the arm of choice (RMB for right arm, LMB for left arm).
				<b></b>
				<b>Zoom.</b>
				Most 'suits are equipped with advanced optics, allowing for magnification when standing still. This may be helpful during long-range firefights.
				<b></b>
				<b>IR sensors.</b>
				Striker Eel 'suit is fitted with experimental IR sensor, allowing it to see targets through solid objects.
				<b></b>
				<b>Smoke.</b>
				Deploys an opaque smokescreen.
				<b></b>
				<b>Fist.</b>
				Allows a pilot to take onboard up to 15 crates or to reload friendly 'suits with ammo from internal cargo storage.
				<b></b>
				<b>LRM barrage.</b>
				Allows a pilot to unleash many weak missiles. There is a huge amount of them onboard.
				<b></b>
				<b>Wallbreaking power.</b>
				Most 'suits are capable of punching through walls.
				<b></b>
				<b>ID lock.</b>
				A pilot may engage the ID lock from outside by swiping his codex over the 'suit hatch.
				<b></b>
				<h2>CH5. Mech overview.</h2>
				<li>CHASSIS: <b>TideShark</b></li>
				<ol>INTEGRITY: 600</ol>
				<ol>SPEED: Slow</ol>
				<ol>ABILTIES: Zoom, Wallbreak, Pivot Step</ol>
				<ol>EQUIPMENT: 2 Double ER PC, Armor module, Air tank, Ionjets, Radio</ol>
				<ol>NOTES: A slow, powerfull 'suit. For experienced pilots only.</ol>
				<b></b>
				<li>CHASSIS: <b>Kelp Wulp</b></li>
				<ol>INTEGRITY: 450</ol>
				<ol>SPEED: Medium</ol>
				<ol>ABILTIES: Zoom, Wallbreak, LRM barrage</ol>
				<ol>EQUIPMENT: 2 ER Lasers, Armor module, Air tank, Ionjets, Radio</ol>
				<ol>NOTES: A good overall choice.</ol>
				<b></b>
				<li>CHASSIS: <b>Striker Eel</b></li>
				<ol>INTEGRITY: 380</ol>
				<ol>SPEED: Medium</ol>
				<ol>ABILTIES: IR sensors, Wallbreak, Overclock, Smoke</ol>
				<ol>EQUIPMENT: LB-10X AC, Fist, Armor module, Air tank, Ionjets, Radio</ol>
				<ol>NOTES: A Jack-of-all-trades. With IR sensors it is really good for ambushing.</ol>
				<b></b>
				<li>CHASSIS: <b>Seagull</b></li>
				<ol>INTEGRITY: 300</ol>
				<ol>SPEED: Fast</ol>
				<ol>ABILTIES: Zoom, Wallbreak, Jumpjets</ol>
				<ol>EQUIPMENT: Rapid Cycle Laser, SRM-1, Armor module, Air tank, Ionjets, Radio</ol>
				<ol>NOTES: A powerfull 'suit. The jumpjets drain the batteries fast.</ol>
				<b></b>
				<li>CHASSIS: <b>ReefBreaker</b></li>
				<ol>INTEGRITY: 200</ol>
				<ol>SPEED: Instantenious</ol>
				<ol>ABILTIES: Zoom, Overclock, Pivot Step</ol>
				<ol>EQUIPMENT: Machine Gun, F-SRM-1, Armor module, Air tank, Ionjets, Radio</ol>
				<ol>NOTES: An extremely fast and maneurable machine for experienced pilots.</ol>
				</body>
			"}
