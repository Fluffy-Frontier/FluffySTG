/atom/movable/screen/fullscreen/void_brightless
	icon = 'tff_modular/modules/void/icons/fullscrean.dmi'
	icon_state = "void"
	blend_mode = BLEND_OVERLAY
	show_when_dead = TRUE
	var/target_alpha = 80

/atom/movable/screen/fullscreen/void_brightless/Initialize(mapload, datum/hud/hud_owner)
	. = ..()
	animate(src, alpha = target_alpha, 10)

/atom/movable/screen/fullscreen/see_through_darkness/Initialize(mapload, datum/hud/hud_owner)
	. = ..()
	//Эффект абсолютной тьмы для нишх глазок.
	alpha = 0
