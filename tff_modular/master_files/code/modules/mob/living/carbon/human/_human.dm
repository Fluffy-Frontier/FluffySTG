/mob/living/carbon/human/is_shove_knockdown_blocked()
	if(HAS_TRAIT(src, TRAIT_KNOCKDOWN_IMMUNE))
		return TRUE
	..()

/mob/living/carbon/human/disarm(mob/living/carbon/target)
	if((HAS_TRAIT(src, TRAIT_WEAK_BODY) && !HAS_TRAIT(target, TRAIT_WEAK_BODY)) && zone_selected != (BODY_ZONE_PRECISE_MOUTH || BODY_ZONE_PRECISE_GROIN))
		target.visible_message(span_danger("[src.name] try shoves [target.name], but [target.p_their()] to heavy!"))
		do_attack_animation(target, ATTACK_EFFECT_DISARM)
		playsound(target, 'sound/weapons/thudswoosh.ogg', 50, TRUE, -1)
		return
	..(target)

/mob/living/carbon/human/throw_item(atom/target)
	var/obj/item/held_item = get_active_held_item()
	if(!held_item)
		if(pulling && isliving(pulling) && grab_state >= GRAB_AGGRESSIVE)
			var/mob/living/mob = pulling
			if(!mob.buckled)
				if(HAS_TRAIT(src, TRAIT_WEAK_BODY) && !HAS_TRAIT(mob, TRAIT_WEAK_BODY))
					stop_pulling()
					to_chat(src, span_notice("You try throw [mob], but [mob.p_their()] to heavy!"))
					return FALSE
	..(target)
