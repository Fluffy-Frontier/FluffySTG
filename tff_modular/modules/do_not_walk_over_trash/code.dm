// Чем больше значение, тем меньше предметов должно быть на полу для превышения порога
#define ITEM_BASE_DEGREE 1.5
// На сколько умножается общий вес вещей в рандоме
#define MAX_ITEMS_PER_TURF_PROB_MULTIPLYER 4
// Вес вещей, после которого нет смысла дальше сканировать клетку
#define MAX_ITEMS_PER_TURF (100/MAX_ITEMS_PER_TURF_PROB_MULTIPLYER)
// Минимальный вес вещей на клетке, чтобы можно было попытаться подскальзнуться
#define MIN_ITEMS_PER_TURF 10

/mob/living/carbon/human/Move(NewLoc, direct)
	. = ..()
	if(!istype(NewLoc, /turf/open) || istype(NewLoc, /turf/open/space))
		return

	var/turf/our_turf = NewLoc
	if(!our_turf.contents || length(our_turf.contents) <= 1)
		return

	var/number_of_items = 0
	for(var/obj/item/our_item in our_turf.contents)
		if(our_item.w_class)
			number_of_items += (ITEM_BASE_DEGREE**our_item.w_class)
		else
			number_of_items += 1
		if(number_of_items >= MAX_ITEMS_PER_TURF) // Дабы не расходовать вычислительные ресурсы
			break

	if(number_of_items >= MIN_ITEMS_PER_TURF && prob(number_of_items*MAX_ITEMS_PER_TURF_PROB_MULTIPLYER))
		slip(1 SECONDS, lube_flags = NO_SLIP_WHEN_WALKING)
