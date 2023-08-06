/datum/quirk/weak_body
	name = "Weak body"
	desc = "Your body is EXTREMLY WEAK! You can't use heavy weapons or powerful guns! Everything deals MUCH more damage for you."
	value = -16
	gain_text = span_danger("You body is really weak.. what are you doing here?!")
	medical_record_text = ("Patient body is extremely weak.")
	icon = FA_ICON_DNA
	mob_trait = TRAIT_WEAK_BODY

/datum/quirk/weak_body/add(client/client_source)
	. = ..()
	var/mob/living/carbon/human/h = client_source
	h.AddComponent(/datum/component/weak_body)
