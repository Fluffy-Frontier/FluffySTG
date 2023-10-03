/datum/phystool_mode/spawn_mode
	name = "Spawn mode"
	desc = "LMB for spawn, use button for choise spawn type."
	var/atom/selected_object

/datum/phystool_mode/spawn_mode/use_act(mob/user)
	. = ..()
	var/text_patch = tgui_input_text(user, "Enter object patch:", "Spawn tool", "none", 256, FALSE)
	selected_object = text2path(text_patch)
	if(!ispath(selected_object))
		selected_object = pick_closest_path(text_patch)
	if(istype(selected_object, /obj/singularity))
		user.balloon_alert(user, "Singularity locked!")
		selected_object = null
		return FALSE
	if(istype(selected_object, /obj/effect))
		user.balloon_alert(user, "Effectds locked!")
		selected_object = null
		return FALSE
	if(istype(selected_object, /obj/machinery/power/supermatter_crystal))
		user.balloon_alert(user, "Suppermatter locked!")
		selected_object = null
		return FALSE
	if(istype(selected_object, /area))
		user.balloon_alert(user, "Area locked!")
		selected_object = null
		return FALSE
	if(istype(selected_object, /turf))
		user.balloon_alert(user, "Turf locked!")
		selected_object = null
		return FALSE
	if(istype(selected_object, /obj/crystal_mass))
		user.balloon_alert(user, "No SM delam!")
		selected_object = null
		return FALSE
	if(istype(selected_object, /obj/cascade_portal))
		user.balloon_alert(user, "No SM delam!")
		selected_object = null
		return FALSE
	user.balloon_alert(user, "Selected!")
	to_chat(user, span_notice("Now spawn type [selected_object]."))

/datum/phystool_mode/spawn_mode/main_act(atom/target, mob/user)
	. = ..()
	if(!selected_object)
		user.balloon_alert(user, "Select type first!")
		return
	selected_object = new(get_turf(target))
