/// TGMC_XENOS (old nova sector xenos)

// Полная копирка с /datum/element/web_walker
/datum/element/resin_walker
	element_flags = ELEMENT_BESPOKE
	argument_hash_start_idx = 2

	var/datum/movespeed_modifier/on_resin_modifier

/datum/element/resin_walker/Attach(datum/target, datum/movespeed_modifier/on_resin_modifier = /datum/movespeed_modifier/resin_speedup)
	. = ..()
	if (!isliving(target))
		return ELEMENT_INCOMPATIBLE
	src.on_resin_modifier = on_resin_modifier

	RegisterSignal(target, COMSIG_MOVABLE_MOVED, PROC_REF(on_moved))

/datum/element/resin_walker/Detach(datum/source)
	. = ..()
	UnregisterSignal(source, COMSIG_MOVABLE_MOVED)

/datum/element/resin_walker/proc/on_moved(mob/living/source)
	SIGNAL_HANDLER

	var/obj/structure/alien/weeds/resin = locate() in get_turf(source)
	if(resin)
		source.add_movespeed_modifier(on_resin_modifier)
	else
		source.remove_movespeed_modifier(on_resin_modifier)


/datum/movespeed_modifier/resin_speedup
	multiplicative_slowdown = -0.5
