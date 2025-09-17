#define MAX_PRIORITY 1
#define DEFAULT_PRIORITY 0.6
#define MEDIUM_PRIORITY 0.5
#define LOW_PRIORITY 0.4

#define CATEGORY_DEFAULT "default"
#define CATEGORY_QUEST "quest"
#define CATEGORY_FAREWELL "farewell" //end of dialog, no options here
#define CATEGORY_UNIQUE "unique" //stops from adding other options
#define CATEGORY_GREET "greet" //beginning of dialog

/datum/dialog_options
	var/entry_text = null
	var/player_choice_text = null
	var/priority = MAX_PRIORITY
	var/category = CATEGORY_DEFAULT
	var/repeatable = FALSE
	var/met_requirments = TRUE
	var/private = FALSE
	var/relationship_change = 0
	var/list/choices = list()

	var/list/damaged_callouts = list(
		DIALOG_MOB_DAMAGED_WEAK = list(
			"say Ouch",
			"say Это было больно",
			"say Всего лишь царапина.",
		),
		DIALOG_MOB_DAMAGED_MEDIUM = list(
			"say А вот это не смешно",
			"say СЛОВИЛ МАСЛИНУ",
			"say ТЫ МНЕ КОСТЬ ВЫВИХНУЛ",
		),
		DIALOG_MOB_DAMAGED_CRITICAL = list(
			"say НЕ НАДО ДЯДЯ",
			"say БЛЯЯЯЯЯЯЯЯЯЯЯТЬ",
			"say МОЯ НОГА!",
		)
	)

	var/list/area_entry = list(
		"default" = list(
			"say Тускловато здесь...",
		)
	)

	var/resumable = TRUE
	var/list/resumable_entries = list(
		"say",
		"emote",
	)
	var/list/resume_entry = list(
		"resume Хочешь продолжить разговор?"
	)

/datum/dialog_options/Destroy(force)
	choices = null
	return ..()

/datum/dialog_options/proc/rebuild_choices(list/new_choices)
	choices = null
	for(var/datum/dialog_options/choice in new_choices)
		LAZYADD(choices, choice)

/datum/dialog_options/proc/mark_as_needed()
	met_requirments = FALSE

/datum/dialog_options/proc/mark_as_possible()
	met_requirments = TRUE

//Вывод первоначального текста. Можно менять choices
/datum/dialog_options/proc/get_entry(mob/living/me, mob/living/player)
	return entry_text

/datum/dialog_options/proc/bonus_entry(command, value)
	return

#undef MAX_PRIORITY
#undef MEDIUM_PRIORITY
#undef LOW_PRIORITY
#undef DEFAULT_PRIORITY
