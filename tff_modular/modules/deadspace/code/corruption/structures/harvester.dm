#define HARVESTER_CONTROL_RANGE 7

/obj/structure/necromorph/harvester
	name = "harvester"
	icon = 'tff_modular/modules/deadspace/icons/effects/harvester_new.dmi'
	icon_state = "closed"
	density = TRUE
	pixel_x = -16
	base_pixel_x = -16
	pixel_y = -8
	base_pixel_y = -8
	var/active = FALSE
	var/biomass_per_tick = 0
	var/list/controlled_atoms
	var/obj/structure/marker/marker
	var/datum/biomass_source/our_source
	cost = 50
	marker_only = TRUE

/obj/structure/necromorph/harvester/Initialize(mapload, obj/structure/marker/new_master)
	.=..()
	AddComponent(/datum/component/seethrough, SEE_THROUGH_MAP_DEFAULT_TWO_TALL)
	if(!new_master)
		return INITIALIZE_HINT_QDEL
	marker = new_master
	controlled_atoms = list()

/obj/structure/necromorph/harvester/LateInitialize()
	..()
	//If we have corruption beneath - we are growing
	var/turf/our_loc = loc
	if(istype(our_loc) && our_loc.necro_corrupted)
		addtimer(CALLBACK(src, PROC_REF(activate)), 1 MINUTES, TIMER_UNIQUE|TIMER_OVERRIDE)

/obj/structure/necromorph/harvester/Destroy()
	marker?.remove_biomass_source(our_source)
	our_source = null
	for(var/atom/movable/controlled as anything in controlled_atoms)
		UnregisterSignal(controlled, list(COMSIG_QDELETING, COMSIG_MOVABLE_MOVED))
		REMOVE_TRAIT(controlled, TRAIT_PRODUCES_BIOMASS, src)
		controlled.remove_filter("harvester_glow")
	controlled_atoms = null
	marker = null
	return ..()

/obj/structure/necromorph/harvester/update_icon_state()
	icon_state = (active ? "active" : "closed")
	return ..()
/obj/structure/necromorph/harvester/on_turf_corrupted()
	..()
	addtimer(CALLBACK(src, PROC_REF(activate)), 1 MINUTES, TIMER_UNIQUE|TIMER_OVERRIDE)

/obj/structure/necromorph/harvester/on_turf_uncorrupted()
	..()
	active = FALSE
	marker.remove_biomass_source(our_source)
	our_source = null
	for(var/atom/movable/controlled as anything in controlled_atoms)
		UnregisterSignal(controlled, list(COMSIG_QDELETING, COMSIG_MOVABLE_MOVED))
		REMOVE_TRAIT(controlled, TRAIT_PRODUCES_BIOMASS, src)
		controlled.remove_filter("harvester_glow")
	controlled_atoms.Cut()
	update_icon_state()
	light_power = 0
	light_range = 0
	update_light()

/obj/structure/necromorph/harvester/proc/activate()
	if(active)
		return
	var/turf/our_loc = loc
	if(istype(our_loc) && our_loc.necro_corrupted)
		active = TRUE
		FOR_DVIEW(var/atom/movable/controlled, HARVESTER_CONTROL_RANGE, get_turf(src), INVISIBILITY_LIGHTING)
			if(controlled.biomass_produce && !HAS_TRAIT(controlled, TRAIT_PRODUCES_BIOMASS))
				controlled_atoms += controlled
				RegisterSignal(controlled, COMSIG_QDELETING, PROC_REF(on_controlled_delete))
				RegisterSignal(controlled, COMSIG_MOVABLE_MOVED, PROC_REF(on_controlled_moved))
				ADD_TRAIT(controlled, TRAIT_PRODUCES_BIOMASS, src)
				controlled.add_filter("harvester_glow", 1, outline_filter(1, COLOR_HARVESTER_RED))
				biomass_per_tick += controlled.biomass_produce
		FOR_DVIEW_END
		our_source = marker.add_biomass_source(/datum/biomass_source/harvester, src)
		update_icon_state()
		light_power = 0.5
		light_range = 3
		light_color = "#bcb10d"
		update_light()

/obj/structure/necromorph/harvester/proc/on_controlled_delete(atom/movable/controlled, force)
	SIGNAL_HANDLER
	biomass_per_tick -= controlled.biomass_produce
	controlled_atoms -= controlled
	UnregisterSignal(controlled, list(COMSIG_QDELETING, COMSIG_MOVABLE_MOVED))
	REMOVE_TRAIT(controlled, TRAIT_PRODUCES_BIOMASS, src)
	controlled.remove_filter("harvester_glow")

/obj/structure/necromorph/harvester/proc/on_controlled_moved(atom/movable/controlled)
	SIGNAL_HANDLER
	if(!IN_GIVEN_RANGE(src, controlled, HARVESTER_CONTROL_RANGE))
		biomass_per_tick -= controlled.biomass_produce
		controlled_atoms -= controlled
		UnregisterSignal(controlled, list(COMSIG_QDELETING, COMSIG_MOVABLE_MOVED))
		REMOVE_TRAIT(controlled, TRAIT_PRODUCES_BIOMASS, src)
		controlled.remove_filter("harvester_glow")

#undef HARVESTER_CONTROL_RANGE
