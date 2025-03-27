/datum/effect_system/fluid_spread/smoke/fire
	effect_type = /obj/effect/particle_effect/fluid/smoke/fire

/obj/effect/particle_effect/fluid/smoke/fire
	name = "fire"
	icon = 'modular_nova/modules/liquids/icons/obj/effects/liquid.dmi'
	icon_state = "fire_big"
	pixel_x = 0
	pixel_y = 0
	opacity = FALSE
	lifetime = 60 SECONDS

	light_range = 0
	light_power = 1
	light_color = LIGHT_COLOR_FIRE

/obj/effect/particle_effect/fluid/smoke/fire/Initialize(mapload, datum/fluid_group/group, ...)
	if(isspaceturf(get_turf(src)))
		qdel(src)
		return
	. = ..()
	RegisterSignal(loc, COMSIG_ATOM_ENTERED, PROC_REF(movable_entered))
	addtimer(CALLBACK(src, PROC_REF(lower_fire)), lifetime / 3)
	set_light_range(LIGHT_RANGE_FIRE + 1)
	update_light()

/obj/effect/particle_effect/fluid/smoke/fire/Destroy()
	. = ..()
	UnregisterSignal(loc, COMSIG_ATOM_ENTERED)

/obj/effect/particle_effect/fluid/smoke/fire/proc/lower_fire()
	switch(icon_state)
		if("fire_big")
			icon_state = "fire_medium"
			set_light_range(LIGHT_RANGE_FIRE)

			addtimer(CALLBACK(src, PROC_REF(lower_fire)), lifetime / 3)
		if("fire_medium")
			icon_state = "fire_small"
			set_light_range(LIGHT_RANGE_FIRE)

	update_light()

/obj/effect/particle_effect/fluid/smoke/fire/proc/movable_entered(datum/source, atom/movable/target_atom)
	SIGNAL_HANDLER
	if(isobserver(target_atom))
		return

	target_atom.fire_act(5000, 1000)
