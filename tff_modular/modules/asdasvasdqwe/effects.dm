
/atom/movable/screen/fullscreen/mrak

	icon = 'tff_modular/modules/asdasvasdqwe/ship/map_backgrounds.dmi'

	icon_state = "oxydamageoverlay1"

	alpha = 100

	layer = FULLSCREEN_LAYER

	plane = FULLSCREEN_PLANE


/atom/movable/screen/fullscreen/mrak/update_for_view(client_view)
	animate(src, flags = ANIMATION_END_NOW) //Stop all animations.

	. = ..()

	alpha = 255

	animate(src, alpha = 0, time = 1 SECONDS)
	hud.mymob.clear_fullscreen("mrak", 3)

/atom/movable/screen/fullscreen/vhs

	icon = 'tff_modular/modules/asdasvasdqwe/ship/map_backgrounds.dmi'

	icon_state = "scanline"

	alpha = 100

	layer = FLASH_LAYER

	plane = FULLSCREEN_PLANE

/mob/living/proc/addmrak()
	overlay_fullscreen("mrak", /atom/movable/screen/fullscreen/mrak, 1)

/mob/living/proc/removemrak()
	overlay_fullscreen("mrak", /atom/movable/screen/fullscreen/mrak, 1)

/mob/living/proc/addvhs()
	overlay_fullscreen("vhs", /atom/movable/screen/fullscreen/vhs, 1)

/mob/living/proc/removevhs()
	overlay_fullscreen("test", /atom/movable/screen/fullscreen/vhs, 1)




/obj/effect/cleave
	icon = 'tff_modular/modules/asdasvasdqwe/structures/eldritch.dmi'
	icon_state = "cleave"

/obj/effect/smoke
	icon = 'tff_modular/modules/asdasvasdqwe/structures/eldritch.dmi'
	icon_state = "smoke"

/obj/effect/regenpuff
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/32x32.dmi'
	icon_state = "regenpuff"

/obj/effect/regenpuff/heavy
	icon_state = "regenpuff_heavy"

/obj/effect/gcorp
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/32x32.dmi'
	icon_state = "gcorp_corpse"

/obj/effect/turf_decal/signn
	name = "Warning sign"
	desc = ""
	icon = 'tff_modular/modules/asdasvasdqwe/ship/decals.dmi'
	icon_state = "darkplaque"

/obj/effect/turf_decal/signn/b
	icon_state = "turrets"

/obj/effect/turf_decal/signn/c
	icon_state = "blast"

/obj/effect/turf_decal/signn/d
	icon_state = "falling"

/obj/effect/turf_decal/signn/e
	icon_state = "movingparts"

/obj/effect/turf_decal/signn/g
	icon_state = "securearea2"

/obj/effect/turf_decal/signn/h
	icon_state = "armory"

/obj/effect/turf_decal/signn/aa
	icon_state = "server"

/obj/effect/turf_decal/signn/ab
	icon_state = "nosmoking2_b"

/obj/effect/turf_decal/signn/ac
	icon_state = "incident"

/obj/effect/turf_decal/huge_corn
	name = "corn"
	desc = ""
	icon = 'tff_modular/modules/asdasvasdqwe/mobs/cron.dmi'
	icon_state = "huge"
	layer = ABOVE_ALL_MOB_LAYER
