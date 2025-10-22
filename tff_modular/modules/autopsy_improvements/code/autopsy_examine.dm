/// TFF MODULAR - Улучшения вскрытия - Examine трупа для коронеров

/mob/living/carbon
	var/list/autopsied_by_coroners

/datum/surgery_step/autopsy/success(mob/living/user, mob/living/carbon/target, target_zone, obj/item/autopsy_scanner/tool, datum/surgery/surgery, default_display_results = FALSE)
	. = ..()
	if(HAS_MIND_TRAIT(user, TRAIT_ENTRAILS_READER))
		LAZYSET(target.autopsied_by_coroners, REF(user), TRUE)
		to_chat(user, span_notice("Вы провели тщательное вскрытие и теперь можете определить причину смерти при осмотре трупа."))

/mob/living/carbon/examine(mob/user)
	. = ..()

	if(stat != DEAD || !HAS_TRAIT(src, TRAIT_DISSECTED))
		return

	if(!HAS_MIND_TRAIT(user, TRAIT_ENTRAILS_READER) && !isobserver(user))
		return

	if(!LAZYACCESS(autopsied_by_coroners, REF(user)))
		return

	. += span_notice("<i>Основываясь на вашем вскрытии:</i>")

	var/oxy_loss = getOxyLoss()
	var/tox_loss = getToxLoss()
	var/fire_loss = getFireLoss()
	var/brute_loss = getBruteLoss()

	// Находим самое тяжелое оружие для краткого описания
	var/most_severe_weapon = null
	var/highest_severity = 0
	for(var/zone in get_all_limbs())
		var/obj/item/bodypart/limb = get_bodypart(zone)
		if(isnull(limb))
			continue
		for(var/datum/wound/wound as anything in limb.wounds)
			if(wound.wound_source && wound.wound_source != "Unknown" && wound.severity > highest_severity)
				most_severe_weapon = wound.wound_source
				highest_severity = wound.severity

	var/list/injuries = list()

	// Описательные термины БЕЗ точных цифр
	if(HAS_TRAIT(src, TRAIT_SUICIDED))
		var/method_text = suicide_method ? " using [suicide_method]" : ""
		injuries += span_deadsay("died by <b>suicide</b>[method_text]")

	if(brute_loss >= 100)
		var/weapon_text = most_severe_weapon ? " from <b>[most_severe_weapon]</b>" : ""
		injuries += span_warning("severe physical trauma[weapon_text]")
	else if(brute_loss >= 50)
		injuries += span_warning("significant bruising")

	if(fire_loss >= 100)
		var/weapon_text = most_severe_weapon ? " from <b>[most_severe_weapon]</b>" : ""
		injuries += span_warning("severe burns[weapon_text]")
	else if(fire_loss >= 50)
		injuries += span_warning("extensive burns")

	if(tox_loss >= 100)
		injuries += span_warning("severe toxin exposure")
	else if(tox_loss >= 50)
		injuries += span_warning("moderate toxin exposure")

	if(oxy_loss >= 100)
		injuries += span_warning("fatal asphyxiation")
	else if(oxy_loss >= 50)
		injuries += span_warning("oxygen deprivation")

	if(HAS_TRAIT(src, TRAIT_HUSK))
		injuries += span_danger("body is husked")

	if(blood_volume <= BLOOD_VOLUME_OKAY)
		injuries += span_danger("severe blood loss")

	if(length(injuries))
		. += span_notice("• [english_list(injuries, and_text = ", ")].")

	. += span_notice("<i>(Shift+Click для детального анализа)</i>")

/// Shift+Click для подробного анализа причины смерти
/mob/living/carbon/examine_more(mob/user)
	. = ..()

	// Только для трупов после вскрытия
	if(stat != DEAD || !HAS_TRAIT(src, TRAIT_DISSECTED))
		return

	// Только для тех у кого есть навык чтения внутренностей
	if(!HAS_MIND_TRAIT(user, TRAIT_ENTRAILS_READER) && !isobserver(user))
		return

	// Только если проводил вскрытие
	if(!LAZYACCESS(autopsied_by_coroners, REF(user)))
		return

	. += span_notice("<b><u>Детальный анализ причины смерти:</u></b>")

	var/oxy_loss = getOxyLoss()
	var/tox_loss = getToxLoss()
	var/fire_loss = getFireLoss()
	var/brute_loss = getBruteLoss()
	var/total_damage = oxy_loss + tox_loss + fire_loss + brute_loss

	// ======= ОБЩЕЕ СОСТОЯНИЕ =======
	. += span_notice("─────────────────────────────")
	. += span_notice("<b><u>Общее состояние:</u></b>")

	// Описательные термины вместо цифр
	if(brute_loss >= 100)
		. += span_danger("  • Physical trauma: <b>Severe</b>")
	else if(brute_loss >= 50)
		. += span_warning("  • Physical trauma: <b>Significant</b>")
	else if(brute_loss > 0)
		. += span_info("  • Physical trauma: Minor")

	if(fire_loss >= 100)
		. += span_danger("  • Burns: <b>Severe</b>")
	else if(fire_loss >= 50)
		. += span_warning("  • Burns: <b>Extensive</b>")
	else if(fire_loss > 0)
		. += span_info("  • Burns: Minor")

	if(tox_loss >= 100)
		. += span_danger("  • Toxin exposure: <b>Severe</b>")
	else if(tox_loss >= 50)
		. += span_warning("  • Toxin exposure: <b>Moderate</b>")
	else if(tox_loss > 0)
		. += span_info("  • Toxin exposure: Minor")

	if(oxy_loss >= 100)
		. += span_danger("  • Asphyxiation: <b>Fatal</b>")
	else if(oxy_loss >= 50)
		. += span_warning("  • Asphyxiation: <b>Moderate</b>")
	else if(oxy_loss > 0)
		. += span_info("  • Asphyxiation: Minor")

	// ======= УРОН ПО ЧАСТЯМ ТЕЛА =======
	. += span_notice("─────────────────────────────")
	. += span_notice("<b><u>Повреждения по частям тела:</u></b>")

	for(var/zone in get_all_limbs())
		var/obj/item/bodypart/limb = get_bodypart(zone)
		if(isnull(limb))
			. += span_danger("• <b>[capitalize(parse_zone(zone))]:</b> DISMEMBERED")
			continue

		var/limb_brute = limb.brute_dam
		var/limb_burn = limb.burn_dam

		if(limb_brute > 0 || limb_burn > 0 || length(limb.wounds))
			var/damage_desc = ""

			// Описательные термины для конечности
			if(limb_brute >= 50 || limb_burn >= 50)
				damage_desc = span_danger("Severely damaged")
			else if(limb_brute >= 20 || limb_burn >= 20)
				damage_desc = span_warning("Moderately damaged")
			else if(limb_brute > 0 || limb_burn > 0)
				damage_desc = "Lightly damaged"

			if(damage_desc)
				. += span_info("• <b>[capitalize(limb.name)]:</b> [damage_desc]")

			// Показываем раны на этой конечности
			for(var/datum/wound/wound as anything in limb.wounds)
				var/severity_text = ""
				switch(wound.severity)
					if(WOUND_SEVERITY_CRITICAL)
						severity_text = span_danger("CRITICAL")
					if(WOUND_SEVERITY_SEVERE)
						severity_text = span_warning("SEVERE")
					if(WOUND_SEVERITY_MODERATE)
						severity_text = "Moderate"
				. += span_info("    ─ [wound.name] ([severity_text]) from <b>[wound.wound_source]</b>")

	// Шанс ошибиться в анализе если урон > 200 (до 15% при очень высоком уроне)
	var/analysis_error = FALSE
	if(total_damage > 200)
		var/error_chance = min((total_damage - 200) / 10, 15)
		if(prob(error_chance))
			analysis_error = TRUE
			. += span_warning("<i>Труп сильно поврежден, сложно определить точную причину смерти...</i>")

	// Находим самую тяжелую рану и ее источник (для определения оружия)
	var/most_severe_weapon = null
	var/highest_severity = 0
	for(var/zone in get_all_limbs())
		var/obj/item/bodypart/limb = get_bodypart(zone)
		if(isnull(limb))
			continue
		for(var/datum/wound/wound as anything in limb.wounds)
			if(wound.wound_source && wound.wound_source != "Unknown" && wound.severity > highest_severity)
				most_severe_weapon = wound.wound_source
				highest_severity = wound.severity


	// ======= ДЕТАЛИЗАЦИЯ УРОНА ПО ИСТОЧНИКАМ =======
	var/list/wound_sources = list()
	var/list/embedded_items = list()

	// Собираем все источники ран и застрявшие предметы
	for(var/zone in get_all_limbs())
		var/obj/item/bodypart/limb = get_bodypart(zone)
		if(isnull(limb))
			continue

		for(var/datum/wound/wound as anything in limb.wounds)
			if(wound.wound_source && wound.wound_source != "Unknown")
				if(!wound_sources[wound.wound_source])
					wound_sources[wound.wound_source] = list("count" = 0, "severity" = wound.severity, "zones" = list())
				wound_sources[wound.wound_source]["count"]++
				wound_sources[wound.wound_source]["zones"] |= capitalize(limb.plaintext_zone)
				if(wound.severity > wound_sources[wound.wound_source]["severity"])
					wound_sources[wound.wound_source]["severity"] = wound.severity

		for(var/obj/item/embed as anything in limb.embedded_objects)
			embedded_items[embed.name] = capitalize(limb.plaintext_zone)

	// Показываем детализацию урона
	if(length(wound_sources) || length(embedded_items))
		. += span_notice("─────────────────────────────")
		. += span_notice("<b><u>Детализация урона:</u></b>")

		if(length(wound_sources))
			. += span_info("<b>Оружие/источники:</b>")
			for(var/source in wound_sources)
				var/list/source_data = wound_sources[source]
				var/severity_text = ""
				switch(source_data["severity"])
					if(WOUND_SEVERITY_CRITICAL)
						severity_text = span_danger(" (CRITICAL)")
					if(WOUND_SEVERITY_SEVERE)
						severity_text = span_warning(" (SEVERE)")
					if(WOUND_SEVERITY_MODERATE)
						severity_text = " (Moderate)"

				var/zones_text = english_list(source_data["zones"])
				var/wound_count_text = ""
				switch(source_data["count"])
					if(1)
						wound_count_text = "single wound"
					if(2 to 3)
						wound_count_text = "multiple wounds"
					else
						wound_count_text = "numerous wounds"
				. += span_info("  • <b>[source]</b>[severity_text]: [wound_count_text] on [zones_text]")

		if(length(embedded_items))
			. += span_warning("<b>Застрявшие предметы:</b>")
			for(var/item_name in embedded_items)
				. += span_warning("  • <b>[item_name]</b> in [embedded_items[item_name]]")

	// ======= ИНФОРМАЦИЯ О САМОУБИЙСТВЕ =======
	if(HAS_TRAIT(src, TRAIT_SUICIDED))
		. += span_notice("─────────────────────────────")
		. += span_deadsay("<b><u>САМОУБИЙСТВО ОБНАРУЖЕНО</u></b>")

		if(suicide_method)
			. += span_deadsay("<b>Метод:</b> [suicide_method]")
		else
			. += span_deadsay("<b>Метод:</b> неизвестен")

		// Типы урона от самоубийства (описательно)
		if(suicide_damage_type)
			. += span_info("<b>Типы урона от самоубийства:</b>")
			var/list/damage_types = list()

			if(suicide_damage_type & BRUTELOSS)
				damage_types += "Physical"
			if(suicide_damage_type & FIRELOSS)
				damage_types += "Thermal"
			if(suicide_damage_type & TOXLOSS)
				damage_types += "Toxin"
			if(suicide_damage_type & OXYLOSS)
				damage_types += "Asphyxiation"

			if(length(damage_types))
				. += span_info("  • [english_list(damage_types)]")

