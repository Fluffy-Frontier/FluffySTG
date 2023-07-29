/datum/quirk/weak_body
	name = "Weak body"
	desc = "Your body EXTREMLY WEAK! You can't use heavy weapon or gun! Everything deal MUCH more damage for you."
	value = -16
	gain_text = span_danger("You body realy weak.. what are you doing here?!")
	medical_record_text = ("Patient body is extremly weak.")
	icon = FA_ICON_FACE_ANGRY
	mob_trait = TRAIT_WEAK_BODY

/datum/quirk/weak_body/add(client/client_source)
	. = ..()
	var/mob/living/carbon/human/h = client_source
	h.AddComponent(/datum/component/weak_body)
