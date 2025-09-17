/* Spreading Structures Code
	Stolen and edited from alien weed code. I wanted a spreading
	structure that doesnt have the atmospheric element attached to its root. */
/obj/structure/spreading
	name = "spreading structure"
	desc = "This thing seems to spread when supplied with a outside signal."
	max_integrity = 15
	anchored = TRUE
	density = FALSE
	layer = ABOVE_ALL_MOB_LAYER
	plane = FLOOR_PLANE
	var/conflict_damage = 10
	var/last_expand = 0 //last world.time this weed expanded
	var/expand_cooldown = 1.5 SECONDS
	var/can_expand = TRUE
	var/bypass_density = FALSE
	var/static/list/blacklisted_turfs

/obj/structure/spreading/Initialize()
	. = ..()

	if(!blacklisted_turfs)
		blacklisted_turfs = typecacheof(list(
			/turf/open/space,
			/turf/open/chasm,
			/turf/open/lava,
			/turf/open/openspace))

/obj/structure/spreading/proc/expand(bypasscooldown = FALSE)
	if(!can_expand)
		return

	if(!bypasscooldown)
		last_expand = world.time + expand_cooldown

	var/turf/U = get_turf(src)
	if(is_type_in_typecache(U, blacklisted_turfs))
		qdel(src)
		return FALSE

	var/list/spread_turfs = U.reachableAdjacentTurfs()
	shuffle_inplace(spread_turfs)
	for(var/turf/T in spread_turfs)
		var/obj/machinery/M = locate(/obj/machinery) in T
		if(M)
			if(M.density && !bypass_density)
				continue
		var/obj/structure/spreading/S = locate(/obj/structure/spreading) in T
		if(S)
			if(S.type != type) //if it is not another of the same spreading structure.
				S.take_damage(conflict_damage, BRUTE, "melee", 1)
				break
			last_expand += (0.6 SECONDS) //if you encounter another of the same then the delay increases
			continue

		if(is_type_in_typecache(T, blacklisted_turfs))
			continue

		new type(T)
		break
	return TRUE

//Cosmetic Structures
/obj/structure/cavein_floor
	name = "blocked off floor entrance"
	desc = "An entrance to some underground facility that has been caved in."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/lc13_structures.dmi'
	icon_state = "cavein_floor"
	anchored = TRUE

/obj/structure/cavein_door
	name = "blocked off facility entrance"
	desc = "A entrance to somewhere that has been blocked off with rubble."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/32x48.dmi'
	icon_state = "cavein_door"
	pixel_y = -8
	base_pixel_y = -8
	anchored = TRUE

/*
* Wave Spawners. Uses the monwave_spawners component.
*/
/obj/structure/den
	name = "spawning_den"
	desc = "subtype for dens you shouldnt be seeing this."
	icon_state = "hole"
	icon = 'icons/mob/simple/lavaland/nest.dmi'
	max_integrity = 200
	anchored = TRUE
	density = FALSE
	var/list/moblist = list()

/obj/structure/den/tunnel/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/monwave_spawner, attack_target = get_turf(src), new_wave_order = moblist)

/obj/structure/den/proc/changeTarget(thing)
	var/turf/target_turf = get_turf(thing)
	if(!target_turf)
		return FALSE
	var/datum/component/monwave_spawner/target_component = GetComponent(/datum/component/monwave_spawner)
	target_component.GeneratePath(target_turf)
	return TRUE

/obj/structure/den/tunnel
	name = "tunnel entrance"
	desc = "A entrance to a underground tunnel. It would only take a few whacks to cave it in."
	icon_state = "hole"
	icon = 'icons/mob/simple/lavaland/nest.dmi'
	moblist = list(
		/mob/living/simple_animal/hostile/ordeal/steel_dawn = 3,
		/mob/living/simple_animal/hostile/ordeal/steel_dawn/steel_noon/flying = 1,
	)
