// Класс Брата. Хилер и призыватель. Используется как поддержка.

// Аура - лечебная аура с расстоянием 7 тайлов. Лечит в тик: брут и берн по 1.5 единицы, 1 единицу токсина, 2 единицы удушения, 0.3 единицы ран, 0.3 единицы крови.
/datum/action/cooldown/hematocrat_aura
	name = "hematocrat aura"
	desc = "Hematocrats and you in a range of 7 tiles will get passive healing that removes that types of damage: brute, burn, toxin, suffocation, wounds, stamina. Works better when there's a two brothers with auras!"
	background_icon = 'icons/mob/actions/backgrounds.dmi'
	background_icon_state = "bg_fugu"
	overlay_icon = 'icons/mob/actions/backgrounds.dmi'
	overlay_icon_state = "bg_fugu_border"
	button_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "berserk_mode"
	cooldown_time = 1 SECONDS
	var/aura_active = FALSE
	var/aura_duration = INFINITY
	var/aura_range = 7
	var/aura_healing_color = COLOR_RED
	var/datum/component/aura_healing/aura_healing_component

/datum/action/cooldown/hematocrat_aura/Activate()

	if(aura_active)
		aura_deactivate()
		return FALSE
	owner.balloon_alert(owner, "healing aura started")
	to_chat(owner, span_danger("We begin to transfer the recovery cells to our hematocrats around us, healing every hematocrat in range and yourself."))
	aura_active = TRUE
	aura_healing_component = owner.AddComponent( \
		/datum/component/aura_healing, \
		range = aura_range, \
		requires_visibility = FALSE, \
		brute_heal = 1.5, \
		burn_heal = 1.5, \
		toxin_heal = 3, \
		suffocation_heal = 5, \
		stamina_heal = 2, \
		wound_clotting = 0.2, \
		blood_heal = 0.3, \
		limit_to_trait = TRAIT_HEMATOCRAT, \
		healing_color = aura_healing_color, \
	)
	return TRUE

/datum/action/cooldown/hematocrat_aura/proc/aura_deactivate()
	if(!aura_active)
		return
	aura_active = FALSE
	QDEL_NULL(aura_healing_component)
	owner.balloon_alert(owner, "healing aura removed")

// Кровавый джаунт. Навык просто позволяет телепортироваться на некоторое расстояние.
/datum/action/cooldown/spell/jaunt/ethereal_jaunt/red_jaunt
	name = "blood passage"
	desc = "A short range ability that allows you to pass unimpeded through walls."
	button_icon = 'icons/mob/actions/actions_cult.dmi'
	button_icon_state = "tele"
	background_icon = 'icons/mob/actions/backgrounds.dmi'
	background_icon_state = "bg_fugu"
	overlay_icon = 'icons/mob/actions/backgrounds.dmi'
	overlay_icon_state = "bg_fugu_border"
	sound = null

	school = SCHOOL_FORBIDDEN
	cooldown_time = 30 SECONDS
	invocation_type = INVOCATION_NONE
	spell_requirements = NONE

	exit_jaunt_sound = null
	jaunt_duration = 3 SECONDS
	jaunt_in_time = 1 SECONDS
	jaunt_type = /obj/effect/dummy/phased_mob/spell_jaunt/red
	jaunt_in_type = /obj/effect/temp_visual/dir_setting/blood_in
	jaunt_out_type = /obj/effect/temp_visual/dir_setting/blood_in/out

/datum/action/cooldown/spell/jaunt/ethereal_jaunt/red_jaunt/do_steam_effects()
	return

/obj/effect/temp_visual/dir_setting/blood_in
	name = "blood_in"
	icon = 'icons/effects/cult.dmi'
	icon_state = "bloodin"
	duration = 1.3 SECONDS

/obj/effect/temp_visual/dir_setting/blood_in/out
	icon = 'icons/effects/cult.dmi'
	icon_state = "bloodout"

/datum/action/cooldown/spell/pointed/projectile/hematocrat
	name = "blood spit"
	desc = "Spit a infected blood at target, with having chance of infecting someone."
	button_icon = 'tff_modular/modules/hematocrat/icons/hematocraticons.dmi'
	button_icon_state = "limb"
	background_icon = 'icons/mob/actions/backgrounds.dmi'
	background_icon_state = "bg_fugu"
	overlay_icon = 'icons/mob/actions/backgrounds.dmi'
	overlay_icon_state = "bg_fugu_border"
	school = SCHOOL_EVOCATION
	cooldown_time = 25 SECONDS
	sound = 'sound/effects/meatslap.ogg'
	invocation_type = INVOCATION_NONE
	spell_requirements = NONE
	active_msg = "You prepare to spit your blood!"
	deactive_msg = "You closed your mouth... For now."
	cast_range = 8
	projectile_type = /obj/projectile/bloodspit
	projectiles_per_fire = 1
	projectile_amount = 2

/obj/projectile/bloodspit
	name = "blood spit"
	icon_state = "vileworm"
	damage = 15
	armour_penetration = 100
	damage_type = BRUTE

/obj/projectile/bloodspit/on_hit(atom/target, blocked, pierce_hit)
	. = ..()
	if(isliving(target))
		var/mob/living/carbon/human/creature = target
		if(HAS_TRAIT(creature, TRAIT_HEMATOCRAT))
			return FALSE

		creature.adjust_disgust(2, 2)
		if(prob(15))
			creature.drop_all_held_items()
			creature.emote("cough")
			creature.adjust_disgust(4, 4)
			creature.ForceContractDisease(new /datum/disease/piuc(), FALSE, TRUE)
			creature.adjustBruteLoss(5)
