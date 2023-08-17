/datum/action/cooldown/void_ability/void_teleport
	name = "Телепортация"
	desc = "Быстрая телепортация к цели."
	click_to_activate = TRUE

	button_icon = 'icons/hud/guardian.dmi'
	button_icon_state = "charger"
	cooldown_time = 10 SECONDS

/datum/action/cooldown/void_ability/Activate(atom/target)
	. = ..()
	var/turf/source_turf = get_turf(owner)
	var/turf/targeted_turf = get_turf(target)

	if(isclosedturf(targeted_turf) || !targeted_turf)
		owner.balloon_alert(owner, "Solid turf!")
		return FALSE

	for(var/mob/living/carbon/human/flash_target in view(owner))
		flash_target.add_screeen_temporary_effect(/atom/movable/screen/fullscreen/void_brightless/highter, 5 SECONDS, TRUE)

	do_effect(source_turf)
	do_effect(targeted_turf, /obj/effect/temp_visual/voidout)

	do_teleport(
		owner,
		targeted_turf,
		precision = 1,
		no_effects = TRUE,
		channel = TELEPORT_CHANNEL_FREE,
	)

/datum/action/cooldown/void_ability/proc/do_effect(turf/target, type = /obj/effect/temp_visual/voidin)
	playsound(owner, 'tff_modular/modules/void/sounds/stab.ogg', 100, TRUE)
	new type(target)
