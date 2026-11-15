

/obj/item/stack/ore/bluespace_crystal/attack_self(mob/living/user)
	if(istype(user.loc, /obj/effect/abstract/sync_holder))
		user.visible_message(
			span_userdanger("[user]'s body twists horrifically as bluespace energy interacts with the desynchronized pocket!"),
			span_userdanger("You feel your atoms scatter across multiple timelines simultaneously!"),
		)
		new /obj/effect/particle_effect/sparks(loc)
		playsound(loc, SFX_PORTAL_ENTER, 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
		use(1)
		rip_from_desync(user)
		return
	return ..()

/obj/item/stack/ore/bluespace_crystal/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	if(isliving(hit_atom))
		var/mob/living/target = hit_atom
		if(istype(target.loc, /obj/effect/abstract/sync_holder))
			visible_message(span_userdanger("[src] fizzles violently as bluespace energy pierces the desynchronized pocket around [target]!"))
			var/turf/target_turf = get_turf(target)
			new /obj/effect/particle_effect/sparks(target_turf)
			playsound(loc, SFX_PORTAL_ENTER, 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
			use(1)
			rip_from_desync(target)
			return
	return ..()

/// Throws the target out of the desynchronized pocket onto the turf below, then gibs them with all remains dropped.
/obj/item/stack/ore/bluespace_crystal/proc/rip_from_desync(mob/living/target)
	target.forceMove(get_turf(target))
	target.gib(DROP_ALL_REMAINS)

// Fixes the desynchronizer being usable while the user is inside another desynchronizer's spacetime pocket.
// Vanilla desync() only checks its own sync_holder, so activating a second desynchronizer inside a
// sync_holder would rip the user out of it into a second pocket, leaving both timers running.

/obj/item/desynchronizer/desync(mob/living/user)
	if(istype(user.loc, /obj/effect/abstract/sync_holder))
		to_chat(user, span_userdanger("[src] sparks violently! You cannot desynchronize spacetime that is already desynchronized!"))
		playsound(src, SFX_SPARKS, 50, TRUE)
		new /obj/effect/particle_effect/sparks(drop_location())
		return
	return ..()
