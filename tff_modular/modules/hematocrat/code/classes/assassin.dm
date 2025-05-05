// Класс Ассасина. Самый безобидный в бою класс из всех. Даже саппорт более опасен.

// Стелс. Стелс позволяет перейти в режим полуневидимости и скрыть свою личность.
/datum/action/cooldown/spell/bbstealth
	name = "camouflage skin"
	desc = "Blend into the environment."
	button_icon = 'icons/mob/actions/actions_minor_antag.dmi'
	button_icon_state = "ninja_cloak"
	background_icon = 'icons/mob/actions/backgrounds.dmi'
	background_icon_state = "bg_fugu"
	overlay_icon = 'icons/mob/actions/backgrounds.dmi'
	overlay_icon_state = "bg_fugu_border"
	cooldown_time = 0.5 SECONDS
	melee_cooldown_time = 0 SECONDS
	click_to_activate = FALSE
	spell_requirements = NONE
	/// The alpha we go to when sneaking.
	var/sneak_alpha = 75
	/// How long it takes to become transparent
	var/animation_time = 0.5 SECONDS

/datum/action/cooldown/spell/bbstealth/Remove(mob/living/remove_from)
	if(HAS_TRAIT(remove_from, TRAIT_SNEAK))
		remove_from.alpha = initial(remove_from.alpha)
		REMOVE_TRAIT(remove_from, TRAIT_SNEAK, ACTION_TRAIT)
		REMOVE_TRAIT(remove_from, TRAIT_UNKNOWN, ACTION_TRAIT)

	return ..()

/datum/action/cooldown/spell/bbstealth/Activate(atom/target)
	if(HAS_TRAIT(owner, TRAIT_SNEAK))
		animate(owner, alpha = initial(owner.alpha), time = animation_time)
		owner.balloon_alert(owner, "you reveal yourself")
		REMOVE_TRAIT(owner, TRAIT_SNEAK, ACTION_TRAIT)
		REMOVE_TRAIT(owner, TRAIT_UNKNOWN, ACTION_TRAIT)

	else
		animate(owner, alpha = sneak_alpha, time = animation_time)
		owner.balloon_alert(owner, "you blend into the environment")
		ADD_TRAIT(owner, TRAIT_SNEAK, ACTION_TRAIT)
		ADD_TRAIT(owner, TRAIT_UNKNOWN, ACTION_TRAIT)

	return TRUE

// Зрение Ассасина. Дает ХУДы всех очков, ночное зрение, иксрей, зрение через стены и темноту. Глаза ассасина при активации становятся красными, что можно обнаружить при экзамайне.
// Считать это дебаффом не стоит - можно просто очками закрыть.
/datum/action/cooldown/spell/bbvision
	name = "assassin vision"
	desc = "Gives you xray, night vision and all HUDs, but at the same time, your eyes start to glow strangely and anyone can see it!"
	button_icon = 'icons/mob/actions/actions_cult.dmi'
	button_icon_state = "horror"
	background_icon = 'icons/mob/actions/backgrounds.dmi'
	background_icon_state = "bg_fugu"
	overlay_icon = 'icons/mob/actions/backgrounds.dmi'
	overlay_icon_state = "bg_fugu_border"
	cooldown_time = 0.5 SECONDS
	melee_cooldown_time = 0 SECONDS
	click_to_activate = FALSE
	spell_requirements = NONE

/datum/action/cooldown/spell/bbvision/Remove(mob/living/remove_from)
	if(HAS_TRAIT(remove_from, TRAIT_BLOODSHOT_EYES))
		REMOVE_TRAIT(remove_from, TRAIT_TRUE_NIGHT_VISION, ACTION_TRAIT)
		REMOVE_TRAIT(remove_from, TRAIT_HEAR_THROUGH_DARKNESS, ACTION_TRAIT)
		REMOVE_TRAIT(remove_from, TRAIT_BLOODSHOT_EYES, ACTION_TRAIT)
		REMOVE_TRAIT(remove_from, TRAIT_UNNATURAL_RED_GLOWY_EYES, ACTION_TRAIT)
		REMOVE_TRAIT(remove_from, TRAIT_XRAY_VISION, ACTION_TRAIT)
		REMOVE_TRAIT(remove_from, TRAIT_XRAY_HEARING, ACTION_TRAIT)
		REMOVE_TRAIT(remove_from, TRAIT_SECURITY_HUD, ACTION_TRAIT)
		REMOVE_TRAIT(remove_from, TRAIT_MEDICAL_HUD, ACTION_TRAIT)
		REMOVE_TRAIT(remove_from, TRAIT_DIAGNOSTIC_HUD, ACTION_TRAIT)
		REMOVE_TRAIT(remove_from, TRAIT_TRUE_NIGHT_VISION, ACTION_TRAIT)
	return ..()

/datum/action/cooldown/spell/bbvision/Activate(atom/target)
	if(HAS_TRAIT(owner, TRAIT_BLOODSHOT_EYES))
		owner.balloon_alert(owner, "Assassin vision removed")
		REMOVE_TRAIT(owner, TRAIT_TRUE_NIGHT_VISION, ACTION_TRAIT)
		REMOVE_TRAIT(owner, TRAIT_HEAR_THROUGH_DARKNESS, ACTION_TRAIT)
		REMOVE_TRAIT(owner, TRAIT_BLOODSHOT_EYES, ACTION_TRAIT)
		REMOVE_TRAIT(owner, TRAIT_UNNATURAL_RED_GLOWY_EYES, ACTION_TRAIT)
		REMOVE_TRAIT(owner, TRAIT_XRAY_VISION, ACTION_TRAIT)
		REMOVE_TRAIT(owner, TRAIT_XRAY_HEARING, ACTION_TRAIT)
		REMOVE_TRAIT(owner, TRAIT_SECURITY_HUD, ACTION_TRAIT)
		REMOVE_TRAIT(owner, TRAIT_MEDICAL_HUD, ACTION_TRAIT)
		REMOVE_TRAIT(owner, TRAIT_DIAGNOSTIC_HUD, ACTION_TRAIT)
		REMOVE_TRAIT(owner, TRAIT_TRUE_NIGHT_VISION, ACTION_TRAIT)

	else
		owner.balloon_alert(owner, "Assassin vision activated")
		ADD_TRAIT(owner, TRAIT_TRUE_NIGHT_VISION, ACTION_TRAIT)
		ADD_TRAIT(owner, TRAIT_HEAR_THROUGH_DARKNESS, ACTION_TRAIT)
		ADD_TRAIT(owner, TRAIT_BLOODSHOT_EYES, ACTION_TRAIT)
		ADD_TRAIT(owner, TRAIT_UNNATURAL_RED_GLOWY_EYES, ACTION_TRAIT)
		ADD_TRAIT(owner, TRAIT_XRAY_VISION, ACTION_TRAIT)
		ADD_TRAIT(owner, TRAIT_XRAY_HEARING, ACTION_TRAIT)
		ADD_TRAIT(owner, TRAIT_SECURITY_HUD, ACTION_TRAIT)
		ADD_TRAIT(owner, TRAIT_MEDICAL_HUD, ACTION_TRAIT)
		ADD_TRAIT(owner, TRAIT_DIAGNOSTIC_HUD, ACTION_TRAIT)
		ADD_TRAIT(owner, TRAIT_TRUE_NIGHT_VISION, ACTION_TRAIT)

	return TRUE

// Дым. Создает красное облако дыма на уровне облака священника.
/datum/action/cooldown/spell/smoke/lesser/bbsmoke
	name = "boil the blood"
	desc = "Creates a red cloud in a radius around."
	background_icon = 'icons/mob/actions/backgrounds.dmi'
	background_icon_state = "bg_fugu"
	overlay_icon = 'icons/mob/actions/backgrounds.dmi'
	overlay_icon_state = "bg_fugu_border"
	cooldown_time = 20 SECONDS

/obj/effect/particle_effect/fluid/smoke/bloody
	color = "#9C3636"

// Кража - способность позволяет красть вещи из рюкзака на расстоянии 7 тайлов.
/datum/action/cooldown/spell/pointed/burglar_finesse/bbsteal
	name = "thief Steal"
	desc = "Steal a random item from the victim's backpack."
	background_icon = 'icons/mob/actions/backgrounds.dmi'
	background_icon_state = "bg_fugu"
	overlay_icon = 'icons/mob/actions/backgrounds.dmi'
	overlay_icon_state = "bg_fugu_border"
	button_icon = 'icons/mob/actions/actions_ecult.dmi'
	button_icon_state = "burglarsfinesse"

	school = SCHOOL_FORBIDDEN
	cooldown_time = 20 SECONDS

	invocation_type = INVOCATION_NONE
	spell_requirements = NONE

	cast_range = 7

// Дэш - рывок, который больше напоминает телепорт. Можно увидеть у пешек средневековых пиратов.
/datum/action/cooldown/mob_cooldown/dash/bbdash
	name = "dash"
	button_icon = 'icons/mob/actions/actions_spells.dmi'
	button_icon_state = "lace"
	background_icon = 'icons/mob/actions/backgrounds.dmi'
	background_icon_state = "bg_fugu"
	overlay_icon = 'icons/mob/actions/backgrounds.dmi'
	overlay_icon_state = "bg_fugu_border"
	cooldown_time = 7 SECONDS

// Взлом - позволяет взломать какой-либо механизм на расстоянии 7 тайлов. Не работает на боргов/мехов.
/datum/action/cooldown/spell/pointed/bbhack
	name = "machinery manipulatin"
	desc = "Click on any machine, excepting cyborgs, to hack them. Has a 7 tiles range. Creates a blood-red line between the machinery and the caster."
	active_msg = null
	deactive_msg = null
	button_icon = 'icons/mob/actions/actions_AI.dmi'
	button_icon_state = "roll_over"
	background_icon = 'icons/mob/actions/backgrounds.dmi'
	background_icon_state = "bg_fugu"
	overlay_icon = 'icons/mob/actions/backgrounds.dmi'
	overlay_icon_state = "bg_fugu_border"
	spell_requirements = NONE
	cooldown_time = 5 SECONDS
	ranged_mousepointer = 'icons/effects/mouse_pointers/supplypod_target.dmi'
	var/hack_range = 7

/datum/action/cooldown/spell/pointed/bbhack/is_valid_target(atom/cast_on)
	. = ..()

	if(ismob(cast_on))
		owner.balloon_alert(owner, "security too strong")
		return FALSE

	if(get_dist(owner, cast_on) > hack_range)
		owner.balloon_alert(owner, "too far away")
		return FALSE

	return TRUE

/datum/action/cooldown/spell/pointed/bbhack/cast(atom/cast_on)
	. = ..()

	unset_click_ability(owner)

	playsound(owner, 'sound/effects/light_flicker.ogg', 50, TRUE)
	var/beam = owner.Beam(cast_on, icon_state = "sendbeam", time = 1 SECONDS)

	if(!do_after(owner, 1 SECONDS, cast_on, IGNORE_SLOWDOWNS))
		qdel(beam)
		StartCooldown(1 SECONDS) // Resets the spell to working after a second, just so its not spammed
		return

	if(!cast_on.emag_act(owner))
		owner.balloon_alert(owner, "can't hack this!")
		StartCooldown(1 SECONDS) // Resets the spell to working after a second, just so its not spammed
		return

	owner.log_message("hacked [key_name(cast_on)] from [get_dist(owner, cast_on)] tiles away using a hematocrat hacking ability!", LOG_ATTACK)
	cast_on.forensics?.add_hacking_implant_trace()
	cast_on.add_hiddenprint(owner)

	playsound(cast_on, 'sound/machines/terminal/terminal_processing.ogg', 15, TRUE)
