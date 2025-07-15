///Hunters Pride Weapons
///Shotguns

/////////////////////////////
// DOUBLE BARRELED SHOTGUN //
/////////////////////////////

/obj/item/gun/ballistic/shotgun/doublebarrel/shiptest
	name = "double-barreled shotgun"
	desc = "A classic break action shotgun, hand-made in a Hunter's Pride workshop. Both barrels can be fired in quick succession or even simultaneously. Guns like this have been popular with hunters, sporters, and criminals for millennia. Chambered in 12g."
	sawn_desc = "A break action shotgun cut down to the size of a sidearm. While the recoil is even harsher, it offers a lot of power in a very small package. Chambered in 12g."

	icon = 'tff_modular/modules/evento_needo/icons/hunterspride/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/hunterspride/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/hunterspride/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/hunterspride/onmob.dmi'

	base_icon_state = "dshotgun"

	icon_state = "dshotgun"
	inhand_icon_state = "dshotgun"

	rack_sound = 'tff_modular/modules/evento_needo/sounds/shotgun/dbshotgun_break.ogg'
	bolt_drop_sound = 'tff_modular/modules/evento_needo/sounds/shotgun/dbshotgun_close.ogg'

	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_MEDIUM
	force = 10
	slot_flags = ITEM_SLOT_BACK
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/shot/dual

	obj_flags = UNIQUE_RENAME
	semi_auto = TRUE
	can_be_sawn_off = TRUE
	bolt_type = BOLT_TYPE_NO_BOLT
	pb_knockback = 3 // it's a super shotgun!
	bolt_wording = "barrel"

	burst_delay = 0.05 SECONDS
	burst_size = 2

/obj/item/gun/ballistic/shotgun/doublebarrel/shiptest/drop_bolt(mob/user = null)
	playsound(src, bolt_drop_sound, bolt_drop_sound_volume, FALSE)
	if (user)
		to_chat(user, span_notice("You snap the [bolt_wording] of \the [src] closed."))
	chamber_round()
	bolt_locked = FALSE
	update_appearance()

/obj/item/gun/ballistic/shotgun/doublebarrel/shiptest/can_shoot()
	if (bolt_locked)
		return FALSE
	return ..()

/obj/item/gun/ballistic/shotgun/doublebarrel/shiptest/attackby(obj/item/A, mob/user, params)
	if (!bolt_locked)
		if(SEND_SIGNAL(src, COMSIG_ATOM_ATTACKBY, A, user, params) & COMPONENT_NO_AFTERATTACK)
			return TRUE
		to_chat(user, span_notice("The [bolt_wording] is shut closed!"))
		return
	return ..()

/obj/item/gun/ballistic/shotgun/doublebarrel/shiptest/update_icon_state()
	. = ..()
	if(current_skin)
		icon_state = "[unique_reskin[current_skin]][sawn_off ? "_sawn" : ""][bolt_locked ? "_open" : ""]"
	else
		icon_state = "[base_icon_state || initial(icon_state)][sawn_off ? "_sawn" : ""][bolt_locked ? "_open" : ""]"

/obj/item/gun/ballistic/shotgun/doublebarrel/shiptest/sawoff(forced = FALSE)
	. = ..()
	if(.)
		weapon_weight = WEAPON_MEDIUM

		spread = 8
		recoil = 3 //or not
		inhand_icon_state = "dshotgun_sawn"

// sawn off beforehand
/obj/item/gun/ballistic/shotgun/doublebarrel/shiptest/presawn
	//init gives it the sawn_off name
	name = "double-barreled shotgun"
	desc = "A break action shotgun cut down to the size of a sidearm. While the recoil is even harsher, it offers a lot of power in a very small package. Chambered in 12g."
	inhand_x_dimension = 32
	inhand_y_dimension = 32
	sawn_off = TRUE
	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BELT

	spread = 8
	recoil = 3
	inhand_icon_state = "dshotgun_sawn"

/obj/item/gun/ballistic/shotgun/doublebarrel/shiptest/roumain
	name = "HP antique double-barreled shotgun"
	desc = "A special-edition shotgun hand-made by Hunter's Pride with a high-quality walnut stock inlaid with brass scrollwork. Shotguns like this are very rare outside of the Saint-Roumain Militia's ranks. Otherwise functionally identical to a common double-barreled shotgun. Chambered in 12g."
	sawn_desc = "A special-edition Hunter's Pride shotgun, cut down to the size of a sidearm by some barbarian. The brass inlay on the stock and engravings on the barrel have been obliterated in the process, destroying any value beyond its use as a crude sidearm."
	base_icon_state = "dshotgun_srm"
	icon_state = "dshotgun_srm"
	inhand_icon_state = "dshotgun_srm"
	inhand_x_dimension = 32
	inhand_y_dimension = 32
	unique_reskin = null

/obj/item/gun/ballistic/shotgun/doublebarrel/shiptest/roumain/sawoff(forced = FALSE)
	. = ..()
	if(.)
		inhand_icon_state = "dshotgun_srm_sawn"

// BRIMSTONE //

/obj/item/gun/ballistic/shotgun/brimstone
	name = "HP Brimstone"
	desc = "A simple and sturdy pump-action shotgun sporting a 5-round capacity, manufactured by Hunter's Pride. Found widely throughout the Frontier in the hands of hunters, pirates, police, and countless others. Chambered in 12g."
	sawn_desc = "A stockless and shortened pump-action shotgun. The worsened recoil and accuracy make it a poor sidearm anywhere beyond punching distance."
	fire_sound = 'tff_modular/modules/evento_needo/sounds/shotgun/brimstone.ogg'
	icon = 'tff_modular/modules/evento_needo/icons/hunterspride/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/hunterspride/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/hunterspride/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/hunterspride/onmob.dmi'

	icon_state = "brimstone"
	inhand_icon_state = "brimstone"
	inhand_x_dimension = 32
	inhand_y_dimension = 32

	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/shot/lethal
	fire_delay = 0.05 SECONDS //slamfire
	rack_delay = 0.2 SECONDS

	can_be_sawn_off = TRUE

/obj/item/gun/ballistic/shotgun/brimstone/sawoff(forced = FALSE)
	. = ..()
	if(.)
		weapon_weight = WEAPON_MEDIUM

		spread = 18
		recoil = 5 //your punishment for sawing off an short shotgun

		inhand_icon_state = "illestren_factory_sawn" // i couldnt care about making another sprite, looks close enough

// HELLFIRE //

/obj/item/gun/ballistic/shotgun/hellfire
	name = "HP Hellfire"
	desc = "A hefty pump-action riot shotgun with an eight-round tube, manufactured by Hunter's Pride. Especially popular among the Frontier's police forces. Chambered in 12g."
	icon = 'tff_modular/modules/evento_needo/icons/hunterspride/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/hunterspride/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/hunterspride/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/hunterspride/onmob.dmi'
	icon_state = "hellfire"
	inhand_icon_state = "hellfire"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/shot/riot
	sawn_desc = "Come with me if you want to live."
	can_be_sawn_off = TRUE
	rack_sound = 'tff_modular/modules/evento_needo/sounds/shotgun/rack_alt.ogg'
	fire_delay = 0.1 SECONDS

/obj/item/gun/ballistic/shotgun/hellfire/sawoff(forced = FALSE)
	. = ..()
	if(.)
		weapon_weight = WEAPON_MEDIUM

		spread = 8
		recoil = 3
		inhand_icon_state = "dshotgun_sawn"

/obj/item/gun/ballistic/shotgun/flamingarrow/conflagration
	name = "HP Conflagration"
	base_icon_state = "conflagration"
	icon_state = "conflagration"
	inhand_icon_state = "conflagration"
	fire_sound = 'tff_modular/modules/evento_needo/sounds/shotgun/shot.ogg'
	desc = "A lightweight lever-action shotgun with a 5 round ammunition capacity. The lever action allows it to be cycled quickly and acurrately. In theory, you could ever operate it one-handed. Chambered in 12g."
	sawn_desc = "A lever action shotgun that's been sawed down for portability. The recoil makes it mostly useless outside of point-blank range, but it hits hard for its size and, more importantly, can be flipped around stylishly."
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/shot/winchester/conflagration

/obj/item/ammo_box/magazine/internal/shot/winchester/conflagration
	name = "conflagration internal magazine"
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot
	caliber = CALIBER_SHOTGUN
	max_ammo = 5

/obj/item/gun/ballistic/shotgun/flamingarrow/conflagration/sawoff(forced = FALSE)
	. = ..()
	if(.)
		inhand_icon_state = "beacon_factory_sawn"
		weapon_weight = WEAPON_MEDIUM
		spread = 4
		recoil = 0

//Elephant Gun
/obj/item/gun/ballistic/shotgun/doublebarrel/shiptest/twobore
	name = "HP Huntsman"
	desc = "A comically huge double-barreled rifle replete with brass inlays depicting flames and naturalistic scenes, clearly meant for the nastiest monsters the Frontier has to offer. If you want an intact trophy, don't aim for the head. Chambered in two-bore."
	icon = 'tff_modular/modules/evento_needo/icons/hunterspride/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/hunterspride/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/hunterspride/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/hunterspride/onmob.dmi'
	inhand_x_dimension = 32
	inhand_y_dimension = 32
	base_icon_state = "huntsman"
	icon_state = "huntsman"
	inhand_icon_state = "huntsman"
	unique_reskin = null
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/shot/twobore
	w_class = WEIGHT_CLASS_BULKY
	force = 20 //heavy ass elephant gun, why wouldnt it be
	recoil = 4
	pb_knockback = 12
	fire_sound = 'tff_modular/modules/evento_needo/sounds/shotgun/quadfire.ogg'
	rack_sound = 'tff_modular/modules/evento_needo/sounds/shotgun/quadrack.ogg'
	load_sound = 'tff_modular/modules/evento_needo/sounds/shotgun/quadinsert.ogg'

	can_be_sawn_off = FALSE
	fire_sound_volume = 80
	rack_sound_volume = 50

/obj/item/ammo_box/magazine/internal/shot/twobore
	name = "two-bore shotgun internal magazine"
	max_ammo = 2
	caliber = CALIBER_SHOTGUN

/// Rifles

/obj/item/gun/ballistic/rifle/illestren
	name = "\improper HP Illestren"
	desc = "A sturdy and conventional bolt-action rifle. One of Hunter's Pride's most successful firearms, the Illestren is popular among colonists, pirates, snipers, and countless others. Chambered in 8x50mmR."
	icon_state = "illestren"
	inhand_icon_state = "illestren"
	icon = 'tff_modular/modules/evento_needo/icons/hunterspride/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/hunterspride/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/hunterspride/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/hunterspride/onmob.dmi'

	sawn_desc = "An Illestren rifle sawn down to a ridiculously small size. There was probably a reason it wasn't made this short to begin with, but it still packs a punch."
	eject_sound = 'tff_modular/modules/evento_needo/sounds/rifle/vickland_unload.ogg'
	eject_empty_sound = 'tff_modular/modules/evento_needo/sounds/rifle/vickland_unload.ogg'

	internal_magazine = FALSE
	accepted_magazine_type = /obj/item/ammo_box/magazine/illestren_a850r
	eject_sound_vary = FALSE
	can_be_sawn_off = TRUE

/obj/item/ammo_box/magazine/illestren_a850r //this is a magazine codewise do nothing breaks
	name = "en bloc clip (8x50mmR)"
	desc = "A 5-round en bloc clip for the Illestren Hunting Rifle. These rounds do good damage with significant armor penetration."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	icon_state = "enbloc_858"
	ammo_type = /obj/item/ammo_casing/a8_50r
	caliber = CALIBER_8X50MM
	max_ammo = 5
	multiple_sprites = AMMO_BOX_PER_BULLET
	w_class = WEIGHT_CLASS_TINY
	custom_materials = list(/datum/material/iron = 500)

/obj/item/ammo_box/magazine/illestren_a850r/empty
	start_empty = TRUE

/obj/item/gun/ballistic/rifle/illestren/empty //i had to name it empty instead of no_mag because else it wouldnt work with guncases. sorry!
	magazine = null

/obj/item/gun/ballistic/rifle/illestren/sawoff(forced = FALSE)
	. = ..()
	if(.)
		spread = 19
		inhand_icon_state = "illestren_sawn"
		worn_icon = inhand_icon_state
		weapon_weight = WEAPON_MEDIUM //you can fire it onehanded, makes it worse than worse than useless onehanded, but you can

/obj/item/gun/ballistic/rifle/illestren/blow_up(mob/user)
	. = FALSE
	if(chambered)
		process_fire(user, user, FALSE)
		. = TRUE

/obj/item/gun/ballistic/rifle/illestren/factory
	desc = "A sturdy and conventional bolt-action rifle. One of Hunter's Pride's most successful firearms, this example has been kept in excellent shape and may as well be fresh out of the workshop. Chambered in 8x50mmR."
	icon_state = "illestren_factory"
	inhand_icon_state = "illestren_factory"

/obj/item/gun/ballistic/rifle/illestren/sawoff(forced = FALSE)
	. = ..()
	if(.)
		inhand_icon_state = "illestren_factory_sawn"
		worn_icon = inhand_icon_state

/obj/item/gun/ballistic/rifle/illestren/sawn
	desc = "An Illestren rifle sawn down to a ridiculously small size. There was probably a reason it wasn't made this short to begin with, but it still packs a punch."
	sawn_off = TRUE

//Lever-Action Rifles

/obj/item/gun/ballistic/shotgun/flamingarrow
	name = "HP Flaming Arrow"
	desc = "A sturdy and lightweight lever-action rifle with hand-stamped Hunter's Pride marks on the receiver. A popular choice among Frontier homesteaders for hunting small game and rudimentary self-defense. Chambered in .38."
	sawn_desc = "A lever-action rifle that has been sawed down and modified for extra portability. While surprisingly effective as a sidearm, the more important benefit is how much cooler it looks."
	base_icon_state = "flamingarrow"
	icon_state = "flamingarrow"
	inhand_icon_state = "flamingarrow"
	icon = 'tff_modular/modules/evento_needo/icons/hunterspride/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/hunterspride/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/hunterspride/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/hunterspride/onmob.dmi'
	inhand_x_dimension = 32
	inhand_y_dimension = 32
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/shot/winchester
	fire_sound = 'tff_modular/modules/evento_needo/sounds/rifle/flamingarrow.ogg'
	rack_sound = 'tff_modular/modules/evento_needo/sounds/rifle/skm_cocked.ogg'
	bolt_wording = "lever"
	cartridge_wording = "bullet"
	can_be_sawn_off = TRUE
	spread = -5
	recoil = 0

/obj/item/ammo_box/magazine/internal/shot/winchester
	name = "winchester internal magazine"
	ammo_type = /obj/item/ammo_casing/c38
	caliber = CALIBER_38
	max_ammo = 12

/obj/item/gun/ballistic/shotgun/flamingarrow/update_icon_state()
	. = ..()
	if(current_skin)
		icon_state = "[unique_reskin[current_skin]][sawn_off ? "_sawn" : ""]"
	else
		icon_state = "[base_icon_state || initial(icon_state)][sawn_off ? "_sawn" : ""]"

/obj/item/gun/ballistic/shotgun/flamingarrow/sawoff(forced = FALSE)
	. = ..()
	if(.)
		inhand_icon_state = "flamingarrow_sawn"
		weapon_weight = WEAPON_MEDIUM
		spread = 4
		recoil = 0

/obj/item/gun/ballistic/shotgun/flamingarrow/factory
	desc = "A sturdy and lightweight lever-action rifle with hand-stamped Hunter's Pride marks on the receiver. This example has been kept in excellent shape and may as well be fresh out of the workshop. Chambered in .38."
	icon_state = "flamingarrow_factory"
	base_icon_state = "flamingarrow_factory"
	inhand_icon_state = "flamingarrow_factory"

/obj/item/gun/ballistic/shotgun/flamingarrow/factory/sawoff(forced = FALSE)
	. = ..()
	if(.)
		inhand_icon_state = "flamingarrow_factory_sawn"

/obj/item/gun/ballistic/shotgun/flamingarrow/bolt
	name = "HP Flaming Bolt"
	desc = "A sturdy, excellently-made lever-action rifle. This one appears to be a genuine antique, kept in incredibly good condition despite its advanced age. Chambered in .38."
	base_icon_state = "flamingbolt"
	icon_state = "flamingbolt"
	inhand_icon_state = "flamingbolt"

/obj/item/gun/ballistic/shotgun/flamingarrow/bolt/sawoff(forced = FALSE)
	. = ..()
	if(.)
		inhand_icon_state = "flamingbolt_sawn"
		worn_icon = inhand_icon_state

/obj/item/gun/ballistic/shotgun/flamingarrow/absolution
	name = "HP Absolution"
	base_icon_state = "absolution"
	icon_state = "absolution"
	inhand_icon_state = "absolution"
	fire_sound = 'tff_modular/modules/evento_needo/sounds/revolver/shot.ogg'
	desc = "A large lever-action rifle with hand-stamped Hunter's Pride marks on the receiver and an 8 round ammunition capacity. More powerful than the Flaming Arrow, the Absolution is a popular pick for hunting larger fauna like bears and goliaths, especially when a bolt action's slower rate of fire would be a liability. Chambered in .357."
	sawn_desc = "A large lever-action rifle, sawn down for portability. It looks much cooler, but you should probably be using a revolver..."
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/shot/winchester/absolution

/obj/item/ammo_box/magazine/internal/shot/winchester/absolution
	name = "absolution internal magazine"
	ammo_type = /obj/item/ammo_casing/c357
	caliber = CALIBER_357
	max_ammo = 8

/obj/item/gun/ballistic/shotgun/flamingarrow/absolution/sawoff(forced = FALSE)
	. = ..()
	if(.)

		inhand_icon_state = "illestren_sawn"
		worn_icon = inhand_icon_state
		weapon_weight = WEAPON_MEDIUM
		spread = 4
		recoil = 0

/obj/item/gun/ballistic/shotgun/flamingarrow/absolution/factory
	desc = "A large lever-action rifle with hand-stamped Hunter's Pride marks on the receiver and an 8 round ammunition capacity. More powerful than the Flaming Arrow, the Absolution is a popular pick for hunting larger fauna like bears and goliaths, especially when a bolt action's slower rate of fire would be a liability. This example has been kept in excellent shape and may as well be fresh out of the workshop. Chambered in .357."
	icon_state = "absolution_factory"
	base_icon_state = "absolution_factory"
	inhand_icon_state = "absolution_factory"

/obj/item/gun/ballistic/shotgun/flamingarrow/absolution/factory/sawoff(forced = FALSE)
	. = ..()
	if(.)
		inhand_icon_state = "absolution_factory_sawn"
		worn_icon = inhand_icon_state

/// snipers

//well. its almost a sniper.
/obj/item/gun/ballistic/automatic/marksman/vickland //weapon designed by Apogee-dev
	name = "\improper Vickland"
	desc = "The pride of the Saint-Roumain Militia, the Vickland is a rare semi-automatic battle rifle produced by Hunter's Pride exclusively for SRM use. It is unusual in its class for its internal rotary magazine, which must be reloaded using stripper clips. Chambered in 8x50mmR."
	icon = 'tff_modular/modules/evento_needo/icons/hunterspride/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/hunterspride/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/hunterspride/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/hunterspride/onmob.dmi'

	fire_sound = 'tff_modular/modules/evento_needo/sounds/rifle/vickland.ogg'
	icon_state = "vickland"
	inhand_icon_state = "vickland"
	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_BULKY
	internal_magazine = TRUE
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/vickland
	fire_sound = 'tff_modular/modules/evento_needo/sounds/rifle/vickland.ogg'

	rack_sound = 'tff_modular/modules/evento_needo/sounds/rifle/ar_cock.ogg'

	fire_delay = 0.4 SECONDS
	recoil = 0

/obj/item/ammo_box/magazine/internal/vickland
	name = "Vickland battle rifle internal magazine"
	ammo_type = /obj/item/ammo_casing/a8_50r
	caliber = CALIBER_8X50MM
	max_ammo = 8

/obj/item/gun/ballistic/rifle/scout
	name = "HP Scout"
	desc = "A powerful bolt-action rifle usually given to mercenary hunters of the Saint-Roumain Militia, equally suited for taking down big game or two-legged game. Chambered in .300 Magnum."
	icon = 'tff_modular/modules/evento_needo/icons/hunterspride/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/hunterspride/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/hunterspride/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/hunterspride/onmob.dmi'
	icon_state = "scout"
	inhand_icon_state = "scout"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/boltaction/smile
	fire_sound = 'tff_modular/modules/evento_needo/sounds/rifle/scout.ogg'

	rack_sound = 'tff_modular/modules/evento_needo/sounds/rifle/scout_bolt_out.ogg'
	bolt_drop_sound = 'tff_modular/modules/evento_needo/sounds/rifle/scout_bolt_in.ogg'

	can_be_sawn_off = FALSE

/obj/item/gun/ballistic/rifle/scout/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/scope, range_modifier = 1.5)

/obj/item/ammo_box/magazine/internal/boltaction/smile
	name = "smile internal magazine"
	ammo_type = /obj/item/ammo_casing/a300
	caliber = CALIBER_A300
	max_ammo = 5
	multiload = TRUE
