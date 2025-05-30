// Инвалидная, но рабочая система конверта. Создает опухоль, которую можно вставить в жертву, превращая ее в антагониста. Работает не более двух раз.
/datum/action/cooldown/spell/conjure_item/tumor
	name = "Create Tumor"
	desc = "Creates a tumor, needed to convert living being to your side! Have only two uses and it need times to convert a target."
	background_icon = 'icons/mob/actions/backgrounds.dmi'
	background_icon_state = "bg_fugu"
	overlay_icon = 'icons/mob/actions/backgrounds.dmi'
	overlay_icon_state = "bg_fugu_border"
	button_icon = 'icons/mob/actions/actions_changeling.dmi'
	button_icon_state = "changelingsting"
	item_type = /obj/item/tumorinjector
	delete_old = FALSE
	delete_on_failure = FALSE
	requires_hands = FALSE
	invocation_type = INVOCATION_NONE
	spell_requirements = NONE
	var/uses = 2

/datum/action/cooldown/spell/conjure_item/tumor/can_cast_spell(feedback)
	. = ..()
	if(uses == 0)
		to_chat(owner, span_warning("You have no tumors anymore! Ability removed."))
		qdel(src)
		return FALSE

/datum/action/cooldown/spell/conjure_item/tumor/cast(atom/cast_on)
	. = ..()
	uses -= 1

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

// Призывы.
/datum/action/cooldown/spell/conjure/summon_fleshblob
	name = "Summon Blobflesh"
	desc = "This ability creates a big, cube-like creature, which made of flesh."
	button_icon = 'icons/mob/actions/actions_cult.dmi'
	button_icon_state = "spirit_unsealed"
	background_icon = 'icons/mob/actions/backgrounds.dmi'
	background_icon_state = "bg_fugu"
	overlay_icon = 'icons/mob/actions/backgrounds.dmi'
	overlay_icon_state = "bg_fugu_border"
	school = SCHOOL_CONJURATION
	cooldown_time = 60 SECONDS
	invocation_type = INVOCATION_NONE
	spell_requirements = NONE
	summon_type = list(/mob/living/basic/fleshblob/hematocrat_team)
	summon_amount = 1
	summon_radius = 1

/datum/action/cooldown/spell/conjure/summon_living_flesh
	name = "Summon Living Flesh"
	desc = "This ability creates a limb-like creature, which made of flesh."
	button_icon = 'icons/mob/actions/actions_cult.dmi'
	button_icon_state = "spirit_sealed"
	background_icon = 'icons/mob/actions/backgrounds.dmi'
	background_icon_state = "bg_fugu"
	overlay_icon = 'icons/mob/actions/backgrounds.dmi'
	overlay_icon_state = "bg_fugu_border"
	school = SCHOOL_CONJURATION
	cooldown_time = 60 SECONDS
	invocation_type = INVOCATION_NONE
	spell_requirements = NONE
	summon_type = list(/mob/living/basic/living_limb_flesh/hematocrat_team)
	summon_amount = 1
	summon_radius = 1

// Извлечение. Абилка еретика на извлечение органов, но без хила органов/существ.
/datum/action/cooldown/spell/touch/flesh_harvest
	name = "Flesh Harvest"
	desc = "A touch ability that allows you to either harvest target's organ"
	background_icon = 'icons/mob/actions/backgrounds.dmi'
	background_icon_state = "bg_fugu"
	overlay_icon = 'icons/mob/actions/backgrounds.dmi'
	overlay_icon_state = "bg_fugu_border"
	button_icon = 'icons/mob/actions/actions_ecult.dmi'
	button_icon_state = "mad_touch"
	sound = null
	school = SCHOOL_FORBIDDEN
	cooldown_time = 30 SECONDS
	invocation_type = INVOCATION_NONE
	spell_requirements = NONE

	hand_path = /obj/item/melee/touch_attack/flesh_hand
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

/datum/action/cooldown/spell/touch/flesh_transform
	name = "Flesh Transform"
	desc = "A touch spell that allows you to transform targets organs into random one. If the target is dead and not a hematocrat, you can revive target using this spell."
	background_icon = 'icons/mob/actions/backgrounds.dmi'
	background_icon_state = "bg_fugu"
	overlay_icon = 'icons/mob/actions/backgrounds.dmi'
	overlay_icon_state = "bg_fugu_border"
	button_icon = 'icons/mob/actions/actions_changeling.dmi'
	button_icon_state = "sting_transform"
	sound = null
	school = SCHOOL_FORBIDDEN
	cooldown_time = 20 SECONDS
	invocation_type = INVOCATION_NONE
	spell_requirements = NONE
	hand_path = /obj/item/melee/touch_attack/flesh_hand
	can_cast_on_self = FALSE

/datum/action/cooldown/spell/touch/flesh_transform/cast_on_hand_hit(obj/item/melee/touch_attack/hand, atom/victim, mob/living/carbon/caster)
	var/mob/living/carbon/human/human_victim = victim
	playsound(human_victim, 'sound/items/weapons/slice.ogg', 50, TRUE)
	if(!do_after(caster, 7 SECONDS, target = human_victim))
		human_victim.balloon_alert(caster, "interrupted!")
		return FALSE
	if(ishuman(human_victim))
		switch(rand(1,12))
			if(1)
				var/obj/item/organ/heart/roach/roach_h = new
				var/obj/item/organ/stomach/roach/roach_s = new
				var/obj/item/organ/liver/roach/roach_l = new
				var/obj/item/organ/appendix/roach/roach_ap = new
				roach_h.Insert(human_victim)
				roach_s.Insert(human_victim)
				roach_l.Insert(human_victim)
				roach_ap.Insert(human_victim)
				to_chat(caster, span_warning("You have created a strong and tenacious organs, perhaps it will give its properties to changed one."))
			if(2)
				var/obj/item/organ/eyes/night_vision/rat/rat_e = new
				var/obj/item/organ/heart/rat/rat_h = new
				var/obj/item/organ/stomach/rat/rat_s = new
				var/obj/item/organ/tongue/rat/rat_t = new
				rat_e.Insert(human_victim)
				rat_h.Insert(human_victim)
				rat_s.Insert(human_victim)
				rat_t.Insert(human_victim)
				to_chat(caster, span_warning("You have created the organs of a small, silly creature that loves to bite wires. We all hope the changed one doesn't become the same."))
			if(3)
				var/obj/item/organ/tongue/inky/oink = new
				oink.Insert(human_victim)
				to_chat(caster, span_warning("You have created inky-like tongue for the changed."))
			if(4)
				var/obj/item/organ/eyes/night_vision/goliath/goliath_e = new
				var/obj/item/organ/heart/goliath/goliath_h = new
				var/obj/item/organ/lungs/lavaland/goliath/goliath_l = new
				goliath_e.Insert(human_victim)
				goliath_h.Insert(human_victim)
				goliath_l.Insert(human_victim)
				to_chat(caster, span_warning("You have created something terrible, unpleasant and evil, filled with blood."))
			if(5)
				var/obj/item/organ/heart/carp/carpula_h = new
				var/obj/item/organ/lungs/carp/carpula_l = new
				var/obj/item/organ/tongue/carp/carpula_t = new
				carpula_t.Insert(human_victim)
				carpula_h.Insert(human_victim)
				carpula_l.Insert(human_victim)
				to_chat(caster, span_warning("You have created a beautiful water-living heart and lungs for an equally beautiful changed one. Oh, wait, he can't breath..."))
			if(7)
				// если кому-то это дропнет, будет проблематично вытащить даже со скиллами антага.
				var/obj/item/organ/heart/cybernetic/surplus/surplus_h = new
				var/obj/item/organ/lungs/cybernetic/surplus/surplus_lu = new
				var/obj/item/organ/liver/cybernetic/surplus/surplus_li = new
				surplus_lu.Insert(human_victim)
				surplus_li.Insert(human_victim)
				surplus_h.Insert(human_victim)
				to_chat(caster, span_warning("You have failed in creating something good out of iron and oil. You're better at dealing with the flesh. The changed person will not feel very well."))
			if(8)
				var/obj/item/organ/tail/fish/fish_t = new
				var/obj/item/organ/lungs/fish/fish_l = new
				var/obj/item/organ/stomach/fish/fish_s = new
				fish_t.Insert(human_victim)
				fish_l.Insert(human_victim)
				fish_s.Insert(human_victim)
				to_chat(caster, span_warning("You have created fish organs, It seems like you accidentally added a lot of fish nature..."))
			if(10)
				var/obj/item/organ/heart/corrupt/corrupted_h = new
				var/obj/item/organ/lungs/corrupt/corrupted_l = new
				var/obj/item/organ/tongue/corrupt/corrupted_t = new
				var/obj/item/organ/appendix/corrupt/corrupted_ap = new
				corrupted_h.Insert(human_victim)
				corrupted_l.Insert(human_victim)
				corrupted_t.Insert(human_victim)
				corrupted_ap.Insert(human_victim)
				to_chat(caster, span_warning("You have failed, and what you have created will only do harm."))
			if(11)
				var/obj/item/organ/heart/nightmare/nightmare = new
				nightmare.Insert(human_victim)
				to_chat(caster, span_warning("You have created a heart as dark as night, it is filled with malice and hatred for prosperity and life, and it will surely manifest itself in the changed."))
			if(12)
				var/obj/item/organ/heart/roach/roach_h = new
				var/obj/item/organ/stomach/roach/roach_s = new
				var/obj/item/organ/liver/roach/roach_l = new
				var/obj/item/organ/appendix/roach/roach_ap = new
				roach_h.Insert(human_victim)
				roach_s.Insert(human_victim)
				roach_l.Insert(human_victim)
				roach_ap.Insert(human_victim)
				to_chat(caster, span_warning("You have created a strong and tenacious organs, perhaps it will give its properties to changed one."))

	playsound(victim, 'sound/mobs/non-humanoids/alien/alien_organ_cut.ogg', 50, TRUE)
	if(human_victim.stat == DEAD && !HAS_TRAIT(human_victim, TRAIT_HEMATOCRAT))
		human_victim.revive(HEAL_ADMIN)
		human_victim.visible_message(span_warning("[human_victim] appears to wake from the dead!"), span_notice("You have regenerated."))

	return TRUE

/datum/action/aggressive_intentions
	name = "Aggressive Intentions"
	desc = "Creates a red circle above your head, showing your nature. It has no effects."
	var/activated = FALSE
	button_icon = 'tff_modular/modules/hematocrat/icons/hematocraticons.dmi'
	button_icon_state = "aggressive"
	background_icon = 'icons/mob/actions/backgrounds.dmi'
	background_icon_state = "bg_fugu"
	overlay_icon = 'icons/mob/actions/backgrounds.dmi'
	overlay_icon_state = "bg_fugu_border"

/datum/action/aggressive_intentions/Trigger(trigger_flags)
	var/mob/living/carbon/human = owner
	if(activated)
		deactivate()
		return FALSE

	human.apply_status_effect(/datum/status_effect/aggressive_intentions)
	activated = TRUE

/datum/action/aggressive_intentions/proc/deactivate()
	var/mob/living/carbon/human = owner
	human.remove_status_effect(/datum/status_effect/aggressive_intentions)
	activated = FALSE

/datum/status_effect/aggressive_intentions
	id = "aggressive_intentions"
	alert_type = null
	duration = INFINITY
	status_type = STATUS_EFFECT_REPLACE
	///overlay used to indicate that someone is marked
	var/mutable_appearance/aggressive_overlay
	/// icon file for the overlay
	var/effect_icon = 'tff_modular/modules/hematocrat/icons/smol_effects.dmi'
	/// icon state for the overlay
	var/effect_icon_state = "aggressive_ring"
	/// Storage for the spell caster
	var/datum/weakref/spell_caster

/datum/status_effect/aggressive_intentions/on_creation(mob/living/new_owner, mob/living/new_spell_caster)
	aggressive_overlay = mutable_appearance(effect_icon, effect_icon_state, BELOW_MOB_LAYER)
	if(new_spell_caster)
		spell_caster = WEAKREF(new_spell_caster)
	return ..()

/datum/status_effect/aggressive_intentions/Destroy()
	QDEL_NULL(aggressive_overlay)
	return ..()

/datum/status_effect/aggressive_intentions/on_apply()
	RegisterSignal(owner, COMSIG_ATOM_UPDATE_OVERLAYS, PROC_REF(update_owner_overlay))
	owner.update_appearance(UPDATE_OVERLAYS)
	return TRUE

/// Updates the overlay of the owner
/datum/status_effect/aggressive_intentions/proc/update_owner_overlay(atom/source, list/overlays)
	SIGNAL_HANDLER

	overlays += aggressive_overlay

/datum/status_effect/aggressive_intentions/on_remove()
	UnregisterSignal(owner, COMSIG_ATOM_UPDATE_OVERLAYS)
	owner.update_appearance(UPDATE_OVERLAYS)
	return ..()

/obj/item/melee/touch_attack/flesh_hand
	name = "your hand"
	desc = "What are you waiting for?"
	icon = 'tff_modular/modules/hematocrat/icons/hematocraticons.dmi'
	icon_state = "hand"
	lefthand_file = 'tff_modular/modules/hematocrat/icons/lefthanditems.dmi'
	righthand_file = 'tff_modular/modules/hematocrat/icons/righthanditems.dmi'
	inhand_icon_state = "hand"

// Временно убрано. Через время будет изменено/заменено.
/*
/datum/action/cooldown/spell/touch/blood_mark
	name = "blood mark"
	desc = "Places bloody mark on you and your target. Bloody marks heals you, but deal damages to targets for a 300 seconds."
	button_icon = 'tff_modular/modules/hematocrat/icons/hematocraticons.dmi'
	button_icon_state = "hand"
	background_icon = 'icons/mob/actions/backgrounds.dmi'
	background_icon_state = "bg_fugu"
	overlay_icon = 'icons/mob/actions/backgrounds.dmi'
	overlay_icon_state = "bg_fugu_border"
	cooldown_time = 180 SECONDS
	hand_path = /obj/item/melee/touch_attack/flesh_hand
	can_cast_on_self = FALSE
	spell_requirements = NONE
	invocation_type = NONE
	sound = 'sound/effects/wounds/sizzle1.ogg'

/datum/action/cooldown/spell/touch/blood_mark/cast_on_hand_hit(obj/item/melee/touch_attack/hand, atom/victim, mob/living/carbon/caster)
	var/mob/living/carbon/marked = victim
	var/mob/living/carbon/marker = caster

	if(!istype(marked))
		to_chat(caster, span_warning("Victim must be a human-like creature!"))
		return FALSE

	if(marked.stat == DEAD)
		to_chat(caster, span_warning("Victim must be alive!"))
		return FALSE

	if(!marked.mind)
		to_chat(caster, span_warning("Victim must be a minded creature!"))
		return FALSE

	if(HAS_TRAIT(marked, TRAIT_HEMATOCRAT))
		to_chat(caster, span_warning("Victim must be a human-like creature!"))
		return FALSE

	if(!HAS_TRAIT(marker, TRAIT_HEMATOCRAT))
		to_chat(caster, span_warning("You must choose class first!"))
		return FALSE

	if(!do_after(marker, 10 SECONDS, target = marked))
		marked.balloon_alert(marker, "interrupted!")

	marked.apply_status_effect(/datum/status_effect/blood_mark)
	marker.apply_status_effect(/datum/status_effect/blood_mark)
	marked.adjustBruteLoss(-30)
	marker.adjustBruteLoss(30)
	return TRUE

/datum/status_effect/blood_mark
	id = "blood_mark"
	status_type = STATUS_EFFECT_UNIQUE
	duration = 300 SECONDS
	tick_interval = 2.5 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/blood_mark
	///overlay used to indicate that someone is marked
	var/mutable_appearance/mark_overlay
	/// icon file for the overlay
	var/effect_icon = 'tff_modular/modules/hematocrat/icons/smol_effects.dmi'
	/// icon state for the overlay
	var/effect_icon_state = "mark"
	/// Storage for the spell caster
	var/datum/weakref/spell_caster

/datum/status_effect/blood_mark/on_creation(mob/living/new_owner, mob/living/new_spell_caster)
	mark_overlay = mutable_appearance(effect_icon, effect_icon_state, ABOVE_ALL_MOB_LAYER)
	if(new_spell_caster)
		spell_caster = WEAKREF(new_spell_caster)
	return ..()

/datum/status_effect/blood_mark/Destroy()
	QDEL_NULL(mark_overlay)
	return ..()

/datum/status_effect/blood_mark/on_apply()
	RegisterSignal(owner, COMSIG_ATOM_UPDATE_OVERLAYS, PROC_REF(update_owner_overlay))
	owner.update_appearance(UPDATE_OVERLAYS)
	return TRUE

/// Updates the overlay of the owner
/datum/status_effect/blood_mark/proc/update_owner_overlay(atom/source, list/overlays)
	SIGNAL_HANDLER

	overlays += mark_overlay

/datum/status_effect/blood_mark/on_remove()
	UnregisterSignal(owner, COMSIG_ATOM_UPDATE_OVERLAYS)
	owner.update_appearance(UPDATE_OVERLAYS)
	return ..()

/datum/status_effect/blood_mark/tick(seconds_between_ticks)
	if(owner.stat == DEAD)
		owner.remove_status_effect(/datum/status_effect/blood_mark)

	if(HAS_TRAIT(owner, TRAIT_HEMATOCRAT))
		owner.adjustBruteLoss(-1)
		owner.adjustFireLoss(-1)
		owner.adjustStaminaLoss(-3)
		return FALSE

	owner.adjustBruteLoss(0.3)
	owner.adjustStaminaLoss(0.2)

/atom/movable/screen/alert/status_effect/blood_mark
	name = "the nutrient vessel"
	desc = "There's a mark on your skin! It glows strangely..."
	icon = 'tff_modular/modules/hematocrat/icons/smol_effects.dmi'
	icon_state = "mark"
*/
