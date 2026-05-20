#define IS_HYPNOTIZED(mob) (mob?.mind?.has_antag_datum(/datum/antagonist/hypnotized))
#define IS_OBSESSED(mob) (mob?.mind?.has_antag_datum(/datum/antagonist/obsessed))

// Тут все заклинания, которые являются прикосновением
// Спелл для чтения разума другого игрока на наличие псионических способностей

/datum/action/cooldown/spell/touch/psionic/assay
	name = "Psionic Assay"
	desc = "Check if the target is a psionic."
	button_icon = 'icons/obj/medical/organs/organs.dmi'
	button_icon_state = "brain"
	cooldown_time = 60 SECONDS
	mana_cost = 10
	target_msg = "Your get a headache, but it quickly fades."
	hand_path = /obj/item/melee/touch_attack/psionic/assay
	draw_message = span_notice("You ready your hand to cleanse a patient.")
	drop_message = span_notice("You lower your hand.")
	can_cast_on_self = TRUE
	category = "Tier 1"
	locked = FALSE

/datum/action/cooldown/spell/touch/psionic/assay/cast_on_hand_hit(obj/item/melee/touch_attack/hand, atom/victim, mob/living/carbon/mendicant)
	if(ishuman(victim))
		var/mob/living/carbon/human/human_victim = victim
		if(human_victim.can_block_magic(antimagic_flags))
			to_chat(human_victim, span_notice("Psionic nearby tries to check you for psionic levels."))
		else
			to_chat(human_victim, span_warning(target_msg))
		owner.visible_message(span_warning("[owner] presses his thumb onto [victim]s forehead."),
							  span_notice("You press your thumb onto [victim]s forehead and begin reading them."))
		to_chat(victim, span_danger("[owner] presses a thumb onto your forehead and holds it there. It burns sligthly!"))
		if(do_after(mendicant, 6 SECONDS, human_victim, IGNORE_SLOWDOWNS, TRUE))
			read_psionic_level(human_victim)
		drain_mana()
		return TRUE
	else
		return FALSE

/datum/action/cooldown/spell/touch/psionic/assay/proc/read_psionic_level(mob/living/carbon/human/patient)
	if(issynthetic(patient) && cast_power < 2)
		to_chat(owner, span_notice("I can see... just numbers. No idea how to work with synths."))
		return FALSE

	if(patient.get_psionic())
		var/datum/psionic/target_psi = patient.get_psionic()
		owner.visible_message(span_notice("[owner] backs off from [patient]."),
							  span_cyan("Target is a psionic. [patient.p_Their()] class is [target_psi.psionic_level_string]"))
	else
		owner.visible_message(span_notice("[owner] backs off from [patient]."),
							  span_cyan("Target is not a psionic."))

// Читаем разум. Выдаёт: последние сейлоги, интент, настоящее имя, воспоминания, намёк на работу, намёк на то, что в антаг_датум что то есть.
/datum/action/cooldown/spell/touch/psionic/mind_read
	name = "Psionic Mind Read"
	desc = "Rudely intrude into targets thoughts."
	button_icon_state = "mindread"
	cooldown_time = 3 SECONDS
	mana_cost = 20
	target_msg = "You feel someone else in your head."

	hand_path = /obj/item/melee/touch_attack/psionic/read_mind
	draw_message = span_notice("You ready your hand to read someones mind.")
	drop_message = span_notice("You lower your hand.")
	can_cast_on_self = FALSE
	psionic_level = 3
	locked = FALSE

/datum/action/cooldown/spell/touch/psionic/mind_read/cast_on_hand_hit(obj/item/melee/touch_attack/hand, atom/victim, mob/living/carbon/mendicant)
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

/datum/action/cooldown/spell/touch/psionic/mind_read/proc/read_mind(mob/living/carbon/human/patient)
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
	text_to_show += span_notice("You can vaguely read their memories: ") + boxed_message(span_italics(get_memories(patient)))
	text_to_show += span_notice("You try to read their job: ") + boxed_message(span_italics(get_job_fluff(patient)))
	if(patient.mind.enslaved_to || IS_HYPNOTIZED(patient))
		text_to_show += span_boldnotice("[patient.p_Their()] will is not free.") + "<br>"
	if(IS_OBSESSED(patient))
		text_to_show += span_boldnotice("[patient.p_Their()] mind is assaulted by voices within. They should visit a brain surgeon.") + "<br>"
	if(cast_power >= 2)
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
/datum/action/cooldown/spell/touch/psionic/mind_read/proc/get_job_fluff(mob/living/carbon/human/patient)
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
/datum/action/cooldown/spell/touch/psionic/mind_read/proc/get_memories(mob/living/carbon/human/patient)
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

// Восстанавливает кровь, окси урон, открытые травмы. Не лечит другие типы урона. Если вторичка - психокинетика, то вынимает импланты.
// Если уровень Эпсилон - удаляет лярвы ксеноморфов.
/datum/action/cooldown/spell/touch/psionic/mending
	name = "Psionic Mending"
	desc = "Mend a creature's wounds. This handles internal wounds as well, such as ruptured organs and broken bones."
	button_icon = 'tff_modular/modules/psionics/icons/actions.dmi'
	button_icon_state = "mending_touch"
	cooldown_time = 50 SECONDS
	mana_cost = 30
	target_msg = "You body numbs a little."
	hand_path = /obj/item/melee/touch_attack/psionic/mending
	draw_message = span_notice("You ready your hand to mend a patient.")
	drop_message = span_notice("You lower your hand.")
	can_cast_on_self = TRUE
	locked = FALSE

/datum/action/cooldown/spell/touch/psionic/mending/cast_on_hand_hit(obj/item/melee/touch_attack/hand, atom/victim, mob/living/carbon/mendicant)
	if(ishuman(victim))
		var/mob/living/carbon/human/human_victim = victim
		if(issynthetic(human_victim) && cast_power < 2)
			to_chat(owner, span_notice("I dont know how to work with synths."))
			return FALSE
		if(human_victim.can_block_magic(antimagic_flags))
			to_chat(human_victim, span_notice("Psionic nearby tries to mend you."))
		else
			to_chat(human_victim, span_warning(target_msg))
		if(!do_after(mendicant, 5 SECONDS, human_victim, IGNORE_SLOWDOWNS, TRUE))
			return FALSE
		else
			try_heal_all(human_victim)
		drain_mana()
		return TRUE
	else
		return FALSE

/datum/action/cooldown/spell/touch/psionic/mending/proc/try_heal_all(mob/living/carbon/human/patient)
	if(patient.all_wounds && cast_power >= 2)
		var/datum/wound/wound2fix = patient.all_wounds[1]
		wound2fix.remove_wound()
		playsound(patient, 'sound/effects/wounds/crack2.ogg', 40, TRUE)

	for(var/obj/item/organ/O in patient.organs)
		O.apply_organ_damage(-15 * cast_power)

	if(patient.get_oxy_loss() >= OXYLOSS_PASSOUT_THRESHOLD-10)
		patient.adjust_oxy_loss(-cast_power * 20, forced = TRUE)

	if(patient.get_organ_slot("parasite_egg") && cast_power >= 2) // Удаляем ксеноморфов
		var/obj/item/organ/body_egg/parasite = patient.get_organ_slot("parasite_egg")
		parasite.owner.vomit(VOMIT_CATEGORY_BLOOD | MOB_VOMIT_KNOCKDOWN | MOB_VOMIT_HARM)
		parasite.owner.visible_message(
										span_warning("[patient] twitches, gags and vomits a living creqture with blood! Gross!"),
										span_bolddanger("Suddenly you feel sharp pain in your chest, then something starts moving up your throat. \
														Before you can react somethign slips past your lips with a mix of vomit and blood!"),
									  )
		var/atom/drop_loc = parasite.drop_location()
		parasite.Remove(parasite.owner)
		if(drop_loc)
			parasite.forceMove(drop_loc)

/datum/action/cooldown/spell/touch/psionic/electrocute
	name = "Psionic Electrocute"
	desc = "Administer a painful amount of psionic shock to the nervous system of a foe in melee range, causing burn and agony damage."
	button_icon_state = "chain_lighting"
	cooldown_time = 10 SECONDS
	point_cost = 2
	mana_cost = 10
	psionic_level = 2
	hand_path = /obj/item/melee/touch_attack/psionic/chain_lighting
	locked = FALSE
	category = "Tier 2"

/datum/action/cooldown/spell/touch/psionic/electrocute/cast_on_hand_hit(obj/item/melee/touch_attack/hand, atom/victim, mob/living/carbon/caster)
	. = ..()
	if(ishuman(victim))
		var/mob/living/carbon/human/human_living = victim
		human_living.adjust_fire_loss(20)
		human_living.electrocute_act(10, jitter_time = 2 SECONDS, stutter_time = 2 SECONDS, stun_duration = 2 SECONDS)
	else
		return FALSE

#undef IS_HYPNOTIZED
#undef IS_OBSESSED
