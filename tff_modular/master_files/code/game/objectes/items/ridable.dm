/obj/item/riding_offhand/pre_attack(atom/A, mob/living/user, params)
	if(!istype(A, /obj/item/storage/backpack/duffelbag) || !istesharialt(rider))
		..(A, user, params)

	// Начало кода отвечающего за укладывание сумку.
	var/obj/item/storage/backpack/duffelbag/bag = A
	var/mob/living/carbon/human/tesh = rider

	if(bag.contents.len > 0)
		user.balloon_alert(user, "No space!")
		return

	if(bag.zipped_up)
		return

	if(tesh.combat_mode == TRUE && !user.combat_mode != TRUE)
		user.balloon_alert(user, "[tesh.p_they()] didn't want!")
		return

	user.balloon_alert(user, "Statring puting to [bag.name]")
	if(!do_after(user, 3 SECONDS, user))
		user.balloon_alert(user, "Stand still!")
		return

	tesh.balloon_alert(tesh, "Moved to storage!")
	user.balloon_alert(user, "Succesful!")
	user.visible_message(span_notice("[user.name] put [tesh.name] intro the [bag.name]."), span_notice("You put [tesh.name] to the [bag.name]"))
	to_chat(tesh, span_warning("[user.name], put you to [bag.name]!"))
	// Для успешного бесшовного перемещения. В начале создаем холдер, перемещаем его на турф обьекта, и переносим райдера в него.
	var/obj/item/clothing/head/mob_holder/teshari/holder = new(get_turf(src), tesh, tesh.held_state, tesh.head_icon, tesh.held_lh, tesh.held_rh, tesh.worn_slot_flags)
	holder.holding_bag = bag
	holder.forceMove(bag)
	Destroy()

/obj/item/clothing/head/mob_holder/teshari
	// Сумка в которой мы сейчас находимся.
	var/obj/item/storage/backpack/duffelbag/holding_bag

/obj/item/clothing/head/mob_holder/teshari/on_exit_storage(datum/storage/master_storage)
	. = ..()
	//Никаких дополнительных действий - просто уничтожение.
	Destroy()

/obj/item/clothing/head/mob_holder/teshari/pickup(mob/user)
	. = ..()
	//Никакой логики. Просто к черту все.
	Destroy()

/obj/item/clothing/head/mob_holder/teshari/container_resist_act()
	if(!holding_bag.zipped_up)
		release()

	held_mob.balloon_alert(held_mob, "Begin unzipped")
	if(!do_after(held_mob, 10 SECONDS, held_mob))
		held_mob.balloon_alert(held_mob, "Stand still!")
		return

	held_mob.balloon_alert(held_mob, "Unzipped!")
	holding_bag.set_zipper(FALSE)
	release()

/obj/item/clothing/head/mob_holder/teshari/deposit(mob/living/L)
	. = ..()
	var/mob/living/carbon/human/tesh = held_mob
	tesh.become_blind(EYES_COVERED)
	// Возможно - это костыль. Но самый посто способ ограничить возможность положить что либо в сумку после.
	w_class = 30

/obj/item/clothing/head/mob_holder/teshari/relaymove(mob/living/user, direction)
	container_resist_act()

/obj/item/clothing/head/mob_holder/teshari/release(del_on_release, display_messages)
	var/mob/living/carbon/human/tesh = held_mob
	tesh.cure_blind(EYES_COVERED)
	tesh.clear_fullscreen("tint", 0 SECONDS)
	. = ..()

/obj/item/clothing/head/mob_holder/teshari/on_found(mob/finder)
	if(istesharialt(held_mob))
		return
	..()

