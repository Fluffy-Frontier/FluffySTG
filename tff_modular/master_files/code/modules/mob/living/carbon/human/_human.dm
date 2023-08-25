/mob/living/carbon/human/is_shove_knockdown_blocked()
	if(HAS_TRAIT(src, TRAIT_KNOCKDOWN_IMMUNE))
		return TRUE
	..()

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

/**
 * try_put_to_bag() - Попытка зайти в сумку.
 *
 * forced - если истина, то src, входи с сумку не по своей воле.
 * bag - сумка в которую мы пытаемся залезть.
 * shoving - тот, кто засовывает нас в сумку.
 *
 * Если forced && shoving присудствуют. Выполняем proc/try_put_to_bag_other(), что переадресует сообщения.
 */
/mob/living/carbon/human/proc/try_put_to_bag(obj/item/storage/backpack/bag, forced = FALSE, mob/shoving)
	if(forced && shoving)
		return try_put_to_bag_other(bag, shoving)

	if(!can_enter_bag(bag, src))
		return FALSE

	visible_message(span_notice("[name], starts getting into [bag.name]."), span_notice("You start getting into [bag.name]"))
	if(!do_after(src, 3 SECONDS, bag))
		src.balloon_alert(src, "Stand still!")
		return FALSE

	visible_message(span_notice("[name], got into [bag.name]. "), span_notice("You got into [bag.name]"))
	put_to_bag(bag)
	return TRUE

/mob/living/carbon/human/proc/try_put_to_bag_other(obj/item/storage/backpack/bag, mob/shoving)
	if(!can_enter_bag(bag, shoving))
		return FALSE

	shoving.visible_message(span_notice("[shoving.name] starts shoving [name] into [bag.name]."), span_notice("You start shoving [name] into the [bag.name]"))
	if(!do_after(shoving, 3 SECONDS, bag))
		shoving.balloon_alert(shoving, "Stand still!")
		return FALSE

	shoving.visible_message(span_notice("[shoving.name] shoved [name] into [bag.name]."), span_notice("You shoved [name] into the [bag.name]"))
	put_to_bag(bag)
	return TRUE

// Актуально перемещаемся в сумку.
/mob/living/carbon/human/proc/put_to_bag(obj/item/storage/backpack/bag)
	if(!can_enter_bag(bag, src))
		return

	if(istype(bag.atom_storage, /datum/storage/bag_of_holding))
		for(var/obj/item/i in src.contents)
			if((istype(i, /obj/item/storage/backpack/holding) && !drop_all_held_items()) || istype(back, /obj/item/storage/backpack/holding))
				visible_message(span_danger("Reality tears [name] from the inside out. "), span_userdanger("Reality is ripping you apart from the inside out!"))
				gib(FALSE, TRUE, TRUE)
				return

	var/obj/item/clothing/head/mob_holder/human/holder = new(get_turf(src), src, held_state, head_icon, held_lh, held_rh, worn_slot_flags)
	drop_all_held_items()
	holder.holding_bag = bag
	holder.forceMove(bag)

/mob/living/carbon/human/proc/can_enter_bag(obj/item/storage/backpack/bag, mob/viewer)
	if(!HAS_TRAIT(src, TRAIT_CAN_ENTER_BAG))
		viewer.balloon_alert(viewer, "Too big!")
		return FALSE

	//Если у нас каким-то образом есть этот трейт.. вместь с возможность влазить в сумку -,-
	if(HAS_TRAIT(src, TRAIT_OVERSIZED))
		viewer.balloon_alert(viewer, "Too big!")
		return FALSE

	//Если сумка и так у нас в руках.
	if(bag.loc == src)
		return FALSE

	//Если нас пытаются положить не в БС сумку, выполняем дополнительную проверку..
	if(!istype(bag, /obj/item/storage/backpack/holding))
		//Есть ли что-нибудь на нашей спине.(рюкзаки/оружие/прочее)
		if(back)
			viewer.balloon_alert(viewer, "[back.name] is on the way!")
			return FALSE

	if(bag.atom_storage)

		//Рюкзаки, сатчелы и все, что меньше.
		if(bag.atom_storage.max_total_storage < 20)
			viewer.balloon_alert(viewer, "Too small!")
			return FALSE

		if(bag.atom_storage.max_specific_storage < WEIGHT_CLASS_HUGE && !istype(bag, /obj/item/storage/backpack/duffelbag))
			viewer.balloon_alert(viewer, "Too small!")
			return FALSE

		var/obj/item/blank = new()
		blank.w_class = WEIGHT_CLASS_HUGE
		// Пустышка для теста будет меньше, если мы хотим переместиться в дуфельбаг, если там уже кто-то не лежит.
		if(istype(bag, /obj/item/storage/backpack/duffelbag))
			var/obj/item/storage/backpack/duffelbag/d = bag
			blank.w_class = WEIGHT_CLASS_NORMAL
			if(d.zipped_up)
				blank.Destroy()
				viewer.balloon_alert(viewer, "Closed")
				return FALSE

			for(var/thing in d.contents)
				if(!istype(thing, /obj/item/clothing/head/mob_holder/human))
					continue
				blank.w_class++

		if(!bag.atom_storage.can_insert(blank, src, FALSE))
			blank.Destroy()
			viewer.balloon_alert(viewer, "No space!")
			return FALSE

		blank.Destroy()
		return TRUE

	viewer.balloon_alert(src, "Can't hold any!")
	return FALSE
