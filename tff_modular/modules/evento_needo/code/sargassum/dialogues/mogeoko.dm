/mob/living/carbon/human/mogeoko

/mob/living/carbon/human/mogeoko/Initialize(mapload)
	my_dialog = new /datum/dialog(src, /datum/dialog_options/mogeoko_real)
	return ..()

/datum/dialog_options/mogeoko_real
	entry_text = {"
		say TEST
		"}
	choices = list(
		/datum/dialog_options/mogeoko/otvet,
	)

/datum/dialog_options/mogeoko_real/get_entry(mob/me, mob/player)
	if(player?.name == "Mogeoko")
		rebuild_choices(/datum/dialog_options/mogeoko/mogeoko)
		return "say Mogeoko"
	else
		if(prob(50))
			choices = list()
			return {"say Hello there!
					emote waves!
				"}
		else
			return ..()

/datum/dialog_options/mogeoko/otvet
	entry_text = {"
		say 1
	"}
	player_choice_text = "222"

/datum/dialog_options/mogeoko/mogeoko
	entry_text = {"
		say 1
	"}
	player_choice_text = "2222"


/*
Приветствие

Расскажи мне об изменениях

Расскажи мне о новом



*/
