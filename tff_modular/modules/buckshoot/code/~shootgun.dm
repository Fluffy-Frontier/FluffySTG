// Buckshoot Roulette Ammunition

/obj/projectile/bullet/shotgun_slug/buckshoot
	name = "buckshoot slug"
	damage = 200
	damage_type = OXY
	armour_penetration = 100
	icon_state = "slug"

/obj/item/ammo_casing/shotgun/buckshoot
	name = "buckshoot shell"
	desc = "A mysterious shotgun shell used in Buckshoot Roulette."
	caliber = CALIBER_SHOTGUN
	pellets = 1
	variance = 0

/obj/item/ammo_casing/shotgun/buckshoot/blank
	name = "buckshoot blank shell"
	desc = "A harmless blank shotgun shell for Buckshoot Roulette."
	icon_state = "bshell"

/obj/item/ammo_casing/shotgun/buckshoot/blank/fire_casing(atom/target, mob/living/user, params, distro, quiet, zone_override, spread, atom/fired_from)
	// playsound(fired_from || get_turf(src), 'sound/weapons/gun/revolver/empty.ogg', 100, TRUE)
	..()

/obj/item/ammo_casing/shotgun/buckshoot/live
	name = "buckshoot live shell"
	desc = "A deadly live shotgun shell for Buckshoot Roulette."
	icon_state = "gshell"
	projectile_type = /obj/projectile/bullet/shotgun_slug/buckshoot

// Buckshoot Roulette Shotgun

/obj/item/gun/ballistic/shotgun/buckshoot_game
	name = "\improper Buckshoot shotgun"
	desc = "A modified shotgun designed for the Buckshoot Roulette game. It features a unique internal mechanism that loads and cycles a shuffled mix of live and blank rounds."
	icon_state = "dshotgun_l"
	inhand_icon_state = "shotgun"
	worn_icon_state = "shotgun"
	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'
	can_suppress = FALSE
	burst_size = 1
	fire_delay = 0
	var/list/chambers = list()
	var/datum/weakref/party_ref = null
	var/static/list/possible_ammo_types = list(
		/obj/item/ammo_casing/shotgun/buckshoot/live,
		/obj/item/ammo_casing/shotgun/buckshoot/blank
	)

	var/last_shoot_result = ""

/obj/item/gun/ballistic/shotgun/buckshoot_game/pickup(mob/user)
	if(!party_ref)
		return ..()

	var/datum/buckshoot_roulette_party/party = party_ref.resolve()
	if(!party)
		return ..()
	if(!party.game_started)
		return ..()
	if((party.current_turn_player != user) && user.GetComponent(/datum/component/buckshoot_roulette_participant))
		to_chat(user, span_warning("Сейчас не твой ход!"))
		return FALSE

	return ..()

/obj/item/gun/ballistic/shotgun/buckshoot_game/Initialize(mapload, datum/buckshoot_roulette_party/party)
	. = ..()
	if(party)
		party_ref = WEAKREF(party)
	chambers.Cut()
	chambered = null

/obj/item/gun/ballistic/shotgun/buckshoot_game/process_fire(atom/target, mob/living/user, suppression, miranda_check, shoot_delay, spread_override)
	if(istype(chambered, /obj/item/ammo_casing/shotgun/buckshoot/live))
		last_shoot_result = "live"
	else if(istype(chambered, /obj/item/ammo_casing/shotgun/buckshoot/blank))
		last_shoot_result = "blank"
	else
		last_shoot_result = "empty"
	. = ..()
	if(.)
		process_chamber()

/obj/item/gun/ballistic/shotgun/buckshoot_game/rack(mob/user)
	. = ..()
	load_chamber()

/obj/item/gun/ballistic/shotgun/buckshoot_game/load_gun(obj/item/ammo, mob/living/user)
	if(!istype(ammo, possible_ammo_types))
		to_chat(user, span_warning("This shotgun only accepts special Buckshoot Roulette ammunition!"))
		return FALSE
	return ..()

/obj/item/gun/ballistic/shotgun/buckshoot_game/proc/load_chamber()
	if(chambered)
		return
	if(!length(chambers))
		return
	chambered = chambers[1]
	chambers.Cut(1, 2)

/obj/item/gun/ballistic/shotgun/buckshoot_game/proc/load_rounds(live_count = 0, blank_count = 0)
	var/total = live_count + blank_count
	if(total > 8 || total < 1)
		return FALSE
	chambers.Cut()
	for(var/i in 1 to live_count)
		chambers += new /obj/item/ammo_casing/shotgun/buckshoot/live(src)
		playsound(get_turf(src), 'tff_modular/modules/buckshoot/sounds/load_shell.ogg', 100, TRUE)
		sleep(0.2 SECONDS)
	for(var/i in 1 to blank_count)
		chambers += new /obj/item/ammo_casing/shotgun/buckshoot/blank(src)
		playsound(get_turf(src), 'tff_modular/modules/buckshoot/sounds/load_shell.ogg', 100, TRUE)
		sleep(0.2 SECONDS)
	shuffle(chambers)
	load_chamber()
	return TRUE

/obj/item/gun/ballistic/shotgun/buckshoot_game/examine(mob/user)
	. = ..()
	if(length(chambers))
		. += span_notice("It has [length(chambers)] rounds left.")

/obj/item/gun/ballistic/shotgun/buckshoot_game/attackby(obj/item/I, mob/user, params)
	if(I.tool_behaviour == TOOL_SAW || I.tool_behaviour == TOOL_WIRECUTTER)
		saw_off(user)
		return
	return ..()

/obj/item/gun/ballistic/shotgun/buckshoot_game/proc/saw_off(mob/user)
