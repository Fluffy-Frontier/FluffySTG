/obj/item/necro_plasma_saw
	name = "SH-B1 Plasma Saw"
	desc = "The SH-B1 Plasma Saw is designed for dissection of heavy duty materials in both on and off-site locations. Users are advised to always wear protective clothing when the saw is in use."
	icon = 'tff_modular/modules/deadspace/icons/event/obj/weapons.dmi'
	lefthand_file = 'tff_modular/modules/deadspace/icons/event/mob/weapons_left_hand.dmi'
	righthand_file = 'tff_modular/modules/deadspace/icons/event/mob/weapons_right_hand.dmi'
	icon_state = "plasma_saw"
	inhand_icon_state = "plasma_saw"
	force = 5
	w_class = WEIGHT_CLASS_NORMAL
	throwforce = 13
	throw_speed = 2
	throw_range = 4
	demolition_mod = 1.5
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 6.5)
	attack_verb_continuous = list("attacked", "slashed", "sawed", "cut")
	attack_verb_simple = list("attack", "slash", "saw", "cut")
	hitsound = SFX_SWING_HIT
	sharpness = SHARP_EDGED
	actions_types = list(/datum/action/item_action/startchainsaw)
	tool_behaviour = TOOL_SAW
	toolspeed = 1.5 //Turn it on first you dork
	var/active = FALSE
	var/force_on = 17

/obj/item/necro_plasma_saw/Initialize(mapload)
	. = ..()
	AddComponent( \
		/datum/component/transforming, \
		force_on = force_on, \
		throwforce_on = force_on, \
		throw_speed_on = throw_speed, \
		sharpness_on = SHARP_EDGED, \
		hitsound_on = 'sound/items/weapons/chainsawhit.ogg', \
		w_class_on = w_class, \
	)

	AddComponent(/datum/component/butchering, \
		speed = 3 SECONDS, \
		effectiveness = 100, \
		bonus_modifier = 0, \
		butcher_sound = 'sound/items/weapons/chainsawhit.ogg', \
		disabled = TRUE, \
	)

	RegisterSignal(src, COMSIG_TRANSFORMING_ON_TRANSFORM, PROC_REF(on_transform))

/obj/item/necro_plasma_saw/proc/on_transform(obj/item/source, mob/user, active)
	SIGNAL_HANDLER
	to_chat(user, span_notice("As you pull the starting cord dangling from [src], [active ? "it begins to whirr" : "the chain stops moving"]."))
	var/datum/component/butchering/butchering = GetComponent(/datum/component/butchering)
	butchering.butchering_enabled = active
	if(active)
		playsound(get_turf(src), 'sound/items/weapons/saberoff.ogg', 20, 1, -2)
	else
		playsound(get_turf(src), 'sound/items/weapons/saberon.ogg', 20, 1, -2)
	toolspeed = active ? 0.5 : initial(toolspeed)
	update_item_action_buttons()

	return COMPONENT_NO_DEFAULT_MESSAGE
