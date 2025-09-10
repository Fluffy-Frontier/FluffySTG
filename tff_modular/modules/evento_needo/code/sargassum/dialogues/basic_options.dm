///datum/dialog_options/set_nickname
//	entry_text = {"say Как ты хочешь меня называть?"}
//
///datum/dialog_options/set_nickname/Initialize(...)
//	. = ..()
//	RegisterSignal()

//Вывод первоначального текста. Можно менять choices
/datum/dialog_options/proc/get_damaged_entry(mob/living/me, severity)
	return pick(damaged_callouts[severity])

/datum/dialog_options/proc/get_area_entry(mob/living/me, area_name)
	if(!isnull(area_entry[area_name]))
		return pick(area_entry[area_name])
	else
		return pick(area_entry["default"])

/datum/dialog_options/proc/get_resume_entry(mob/living/me, mob/living/player)
	return pick(resume_entry)

/datum/dialog_options/yes
	player_choice_text = "Да"

/datum/dialog_options/no
	player_choice_text = "Нет"
