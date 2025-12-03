// Добавляем ДНК Манипулятор в карго (goodies) | adding DNA manipulator to cargo UI (goodies)
/datum/supply_pack/goody/plantgenes
	name = "Plant DNA manipulator kit"
	desc = "A kit for genetic engineering professionals.\
		Contains a flatpacked plant DNA manipulator, Disk compartmentalizer and a box of plant data disks."
	cost = PAYCHECK_CREW * 120
	access = ACCESS_HYDROPONICS
	contains = list(
		/obj/item/flatpack/plantgenes,
		/obj/item/flatpack/smartfridge/disks_tff,
		/obj/item/storage/box/disks_plantgene,
	)
