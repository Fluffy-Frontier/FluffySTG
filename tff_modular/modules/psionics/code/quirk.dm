/datum/quirk/psionic
	name = "Psionic Abilities"
	desc = "Either you were born like this or gained powers from implants/training or other events - you are a psionic. \
			Your mind can access the world that lies beyond our mortal plane. One day voices from within had pierced your skull \
			like a tide wave turns a sailboat over in open sea, but you withstanded it and received abilities your father haven't \
			even dreamed of. From now on a special type of energy is stored in your mind, body and soul and you have control over it."
	value = 8
	medical_record_text = "Patient possesses connection to another plain of reality."
	quirk_flags = QUIRK_HIDE_FROM_SCAN|QUIRK_HUMAN_ONLY|QUIRK_PROCESSES // Сканеры не видят псиоников. Только псионик школы может точно определить, является ли живое существо псиоником
	gain_text = span_cyan("You mind feels uneasy, but... so powerful.")
	lose_text = span_warning("You lost something that kept your connection with other realms.")
	nova_stars_only = TRUE
	allow_for_donator = TRUE
	icon = "fa-star"

/datum/quirk/psionic/add(client/client_source)
	quirk_holder.add_psionic(/datum/psionic/sensitive)

/datum/quirk/psionic/remove()
	. = ..()
	quirk_holder.remove_psionic()
