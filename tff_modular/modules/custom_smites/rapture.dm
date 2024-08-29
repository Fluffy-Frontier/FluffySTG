/proc/heavenly_despawn(mob/living/ascended_mob)
	var/turf/gods_turf = get_turf(ascended_mob)
	var/obj/effect/heavenly_light/lightbeam = new /obj/effect/heavenly_light(gods_turf)
	ascended_mob.layer = EFFECTS_LAYER + 1
	lightbeam.alpha = 0
	ascended_mob.Stun(20 SECONDS, ignore_canstun = TRUE) // Cant move by themself
	ascended_mob.mobility_flags = NONE // Cant rest to break animation
	GLOB.move_manager.stop_looping(ascended_mob) // Cant be grabbed
	ascended_mob.density = 0 // Cant be moved by walking into them
	ADD_TRAIT(ascended_mob, TRAIT_NO_TELEPORT, SMITE_TRAIT)
	ascended_mob.move_resist = MOVE_RESIST_DEFAULT * 1000
	playsound(gods_turf, 'tff_modular/modules/custom_smites/sounds/heaven.ogg', 50, 0)
	animate(lightbeam, alpha=255, time=4.5 SECONDS)
	sleep(4.5 SECONDS)
	animate(ascended_mob, pixel_y = 160, time = 12 SECONDS, easing = SINE_EASING, flags = ANIMATION_PARALLEL)
	sleep(12 SECONDS)
	animate(lightbeam, alpha = 0, time=1.5 SECONDS)
	animate(ascended_mob, alpha=0, time=1.5 SECONDS)
	sleep(1.5 SECONDS)
	qdel(lightbeam)
	ascended_mob.ghostize()
	qdel(ascended_mob)

/obj/effect/heavenly_light
	icon = 'tff_modular/modules/custom_smites/icons/32x192.dmi'
	icon_state = "heavenlight"
	layer = EFFECTS_LAYER
	blend_mode = BLEND_ADD

/datum/smite/rapture
	name = "Rapture"

/datum/smite/rapture/effect(client/user, mob/living/target)
	if (!isliving(target))
		return // This doesn't work on ghosts
	. = ..()
	heavenly_despawn(target)
