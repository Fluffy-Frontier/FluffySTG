/obj/effect/temp_visual/rip_space
	name = "dimensional rift"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/32x32.dmi'
	icon_state = "rift"
	duration = 2

/obj/effect/temp_visual/ripped_space
	name = "ripped space"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/32x32.dmi'
	icon_state = "ripped_space"
	duration = 3


/obj/effect/temp_visual/house
	name = "home"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/96x96.dmi'
	icon_state = "House"
	duration = 4 SECONDS
	pixel_x = -34
	pixel_z = 128

/obj/effect/temp_visual/house/Initialize()
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(FadeOut)), 2 SECONDS)

/obj/effect/temp_visual/house/proc/FadeOut()
	animate(src, alpha = 0, time = 1 SECONDS)

/obj/effect/temp_visual/v_noon
	name = "violet noon"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/48x64.dmi'
	icon_state = "violet_noon_ability"
	pixel_x = -8

/obj/effect/temp_visual/warning3x3
	name = "warning3x3"
	icon = 'icons/effects/96x96.dmi'
	icon_state = "warning_gray"
	duration = 2 SECONDS
	pixel_x = -32
	pixel_z = -32
