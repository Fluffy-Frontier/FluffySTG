/datum/language/nabber
	name = "Giant Armored Serpentid"
	desc = "A complex language that contains various sounds and movements, spoken only by Serpentids."
	key = "N"
	syllables = null
	special_characters = null
	default_priority = 70

	flags = NO_STUTTER | TONGUELESS_SPEECH
	always_use_default_namelist = TRUE
	icon_state = "animal"
	secret = TRUE

/datum/language/nabber/scramble_sentence(input, list/mutual_languages)

	var/sentence = "[pick("ритмично", "коротко", "быстро", "громко", "мелодично", "монотонно", "резко", "характерно")] \
						 [pick("жужжит", "щёлкает", "верещит", "стрекочет")] \
						 [pick("пару раз" , "несколько раз", "три раза")]."

	write_word_cache(input, sentence)

	return sentence

/datum/language_holder/nabber
	understood_languages = list(
		/datum/language/common = list(LANGUAGE_MIND),
		/datum/language/nabber = list(LANGUAGE_MIND),
	)
	spoken_languages = list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/nabber = list(LANGUAGE_SPECIES),
	)
	selected_language = /datum/language/common

/obj/item/implant/gas_sol_speaker
	name = "sol speech synthesizer implant"
	actions_types = null
	// Implant gets damaged evevy emp_act(). If 0 - its fine. 1 - it stops working. Any more damage will give burn damage
	// TODO: add more stages
	var/emp_damage = 0

/obj/item/implant/gas_sol_speaker/get_data()
	return "<b>Implant Specifications:</b><BR> \
		<b>Name:</b> Sol Government Giant Armored Serpentid Speech Synthesizer Beta v0.3<BR> \
		<b>Life:</b> Activates upon speech attempt.<BR>\
		<b>Important Notes:</b> Does not work on other species.<BR> \
		<HR> \
		<b>Implant Details:</b><BR> \
		<b>Function:</b> Contains a small electonic speech syntesizer, similar to the borg ones and AI-processing unit, which detects GASs attempt to speak and, \
		if enabled, will translate its neuron signals into comprehensible human language.<BR> \
		<b>Changelog:</b> No longer causes infinite scream loop once GAS is angered.<BR>\
		<b>Known bugs:</b> EMP tends to damage the implant power source. Will isolate it later.<BR>"

/obj/item/implant/gas_sol_speaker/implant(mob/living/target, mob/user, silent = FALSE, force = FALSE)
	. = ..()
	if(isnabber(target) && !QDELING(target))
		var/mob/living/carbon/human/species/nabber/our_gas = target
		our_gas.grant_language(/datum/language/common, language_flags = SPOKEN_LANGUAGE, source = LANGUAGE_ATOM)

/obj/item/implant/gas_sol_speaker/removed(mob/target, silent = FALSE, special = FALSE)
	. = ..()
	if(isnabber(target) && !QDELING(target))
		var/mob/living/carbon/human/species/nabber/our_gas = target
		our_gas.remove_language(/datum/language/common, language_flags = SPOKEN_LANGUAGE)
		if(our_gas.has_status_effect(/datum/status_effect/speech/stutter/nabber))
			our_gas.remove_status_effect(/datum/status_effect/speech/stutter/nabber)

/obj/item/implant/gas_sol_speaker/emp_act(severity)
	. = ..()
	switch(emp_damage)
		if(0)
			emp_damage += 1
			if(imp_in && isnabber(imp_in))
				var/mob/living/carbon/human/species/nabber/our_gas = imp_in
				our_gas.apply_status_effect(/datum/status_effect/speech/stutter/nabber, -1)
				to_chat(imp_in, span_hear("You hear something inside of you zap silently."))
		if (1)
			emp_damage += 1
			if(imp_in && isnabber(imp_in))
				var/mob/living/carbon/human/species/nabber/our_gas = imp_in
				our_gas.remove_language(/datum/language/common, language_flags = SPOKEN_LANGUAGE)
				if(our_gas.has_status_effect(/datum/status_effect/speech/stutter/nabber))
					our_gas.remove_status_effect(/datum/status_effect/speech/stutter/nabber)
				to_chat(imp_in, span_hear("You hear something inside of you zap silently."))
		if (2)
			if (imp_in)
				imp_in.apply_damage(5, BURN)
				to_chat(imp_in, span_warning("You feel something burning inside you!"))

/// Special type of stutter, only affecting non nabber languages
/datum/status_effect/speech/stutter/nabber
	id = "gas_stutter"
	alert_type = null
	duration = -1

/datum/status_effect/speech/stutter/nabber/handle_message(datum/source, list/message_args)
	if(isnabber(owner) && ispath(owner.get_selected_language(), /datum/language/nabber))
		stutter_prob = 0
	else
		stutter_prob = 80
	return ..()

/obj/item/implanter/gas_sol_speaker
	name = "implanter (GAS Sol speaker)"
	imp_type = /obj/item/implant/gas_sol_speaker

/obj/item/implantcase/gas_sol_speaker
	name = "implant case - 'GAS Sol speaker'"
	desc = "A glass case containing a sol speaker, designed for GAS."
	imp_type = /obj/item/implant/gas_sol_speaker

/datum/design/implant_gassolspeaker
	name = "GAS Sol speaker Implant Case"
	desc = "Makes GAS able to speak normally."
	id = "implant_gasspeech"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/glass =SMALL_MATERIAL_AMOUNT*5, /datum/material/silver =SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/implantcase/gas_sol_speaker
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_HEALTH
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE
