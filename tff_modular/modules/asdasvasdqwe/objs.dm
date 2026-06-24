/obj/item/casette
	icon = 'tff_modular/modules/asdasvasdqwe/structures/velvetfu.dmi'
	icon_state = "velvet_used"

/obj/item/notes
	name = "Блокнот с паролем"
	desc = "Привет. Ищешь что то? Может в следующем ивенте здесь будет подсказка."
	icon = 'tff_modular/modules/asdasvasdqwe/structures/toolabnormalities.dmi'
	icon_state = "notes"

/obj/item/ppai
	icon = 'tff_modular/modules/asdasvasdqwe/ship/aicardsradial.dmi'
	icon_state = "pai"

/obj/item/crowbar/pila
	icon = 'tff_modular/modules/asdasvasdqwe/ship/gear_packs.dmi'
	icon_state = "anglegrinder"
	inhand_icon_state = "rtd"

/obj/item/gem
	icon = 'tff_modular/modules/asdasvasdqwe/ship/gems.dmi'
	icon_state = "diamond"

/obj/item/a_la_pda
	icon = 'tff_modular/modules/asdasvasdqwe/ship/pda.dmi'
	icon_state = "pda"
	//-job

/obj/item/wreck_stuff
	desc = ""
	icon = 'tff_modular/modules/asdasvasdqwe/ship/salvage_structure.dmi'
	icon_state = "smetal"

/obj/item/wreck_stuff/metal
	name = "Обломок железа"

/obj/item/wreck_stuff/b
	name = "Кусок золотой детали"
	icon = 'tff_modular/modules/asdasvasdqwe/ship/salvage_structure.dmi'
	icon_state = "sgold"

/obj/item/wreck_stuff/c
	name = "Осколок плазмы"
	icon = 'tff_modular/modules/asdasvasdqwe/ship/salvage_structure.dmi'
	icon_state = "splasma"

/obj/item/wreck_stuff/d
	name = "Крупица урана"
	desc = "Погоди что."
	icon = 'tff_modular/modules/asdasvasdqwe/ship/salvage_structure.dmi'
	icon_state = "suranium"

/obj/item/wreck_stuff/e
	name = "Серебрянная деталь"
	icon = 'tff_modular/modules/asdasvasdqwe/ship/salvage_structure.dmi'
	icon_state = "ssilver"

/obj/item/wreck_stuff/f
	name = "Деталь из титаниума"
	icon = 'tff_modular/modules/asdasvasdqwe/ship/salvage_structure.dmi'
	icon_state = "stitanium"

/obj/item/wreck_stuff/g
	name = "Блюспейс деталь"
	icon = 'tff_modular/modules/asdasvasdqwe/ship/salvage_structure.dmi'
	icon_state = "sbluespace"





/obj/item/analyzer_event
	name = "Биодетектор"
	desc = "Сканер для поиска существ вокруг. Используйте его в руках, чтобы просканировать окружение."
	icon = 'icons/obj/devices/scanner.dmi'
	icon_state = "analyzer"
	inhand_icon_state = "analyzer"
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL

/obj/item/analyzer_event/attack_self(mob/user, modifiers)
	to_chat(user, "старт скана")
	if(locate(/mob/living/simple_animal/hostile) in oview(4, get_turf(src)))
		to_chat(user, "нашол")
	else
		to_chat(user, "не нашол")
