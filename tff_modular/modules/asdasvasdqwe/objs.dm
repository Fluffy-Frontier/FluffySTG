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

/obj/item/field_key
	icon_state = "access_key"
	inhand_icon_state = "access_key"
	icon = 'icons/obj/service/janitor.dmi'
	lefthand_file = 'icons/mob/inhands/items/keys_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/keys_righthand.dmi'
	hitsound = 'sound/items/rattling_keys_attack.ogg'

/obj/item/library_key
	name = "Ключ"
	icon_state = "access_key"
	inhand_icon_state = "access_key"
	icon = 'icons/obj/service/janitor.dmi'
	lefthand_file = 'icons/mob/inhands/items/keys_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/keys_righthand.dmi'
	hitsound = 'sound/items/rattling_keys_attack.ogg'

/obj/item/library_pass
	name = "Карта доступа"
	name = "door keycard"
	icon = 'icons/obj/fluff/puzzle_small.dmi'
	icon_state = "keycard"


/obj/item/notes/cave
	name = "Старые записки"
	desc = "Единственный путь наружу это завал в конце туннеля, а тележка со взрывчаткой - ключ к решению загадки"

/obj/item/notes/library_first
	name = "Старые записки"
	desc = "Эти статуи меня напрягают. Они будто связаны между собой... Будто они что-то сдерживают, но ломать их слишком опасно... точнее слишком громко... Может я найду другой путь отсюда."


/obj/item/notes/library_second
	name = "Старые записки"
	desc = "КТО БЫ ЭТО НЕ ЧИТАЛ, НЕ ОТКРЫВАЙ ЗАКРЫТУЮ ДВЕРЬ НА СЕВЕРЕ. ТЕБЕ НЕ НУЖНО ИСКАТЬ ДВА КЛЮЧА. НЕ ИЩИ В СТАРОЙ ПОДСОБКЕ ФАЛЬШИВУЮ СТЕНУ. ТЫ ПОНЯЛ ЭТО? НИЧЕГО НЕ ДЕЛАЙ ИЛИ ОНО УСЛЫШИТ ТЕБЯ!!!"


/obj/machinery/syndicatebomb
	icon = 'icons/obj/devices/assemblies.dmi'
	name = "syndicate bomb"
	icon_state = "syndicate-bomb"
