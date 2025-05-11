// Инвалидная, но рабочая система конверта. Создает опухоль, которую можно вставить в жертву, превращая ее в антагониста. Работает не более двух раз.
/datum/action/cooldown/spell/conjure_item/bbtumor
	name = "create tumor"
	desc = "Creates a tumor, needed to convert living being to your side! Have only two uses and it need times to convert a target."
	background_icon = 'icons/mob/actions/backgrounds.dmi'
	background_icon_state = "bg_fugu"
	overlay_icon = 'icons/mob/actions/backgrounds.dmi'
	overlay_icon_state = "bg_fugu_border"
	button_icon = 'icons/mob/actions/actions_ecult.dmi'
	button_icon_state = "stargazer_menu"
	item_type = /obj/item/tumorinjector
	delete_old = FALSE
	delete_on_failure = FALSE
	requires_hands = FALSE
	invocation_type = INVOCATION_NONE
	spell_requirements = NONE
	var/uses = 2

/datum/action/cooldown/spell/conjure_item/bbtumor/can_cast_spell(feedback)
	. = ..()
	if(uses == 0)
		to_chat(owner, span_warning("You have no tumors anymore! Ability removed."))
		qdel(src)
		return FALSE

/datum/action/cooldown/spell/conjure_item/bbtumor/cast(atom/cast_on)
	. = ..()
	--uses

// Антаг-выдавалка для наших жертв.
/obj/item/tumorinjector
	name = "black tumor"
	desc = null
	icon = 'icons/obj/medical/organs/organs.dmi'
	icon_state = "random_fly_4"
	force = 0
	w_class = WEIGHT_CLASS_TINY

/obj/item/tumorinjector/attack(mob/target, mob/user)
	var/mob/living/carbon/new_hemocrat = target
	if(!istype(new_hemocrat))
		return FALSE

	if(!new_hemocrat.mind)
		to_chat(user, span_warning("Must have a mind!"))
		return FALSE

	if(!do_after(user, 20 SECONDS, target = new_hemocrat))
		to_chat(user, span_warning("Interrupted!"))
		return FALSE

	if(HAS_TRAIT(new_hemocrat, TRAIT_UNCONVERTABLE))
		user.balloon_alert(user, "Something is eliminating the effect of the tumor!")
		return FALSE

	if(HAS_TRAIT(new_hemocrat, TRAIT_HEMATOCRAT))
		return FALSE

	log_combat(user, new_hemocrat, "target is converted!")

	new_hemocrat.mind.special_role = ROLE_HEMATOCRAT
	new_hemocrat.mind.add_antag_datum(/datum/antagonist/hematocrat)
	user.balloon_alert(user, "success! Target converted!")
	qdel(src)
	return TRUE

// Призыв плоти. Создает выбранное существо. Дружелюбно к гематократам.
/datum/action/cooldown/spell/summon_flesh
	name = "summon flesh"
	desc = "This ability creates a choosen creature, which made of flesh."
	button_icon = 'icons/mob/actions/actions_cult.dmi'
	button_icon_state = "spirit_unsealed"
	background_icon = 'icons/mob/actions/backgrounds.dmi'
	background_icon_state = "bg_fugu"
	overlay_icon = 'icons/mob/actions/backgrounds.dmi'
	overlay_icon_state = "bg_fugu_border"
	school = SCHOOL_CONJURATION
	cooldown_time = 80 SECONDS
	invocation_type = INVOCATION_NONE
	spell_requirements = NONE
	var/static/list/summon_type = list(
		"flesh blob" = /mob/living/basic/fleshblob/hematocrat_team,
		"living limb" = /mob/living/basic/living_limb_flesh/hematocrat_team,
		)

/datum/action/cooldown/spell/summon_flesh/is_valid_target(atom/cast_on)
	return isturf(cast_on.loc)

/datum/action/cooldown/spell/summon_flesh/cast(atom/cast_on)
	. = ..()
	var/choice = tgui_input_list(owner, "Select a flesh to create", "Flesh Creation", summon_type)
	if(isnull(choice) || QDELETED(src) || QDELETED(owner) || !IsAvailable(feedback = TRUE))
		return FALSE

	var/mob/living/basic/choice_path = summon_type[choice]
	if(!ispath(choice_path))
		return FALSE

	new choice_path(owner.loc)
	return TRUE

// Создает сердце. Сердце требуется для захвата территорий или отвлечения СБэу. Смешное и очень больно бьет!
/datum/action/cooldown/spell/conjure/heart
	name = "summon heart"
	desc = "This ability creates a dangerous flesh heart, that attacks near creatures and deal huge damage!"
	button_icon = 'icons/mob/actions/actions_cult.dmi'
	button_icon_state = "spirit_sealed"
	background_icon = 'icons/mob/actions/backgrounds.dmi'
	background_icon_state = "bg_fugu"
	overlay_icon = 'icons/mob/actions/backgrounds.dmi'
	overlay_icon_state = "bg_fugu_border"
	school = SCHOOL_CONJURATION
	cooldown_time = 180 SECONDS
	invocation_type = INVOCATION_NONE
	spell_requirements = NONE
	summon_type = list(/mob/living/basic/meteor_heart/hematocrat_team)
	summon_radius = 1
	summon_amount = 1

// Извлечение. Абилка еретика на извлечение органов, но без хила органов/существ.
/datum/action/cooldown/spell/touch/flesh_harvest
	name = "flesh harvest"
	desc = "A touch ability that allows you to either harvest target's organ"
	background_icon = 'icons/mob/actions/backgrounds.dmi'
	background_icon_state = "bg_fugu"
	overlay_icon = 'icons/mob/actions/backgrounds.dmi'
	overlay_icon_state = "bg_fugu_border"
	button_icon = 'icons/mob/actions/actions_ecult.dmi'
	button_icon_state = "mad_touch"
	sound = null
	school = SCHOOL_FORBIDDEN
	cooldown_time = 60 SECONDS
	invocation_type = INVOCATION_NONE
	spell_requirements = NONE

	hand_path = /obj/item/melee/touch_attack/flesh_harvest
	can_cast_on_self = TRUE

/datum/action/cooldown/spell/touch/flesh_harvest/is_valid_target(atom/cast_on)
	return isliving(cast_on)

/datum/action/cooldown/spell/touch/flesh_harvest/cast_on_hand_hit(obj/item/melee/touch_attack/hand, atom/victim, mob/living/carbon/caster)

	if(isliving(victim))
		return steal_organ_from_mob(hand, victim, caster)

	return FALSE

/// If cast on a carbon, we'll try to steal one of their organs directly from their person.
/datum/action/cooldown/spell/touch/flesh_harvest/proc/steal_organ_from_mob(obj/item/melee/touch_attack/hand, mob/living/victim, mob/living/carbon/caster)
	var/mob/living/carbon/carbon_victim = victim
	if(!istype(carbon_victim) || !length(carbon_victim.organs))
		victim.balloon_alert(caster, "no organs!")
		return FALSE

	// Round u pto the nearest generic zone (body, chest, arm)
	var/zone_to_check = check_zone(caster.zone_selected)
	var/parsed_zone = victim.parse_zone_with_bodypart(zone_to_check)

	var/list/organs_we_can_remove = list()
	for(var/obj/item/organ/organ as anything in carbon_victim.organs)
		// Only show organs which are in our generic zone
		if(deprecise_zone(organ.zone) != zone_to_check)
			continue
		// Also, some organs to exclude. Don't remove vital (brains), don't remove synthetics, and don't remove unremovable
		if(organ.organ_flags & (ORGAN_ROBOTIC|ORGAN_VITAL|ORGAN_UNREMOVABLE))
			continue

		organs_we_can_remove[organ.name] = organ

	if(!length(organs_we_can_remove))
		victim.balloon_alert(caster, "no organs there!")
		return FALSE

	var/chosen_organ = tgui_input_list(caster, "Which organ do you want to extract?", name, sort_list(organs_we_can_remove))
	if(isnull(chosen_organ))
		return FALSE
	var/obj/item/organ/picked_organ = organs_we_can_remove[chosen_organ]
	if(!istype(picked_organ) || !extraction_checks(picked_organ, hand, victim, caster))
		return FALSE

	// Don't let people stam crit into steal heart true combo
	var/time_it_takes = carbon_victim.stat == DEAD ? 3 SECONDS : 10 SECONDS

	// Sure you can remove your own organs, fun party trick
	if(carbon_victim == caster)
		var/are_you_sure = tgui_alert(caster, "Are you sure you want to remove your own [chosen_organ]?", "Are you sure?", list("Yes", "No"))
		if(are_you_sure != "Yes" || !extraction_checks(picked_organ, hand, victim, caster))
			return FALSE

		time_it_takes = 10 SECONDS
		caster.visible_message(
			span_danger("[caster]'s hand glows a brilliant red as [caster.p_they()] reach[caster.p_es()] directly into [caster.p_their()] own [parsed_zone]!"),
			span_userdanger("Your hand glows a brilliant red as you reach directly into your own [parsed_zone]!"),
		)

	else
		carbon_victim.visible_message(
			span_danger("[caster]'s hand glows a brilliant red as [caster.p_they()] reach[caster.p_es()] directly into [carbon_victim]'s [parsed_zone]!"),
			span_userdanger("[caster]'s hand glows a brilliant red as [caster.p_they()] reach[caster.p_es()] directly into your [parsed_zone]!"),
		)

	carbon_victim.balloon_alert(caster, "extracting [chosen_organ]...")
	playsound(victim, 'sound/items/weapons/slice.ogg', 50, TRUE)
	carbon_victim.add_atom_colour(COLOR_DARK_RED, TEMPORARY_COLOUR_PRIORITY)
	if(!do_after(caster, time_it_takes, carbon_victim, extra_checks = CALLBACK(src, PROC_REF(extraction_checks), picked_organ, hand, victim, caster)))
		carbon_victim.balloon_alert(caster, "interrupted!")
		carbon_victim.remove_atom_colour(TEMPORARY_COLOUR_PRIORITY, COLOR_DARK_RED)
		return FALSE

	if(carbon_victim == caster)
		caster.visible_message(
			span_bolddanger("[caster] pulls [caster.p_their()] own [chosen_organ] out of [caster.p_their()] [parsed_zone]!!"),
			span_userdanger("You pull your own [chosen_organ] out of your [parsed_zone]!!"),
		)

	else
		carbon_victim.visible_message(
			span_bolddanger("[caster] pulls [carbon_victim]'s [chosen_organ] out of [carbon_victim.p_their()] [parsed_zone]!!"),
			span_userdanger("[caster] pulls your [chosen_organ] out of your [parsed_zone]!!"),
		)

	picked_organ.Remove(carbon_victim)
	carbon_victim.balloon_alert(caster, "[chosen_organ] removed")
	carbon_victim.remove_atom_colour(TEMPORARY_COLOUR_PRIORITY, COLOR_DARK_RED)
	playsound(victim, 'sound/effects/dismember.ogg', 50, TRUE)
	if(carbon_victim.stat == CONSCIOUS)
		carbon_victim.emote("scream")

	addtimer(CALLBACK(caster, TYPE_PROC_REF(/mob, put_in_hands), picked_organ), 0.1 SECONDS)
	return TRUE

/datum/action/cooldown/spell/touch/flesh_harvest/proc/extraction_checks(obj/item/organ/picked_organ, obj/item/melee/touch_attack/hand, mob/living/carbon/victim, mob/living/carbon/caster)
	if(QDELETED(src) || QDELETED(hand) || QDELETED(picked_organ) || QDELETED(victim) || !IsAvailable())
		return FALSE

	return TRUE

/obj/item/melee/touch_attack/flesh_harvest
	name = "\improper Flesh Harvest"
	desc = "Let's go practice medicine."
	icon = 'icons/obj/weapons/hand.dmi'
	icon_state = "disintegrate"
	inhand_icon_state = "disintegrate"

/datum/action/cooldown/spell/touch/flesh_transform
	name = "Flesh Transform"
	desc = "A touch spell that allows you to transform targets heart into random one. If the target is dead and not a hematocrat, you can revive target using this spell."
	background_icon = 'icons/mob/actions/backgrounds.dmi'
	background_icon_state = "bg_fugu"
	overlay_icon = 'icons/mob/actions/backgrounds.dmi'
	overlay_icon_state = "bg_fugu_border"
	button_icon = 'icons/mob/actions/actions_changeling.dmi'
	button_icon_state = "sting_transform"
	sound = null
	school = SCHOOL_FORBIDDEN
	cooldown_time = 60 SECONDS
	invocation_type = INVOCATION_NONE
	spell_requirements = NONE
	hand_path = /obj/item/melee/touch_attack/flesh_transform
	can_cast_on_self = FALSE
	// много переменных. ОЧЕНЬ много.
	var/obj/item/organ/heart/cybernetic/anomalock/anomalock = new
	var/obj/item/organ/heart/ethereal/ethereal = new
	var/obj/item/organ/heart/cursed/cursed = new
	var/obj/item/organ/heart/cybernetic/surplus/surplus = new
	var/obj/item/organ/heart/freedom/freedom = new
	var/obj/item/organ/heart/pod/podperson = new
	var/obj/item/organ/heart/corrupt/corrupted = new
	var/obj/item/organ/heart/nightmare/nightmare = new
	var/obj/item/organ/heart/roach/roach = new
	var/obj/item/organ/heart/gland/access/access = new
	var/obj/item/organ/heart/gland/heal/heal = new
	var/obj/item/organ/heart/gland/ventcrawling/ventcrawl = new
	var/obj/item/organ/heart/demon/demon = new
	var/obj/item/organ/heart/carp/akula/carpula = new

/datum/action/cooldown/spell/touch/flesh_transform/cast_on_hand_hit(obj/item/melee/touch_attack/hand, atom/victim, mob/living/carbon/caster)
	var/mob/living/carbon/human/human_victim = victim
	if(!do_after(caster, 10 SECONDS, target = human_victim))
		human_victim.balloon_alert(caster, "interrupted!")
		return FALSE
	if(ishuman(victim))
		switch(rand(1,14))
			if(1)
				anomalock.Insert(human_victim)
				to_chat(caster, span_warning("You, the ruler of flesh and blood, have created something special out of iron and oil, and your creation will give great power to the changed."))
			if(2)
				ethereal.Insert(human_victim)
				to_chat(caster, span_warning("You, the ruler of flesh and blood, have created something unusual, filled with energy, perhaps it will grant strength to the changed."))
			if(3)
				cursed.Insert(human_victim)
				to_chat(caster, span_warning("You, the ruler of flesh and blood, have created a curse and a blessing for the changed."))
			if(4)
				demon.Insert(human_victim)
				to_chat(caster, span_warning("You, the ruler of flesh and blood, have created something terrible, unpleasant and evil, filled with blood."))
			if(5)
				carpula.Insert(human_victim)
				to_chat(caster, span_warning("You, the ruler of flesh and blood, have created a beautiful water-living heart for an equally beautiful changed one."))
			if(6)
				ventcrawl.Insert(human_victim)
				to_chat(caster, span_warning("You, the ruler of flesh and blood, have created a heart that allows an changed person to reduce the size of his body to such a state that he can pass into ventilation."))
			if(7)
				surplus.Insert(human_victim)
				to_chat(caster, span_warning("You, the ruler of flesh and blood, have failed in creating something good out of iron and oil. You're better at dealing with the flesh. The changed person will not feel very well."))
			if(8)
				freedom.Insert(human_victim)
				to_chat(caster, span_warning("You, the ruler of flesh and blood, have created the heart of a determined being that will not give up even at death's door."))
			if(9)
				podperson.Insert(human_victim)
				to_chat(caster, span_warning("You, the ruler of flesh and blood, have created the heart that absorbs light, but is it useful..?"))
			if(10)
				corrupted.Insert(human_victim)
				to_chat(caster, span_warning("You, the ruler of flesh and blood, have failed, and what you have created will only do harm."))
			if(11)
				nightmare.Insert(human_victim)
				to_chat(caster, span_warning("You, the ruler of flesh and blood, have created a heart as dark as night, it is filled with malice and hatred for prosperity and life, and it will surely manifest itself in the changed."))
			if(12)
				roach.Insert(human_victim)
				to_chat(caster, span_warning("You, the ruler of flesh and blood, have created a strong and tenacious heart, perhaps it will give its properties to the changed one."))
			if(13)
				access.Insert(human_victim)
				to_chat(caster, span_warning("You, the ruler of flesh and blood, have created a heart that holds the key to all doors. Even you don't know what the key is."))
			if(14)
				heal.Insert(human_victim)
				to_chat(caster, span_warning("You, the ruler of flesh and blood, have created a heart that gives life to the changed and restores his body."))

		if(!HAS_TRAIT(human_victim, TRAIT_HEMATOCRAT) && human_victim.stat == DEAD)
			human_victim.revive(HEAL_DAMAGE)
			human_victim.visible_message(span_warning("[human_victim] appears to wake from the dead!"), span_notice("You have regenerated."))
	return TRUE

/obj/item/melee/touch_attack/flesh_transform
	name = "\improper Flesh Transform"
	desc = "Let's go practice medicine."
	icon = 'icons/obj/weapons/hand.dmi'
	icon_state = "disintegrate"
	inhand_icon_state = "disintegrate"
