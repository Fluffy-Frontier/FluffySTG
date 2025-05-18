// Класс Брата. Хилер и призыватель. Используется как поддержка.

// Аура - лечебная аура с расстоянием 7 тайлов. Лечит в тик: брут и берн по 1.5 единицы, 1 единицу токсина, 2 единицы удушения, 0.3 единицы ран, 0.3 единицы крови.
/datum/action/cooldown/bbaura
	name = "hematocrat aura"
	desc = "Hematocrats and you in a range of 7 tiles will get passive healing that removes that types of damage: brute, burn, toxin, suffocation, wounds. Works better when there's a two brothers with auras!"
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

/datum/action/cooldown/bbaura/Activate()

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
	toxin_heal = 1, \
	suffocation_heal = 2,  \
	wound_clotting = 0.3, \
	blood_heal = 0.3, \
	limit_to_trait = TRAIT_HEMATOCRAT, \
	healing_color = aura_healing_color \
	)
	return TRUE

/datum/action/cooldown/bbaura/proc/aura_deactivate()
	if(!aura_active)
		return
	aura_active = FALSE
	QDEL_NULL(aura_healing_component)
	owner.balloon_alert(owner, "healing aura removed")

// Кровавый джаунт. Навык просто позволяет телепортироваться на некоторое расстояние.
/datum/action/cooldown/spell/jaunt/ethereal_jaunt/bbjaunt
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
	jaunt_in_time = 3 SECONDS
	jaunt_type = /obj/effect/dummy/phased_mob/spell_jaunt/red
	jaunt_in_type = /obj/effect/temp_visual/dir_setting/blood_in
	jaunt_out_type = /obj/effect/temp_visual/dir_setting/blood_in/out

/datum/action/cooldown/spell/jaunt/ethereal_jaunt/bbjaunt/do_steam_effects()
	return

/obj/effect/temp_visual/dir_setting/blood_in
	name = "blood_in"
	icon = 'icons/effects/cult.dmi'
	icon_state = "bloodin"
	duration = 1.3 SECONDS

/obj/effect/temp_visual/dir_setting/blood_in/out
	icon = 'icons/effects/cult.dmi'
	icon_state = "bloodout"

/datum/action/cooldown/spell/touch/flesh_restoration
	name = "flesh Restoration"
	desc = "Restores target brute, burn and toxin damage in short time."
	button_icon = 'icons/mob/actions/actions_changeling.dmi'
	button_icon_state = "fleshmend"
	background_icon = 'icons/mob/actions/backgrounds.dmi'
	background_icon_state = "bg_fugu"
	overlay_icon = 'icons/mob/actions/backgrounds.dmi'
	overlay_icon_state = "bg_fugu_border"
	cooldown_time = 180 SECONDS
	hand_path = /obj/item/melee/touch_attack/flesh_hand
	can_cast_on_self = TRUE
	spell_requirements = NONE
	invocation_type = NONE

/datum/action/cooldown/spell/touch/flesh_restoration/cast_on_hand_hit(obj/item/melee/touch_attack/hand, atom/victim, mob/living/carbon/caster)
	var/mob/living/restor_target = victim

	if(!istype(restor_target))
		return FALSE

	restor_target.adjustBruteLoss(-40)
	restor_target.adjustFireLoss(-40)
	restor_target.adjustToxLoss(-30)
	return TRUE

// Кровавые лезвия. Призывает несколько кровавых лезвий.

/datum/action/cooldown/spell/aoe/magic_missile/bbmissle
	name = "bloody slash"
	desc = "You creates several, slow moving, bloody projectiles at nearby targets."
	button_icon = 'icons/mob/actions/actions_spells.dmi'
	button_icon_state = "scream_for_me"
	background_icon = 'icons/mob/actions/backgrounds.dmi'
	background_icon_state = "bg_fugu"
	overlay_icon = 'icons/mob/actions/backgrounds.dmi'
	overlay_icon_state = "bg_fugu_border"
	projectile_type = /obj/projectile/magic/aoe/soulslash
	cooldown_time = 60 SECONDS
	spell_requirements = NONE
	invocation_type = INVOCATION_NONE
	max_targets = 6

/obj/projectile/magic/aoe/soulslash
	name = "bloody slash"
	icon_state = "soulslash"
	range = 100
	speed = 0.35
	trigger_range = 0
	can_only_hit_target = TRUE
	paralyze = 1.5 SECONDS
	damage = 0
	hitsound = 'sound/effects/magic/mm_hit.ogg'
	trail = FALSE
