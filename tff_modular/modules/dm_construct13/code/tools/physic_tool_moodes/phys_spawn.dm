/datum/phystool_mode/spawn_mode
	name = "Spawn mode"
	desc = "RMB for spawn, LMB for select spwan type."

	//Обьект, который мы будем создавать.
	var/atom/selected_object

/datum/phystool_mode/spawn_mode/secondnary_act(atom/target, mob/user)
	. = ..()
	var/text_patch = tgui_input_text(user, "Enter object patch:", "Spawn tool", "none", 256, FALSE)
	var/list/preparsed = splittext(text_patch,":")
	var/path = preparsed[1]
	var/choise = pick_closest_path(path)
	if(!choise)
		user.balloon_alert(user, "Wrong patch!")
		return
	var/atom/atom_to_spawn = choise
	if(istype(atom_to_spawn, /obj/singularity))
		user.balloon_alert(user, "Spawn blocked!")
		return
	if(istype(atom_to_spawn, /obj/effect))
		user.balloon_alert(user, "Spawn blocked!")
		return
	if(istype(atom_to_spawn, /obj/machinery/power/supermatter_crystal))
		user.balloon_alert(user, "Spawn blocked!")
		return
	user.balloon_alert(user, "Selected!")
	to_chat(user, span_notice("Now spawn type [atom_to_spawn.name]."))
	selected_object = atom_to_spawn

/datum/phystool_mode/spawn_mode/main_act(atom/target, mob/user)
	. = ..()
	if(!selected_object)
		user.balloon_alert(user, "Select type first!")
		return
	selected_object = new(target.loc)
