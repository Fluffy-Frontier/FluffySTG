/obj/item/storage/backpack/duffelbag/super_medik
	name = "medical technician kit"
	desc = "A large duffel bag for holding extra medical supplies."
	icon_state = "duffel-medical"
	inhand_icon_state = "duffel-med"

/obj/item/storage/backpack/duffelbag/super_medik/PopulateContents()
	var/static/items_inside = list(
		/obj/item/storage/box/survival/medical = 1,
		/obj/item/clothing/mask/gas/sechailer/clown/bocheche = 1,
		/obj/item/gun/ballistic/automatic/smg/cobra/indie = 1,
		/obj/item/ammo_box/magazine/m45_cobra = 3,
		/obj/item/storage/medkit/tactical/premium = 2,
		/obj/item/gun/medbeam = 1,
	)
	generate_items_inside(items_inside,src)



/obj/item/storage/backpack/duffelbag/super_shit_s_drobowikom
	name = "armored shotgun kit"
	desc = "A large duffel bag for holding defence items."
	icon_state = "duffel-syndie"
	inhand_icon_state = "duffel-syndie"

/obj/item/storage/backpack/duffelbag/super_shit_s_drobowikom/PopulateContents()
	var/static/items_inside = list(
		/obj/item/storage/box/survival/security = 1,
		/obj/item/gun/ballistic/shotgun/automatic/m11 = 1,
		/obj/item/ammo_box/advanced/s12gauge = 3,
		/obj/item/shield/ballistic = 2,
	)
	generate_items_inside(items_inside,src)



/obj/item/storage/backpack/duffelbag/super_bulldogzer
	name = "tactical annihilation bag"
	desc = "A large duffel bag for holding extra powerful shotgun."
	icon_state = "duffel-syndie"
	inhand_icon_state = "duffel-syndieammo"


/obj/item/storage/backpack/duffelbag/super_bulldogzer/PopulateContents()
	var/static/items_inside = list(
		/obj/item/storage/box/survival/security = 1,
		/obj/item/gun/ballistic/shotgun/automatic/bulldog/drum = 1,
		/obj/item/ammo_box/magazine/m12g_bulldog/drum = 3,
	)
	generate_items_inside(items_inside,src)



/obj/item/storage/backpack/duffelbag/super_machinedozer
	name = "machinegun bag"
	desc = "A large duffel bag for holding machineguns."
	icon_state = "duffel-syndie"
	inhand_icon_state = "duffel-syndieammo"

/obj/item/storage/backpack/duffelbag/super_machinedozer/PopulateContents()
	var/static/items_inside = list(
		/obj/item/storage/box/survival/security = 1,
		/obj/item/gun/ballistic/automatic/hmg/cm40 = 1,
		/obj/item/ammo_box/magazine/cm40_762_40_box = 4,
	)
	generate_items_inside(items_inside,src)



/obj/item/storage/backpack/duffelbag/super_cloaker
	name = "tactical pistol kit"
	desc = "A large duffel bag for holding such a small pistol."
	icon_state = "duffel-security"
	inhand_icon_state = "duffel-sec"

/obj/item/storage/backpack/duffelbag/super_cloaker/PopulateContents()
	var/static/items_inside = list(
		/obj/item/gun/ballistic/automatic/pistol/asp = 1,
		/obj/item/ammo_box/magazine/m57_39_asp = 5,
	)
	generate_items_inside(items_inside,src)



//MASKI

/obj/item/clothing/mask/gas/sechailer/clown/bocheche
	name = "\improper Medik Gasmask"
	desc = ""
	icon = 'modular_nova/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/mask.dmi'
	icon_state = "hecu"
	worn_icon_state = "hecu"
	unique_death = 'sound/machines/cryo_warning.ogg'
	var/list/sound_strings = list(
		"youre_good",
		"patchedup",
		"pain_is_real",
		"live",
		"insult",
		"help",
		"flies",
		"forgive",
	)

	unique_text = list(
		"НАХУЙ С ПЛЯЖА!",
		"Срочники ебаные.",
		"Если кровь уже пролита, то и тварь нужно добить",
		"Ты серьезно считаешь это боевым ранением?!",
		"Поливайте их огнем, ребята!",
		"Вставай и сражайся!",
		"Мне можно верить, дружище!",
		"Не плачь, я уже здесь.",
		"Присмотрю за ранеными!",
		"Снова в строю!",
		"Кровь за кровь!",
	)

/obj/item/clothing/mask/gas/sechailer/clown/bocheche/play_sound_eff()
	playsound(src, "sound/mobs/non-humanoids/medbot/[pick(sound_strings)].ogg", 100, FALSE, 4)
	return

/obj/item/clothing/mask/gas/sechailer/clown/dozer
	name = "\improper Dozerman Gasmask"
	desc = ""
	icon_state = "spacepol"
	worn_icon_state = "spacepol"
	unique_death = 'sound/items/hair-clippers.ogg'
	unique_text = list(
		"Не путайся под ногами.",
		"Ты ничто для меня",
		"Кому кусочек звиздюлей?",
		"Пора отправить тебя в пекло!",
		"Их всего четверо?! ХА!",
		"Молитесь, пока у вас есть на это время!",
		"ТЫ В ДЕРЬМЕ!",
		"БУМ!",
		"СДООООООООООХНИИИИИИИИИИИ",
		"Это меня не остановит!",
	)

/obj/item/clothing/mask/gas/sechailer/clown/dozer/play_sound_eff()
	playsound(src, "sound/runtime/complionator/stfu.ogg", 100, FALSE, 4)
	return

/obj/item/clothing/mask/gas/sechailer/clown/machinedozer
	name = "\improper Machinegunner Gasmask"
	desc = ""
	icon = 'modular_nova/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/mask.dmi'
	icon_state = "hecu"
	worn_icon_state = "hecu"
	unique_text = list(
		"РАТАТАТАТАТАТААТТА!",
		"МНЕ НУЖНЫ ПАТРОНЫ!",
		"ЗАДАВИМ ИХ ГРАДОМ ИЗ СВИНЦА, ТОВАРИЩИ!",
		"КАКИЕ МАЛЕНЬКИЕ ПУШКИ, НА МЫШЕЙ ОХОТИТЕСЬ?",
		"ЭТО БЫЛО ЩЕКОТНО!",
		"Я ГРОМКИЙ? ЭТО ТЫ СЛИШКОМ ТИХИЙ!",
		"ТЕБЕ НЕКУДА БЕЖАТЬ ОТ МОЕГО ПУЛЕМЕТА!",
		"ПРОЧЬ С ДОРОГИ, МЕЛЮЗГА!",
		"Я СКАЗАЛ ВСТАВАЙ, СУКА!",
		"ПОПЛАЧЬ ОБ ЭТОМ ПОЗЖЕ.",
		"А Я ГОВОРИЛ ТЫ СДОХНЕШЬ.",
		"Я УБЬЮ ТЕБЯ, ХОЧЕШЬ ТЫ ТОГО ИЛИ НЕТ!",
	)

/obj/item/clothing/mask/gas/sechailer/clown/machinedozer/play_sound_eff()
	playsound(src, "sound/runtime/complionator/harry.ogg", 100, FALSE, 4)
	return

/obj/item/clothing/mask/gas/sechailer/clown/shield
	name = "\improper Shieldman Gasmask"
	desc = ""
	icon_state = "hunter"
	worn_icon_state = "hunter"
	unique_death = 'sound/mobs/non-humanoids/repairbot/strings.ogg'
	unique_text = list(
		"Возьми калибр побольше!",
		"Я твой щит, а ты мой ствол!",
		"Задавим их!",
		"Прикрываю!",
		"Не пробьешь!",
		"Стою на страже!",
	)

/obj/item/clothing/mask/gas/sechailer/clown/shield/play_sound_eff()
	playsound(src, "sound/runtime/complionator/asshole.ogg", 100, FALSE, 4)
	return

/obj/item/clothing/mask/gas/sechailer/clown/cloaker
	name = "\improper Cloaker Gasmask"
	desc = ""
	icon = 'modular_nova/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/mask.dmi'
	icon_state = "hecu"
	worn_icon_state = "hecu"
	unique_death = 'sound/misc/scary_horn.ogg'
	unique_text = list(
		"БЕГИ, КЛОУН, БЕГИ!",
		"А сейчас твое лицо встретится с моим ботинком!",
		"Купи слуховой аппарат, старикан!",
		"Это маски или все же ваши настоящие лица, клоуны?",
		"Старайся лучше!",
		"ЗАЖДАЛИСЬ, ",
		"Радикальное задержание? Тебе кажется!",
		"Ходи и оглядывайся, сосунок.",
	)

/obj/item/clothing/mask/gas/sechailer/clown/cloaker/play_sound_eff()
	playsound(src, "sound/items/megaphone.ogg", 100, FALSE, 4)
	return
