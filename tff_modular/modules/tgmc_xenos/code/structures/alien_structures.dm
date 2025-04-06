/// TGMC_XENOS (old nova sector xenos)

/obj/structure/alien/egg/tgmc
	child_path = /obj/item/clothing/mask/facehugger/tgmc

/obj/structure/alien/weeds/should_atmos_process(datum/gas_mixture/air, exposed_temperature)
	// Мы подняли температуру, при которой начинает наноситься урон до ~72 градусов. Иначе на какой-нибудь серенити просто атмос улицы будет убивать резину
	return exposed_temperature > 345
