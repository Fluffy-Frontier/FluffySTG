/obj/effect/temp_visual/void_step
	name = "Void steps"
	desc = "Watch your step..."
	icon = 'tff_modular/modules/void/icons/void_effects.dmi'
	icon_state = "void_step1"
	duration = 60 SECONDS
	layer =	BELOW_OBJ_LAYER
	var/true_icon_state

/obj/effect/temp_visual/void_step/Initialize(mapload, mob/caster)
	. = ..()
	if(!caster)
		qdel(src)
		return

	playsound(caster, pick('tff_modular/modules/void/sounds/drip1.ogg','tff_modular/modules/void/sounds/drip2.ogg','tff_modular/modules/void/sounds/drip3.ogg'), 90)
	true_icon_state = "void_step[rand(1, 4)]"
	icon_state = true_icon_state

	update_appearance(UPDATE_ICON_STATE)
	//Эффект постепенного исчезновения!
	animate(src, alpha = 0, time = duration)

/obj/effect/temp_visual/void_step/simple
	duration = 10 SECONDS
