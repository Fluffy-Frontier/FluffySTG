// Блокируем эффект аномалий, если у а номалии есть трейт TRAIT_UNDER_SUPRESSION
/obj/effect/anomaly/process(seconds_per_tick)
	if(HAS_TRAIT(src, TRAIT_UNDER_SUPRESSION))
		return
	return ..()
