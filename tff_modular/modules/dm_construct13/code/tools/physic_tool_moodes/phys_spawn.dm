#define SPAWN_MODE_MOB_COOLDOWN 5 SECONDS
#define SPAWN_MODE_MEGAFAUNA_COOLDOWN 30 SECONDS

/datum/phystool_mode/spawn_mode
	name = "Spawn mode"
	desc = "LMB for spawn, use button for choise spawn type."
	var/atom/selected_object

	var/list/atom/black_list = list(
		/obj/narsie,
		/obj/cascade_portal,
		/obj/singularity,
		/obj/effect,
		/mob/living/basic/supermatter_spider,
		/area,
		/turf
	)
	COOLDOWN_DECLARE(spawn_cooldown)

/datum/phystool_mode/spawn_mode/use_act(mob/user)
	. = ..()
	var/text_patch = tgui_input_text(user, "Enter object patch:", "Spawn tool", "none", 256, FALSE)
	if(!text_patch)
		user.balloon_alert(user, "Input path!")
		return FALSE
	selected_object = text2path(text_patch)
	if(!ispath(selected_object))
		selected_object = pick_closest_path(text_patch)
	for(var/black_list_item in black_list)
		if(ispath(selected_object, black_list_item))
			selected_object = null
			user.balloon_alert(user, "Spawn blocked!")
			return FALSE
	user.balloon_alert(user, "Selected!")
	to_chat(user, span_notice("Now spawn type [selected_object]."))

/datum/phystool_mode/spawn_mode/main_act(atom/target, mob/user)
	. = ..()

	if(!selected_object)
		user.balloon_alert(user, "Select type first!")
		return FALSE

	if(!COOLDOWN_FINISHED(src, spawn_cooldown))
		user.balloon_alert(user, "Wait!")
		return FALSE
	var/target_cooldown
	if(ispath(selected_object, /mob/living/simple_animal/hostile/megafauna))
		target_cooldown = SPAWN_MODE_MEGAFAUNA_COOLDOWN
	if(ispath(selected_object, /mob/living))
		target_cooldown = SPAWN_MODE_MOB_COOLDOWN
	if(target_cooldown)
		COOLDOWN_START(src, spawn_cooldown, target_cooldown)

	new selected_object(get_turf(target))
	return TRUE
