/atom/movable/screen/fullscreen/void_brightless
	icon = 'tff_modular/modules/void/icons/fullscrean.dmi'
	icon_state = "void"
	blend_mode = BLEND_OVERLAY
	show_when_dead = TRUE
	var/target_alpha = 120
	var/alpha_speed = 1 SECONDS

/atom/movable/screen/fullscreen/void_brightless/Initialize(mapload, datum/hud/hud_owner)
	. = ..()
	animate(src, alpha = target_alpha, alpha_speed)

/atom/movable/screen/fullscreen/void_brightless/highter
	target_alpha = 190
	alpha_speed = 10 SECONDS

/atom/movable/screen/fullscreen/see_through_darkness/Initialize(mapload, datum/hud/hud_owner)
	. = ..()
	//Эффект абсолютной тьмы для нишх глазок.
	alpha = 0

/atom/movable/screen/fullscreen/triller_cold
	icon = 'tff_modular/modules/void/icons/fullscrean.dmi'
	icon_state = "cold"
	blend_mode = BLEND_OVERLAY
	layer = FOV_EFFECT_LAYER
	show_when_dead = TRUE
	color = "#3399ff"
	alpha = 100
