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

	var/static/loc_connections2 = list(
		COMSIG_ATOM_ENTERED = PROC_REF(movable_entered),
	)

/obj/effect/particle_effect/fluid/smoke/fire/Initialize(mapload, datum/fluid_group/group, ...)
	. = ..()
	AddElement(/datum/element/connect_loc, loc_connections2)
	addtimer(CALLBACK(src, PROC_REF(lower_fire)), initial(lifetime) / 3)
	set_light_range(LIGHT_RANGE_FIRE + 1)
	update_light()

/obj/effect/particle_effect/fluid/smoke/fire/spread(seconds_per_tick = 0.1 SECONDS)
	if(group.total_size > group.target_size)
		return
	var/turf/t_loc = get_turf(src)
	if(!t_loc)
		return

	for(var/turf/spread_turf in t_loc.get_atmos_adjacent_turfs())
		if(group.total_size > group.target_size)
			break
		if(locate(type) in spread_turf)
			continue // Don't spread smoke where there's already smoke!
		if(isspaceturf(spread_turf))
			continue
		for(var/mob/living/smoker in spread_turf)
			smoke_mob(smoker, seconds_per_tick)

		var/obj/effect/particle_effect/fluid/smoke/spread_smoke = new type(spread_turf, group, src)
		reagents.copy_to(spread_smoke, reagents.total_volume)
		spread_smoke.add_atom_colour(color, FIXED_COLOUR_PRIORITY)
		spread_smoke.lifetime = lifetime

		// the smoke spreads rapidly, but not instantly
		SSsmoke.queue_spread(spread_smoke)

	if(isspaceturf(t_loc))
		qdel(src)

/obj/effect/particle_effect/fluid/smoke/fire/process(seconds_per_tick)
	if(isspaceturf(get_turf(src)))
		qdel(src)
		return FALSE
	return ..()

/obj/effect/particle_effect/fluid/smoke/fire/proc/lower_fire()
	switch(icon_state)
		if("fire_big")
			icon_state = "fire_medium"
			set_light_range(LIGHT_RANGE_FIRE)
			addtimer(CALLBACK(src, PROC_REF(lower_fire)), initial(lifetime) / 3)
		if("fire_medium")
			icon_state = "fire_small"
			set_light_range(LIGHT_RANGE_FIRE)

	update_light()

/obj/effect/particle_effect/fluid/smoke/fire/proc/movable_entered(datum/source, atom/movable/target_atom)
	SIGNAL_HANDLER
	if(isobserver(target_atom))
		return

	target_atom.fire_act(5000, 1000)

/obj/effect/particle_effect/fluid/smoke/fire/extinguish()
	. = ..()
	qdel(src)
