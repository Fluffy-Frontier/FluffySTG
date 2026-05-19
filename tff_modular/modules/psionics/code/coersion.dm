#define IS_HYPNOTIZED(mob) (mob?.mind?.has_antag_datum(/datum/antagonist/hypnotized))
#define IS_OBSESSED(mob) (mob?.mind?.has_antag_datum(/datum/antagonist/obsessed))

/// Школа внушения. 7 спеллов
/// Psionic assay - скан, является ли человек псиоником
/// Psionic focus - лечение мозга и псих болезней
/// Psionic mind read - продвинутое чтение разума(Как обычная ген. мутация, но + работа + воспоминания). Выдаётся только и ТОЛЬКО психологу, если он псионик
/// Psionic agony - работает как стан дубинка, исчезает после одного удара
/// Psionic spasm - станит на полсекунды, заставляет выронить всё из рук. Работает дистанционно
/// Psionic hypnosis - гипнотизирует цель фразой, которую выбрал псионик. ERP IS BAD. DO NOT ERP.
/// P.S. По гипнозу. В оригинале на финиках вообще было порабощение разума.
/// Psionic blind - временно ослепляет.

// Лечим мозги и брейнтравмы.
/datum/action/cooldown/spell/pointed/psionic/psionic_focus
	name = "Psionic Focus"
	desc = "Try to restore patients brain to its natural initial condition, fixing brain damage. Has a chance to heal traumas. Can be cast over distance."
	button_icon = 'icons/obj/medical/organs/organs.dmi'
	button_icon_state = "brain-smooth"
	cooldown_time = 1 SECONDS
	mana_cost = 40
	target_msg = "You feel like someone is messing with your brains."
	active_msg = "You prepare to heal someones mind..."
	psionic_level = 2
	point_cost = 3

/datum/action/cooldown/spell/pointed/psionic/psionic_focus/is_valid_target(atom/cast_on)
	if(!ishuman(cast_on))
		return FALSE
	if(issynthetic(cast_on) && cast_power < 2)
		to_chat(owner, span_notice("I dont know how to work with synths."))
		return FALSE
	return TRUE

/datum/action/cooldown/spell/pointed/psionic/psionic_focus/cast(mob/living/carbon/human/cast_on)
	. = ..()
	if(cast_on.can_block_magic(antimagic_flags))
		to_chat(cast_on, span_notice("Your mind is being healed by a psionic nearby."))
	else
		to_chat(cast_on, span_warning(target_msg))
	owner.Beam(cast_on, icon_state = "blood_light", time = 5 SECONDS)
	owner.visible_message(span_warning("[owner] seems to concentrate on something."),
						  span_notice("You start concentrating your energy to heal [cast_on]s brains."))
	if(!do_after(owner, 5 SECONDS, cast_on, IGNORE_SLOWDOWNS | IGNORE_TARGET_LOC_CHANGE, TRUE))
		accident_harm(cast_on)
	else
		fix_brainz(cast_on)
	drain_mana()
	return TRUE

/datum/action/cooldown/spell/pointed/psionic/psionic_focus/proc/fix_brainz(mob/living/carbon/human/cast_on)
	var/b_damage = cast_on.get_organ_loss(ORGAN_SLOT_BRAIN)
	if(b_damage > 0)
		cast_on.adjust_organ_loss(ORGAN_SLOT_BRAIN, -10 * cast_power)

	var/traumas = cast_on.get_traumas()
	if(traumas)
		var/datum/brain_trauma/trauma = pick(traumas)
		if(trauma.resilience != TRAUMA_RESILIENCE_ABSOLUTE)
			cast_on.cure_trauma_type(resilience = trauma.resilience)
	cast_on.apply_status_effect(/datum/status_effect/drugginess, 20 SECONDS)

/datum/action/cooldown/spell/pointed/psionic/psionic_focus/proc/accident_harm(mob/living/carbon/human/cast_on)
	cast_on.adjust_organ_loss(ORGAN_SLOT_BRAIN, 15 * cast_power, 101)
	to_chat(cast_on, span_bolddanger("You head hurts!"))

// Читаем разум. Выдаёт: последние сейлоги, интент, настоящее имя, воспоминания, намёк на работу, намёк на то, что в антаг_датум что то есть.
/datum/action/cooldown/spell/touch/psionic/psionic_mind_read
	name = "Psionic Mind Read"
	desc = "Rudely intrude into targets thoughts."
	button_icon = 'icons/mob/actions/actions_spells.dmi'
	button_icon_state = "mindread"
	cooldown_time = 3 SECONDS
	mana_cost = 40
	stamina_cost = 40
	target_msg = "You feel someone else in your head."

	hand_path = /obj/item/melee/touch_attack/psionic_mending
	draw_message = span_notice("You ready your hand to read someones mind.")
	drop_message = span_notice("You lower your hand.")
	can_cast_on_self = FALSE
	psionic_level = 3

/datum/action/cooldown/spell/touch/psionic/psionic_mind_read/cast_on_hand_hit(obj/item/melee/touch_attack/hand, atom/victim, mob/living/carbon/mendicant)
	if(ishuman(victim))
		var/mob/living/carbon/human/human_victim = victim
		if(human_victim.mind && human_victim.stat != DEAD)
			if(human_victim.can_block_magic(antimagic_flags))
				to_chat(human_victim, span_bolddanger("Psionic nearby tries to read your mind!"))
			else
				to_chat(human_victim, span_warning(target_msg))
			owner.visible_message(span_warning("[owner] presses his thumb onto [victim]s forehead."),
								span_notice("You press your thumb onto [victim]s forehead and begin reading them."))
			to_chat(victim, span_danger("[owner] presses a thumb onto your forehead and holds it there. It burns sligthly!"))
			if(do_after(mendicant, 10 SECONDS, human_victim, IGNORE_SLOWDOWNS, TRUE))
				read_mind(human_victim)
			drain_mana()
			return TRUE
		else
			return FALSE
	else
		return FALSE

/datum/action/cooldown/spell/touch/psionic/psionic_mind_read/proc/read_mind(mob/living/carbon/human/patient)
	if(patient.can_block_magic(MAGIC_RESISTANCE_MIND, charge_cost = 0))
		to_chat(owner, span_warning("As you reach into [patient]'s mind, \
			you are stopped by a mental blockage. It seems you've been foiled."))
		return
	if(issynthetic(patient) && cast_power < 2)
		to_chat(owner, span_notice("I dont know how to work with synths. It's just zeros and ones. How am I supposed to get info out of this metal bucket?"))
		return
	var/text_to_show = ""

	var/list/recent_speech = patient.copy_recent_speech(copy_amount = 10)
	if(length(recent_speech))
		text_to_show += span_boldnotice("You catch some drifting memories of their past conversations...") + "<br>"
		for(var/spoken_memory in recent_speech)
			text_to_show += span_notice("[spoken_memory]") + "<br>"

	text_to_show += span_notice("You find that their intent is to [patient.combat_mode ? "harm" : "help"]...") + "<br>"
	text_to_show += span_notice("You uncover that [patient.p_their()] true identity is [patient.mind.name].") + "<br>"
	if(cast_power >= 3)
		text_to_show += span_notice("You can vaguely read their memories: ") + boxed_message(span_italics(get_memories(patient)))
	text_to_show += span_notice("You try to read their job: ") + boxed_message(span_italics(get_job_fluff(patient)))
	if(patient.mind.enslaved_to || IS_HYPNOTIZED(patient))
		text_to_show += span_boldnotice("[patient.p_Their()] will is not free.") + "<br>"
	if(IS_OBSESSED(patient))
		text_to_show += span_boldnotice("[patient.p_Their()] mind is assaulted by voices within. They should visit a brain surgeon.") + "<br>"
	var/datum/mind/mind_to_read = patient.mind
	if(prob(20 * cast_power) && mind_to_read.antag_datums)
		if(IS_WIZARD(patient))
			text_to_show += span_notice("You can feel a strong potential pulsating in this individual.") + "<br>"
		else if(IS_HERETIC(patient))
			text_to_show += span_notice("Reality bends around you and goes back to normal, as you try to read [patient.p_their()] mind.") + "<br>"
			var/mob/living/carbon/human/human_owner = owner
			human_owner.add_mood_event("gates_of_mansus", /datum/mood_event/gates_of_mansus)
		else if(IS_CULTIST(patient))
			text_to_show += span_red("Your mind is assaulted with torrents of blood and gore, as you try to dig deeper.") + "<br>"
		else // Там очень много ролей, в том числе не антажных, а мага, еретика и культиста я думаю и без этой способности найти легко. Тем более мы читаем воспоминания, что более имбово
			text_to_show += span_notice("You also can feel something hidden within [patient.p_their()] mind, but it's not readable.") + "<br>"

	to_chat(owner, boxed_message(span_infoplain(text_to_show)))

// Возвращает размытый текст о профессии
/datum/action/cooldown/spell/touch/psionic/psionic_mind_read/proc/get_job_fluff(mob/living/carbon/human/patient)
	var/datum/mind/mind_to_read = patient.mind
	var/datum/job/patient_job = mind_to_read.assigned_role
	var/text_to_return = ""
	if(patient_job.departments_bitflags & DEPARTMENT_BITFLAG_SECURITY)
		text_to_return += "This persons job involves beating up mimes and clowns." + "<br>"
	else if(patient_job.departments_bitflags & DEPARTMENT_BITFLAG_CENTRAL_COMMAND)
		text_to_return += "This persons is a greatest authority on this station." + "<br>"
	else if(patient_job.departments_bitflags & DEPARTMENT_BITFLAG_CAPTAIN)
		text_to_return += "This persons is likely to have megalomania." + "<br>"
	else if(patient_job.departments_bitflags & DEPARTMENT_BITFLAG_COMMAND)
		text_to_return += "This persons calling is commanding others." + "<br>"
	else if(patient_job.departments_bitflags & DEPARTMENT_BITFLAG_SERVICE)
		text_to_return += "This persons labor is about servicing others." + "<br>"
	else if(patient_job.departments_bitflags & DEPARTMENT_BITFLAG_CARGO)
		text_to_return += "This person works physically a lot." + "<br>"
	else if(patient_job.departments_bitflags & DEPARTMENT_BITFLAG_ENGINEERING)
		text_to_return += "This person keeps station alive." + "<br>"
	else if(patient_job.departments_bitflags & DEPARTMENT_BITFLAG_SCIENCE)
		text_to_return += "This person is an egghead." + "<br>"
	else if(patient_job.departments_bitflags & DEPARTMENT_BITFLAG_MEDICAL)
		text_to_return += "This person is accustomed with wounds, blood and their treatment." + "<br>"
	else if(patient_job.departments_bitflags & DEPARTMENT_BITFLAG_SILICON)
		text_to_return += "This is en etenral mankinds servant." + "<br>"
	else if(patient_job.departments_bitflags & DEPARTMENT_BITFLAG_ASSISTANT)
		text_to_return += "This persons mind reeks of freedom." + "<br>"
	else
		text_to_return += "This person is truly free. They are not obligated with any duties." + "<br>"

	return span_notice(text_to_return)

// Возвращает воспоминания разума. Имба против таторов, так как там хранится код от аплинка. А ну и банковский айди.
/datum/action/cooldown/spell/touch/psionic/psionic_mind_read/proc/get_memories(mob/living/carbon/human/patient)
	var/datum/mind/mind_to_read = patient.mind
	if(mind_to_read)
		var/itogo_text = ""
		for(var/key in mind_to_read.memories)
			var/datum/memory/mem = mind_to_read.memories[key]
			itogo_text += mem.name + "<br>"
		if(itogo_text == "")
			itogo_text = "[patient.p_Their()] head is empty."
		return itogo_text
	else
		return "I cant read [patient.p_their()] memories. Maybe there are none?" + "<br>"

// Stun batong на минималках. Исчезает после одного удара
/datum/action/cooldown/spell/touch/psionic/psionic_agony
	name = "Psionic Agony"
	desc = "Deals pain."
	button_icon = 'icons/obj/weapons/baton.dmi'
	button_icon_state = "stunbaton_active"
	cooldown_time = 0.5 SECONDS
	mana_cost = 40
	stamina_cost = 0
	hand_path = /obj/item/melee/touch_attack/psionic_mending
	draw_message = span_notice("You ready your hand to deal pain.")
	drop_message = span_notice("You lower your hand.")
	can_cast_on_self = TRUE // Упс :)

/datum/action/cooldown/spell/touch/psionic/psionic_agony/cast_on_hand_hit(obj/item/melee/touch_attack/hand, atom/victim, mob/living/carbon/mendicant)
	if(ishuman(victim))
		var/mob/living/carbon/human/human_victim = victim
		if(human_victim.can_block_magic(antimagic_flags))
			to_chat(human_victim, span_notice("Psionic nearby tries to attack you, but fails."))
			to_chat(owner, span_notice("You can't attack them. They have some kind of protection."))
			return FALSE
		if(issynthetic(human_victim) && cast_power < 2)
			human_victim.visible_message(span_danger("[owner] slaps [human_victim] with his hand. Nothing happens. Wow!"),
									span_warning("You slap [human_victim], but nothing happens. You cannot transfer your energy through metal."),
									blind_message = span_hear("You hear a slap."))
			return FALSE
		else
			to_chat(human_victim, span_warning("Pain floods your body as soon as [owner] touches you!."))
		psionic_attack(human_victim)
		log_combat(owner, human_victim, "psionically stunned")
		drain_mana()
		return TRUE
	else
		return FALSE

// Прок удара
/datum/action/cooldown/spell/touch/psionic/psionic_agony/proc/psionic_attack(mob/living/carbon/human/patient)
	patient.apply_damage(35, STAMINA) // Стандартный стан батонг
	addtimer(CALLBACK(src, PROC_REF(apply_stun_effect), patient), 2 SECONDS)

/datum/action/cooldown/spell/touch/psionic/psionic_agony/proc/apply_stun_effect(mob/living/carbon/human/patient)
	patient.visible_message(span_danger("[owner] slaps [patient] with his hand, sparks flying out of it!"),
							span_warning("You slap [patient], stunning him."),
							blind_message = span_hear("You hear a slap and an electrical crackling afterwards."))
	var/trait_check = HAS_TRAIT(patient, TRAIT_BATON_RESISTANCE) //var since we check it in out to_chat as well as determine stun duration
	if(!patient.IsKnockdown())
		to_chat(patient, span_warning("Your muscles seize, making you collapse[trait_check ? ", but your body quickly recovers..." : "!"]"))

	if(!trait_check)
		patient.Knockdown((cast_power/2) SECONDS)

// Станит на непродолжительный срок(~0.5 сек) и заставляет выкинуть вещи из рук
/datum/action/cooldown/spell/pointed/psionic/psionic_spasm
	name = "Psionic Spasm"
	desc = "Activate neurons in victims mucles, briefly stunning them and forcing to drop everything in their hands. Can be cast over distance. Silent."
	button_icon = 'tff_modular/modules/psionics/icons/actions.dmi'
	button_icon_state = "spasm"
	cooldown_time = 1 SECONDS
	mana_cost = 40
	target_msg = "Your muscles spasm!"
	active_msg = "You prepare to stun a target..."

/datum/action/cooldown/spell/pointed/psionic/psionic_spasm/is_valid_target(atom/cast_on)
	if(!ishuman(cast_on))
		return FALSE

	if(issynthetic(cast_on) && cast_power < 2)
		to_chat(owner, span_notice("I dont know how to work with synths."))
		return FALSE

	return TRUE

/datum/action/cooldown/spell/pointed/psionic/psionic_spasm/cast(mob/living/carbon/human/cast_on)
	. = ..()
	if(cast_on.can_block_magic(antimagic_flags))
		to_chat(cast_on, span_warning("Your body is assaulted with psionic energy!"))
	else
		to_chat(cast_on, span_warning(target_msg))
	log_combat(owner, cast_on, "psionically spasmed")
	stun(cast_on)
	drain_mana()
	return TRUE

// Сам стан
/datum/action/cooldown/spell/pointed/psionic/psionic_spasm/proc/stun(mob/living/carbon/human/cast_on)
	cast_on.Stun(0.2 SECONDS * cast_power)

/**
 * Гипнотизирует игрока заданной фразой и даёт брейнтравму с ней
 *
 * Условия:
 * * 30 секунд ожидания
 * * в агрограбе
 * * без движения жертвы или псионика
 */
/datum/action/cooldown/spell/touch/psionic/psionic_hypnosis
	name = "Psionic Hypnosis"
	desc = "Implant a looping pattern into victims head."
	button_icon = 'tff_modular/modules/psionics/icons/actions.dmi'
	button_icon_state = "hypno"
	cooldown_time = 10 SECONDS

	mana_cost = 25 // Стоит немного
	stamina_cost = 50 // Но выматывет
	target_msg = "Your get a headache."

	hand_path = /obj/item/melee/touch_attack/psionic_mending
	draw_message = span_notice("You ready your hand to hypnotize a victim.")
	drop_message = span_notice("You lower your hand.")
	can_cast_on_self = FALSE // No

/datum/action/cooldown/spell/touch/psionic/psionic_hypnosis/cast_on_hand_hit(obj/item/melee/touch_attack/hand, atom/victim, mob/living/carbon/mendicant)
	if(ishuman(victim) && mendicant.grab_state == GRAB_AGGRESSIVE && mendicant.pulling == victim)
		var/mob/living/carbon/human/human_victim = victim
		if(HAS_MIND_TRAIT(human_victim, TRAIT_UNCONVERTABLE)) // Не работает на людей с МЩ
			to_chat(owner, span_warning("Victims mind is too strong for you to penetrate."))
			return FALSE
		if(human_victim.can_block_magic(antimagic_flags))
			to_chat(human_victim, span_boldwarning("Psionic nearby tries to hypnotize you!"))
		else
			to_chat(human_victim, span_warning(target_msg))
		owner.visible_message(span_warning("[owner] firmly grabs [victim]s and begins creepely staring onto them."),
							  span_notice("You grab [victim]s head and begin implanting a thought into them."))
		var/player_input = tgui_input_text(mendicant, "Hypnophrase", "Input the hypnophrase", max_length = MAX_MESSAGE_LEN)
		if(!player_input)
			return FALSE
		if(do_after(mendicant, (10 - cast_power) SECONDS, human_victim, IGNORE_SLOWDOWNS, TRUE))
			hypnotize(human_victim, player_input)
		else
			to_chat(owner, span_warning("You failed to hypnotize the victim."))
		drain_mana()
		return TRUE
	else
		to_chat(owner, span_notice("You need to grab a human in aggressive grab to hypnotize them."))
		return FALSE

/datum/action/cooldown/spell/touch/psionic/psionic_hypnosis/proc/hypnotize(mob/living/carbon/human/patient, hypnophrase)
	patient.cure_trauma_type(/datum/brain_trauma/hypnosis, TRAUMA_RESILIENCE_SURGERY)

	owner.log_message("hypnotised [key_name(patient)] with the phrase '[hypnophrase]'", LOG_ATTACK, color="red")

	patient.log_message("has been hypnotised by the phrase '[hypnophrase]' spoken by [key_name(owner)]", LOG_VICTIM, color="orange", log_globally = FALSE)

	addtimer(CALLBACK(patient, TYPE_PROC_REF(/mob/living/carbon, gain_trauma), /datum/brain_trauma/hypnosis, TRAUMA_RESILIENCE_SURGERY, hypnophrase), 1 SECONDS)
	addtimer(CALLBACK(patient, TYPE_PROC_REF(/mob/living, Stun), 60, TRUE, TRUE), 15)

// Ослепляет цель на дистанции на ~15 секунд. Способность максимального уровня
/datum/action/cooldown/spell/pointed/psionic/psionic_blind
	name = "Psionic Blind"
	desc = "Interfere with the way neuron signals are transmitted in the victims eyes."
	button_icon_state = "blind"
	ranged_mousepointer = 'icons/effects/mouse_pointers/blind_target.dmi'
	cooldown_time = 1 SECONDS
	mana_cost = 60
	target_msg = "You eyes hurt!"
	active_msg = "You prepare to blind a target..."

/datum/action/cooldown/spell/pointed/psionic/psionic_blind/is_valid_target(atom/cast_on)
	if(!ishuman(cast_on))
		return FALSE
	else
		var/mob/living/carbon/human/victim = cast_on
		if(victim.is_blind())
			to_chat(owner, span_notice("[victim] is already blind."))
			return FALSE
	if(issynthetic(cast_on) && cast_power < 2)
		to_chat(owner, span_notice("I dont know how to work with synths."))
		return FALSE

	return TRUE

/datum/action/cooldown/spell/pointed/psionic/psionic_blind/cast(mob/living/carbon/human/cast_on)
	. = ..()
	if(cast_on.can_block_magic(antimagic_flags))
		to_chat(cast_on, span_warning("Your eyes are burned with psionic energy!"))
	else
		to_chat(cast_on, span_warning(target_msg))
	log_combat(owner, cast_on, "psionically blinded")
	blind(cast_on)
	drain_mana()
	return TRUE

/datum/action/cooldown/spell/pointed/psionic/psionic_blind/proc/blind(mob/living/carbon/human/cast_on)
	cast_on.adjust_temp_blindness( (10 + cast_power * 2) SECONDS)

#undef IS_HYPNOTIZED
#undef IS_OBSESSED
