/obj/effect/temp_visual/void_step
	name = "Void steps"
	desc = "Whatch your steps.."
	icon = 'tff_modular/modules/void/icons/void_effects.dmi'
	icon_state = "void_step1"
	duration = 60 SECONDS
	layer =	BELOW_OBJ_LAYER
	var/true_icon_state

/obj/effect/temp_visual/void_step/Initialize(mapload, mob/caster, live_time = 60 SECONDS)
	if(!caster)
		qdel(src)
		return

	duration = live_time
	playsound(caster, pick('tff_modular/modules/void/sounds/drip1.ogg','tff_modular/modules/void/sounds/drip2.ogg','tff_modular/modules/void/sounds/drip3.ogg'), 90)
	true_icon_state = "void_step[rand(1, 4)]"
	icon_state = true_icon_state

	update_appearance(UPDATE_ICON_STATE)
	//Эффект постепенного исчезновения!
	animate(src, alpha = 0, time = duration)
	return ..()
