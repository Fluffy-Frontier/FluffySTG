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
		if(number_of_items >= 25) // Дабы не расходовать вычислительные ресурсы
			break

	if(number_of_items >= 10 && prob(number_of_items*4))
		slip(1 SECONDS, lube_flags = NO_SLIP_WHEN_WALKING)
