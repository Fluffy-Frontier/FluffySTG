/// TFF MODULAR - Улучшения вскрытия - Хуки для дополнительной информации вскрытия

/**
 * Генерирует секцию анализа причины смерти
 * Возвращает строку для вставки в отчет вскрытия после базовой информации
 */
/obj/item/autopsy_scanner/proc/generate_cause_of_death_analysis(mob/living/carbon/scanned)
	var/oxy_loss = scanned.getOxyLoss()
	var/tox_loss = scanned.getToxLoss()
	var/fire_loss = scanned.getFireLoss()
	var/brute_loss = scanned.getBruteLoss()

	// Собираем информацию об оружии из ран
	var/most_severe_weapon = null
	var/highest_severity = 0
	for(var/zone in scanned.get_all_limbs())
		var/obj/item/bodypart/limb = scanned.get_bodypart(zone)
		if(isnull(limb))
			continue
		for(var/datum/wound/wound as anything in limb.wounds)
			if(wound.wound_source && wound.wound_source != "Unknown" && wound.severity > highest_severity)
				most_severe_weapon = wound.wound_source
				highest_severity = wound.severity

	var/list/death_causes = list()

	// Проверка на самоубийство
	if(HAS_TRAIT(scanned, TRAIT_SUICIDED))
		death_causes += "Suicide[scanned.suicide_method ? " ([scanned.suicide_method])" : ""]"

	// Проверка уровня повреждений с указанием вероятного оружия
	if(brute_loss >= 100)
		var/weapon_text = most_severe_weapon ? ", likely from <b>[most_severe_weapon]</b>" : ""
		death_causes += "Severe Physical Trauma ([brute_loss] brute damage[weapon_text])"
	if(fire_loss >= 100)
		var/weapon_text = most_severe_weapon ? ", likely from <b>[most_severe_weapon]</b>" : ""
		death_causes += "Severe Burn Trauma ([fire_loss] burn damage[weapon_text])"
	if(tox_loss >= 100)
		death_causes += "Severe Toxin Exposure ([tox_loss] toxin damage)"
	if(oxy_loss >= 100)
		death_causes += "Asphyxiation ([oxy_loss] suffocation damage)"

	// Проверка на обезвоживание
	if(HAS_TRAIT(scanned, TRAIT_HUSK))
		if(HAS_TRAIT_FROM(scanned, TRAIT_HUSK, BURN))
			death_causes += "Husked by Severe Burns"
		else if (HAS_TRAIT_FROM(scanned, TRAIT_HUSK, CHANGELING_DRAIN))
			death_causes += "Desiccation (Suspected Changeling Activity)"
		else
			death_causes += "Husked (Unknown Cause)"

	// Проверка потери крови
	if(scanned.blood_volume <= BLOOD_VOLUME_OKAY)
		var/weapon_text = most_severe_weapon ? ", likely from <b>[most_severe_weapon]</b>" : ""
		death_causes += "Severe Blood Loss ([scanned.blood_volume]cl remaining[weapon_text])"

	if(!length(death_causes))
		return ""

	. = "<u><b>Cause of Death Analysis:</b></u></br>"
	. += "<b>Probable causes:</b></br>"
	for(var/cause in death_causes)
		. += "&rdsh; [cause]</br>"
	. += "<hr>"

/**
 * Генерирует сводку источников урона из ран
 * Возвращает строку для добавления после таблицы повреждений тела
 */
/obj/item/autopsy_scanner/proc/generate_damage_source_summary(mob/living/carbon/scanned)
	var/list/wound_sources = list()
	var/list/embedded_items = list()

	for(var/zone in scanned.get_all_limbs())
		var/obj/item/bodypart/limb = scanned.get_bodypart(zone)
		if(isnull(limb))
			continue

		// Отслеживаем источники ран
		for(var/datum/wound/wound as anything in limb.wounds)
			if(wound.wound_source && wound.wound_source != "Unknown")
				if(!wound_sources[wound.wound_source])
					wound_sources[wound.wound_source] = list("count" = 0, "severity" = wound.severity, "zones" = list())
				wound_sources[wound.wound_source]["count"]++
				wound_sources[wound.wound_source]["zones"] |= capitalize(limb.plaintext_zone)
				// Отслеживаем наивысшую степень тяжести
				if(wound.severity > wound_sources[wound.wound_source]["severity"])
					wound_sources[wound.wound_source]["severity"] = wound.severity

		// Отслеживаем застрявшие предметы
		for(var/obj/item/embed as anything in limb.embedded_objects)
			embedded_items[embed.name] = capitalize(limb.plaintext_zone)

	if(!length(wound_sources) && !length(embedded_items))
		return ""

	. = "</br><u><b>Damage Source Summary:</b></u></br>"

	if(length(wound_sources))
		. += "<b>Weapons/sources identified:</b></br>"
		for(var/source in wound_sources)
			var/list/source_data = wound_sources[source]
			var/severity_text = ""
			switch(source_data["severity"])
				if(WOUND_SEVERITY_CRITICAL)
					severity_text = " (<font color='red'><b>Critical</b></font>)"
				if(WOUND_SEVERITY_SEVERE)
					severity_text = " (<font color='orange'><b>Severe</b></font>)"
				if(WOUND_SEVERITY_MODERATE)
					severity_text = " (Moderate)"

			var/zones_text = english_list(source_data["zones"])
			. += "&rdsh; <b>[source]</b>[severity_text]: [source_data["count"]] wound\s on [zones_text]</br>"

	if(length(embedded_items))
		. += "<b>Foreign objects still embedded:</b></br>"
		for(var/item_name in embedded_items)
			. += "&rdsh; <b>[item_name]</b> in [embedded_items[item_name]]</br>"

/**
 * Генерирует секцию информации о самоубийстве
 * Возвращает строку для вставки перед данными о болезнях
 */
/obj/item/autopsy_scanner/proc/generate_suicide_info(mob/living/carbon/scanned)
	if(!HAS_TRAIT(scanned, TRAIT_SUICIDED))
		return ""

	. = "<u><b>Suicide Detected:</b></u></br>"
	if(scanned.suicide_method)
		. += "<b>Method used:</b> [scanned.suicide_method]</br>"
	else
		. += "<b>Method:</b> Unknown (subject committed suicide)</br>"

	// Отображаем информацию о повреждениях
	if(scanned.suicide_damage_type)
		. += "<b>Damage dealt by suicide:</b></br>"
		var/damage_per_type = scanned.maxHealth * 2 // Общий урон равен 2x макс. здоровья
		var/damage_types_count = 0

		// Считаем количество типов урона
		for(var/type in list(BRUTELOSS, FIRELOSS, OXYLOSS, TOXLOSS))
			if(scanned.suicide_damage_type & type)
				damage_types_count++

		if(damage_types_count > 0)
			damage_per_type = damage_per_type / damage_types_count

		// Отображаем каждый тип урона
		if(scanned.suicide_damage_type & BRUTELOSS)
			. += "&rdsh; <b>Brute Damage:</b> [round(damage_per_type)] points</br>"
		if(scanned.suicide_damage_type & FIRELOSS)
			. += "&rdsh; <b>Burn Damage:</b> [round(damage_per_type)] points</br>"
		if(scanned.suicide_damage_type & TOXLOSS)
			. += "&rdsh; <b>Toxin Damage:</b> [round(damage_per_type)] points</br>"
		if(scanned.suicide_damage_type & OXYLOSS)
			. += "&rdsh; <b>Suffocation Damage:</b> [round(damage_per_type)] points</br>"

	. += "<hr>"

