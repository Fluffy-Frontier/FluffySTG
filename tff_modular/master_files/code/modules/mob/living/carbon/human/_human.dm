/mob/living/carbon/human/set_mob_height(new_height)
	if(dna.species.body_size_restricted)
		return FALSE
	..(new_height)

// Предпроверка оригинальнго прока /carbon/disarm(), если src, слаб телом, прирвыаем атаку. За исключением тех случаев, если это акт эмоции. Вызывается перед оригиналом.
/mob/living/carbon/human/disarm(mob/living/carbon/target)
	if((HAS_TRAIT(src, TRAIT_WEAK_BODY) && !HAS_TRAIT(target, TRAIT_WEAK_BODY)) && zone_selected != (BODY_ZONE_PRECISE_MOUTH || BODY_ZONE_PRECISE_GROIN))
		target.visible_message(span_danger("[src.name] tries shoving [target.name], but [target.p_they()] is too heavy!"))
		do_attack_animation(target, ATTACK_EFFECT_DISARM)
		playsound(target, 'sound/weapons/thudswoosh.ogg', 50, TRUE, -1)
		return
	..(target)

// Предпроверка оригинальнго прока /living/throw_item(), если src, слаб телом, прирвыаем бросок. Вызывается перед оригиналом.
/mob/living/carbon/human/throw_item(atom/target)
	//Если мы не обладатель слабого тела - то не выполняем ничего.
	if(HAS_TRAIT(src, TRAIT_WEAK_BODY))

		var/obj/item/held_item = get_active_held_item()
		var/obj/item/inactive = get_inactive_held_item()
		//Проверяем, что мы бросаем моба.
		if(!held_item)
			if(pulling && isliving(pulling) && grab_state >= GRAB_AGGRESSIVE)
				var/mob/living/mob = pulling
				if(!mob.buckled)
					if(!HAS_TRAIT(mob, TRAIT_WEAK_BODY))
						stop_pulling()
						Knockdown(3 SECONDS)
						to_chat(src, span_notice("You try throwing [mob], but [mob.p_they()] is too heavy!"))
						return FALSE
		//Проверяем, что мы бросаем двуручный предмет.
		else if(held_item.w_class >= WEIGHT_CLASS_BULKY && istype(inactive, /obj/item/offhand) && !HAS_TRAIT(src, TRAIT_NEGATES_GRAVITY))
			to_chat(src, span_notice("You try throwing [held_item], but it is too heavy!"))
			Knockdown(3 SECONDS)
			dropItemToGround(held_item)
			return FALSE

	..(target)
