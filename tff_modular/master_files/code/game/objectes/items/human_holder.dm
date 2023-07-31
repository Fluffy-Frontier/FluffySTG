/obj/item/clothing/head/mob_holder/human
	// Сумка в которой мы сейчас находимся.
	var/obj/item/storage/backpack/holding_bag

/obj/item/clothing/head/mob_holder/human/on_exit_storage(datum/storage/master_storage)
	release()

/obj/item/clothing/head/mob_holder/human/container_resist_act()
	if(!istype(holding_bag, /obj/item/storage/backpack/duffelbag))
		release()
		return
	var/obj/item/storage/backpack/duffelbag/bag = holding_bag

	if(!bag.zipped_up)
		release()
		return

	if(!do_after(held_mob, 10 SECONDS, bag))
		held_mob.balloon_alert(held_mob, "Stand still!")
		return

	bag.set_zipper(FALSE)
	release()

/obj/item/clothing/head/mob_holder/human/deposit(mob/living/carbon/human/H, obj/item/storage/backpack/bag)
	. = ..()
	H.AddComponent(/datum/component/human_holder, holder = src, handle_human = H, handle_environment = TRUE)
	SEND_SIGNAL(H, COMSIG_HUMAN_ENTER_STORAGE, bag)
	holding_bag = bag

/obj/item/clothing/head/mob_holder/human/relaymove(mob/living/user, direction)
	held_mob.balloon_alert(held_mob, "Can't move!")
	return

/obj/item/clothing/head/mob_holder/human/release(del_on_release, display_messages)
	if(held_mob)
		SEND_SIGNAL(held_mob, COMSIG_HUMAN_EXIT_STORAGE, holding_bag)
	..(TRUE, FALSE)

/obj/item/clothing/head/mob_holder/human/on_found(mob/finder)
	if(HAS_TRAIT(held_mob, TRAIT_CAN_ENTER_BAG))
		return
	..()
