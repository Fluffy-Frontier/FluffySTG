/proc/anvilgib(mob/living/poor_soul)
	ADD_TRAIT(poor_soul, TRAIT_NO_TELEPORT, SMITE_TRAIT)
	poor_soul.Stun(20 SECONDS, ignore_canstun = TRUE) // Cant move by themself
	poor_soul.mobility_flags = NONE // Cant rest to break animation
	GLOB.move_manager.stop_looping(poor_soul) // Cant be grabbed
	poor_soul.density = 0 // Cant be moved by walking into them
	poor_soul.move_resist = MOVE_RESIST_DEFAULT * 1000

	var/obj/anvil = new /obj/structure/reagent_anvil(get_turf(poor_soul))
	anvil.anchored = TRUE
	anvil.pixel_y = 32 * 7
	anvil.alpha = 0
	anvil.layer += 4
	animate(anvil, alpha = 255, time = 0.9 SECONDS, flags = ANIMATION_PARALLEL)
	animate(anvil, pixel_y = 0, easing = EASE_IN | QUAD_EASING, time = 1.84 SECONDS, flags = ANIMATION_PARALLEL)

	var/obj/effect/smash_shadow/anvil_shadow = new /obj/effect/smash_shadow(get_turf(poor_soul))
	animate(anvil_shadow, alpha = 150, transform = matrix(0.25, 0, 0, 0, 0.17, 0), easing = EASE_IN | QUAD_EASING, time = 1.75 SECONDS, flags = ANIMATION_PARALLEL)

	playsound(get_turf(poor_soul), 'tff_modular/modules/custom_smites/sounds/cartoon_fall.ogg', 50, FALSE)
	sleep(1.6 SECONDS)
	poor_soul.gib()
	anvil.anchored = FALSE
	qdel(anvil_shadow)

/obj/effect/smash_shadow
	icon='tff_modular/modules/custom_smites/icons/96x96.dmi';
	icon_state="circle"
	mouse_opacity = 0
	color = "#000000"
	alpha = 0
	transform = matrix(0.8, 0, 0, 0, 0.5, 0)
	pixel_x = -32
	pixel_y = -32 - 7
	anchored = TRUE
	plane = GAME_PLANE

/datum/smite/cartoon_anvil
	name = "Cartoon anvil gib"

/datum/smite/cartoon_anvil/effect(client/user, mob/living/target)
	if (!isliving(target))
		return // This doesn't work on ghosts
	. = ..()
	anvilgib(target)
