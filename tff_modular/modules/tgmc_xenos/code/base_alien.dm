/// TGMC_XENOS (old nova sector xenos)

/mob/living/carbon/alien/adult/tgmc
	name = "rare bugged alien"
	icon = 'tff_modular/modules/tgmc_xenos/icons/big_xenos.dmi'
	rotate_on_lying = FALSE
	base_pixel_x = -16 //All of the xeno sprites are 64x64, and we want them to be level with the tile they are on, much like oversized quirk users
	layer = LARGE_MOB_LAYER //above most mobs, but below speechbubbles
	maptext_height = 64
	maptext_width = 64
	pressure_resistance = 200

	bodyparts = list(
		/obj/item/bodypart/chest/alien/tgmc,
		/obj/item/bodypart/head/alien/tgmc,
		/obj/item/bodypart/arm/left/alien/tgmc,
		/obj/item/bodypart/arm/right/alien/tgmc,
		/obj/item/bodypart/leg/right/alien/tgmc,
		/obj/item/bodypart/leg/left/alien/tgmc,
	)

	default_organ_types_by_slot = list(
		ORGAN_SLOT_BRAIN = /obj/item/organ/brain/alien,
		ORGAN_SLOT_XENO_HIVENODE = /obj/item/organ/alien/hivenode,
		ORGAN_SLOT_TONGUE = /obj/item/organ/tongue/alien,
		ORGAN_SLOT_EYES = /obj/item/organ/eyes/alien,
		ORGAN_SLOT_LIVER = /obj/item/organ/liver/alien,
		ORGAN_SLOT_EARS = /obj/item/organ/ears,
		ORGAN_SLOT_STOMACH = /obj/item/organ/stomach/alien,
	)

	/// What icon file update_held_items will look for when making inhands for xenos
	var/alt_inhands_file = 'tff_modular/modules/tgmc_xenos/icons/big_xenos.dmi'
	/// Setting this will give a xeno generic_evolve set to evolve them into this type
	var/next_evolution
	/// Keeps track of if a xeno has evolved recently, if so then we prevent them from evolving until that time is up
	var/has_evolved_recently = FALSE
	/// How long xenos should be unable to evolve after recently evolving
	var/evolution_cooldown_time = 90 SECONDS
	/// Determines if a xeno is unable to use abilities
	var/unable_to_use_abilities = FALSE
	/// Pixel X shifting of the on fire overlay
	var/on_fire_pixel_x = 16
	/// Pixel Y shifting of the on fire overlay
	var/on_fire_pixel_y = 16
	/// Все дополнительные органы, что должны находиться в телах ксеносов
	var/list/additional_organ_types_by_slot

	// Оффсет для худ-ов, чтобы они лучше соответствовали размерам ксеноса
	var/hud_offset_x = 32
	var/hud_offset_y = 0

	// Урон по тяжелым транспортным штукам (типа мехов)
	var/melee_vehicle_damage
	var/resist_heavy_hits = FALSE

/mob/living/carbon/alien/adult/tgmc/Initialize(mapload)
	. = ..()
	real_name = "alien [caste]"
	pixel_x = -16

	if(next_evolution)
		GRANT_ACTION(/datum/action/cooldown/alien/tgmc/generic_evolve)

	ADD_TRAIT(src, TRAIT_XENO_HEAL_AURA, TRAIT_XENO_INNATE)
	RegisterSignal(src, COMSIG_LIVING_UPDATED_RESTING, PROC_REF(on_rest))

/mob/living/carbon/alien/adult/tgmc/Destroy()
	. = ..()
	UnregisterSignal(src, COMSIG_LIVING_UPDATED_RESTING)

/mob/living/carbon/alien/adult/tgmc/create_internal_organs()
	if(additional_organ_types_by_slot)
		default_organ_types_by_slot += additional_organ_types_by_slot
	return ..()

/// Called when a larva or xeno evolves, adds a configurable timer on evolving again to the xeno
/mob/living/carbon/alien/adult/tgmc/proc/has_just_evolved()
	if(has_evolved_recently)
		return
	has_evolved_recently = TRUE
	addtimer(CALLBACK(src, PROC_REF(can_evolve_once_again)), evolution_cooldown_time)

/// Allows xenos to evolve again if they are currently unable to
/mob/living/carbon/alien/adult/tgmc/proc/can_evolve_once_again()
	if(!has_evolved_recently)
		return
	has_evolved_recently = FALSE

/mob/living/carbon/alien/adult/tgmc/UnarmedAttack(atom/attack_target, proximity_flag, list/modifiers)
	if(body_position == LYING_DOWN) // Лежим - значит отдыхаем. Никакой войны во время отдыха
		return FALSE
	return ..()

/datum/movespeed_modifier/alien_quick
	multiplicative_slowdown = -0.5

/datum/movespeed_modifier/alien_slow
	multiplicative_slowdown = 0.5

/datum/movespeed_modifier/alien_heavy
	multiplicative_slowdown = 1

/datum/movespeed_modifier/alien_big
	multiplicative_slowdown = 2

/mob/living/carbon/alien/adult/tgmc/update_held_items()
	..()
	remove_overlay(HANDS_LAYER)
	var/list/hands = list()

	var/obj/item/l_hand = get_item_for_held_index(1)
	if(l_hand)
		var/itm_state = l_hand.inhand_icon_state
		if(!itm_state)
			itm_state = l_hand.icon_state
		var/mutable_appearance/l_hand_item = mutable_appearance(alt_inhands_file, "[itm_state][caste]_l", -HANDS_LAYER)
		if(l_hand.blocks_emissive)
			l_hand_item.overlays += emissive_blocker(l_hand_item.icon, l_hand_item.icon_state, alpha = l_hand_item.alpha)
		hands += l_hand_item

	var/obj/item/r_hand = get_item_for_held_index(2)
	if(r_hand)
		var/itm_state = r_hand.inhand_icon_state
		if(!itm_state)
			itm_state = r_hand.icon_state
		var/mutable_appearance/r_hand_item = mutable_appearance(alt_inhands_file, "[itm_state][caste]_r", -HANDS_LAYER)
		if(r_hand.blocks_emissive)
			r_hand_item.overlays += emissive_blocker(r_hand_item.icon, r_hand_item.icon_state, alpha = r_hand_item.alpha)
		hands += r_hand_item

	overlays_standing[HANDS_LAYER] = hands
	apply_overlay(HANDS_LAYER)

/mob/living/carbon/proc/get_max_plasma()
	var/obj/item/organ/alien/plasmavessel/vessel = get_organ_by_type(/obj/item/organ/alien/plasmavessel)
	if(!vessel)
		return -1
	return vessel.max_plasma

/mob/living/carbon/alien/adult/tgmc/alien_evolve(mob/living/carbon/alien/new_xeno, is_it_a_larva)
	var/mob/living/carbon/alien/adult/tgmc/xeno_to_transfer_to = new_xeno

	xeno_to_transfer_to.setDir(dir)
	if(!islarva(xeno_to_transfer_to))
		xeno_to_transfer_to.has_just_evolved()
	if(mind)
		mind.name = xeno_to_transfer_to.real_name
		mind.transfer_to(xeno_to_transfer_to)
	qdel(src)

/mob/living/carbon/alien/adult/tgmc/get_fire_overlay(stacks, on_fire)
	var/fire_icon = "generic_fire"

	if(!GLOB.fire_appearances[fire_icon])
		var/mutable_appearance/new_fire_overlay = mutable_appearance(
			'icons/mob/effects/onfire.dmi',
			fire_icon,
			-HIGHEST_LAYER,
			appearance_flags = RESET_COLOR,
		)
		GLOB.fire_appearances[fire_icon] = new_fire_overlay

	return GLOB.fire_appearances[fire_icon]

//Yes we really do need to do this whole thing to let the queen finder work
/mob/living/carbon/alien/adult/tgmc/findQueen()
	if(hud_used)
		hud_used.alien_queen_finder.cut_overlays()
		var/mob/queen = get_alien_type(/mob/living/carbon/alien/adult/tgmc/queen)
		if(!queen)
			return
		var/turf/Q = get_turf(queen)
		var/turf/A = get_turf(src)
		if(Q.z != A.z) //The queen is on a different Z level, we cannot sense that far.
			return
		var/Qdir = get_dir(src, Q)
		var/Qdist = get_dist(src, Q)
		var/finder_icon = "finder_center" //Overlay showed when adjacent to or on top of the queen!
		switch(Qdist)
			if(2 to 7)
				finder_icon = "finder_near"
			if(8 to 20)
				finder_icon = "finder_med"
			if(21 to INFINITY)
				finder_icon = "finder_far"
		var/image/finder_eye = image('icons/hud/screen_alien.dmi', finder_icon, dir = Qdir)
		hud_used.alien_queen_finder.add_overlay(finder_eye)

/mob/living/carbon/alien/adult/tgmc/set_hud_image_state(hud_type, hud_state, x_offset = 0, y_offset = 0)
	return ..(hud_type, hud_state, hud_offset_x, hud_offset_y)

/mob/living/carbon/alien/adult/tgmc/proc/on_rest()
	SIGNAL_HANDLER

	if(resting)
		add_movespeed_modifier(/datum/movespeed_modifier/alien_rest)
	else
		remove_movespeed_modifier(/datum/movespeed_modifier/alien_rest)

/datum/movespeed_modifier/alien_rest
	multiplicative_slowdown = 5
