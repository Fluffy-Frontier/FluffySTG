GLOBAL_LIST_EMPTY(event_passwords)

/client

	var/death_count = 0

/mob/living/carbon/human/death(gibbed)
	if(!LAZYLEN(SSjob.firsto_randoms) || !client)
		return ..()

	var/area/my_area = get_area(src)
	if(istype(my_area, /area/event/sublocation/fun) && prob(80))
		revive(ADMIN_HEAL_ALL)
		return

	client.death_count++

	forceMove(pick(SSjob.sublocations[pizda(clamp(client.death_count, 1, 6))]))
	revive(ADMIN_HEAL_ALL)


/datum/job/special_researcher
	title = "Учёный"
	outfit = /datum/outfit/researcher

/datum/outfit/researcher

	id_trim = /datum/id_trim/job/scientist
	uniform = /obj/item/clothing/under/rank/rnd/scientist
	shoes = /obj/item/clothing/shoes/sneakers/random

/datum/job/popadanec
	title = "Гражданский"
	outfit = /datum/outfit/popadanec

/datum/outfit/popadanec
	id_trim = /datum/id_trim/job/assistant
	uniform = /obj/item/clothing/under/rank/civilian/curator
	l_pocket = /obj/item/food/sustenance_bar/wonka
	r_pocket = /obj/item/lighter
	shoes = /obj/item/clothing/shoes/sneakers/random

/obj/effect/landmark/latejoin_start

/obj/effect/landmark/latejoin_start/Initialize(mapload)
	. = ..()
	SSjob.latejoin_start += loc




/obj/effect/landmark/latejoin_post

/obj/effect/landmark/latejoin_post/Initialize(mapload)
	. = ..()
	SSjob.latejoin_post += loc


/obj/effect/landmark/latejoin_unlucky

/obj/effect/landmark/latejoin_unlucky/Initialize(mapload)
	. = ..()
	SSjob.latejoin_unlucky += loc



/obj/effect/landmark/sublocation_teleporter
	var/level = 1

/obj/effect/landmark/sublocation_teleporter/Initialize(mapload)
	. = ..()
	SSjob.sublocations[pizda(level)] += get_turf(src)



/obj/effect/step_trigger/firsto_random
	mobs_only = TRUE

/obj/effect/step_trigger/firsto_random/Initialize(mapload)
	SSjob.firsto_randoms += get_turf(src)
	return ..()

/obj/effect/step_trigger/firsto_random/Trigger(atom/movable/A)
	if(prob(25))
		A.forceMove(pick(SSjob.firsto_randoms))


/obj/effect/step_trigger/teleporter/offset/looped
	mobs_only = TRUE

/obj/effect/step_trigger/teleporter/offset/looped/Trigger(atom/movable/poor_soul)
	if(prob(70))
		return ..()
	else
		poor_soul.forceMove(pick(SSjob.return_points[pizda(SSjob.return_level)]))

/obj/effect/step_trigger/teleporter/returner
	mobs_only = TRUE

/obj/effect/step_trigger/teleporter/returner/Trigger(atom/movable/A)
	A.forceMove(pick(SSjob.return_points[pizda(SSjob.return_level)]))

/obj/effect/step_trigger/library_left
	mobs_only = TRUE
	var/offset_x = 0
	var/offset_y = 0

/obj/effect/step_trigger/library_left/Trigger(atom/movable/A)
	var/turf/target_turf = pick(SSjob.library_right)
	if(prob(10))
		A.forceMove(pick(SSjob.library_pre_exit))
	else
		A.forceMove(locate(target_turf.x + offset_x, target_turf.y + offset_y, target_turf.z))


/obj/effect/step_trigger/library_right
	mobs_only = TRUE
	var/offset_x = 0
	var/offset_y = 0

/obj/effect/step_trigger/library_right/Trigger(atom/movable/A)
	var/turf/target_turf = pick(SSjob.library_left)
	if(prob(10))
		A.forceMove(pick(SSjob.library_pre_exit))
	else
		A.forceMove(locate(target_turf.x + offset_x, target_turf.y + offset_y, target_turf.z))

/obj/effect/landmark/library_pre_exit


/obj/effect/landmark/library_pre_exit/Initialize(mapload)
	. = ..()

	SSjob.library_pre_exit += loc

/obj/effect/landmark/library_exit

/obj/effect/landmark/library_exit/Initialize(mapload)
	. = ..()

	SSjob.library_exit += loc


/obj/effect/landmark/return_point
	var/level = 0

/obj/effect/landmark/return_point/Initialize(mapload)
	. = ..()
	SSjob.return_points[pizda(level)] += get_turf(src)

ADMIN_VERB_AND_CONTEXT_MENU(onetwo_announce, R_DEBUG, "12nd_announce", "", ADMIN_CATEGORY_DEBUG)

	priority_announce("В случае обнаружения несоответствий в окружающей среде или поведении членов группы — немедленно зафиксируйте это и сохраняйте дистанцию.\n\
		Не делайте поспешных выводов!", "Исследовательский центр", 'tff_modular/modules/asdasvasdqwe/sounds/soundy/announce2.wav')

ADMIN_VERB_AND_CONTEXT_MENU(second_announce, R_DEBUG, "2nd_announce", "", ADMIN_CATEGORY_DEBUG)

	priority_announce("Переход зафиксирован.\n\
		Вы вошли в активную зону аномалии.\n\
		Показатели стабильности в пределах допустимых значений.\n\
		Продолжайте движение и фиксируйте любые отклонения.\n\n\
		Напоминаем: сохраняйте визуальный контакт с группой.", "Исследовательский центр")

ADMIN_VERB_AND_CONTEXT_MENU(third_announce, R_DEBUG, "3rd_announce", "", ADMIN_CATEGORY_DEBUG)
	priority_announce("Данные получены.\n\n\
		Обнаружены первые несоответствия в структуре пространства.\n\
		Это… ожидаемо.\n\
		Продолжайте движение.\n\
		Система рекомендует не разделяться.\n\n\
		…это повышает вероятность успешного продвижения.\n\n\
		Если вы уже разделились — восстановите контакт.", "Исследоwaтельский ценtr", 'tff_modular/modules/asdasvasdqwe/sounds/soundy/announce3.wav')

ADMIN_VERB_AND_CONTEXT_MENU(fourth_announce, R_DEBUG, "4th_announce", "", ADMIN_CATEGORY_DEBUG)
	priority_announce("Внимание экипаж!\n\n\
		Подтверждаю наличие… других форм активности.\n\
		И ещё кое-что.\n\
		В этой зоне будет… жарковато.\n\
		Температура там нестабильна, местами — значительно выше нормы.\n\
		Следите за окружением.\n\
		Не заходите в помещения, если не уверены.\n\
		Некоторые источники тепла…\n\n\
		…не являются естественными.\n\
		И если вам покажется, что за дверью слишком жарко — старайтесь не-", "Исследова..12ский цетr", 'tff_modular/modules/asdasvasdqwe/sounds/soundy/announce4.wav')

ADMIN_VERB_AND_CONTEXT_MENU(fifth_announce, R_DEBUG, "5th_announce", "", ADMIN_CATEGORY_DEBUG)
	priority_announce("Я… потерял часть ваших показателей.\n\
		Попробую восстановить.\n\
		Не задерживайтесь в этой зоне.\n\
		Холод и… давление здесь влияют не только на тело.\n\
		Если кто-то начинает вести себя иначе —\n\n\
		не игнорируйте это.", "Исследовательский центр", 'tff_modular/modules/asdasvasdqwe/sounds/soundy/announce5.wav')

ADMIN_VERB_AND_CONTEXT_MENU(sixth_announce, R_DEBUG, "6th_announce", "", ADMIN_CATEGORY_DEBUG)
	priority_announce("Стабильность частично восстановлена.\n\
		Обнаружены участки, имитирующие нормальную среду. Это не означает, что они безопасны.\n\
		Продолжайте движение.\n\
		Система…\n\n\
		…испытывает трудности с идентификацией.", "И55л!д-в4тельский ц3Htр", 'tff_modular/modules/asdasvasdqwe/sounds/soundy/announce6.wav')

ADMIN_VERB_AND_CONTEXT_MENU(seventh_announce, R_DEBUG, "7th_announce", "", ADMIN_CATEGORY_DEBUG)
	priority_announce("Внимание!\n\
		Зафиксированы… попытки взаимодействия с системой.\n\
		Они не были инициированы вами.\n\
		Ограничьте любые лишние действия.\n\
		Вас…\n\n\
		…слышат.", "Исследовательский центр", 'tff_modular/modules/asdasvasdqwe/sounds/soundy/announce7.wav')

ADMIN_VERB_AND_CONTEXT_MENU(eighth_announce, R_DEBUG, "8th_announce", "", ADMIN_CATEGORY_DEBUG)
	priority_announce("Финальный участок маршрута достигнут.\n\
		Проверка близка к завершению.\n\
		Система сопоставляет полученные данные.\n\
		Продолжайте движение.\n\
		Не останавливайтесь.", "Исследовательский центр", 'tff_modular/modules/asdasvasdqwe/sounds/soundy/announce8.wav')

ADMIN_VERB_AND_CONTEXT_MENU(nineth_announce, R_DEBUG, "9th_announce", "", ADMIN_CATEGORY_DEBUG)
	priority_announce("Переход завершён.\n\
		Вы вернулись.\n\
		Проверка завершена.\n\
		Результаты… не определены.\n\n\
		Может потребоваться повторная проверка.", "Исследовательский центр", 'tff_modular/modules/asdasvasdqwe/sounds/soundy/announce9.wav')



ADMIN_VERB_AND_CONTEXT_MENU(set_passwords, R_DEBUG, "0set_passwords", "", ADMIN_CATEGORY_DEBUG)
	var/index = 1
	var/area/old
	for(var/atom/a in GLOB.event_passwords)
		var/area/current = get_area(a)
		if(istype(current, old))
			index++
		else
			index = 1
		old = current
		var/mob/player = user.mob
		player.forceMove(get_turf(a))
		var/input = tgui_input_text(user, "ХЫХ", "Ввод паролей", encode = FALSE)

		if(input)
			a.desc += input

ADMIN_VERB_AND_CONTEXT_MENU(return_level, R_DEBUG, "0return_level", "", ADMIN_CATEGORY_DEBUG)
	if(SSjob.return_level < 6)
		SSjob.return_level++
	else
		to_chat(user, "max")

/proc/pizda(level)
	switch(level)
		if(0)
			return "a"
		if(1)
			return "b"
		if(2)
			return "c"
		if(3)
			return "d"
		if(4)
			return "e"
		if(5)
			return "f"
		if(6)
			return "g"

/obj/effect/step_trigger/finall
	mobs_only = TRUE

/obj/effect/step_trigger/finall/Initialize(mapload)
	new /obj/effect/event_smoke(get_turf(src))
	return ..()

/obj/effect/step_trigger/finall/Trigger(atom/movable/A)
	A.forceMove(pick(SSjob.library_exit))
