/datum/action/cooldown/necro/corruption
	name = "Generic corruption placement ability"
	button_icon = 'tff_modular/modules/deadspace/icons/hud/action_corruption.dmi'
	button_icon_state = "propagator"
	cooldown_time = 0.1 SECONDS
	click_to_activate = TRUE
	var/obj/structure/necromorph/place_structure

/datum/action/cooldown/necro/corruption/set_click_ability(mob/on_who)
	.=..()
	owner.mouse_move_intercept = src

/datum/action/cooldown/necro/corruption/unset_click_ability(mob/on_who, refund_cooldown)
	.=..()
	owner.mouse_move_intercept = null
	//Gotta check if client is still there because unset is also called in Logout()

/datum/action/cooldown/necro/corruption/InterceptClickOn(mob/living/clicker, params, atom/target)
	var/list/modifiers = params2list(params)
	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		if(unset_after_click)
			unset_click_ability(clicker, refund_cooldown = TRUE)
		clicker.next_click = world.time + click_cd_override
		return FALSE
	if(!IsAvailable(feedback = TRUE))
		return FALSE
	if(!target)
		return FALSE
	// The actual action begins here
	if(!PreActivate(target))
		return FALSE

	// And if we reach here, the action was complete successfully
	if(!LAZYACCESS(modifiers, SHIFT_CLICK) && unset_after_click)
		unset_click_ability(clicker, refund_cooldown = FALSE)
	clicker.next_click = world.time + click_cd_override

	return TRUE

/datum/action/cooldown/necro/corruption/PreActivate(atom/target)
	var/list/list_to_pick = list()
	for(var/obj/structure/necromorph/struct as anything in subtypesof(/obj/structure/necromorph))
		if(struct.marker_only && !ismarkermark(owner))
			continue
		list_to_pick["[initial(struct.name)] - [initial(struct.cost)]"] = struct

	place_structure = list_to_pick[tgui_input_list(owner, "Pick a structure to spawn", "Spawning", list_to_pick)]
	if(!place_structure)
		return

	if(!length(GLOB.necromorph_markers))
		to_chat(owner, span_warning("There are no markers present!"))
		return

	return ..()

/datum/action/cooldown/necro/corruption/Activate(atom/target)
	var/current_biomass = 0
	var/obj/structure/marker/mark = null
	if(typesof(owner, /mob/living/carbon/human/necromorph/infector))
		var/mob/living/carbon/human/necromorph/infector/necro = owner
		current_biomass = necro.marker.signal_biomass
		mark = necro.marker
	else
		var/mob/eye/marker_signal/signal = owner
		mark = signal.marker
		current_biomass = ismarkermark(owner) ? mark.marker_biomass : mark.signal_biomass
	if(current_biomass < place_structure.cost)
		to_chat(owner, span_warning("Not enough biomass!"))
		return TRUE
	var/turf/target_turf = get_turf(target)
	var/result_message = can_place(target_turf, place_structure)
	if(result_message)
		to_chat(owner, span_warning(result_message))
		return TRUE
	if(istype(owner, /mob/eye/marker_signal/marker))
		mark.change_marker_biomass(-place_structure.cost)
	else
		mark.change_signal_biomass(-place_structure.cost)
	var/obj/structure/necromorph/structure = new place_structure(target_turf, mark)
	if(!structure)
		return
	place_structure = null
	return ..()


//Returns a string on fail. Otherwise - null
/datum/action/cooldown/necro/corruption/proc/can_place(turf/turf_loc)
	if(!place_structure)
		return "No structure selected!"
	if(!turf_loc)
		return "No turf selected!"
	if(turf_loc.density)
		return "Turf is obstructed!"
	if(!turf_loc.necro_corrupted)
		return "Turf isn't corrupted!"
	if(locate(/obj/structure/necromorph) in turf_loc)
		return "There is another necromorph structure on this turf!"
	if(locate(/obj/structure/necromorph) in range(place_structure.placement_range, turf_loc))
		return "Too close to another necromorph structure!"
	//Remove this loop if it causes too much lag when hovering over a pile of items
	for(var/atom/movable/movable as anything in turf_loc)
		if(movable.density)
			return "Turf is obstructed!"
	if(!place_structure.can_place_in_sight)
		for(var/mob/living/living in viewers(world.view, turf_loc))
			if((!isnecromorph(living) && living.ckey) && (living.stat < UNCONSCIOUS) && !living.is_blind())
				return "Turf is in sight of a sentient creature!"
	return
