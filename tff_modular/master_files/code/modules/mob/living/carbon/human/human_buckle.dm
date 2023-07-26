// Перезапись проверки по перетягиванию моба на себя. Или себя на него. Проверка на возможность взятия в руки. Порядок проверки следующий : может ли взять в руки >> может ли взять на спину >> может ли взять на плечо.
/mob/living/carbon/human/mouse_buckle_handling(mob/living/M, mob/living/user)
	if(pulling != M || grab_state != GRAB_AGGRESSIVE || stat != CONSCIOUS)
		return FALSE

	if(can_buckle_to_hand(M))
		buckle_to_hand_mob(M)
		return TRUE
	..(M, user)
// Перезапись взятия на плечо. Пердпроверка на трейт слабого тела. Если проверка пройдена, вызывает оригинальный проек.
/mob/living/carbon/human/fireman_carry(mob/living/carbon/target)
	if(!can_be_firemanned(target) || incapacitated(IGNORE_GRAB))
		to_chat(src, span_warning("You can't fireman carry [target] while [target.p_they()] [target.p_are()] standing!"))
		return

	if(HAS_TRAIT(src, TRAIT_WEAK_BODY))
		visible_message(span_warning("[src] tries to carry [target], but they are too heavy!"))
		return
	..(target)
// Перезапись взятия на спину. Предпроверка на наличие у человека трейта слабого тела и проверка на то, если ли этот трейт у того, кто берется на спину. Вызывает оригинальный прок.
/mob/living/carbon/human/piggyback(mob/living/carbon/target)
	if(!can_piggyback(target))
		to_chat(target, span_warning("You can't piggyback ride [src] right now!"))
		return

	if(HAS_TRAIT(src, TRAIT_WEAK_BODY) && !HAS_TRAIT(target, TRAIT_WEAK_BODY))
		target.visible_message(span_warning("[target] is too heavy for [src] to carry!"))
		return
	..(target)

/mob/living/carbon/human/proc/buckle_to_hand_mob(mob/living/carbon/target)
	if(!can_buckle_to_hand(target) || incapacitated(IGNORE_GRAB))
		to_chat(src, span_warning("You can't lift to hand [target] while [target.p_they()] [target.p_are()] standing!"))
		return

	var/carrydelay = 3 SECONDS
	if(HAS_TRAIT(src, TRAIT_QUICKER_CARRY) || has_quirk(/datum/quirk/oversized))
		carrydelay = 1 SECONDS
	else if(HAS_TRAIT(src, TRAIT_QUICK_CARRY))
		carrydelay = 2 SECONDS

	visible_message(span_notice("[src] starts lifting [target] onto their hand..."),
		span_notice("You start to lift [target] onto your hand..."))
	if(!do_after(src, carrydelay, target))
		visible_message(span_warning("[src] fails to lift to hand [target]!"))
		return

	if(!can_buckle_to_hand(target) || incapacitated(IGNORE_GRAB) || target.buckled)
		visible_message(span_warning("[src] fails to lift to hand [target]!"))
		return

	return buckle_mob(target, TRUE, TRUE, CARRIER_NEEDS_ARM)

/mob/living/carbon/human/proc/can_buckle_to_hand(mob/living/carbon/target)
	// Если мы имеем квирк овесайзед и цель - не имеет его. Возращаем истину.
	if(has_quirk(/datum/quirk/oversized) && !target.has_quirk(/datum/quirk/oversized))
		return TRUE
	// Если цель- человек и мы не имеем квирка слабого тела, и цель имеет квирк легкого тела, или трейт возможности взятия на руки, возращаем истину.
	else if((ishuman(target) && !HAS_TRAIT(src, TRAIT_WEAK_BODY)) &&  HAS_TRAIT(target, TRAIT_CAN_BUCKLED_TO_HAND))
		return TRUE
	return FALSE
