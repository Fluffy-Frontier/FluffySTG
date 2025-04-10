/mob/living/carbon/human/Move(NewLoc, direct)
	. = ..()
	if(!istype(NewLoc, /turf/open))
		return

	var/turf/our_turf = NewLoc
	if(!our_turf.contents || length(our_turf.contents) <= 1)
		return

	var/number_of_items = 0
	for(var/obj/item/our_item in our_turf.contents):
		if(our_item.w_class)
			number_of_items += (1.5**our_item.w_class)
		else
			number_of_items += 1
		if(number_of_items >= 16) // Дабы не расходовать вычислительные ресурсы
			break

	if(number_of_items >= 16) // 16 lighters, cards, vapes OR 6-9 engitools, organs OR 5 fire extinguishers, sheets OR 4 backpacks OR 3 big weapons
		slip(1 SECONDS, lube_flags = NO_SLIP_WHEN_WALKING)
