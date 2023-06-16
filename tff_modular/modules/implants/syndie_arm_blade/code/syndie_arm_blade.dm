/obj/item/melee/implantsyndiearmblade
	name = "implanted blood-red mantis blade"
	desc = "A long, EXTREMELY sharp, blood-red mantis-like blade implanted in someones arm. Cleaves through flesh and iron like its weak butter."
	icon = 'tff_modular/modules/implants/syndie_arm_blade/icons/syndi_blade.dmi'
	righthand_file = 'tff_modular/modules/implants/syndie_arm_blade/icons/syndi_blade_righthand.dmi'
	lefthand_file = 'tff_modular/modules/implants/syndie_arm_blade/icons/syndi_blade_lefthand.dmi'
	icon_state = "syndi_mantis_blade"
	w_class = WEIGHT_CLASS_BULKY
	flags_1 = CONDUCT_1
	sharpness = SHARP_EDGED
	force = 35
	armour_penetration = 30
	item_flags = NEEDS_PERMIT
	hitsound = 'modular_skyrat/master_files/sound/weapons/bloodyslice.ogg'

/obj/item/organ/internal/cyberimp/arm/syndiearmblade
	name = "blood-red mantis blade implant"
	desc = "An blood-red integrated blade implant designed to be installed into a persons arm. Very stylish and ULTRA deadly."
	items_to_create = list(/obj/item/melee/implantsyndiearmblade)
	icon = 'tff_modular/modules/implants/syndie_arm_blade/icons/syndi_blade.dmi'
	icon_state = "syndi_mantis_blade"

/obj/item/autosurgeon/syndicate/syndiearmblade
	starting_organ = /obj/item/organ/internal/cyberimp/arm/syndiearmblade // Используется(или будет в будущем) только в синди- и опфор-бандлах
	uses = 2

/obj/item/autosurgeon/syndicate/psycho_kit
	name = "suspicious autosurgeon"
	icon_state = "autosurgeon_syndicate"
	surgery_speed = 0.75
	loaded_overlay = "autosurgeon_syndicate_loaded_overlay"
	uses = 6

/obj/item/storage/box/syndie_kit/imp_mantis
	name = "syndie armblade implants box"

/obj/item/storage/box/syndie_kit/imp_mantis/PopulateContents()
	new /obj/item/autosurgeon/syndicate/syndiearmblade(src)
	new /obj/item/organ/internal/cyberimp/arm/syndiearmblade(src)

/obj/item/storage/box/syndie_kit/psycho_kit
	name = "Cyberpsycho kit"

/obj/item/storage/box/syndie_kit/psycho_kit/PopulateContents()
	for(var/i in 1 to 2)
		new /obj/item/organ/internal/cyberimp/arm/syndiearmblade(src)
	new /obj/item/autosurgeon/syndicate/psycho_kit(src)

/datum/uplink_item/implants/mantisblade
	name = "Mantis Blades"
	desc = "Pair of deadly blood-red mantis blade implants, specially sharped and painted using Spider clan technologies. \
	ATTENTION: THERE'S NO AUTOSURGEON INSIDE BOX! FIND GOOD REAPER BEFORE PURCHASE!" // В стандартном общедоступном варианте идут парой, но их установка это уже головная боль антагониста.
	progression_minimum = 30 MINUTES
	item = /obj/item/storage/box/syndie_kit/imp_mantis
	cost = 14 // Возможно, надо будет поднять до 16, как альтернатива д-есворду, но колеблюсь из-за отсутствия у них автохирургов
	surplus = 10
	limited_stock = 1
	purchasable_from = ~UPLINK_CLOWN_OPS // Не доступно клоунской нюке

/datum/uplink_item/role_rkestricted/psycho_kit
	name = "Cyber-Psycho kit"
	desc = "Kit of blood-red mantis blades and autosurgeon for the craziest punks of this station. \
	ATTENTION: AUTOSURGEON HAVE 6 USES ONLY."
	progression_minimum = 30 MINUTES
	item = /obj/item/storage/box/syndie_kit/psycho_kit
	restricted_roles = list(JOB_ROBOTICIST, JOB_RESEARCH_DIRECTOR)
	cost = 25
	surplus = 1
	limited_stock = 1
	purchasable_from = ~UPLINK_CLOWN_OPS
