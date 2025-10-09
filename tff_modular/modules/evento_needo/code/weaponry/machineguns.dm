//TODO: rename this file to lmg.dm and: /obj/item/gun/ballistic/automatic/hmg --> /obj/item/gun/ballistic/automatic/lmg

/obj/item/gun/ballistic/automatic/hmg
	w_class = WEIGHT_CLASS_HUGE
	slot_flags = 0
	weapon_weight = WEAPON_HEAVY
	burst_size = 1
	actions_types = list(/datum/action/item_action/deploy_bipod) //this is on hmg, as I need the same mechanics for a future gun. ideally, this would be an attachment, but that's still pending
	drag_slowdown = 1.5
	fire_delay = 0.1 SECONDS

	gun_firemodes = list(FIREMODE_FULLAUTO)
	default_firemode = FIREMODE_FULLAUTO

	wield_slowdown = HMG_SLOWDOWN

	spread = 4
	spread_unwielded = 80
	recoil = 1
	recoil_unwielded = 4

	///does this have a bipod?
	var/has_bipod = FALSE
	///is the bipod deployed?
	var/bipod_deployed = FALSE
	///how long do we need to deploy the bipod?
	var/deploy_time = 0.5 SECONDS

	///we add these two values to recoi/spread when we have the bipod deployed
	var/deploy_recoil_bonus = -1
	var/deploy_spread_bonus = -5

	var/list/deployable_on_structures = list(
		/obj/structure/table,
		/obj/structure/barricade,
		/obj/structure/bed,
		/obj/structure/chair,
		/obj/structure/railing,
	)

/obj/item/gun/ballistic/automatic/hmg/Initialize()
	. = ..()
	for(var/datum/action/item_action/deploy_bipod/action as anything in actions)
		if(!has_bipod)
			qdel(action)
	RegisterSignal(src, COMSIG_ITEM_EQUIPPED, PROC_REF(retract_bipod))
	RegisterSignal(src, COMSIG_MOVABLE_MOVED, PROC_REF(retract_bipod))

/obj/item/gun/ballistic/automatic/hmg/Destroy()
	. = ..()
	UnregisterSignal(src, list(COMSIG_ITEM_EQUIPPED, COMSIG_MOVABLE_MOVED))

/datum/action/item_action/deploy_bipod //TODO: Make this an accessory when that's added
	name = "Deploy Bipod"
	desc = "Deploy the bipod when bracing against something to increase accuracy."

/obj/item/gun/ballistic/automatic/hmg/ui_action_click(mob/user, action)
	if(!istype(action, /datum/action/item_action/deploy_bipod))
		return ..()
	if(!bipod_deployed)
		deploy_bipod(user)
	else
		retract_bipod(user=user)

/obj/item/gun/ballistic/automatic/hmg/calculate_recoil(mob/user, recoil_bonus = 0)
	var/total_recoil = recoil_bonus

	if(bipod_deployed)
		total_recoil += deploy_recoil_bonus

	return ..(user, total_recoil)

/obj/item/gun/ballistic/automatic/hmg/calculate_spread(mob/user, bonus_spread)
	var/total_spread = bonus_spread

	if(bipod_deployed)
		total_spread += deploy_spread_bonus

	return ..(user, total_spread)

/obj/item/gun/ballistic/automatic/hmg/proc/deploy_bipod(mob/user)
	//we check if we can actually deploy the thing
	var/can_deploy = TRUE
	var/mob/living/wielder = user

	if(!wielder)
		return

	if(!wielded_fully)
		to_chat(user, span_warning("You need to fully grip [src] to deploy it's bipod!"))
		return

	if(wielder.body_position != LYING_DOWN) //are we braced against the ground? if not, we check for objects to brace against
		can_deploy = FALSE

		for(var/direction_to_check as anything in GLOB.cardinals) //help
			var/turf/open/turf_to_check = get_step(get_turf(src),direction_to_check)
			for(var/obj/structure/checked_struct as anything in turf_to_check.contents) //while you can fire in non-braced directions, this makes it so you have to get good positioning to fire standing up.
				for(var/checking_allowed as anything in deployable_on_structures)
					if(istype(checked_struct, checking_allowed)) //help if you know how to write this better
						can_deploy = TRUE
						break


	if(!can_deploy)
		to_chat(user, span_warning("You need to brace against something to deploy [src]'s bipod! Either lie on the floor or stand next to a waist high object like a table!"))
		return
	if(!do_after(user, deploy_time, src, NONE, TRUE, CALLBACK(src, PROC_REF(is_wielded))))
		to_chat(user, span_warning("You need to hold still to deploy [src]'s bipod!"))
		return
	playsound(src, 'sound/machines/click.ogg', 75, TRUE)
	to_chat(user, span_notice("You deploy [src]'s bipod."))
	bipod_deployed = TRUE

	RegisterSignal(user, COMSIG_MOVABLE_MOVED, PROC_REF(retract_bipod))
	update_appearance()

/obj/item/gun/ballistic/automatic/hmg/proc/retract_bipod(atom/source, mob/user)
	SIGNAL_HANDLER
	if(!bipod_deployed)
		return
	if(!user || !ismob(user))
		user = loc
	playsound(src, 'sound/machines/click.ogg', 75, TRUE)
	to_chat(user, span_notice("The bipod undeploys itself."))
	bipod_deployed = FALSE

	UnregisterSignal(user, COMSIG_MOVABLE_MOVED)
	update_appearance()


/obj/item/gun/ballistic/automatic/hmg/on_unwield(obj/item/source, mob/user)
	. = ..()
	retract_bipod(user=user)

/obj/item/gun/ballistic/automatic/hmg/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)][bipod_deployed ? "_deployed" : ""]"

/obj/item/gun/ballistic/automatic/hmg/update_overlays()
	. = ..()
	if(has_bipod)
		. += "[base_icon_state || initial(icon_state)][bipod_deployed ? "_deployed" : "_undeployed"]"

/obj/item/gun/ballistic/automatic/hmg/solar //This thing fires a 5.56 equivalent, that's an LMG, not an HMG, get out
	name = "\improper Solar"
	desc = "A TerraGov LMG-169 designed in 169 FS, nicknamed 'Solar.' A inscription reads: 'PROPERTY OF TERRAGOV', with 'TERRAGOV' poorly scribbled out, and replaced by 'SOLAR ARMORIES'. Chambered in 4.73×33mm caseless ammunition."
	icon = 'tff_modular/modules/evento_needo/icons/solararmories/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/solararmories/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/solararmories/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/solararmories/onmob.dmi'

	icon_state = "solar"
	inhand_icon_state = "solar"
	worn_icon = "solar"

	fire_sound = 'tff_modular/modules/evento_needo/sounds/l6/shot.ogg'
	accepted_magazine_type = /obj/item/ammo_box/magazine/rifle47x33mm
	spread = 7

	fire_delay = 0.1 SECONDS

	fire_select_icon_state_prefix = "caseless_"
	w_class = WEIGHT_CLASS_BULKY

/obj/item/ammo_box/magazine/rifle47x33mm
	name = "\improper Solarian LMG magazine (4.73x33mm caseless)"
	desc = "A large, 50-round magazine for the Solar machine gun. These rounds do moderate damage with good armor penetration."
	icon = 'tff_modular/modules/evento_needo/icons/ammunition/ammo.dmi'
	icon_state = "47x33mm-50"
	base_icon_state = "47x33mm"
	ammo_type = /obj/item/ammo_casing/caseless/c47x33mm
	caliber = CALIBER_47X33MM
	max_ammo = 100 //brrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/ammo_box/magazine/rifle47x33mm/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[round(ammo_count(),5)]"

/obj/item/gun/ballistic/automatic/hmg/skm_lmg
	name = "\improper SKM-24u"
	desc = "What appears to be a standard SKM-24 at first glance is actually a light machine gun conversion, with an extended, heavy barrel and overhauled internals. Its weight, bulk, and robust fire rate make it difficult to handle without using the bipod in a prone position or against appropriate cover such as a table. Chambered in 7.62x40mm CLIP."

	icon = 'tff_modular/modules/evento_needo/icons/frontier_import/48x32.dmi'
	lefthand_file = 'tff_modular/modules/evento_needo/icons/frontier_import/lefthand.dmi'
	righthand_file = 'tff_modular/modules/evento_needo/icons/frontier_import/righthand.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/frontier_import/onmob.dmi'

	icon_state = "skm_lmg"
	inhand_icon_state = "skm_lmg"
	worn_icon_state = "skm_lmg"

	fire_sound = 'tff_modular/modules/evento_needo/sounds/rifle/skm.ogg'
	rack_sound = 'tff_modular/modules/evento_needo/sounds/rifle/skm_cocked.ogg'
	load_sound = 'tff_modular/modules/evento_needo/sounds/rifle/skm_reload.ogg'
	load_empty_sound = 'tff_modular/modules/evento_needo/sounds/rifle/skm_reload.ogg'
	eject_sound = 'tff_modular/modules/evento_needo/sounds/rifle/skm_unload.ogg'
	eject_empty_sound = 'tff_modular/modules/evento_needo/sounds/rifle/skm_unload.ogg'

	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_FULLAUTO)
	default_firemode = FIREMODE_SEMIAUTO

	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	accepted_magazine_type = /obj/item/ammo_box/magazine/skm_762_40

	fire_delay = 0.13 SECONDS

	spread = 7 //you can hipfire, but why?
	spread_unwielded = 25

	recoil = 1 //identical to other LMGS
	recoil_unwielded = 4 //same as skm

	wield_slowdown = SAW_SLOWDOWN //not as severe as other lmgs, but worse than the normal skm
	has_bipod = TRUE

/obj/item/gun/ballistic/automatic/hmg/skm_lmg/extended //spawns with the proper extended magazine, for erts
	spawnwithmagazine = /obj/item/ammo_box/magazine/skm_762_40/extended

/obj/item/gun/ballistic/automatic/hmg/skm_lmg/drum_mag //spawns with a drum, maybe not for erts but admin enhanced ERTS? when things really go to shit
	spawnwithmagazine = /obj/item/ammo_box/magazine/skm_762_40/drum
