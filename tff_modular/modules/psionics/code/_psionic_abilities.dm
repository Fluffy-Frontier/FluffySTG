// Тут хранятся некрасивые базовые классы и прочее. Не смотрите сюда.

/datum/action/cooldown/spell
	// Сколько маны стоит кастануть спелл
	var/mana_cost = 10
	// Что написать жертве
	var/target_msg
	// Сила способности
	var/cast_power = 0
	// Является псионическим спеллом? Нужен чтобы потом удалить их
	var/psionic = FALSE
	// Уровень способности, определяет может ли ее купить псионик
	var/psionic_level = 1
	// Датум псионики что используется при касте
	var/datum/psionic/psionic_datum
	// Категория
	var/category = "Tier 1"
	// Цена
	var/point_cost = 1
	// Текст помощи
	var/helptext = ""
	// Доступ
	var/locked = TRUE
	// Игнорируем ли мы подавление/отсутствие маны?
	var/ignore_suppression = FALSE

/datum/action/cooldown/spell/Grant(mob/grant_to)
	. = ..()
	if(psionic)
		var/mob/living/our_psionic = grant_to
		psionic_datum = our_psionic.get_psionic()
		cast_power = psionic_datum.psionic_level

/datum/action/cooldown/spell/update_button_name(atom/movable/screen/movable/action_button/button, force)
	. = ..()
	if(mana_cost)
		button.desc += " Costs [mana_cost] Psi Energy."

// Спеллы для призвания предмета
/datum/action/cooldown/spell/conjure_item/psionic
	button_icon = 'tff_modular/modules/psionics/icons/spells.dmi'
	background_icon_state = "bg_tech_blue"
	overlay_icon_state = "bg_tech_blue_border"
	delete_old = FALSE
	delete_on_failure = TRUE
	requires_hands = TRUE
	// Псионические способности (в основном) не блокируются, но выводят особенные сообщения тем, кто это может
	antimagic_flags = MAGIC_RESISTANCE_MIND
	spell_requirements = NONE
	cooldown_reduction_per_rank = 0 SECONDS
	psionic = TRUE

// Проверяем достаточно ли маны
/datum/action/cooldown/spell/proc/check_for_mana()
	var/mob/living/carbon/human/caster = owner
	var/datum/psionic/psi_holder = caster.get_psionic()
	if(!psi_holder)
		return FALSE
	if(HAS_TRAIT(caster, TRAIT_PSIONIC_EXHAUSTION))
		return FALSE
	if(HAS_TRAIT(caster, TRAIT_PSIONIC_SUPPRESSED))
		if(ignore_suppression)
			return TRUE
		return FALSE
	return TRUE

// Сосём ману у псионика
/datum/action/cooldown/spell/proc/drain_mana()
	var/mob/living/carbon/human/caster = owner
	var/datum/psionic/psi_holder = caster.get_psionic()
	if(psi_holder)
		psi_holder.adjust_psi_energy(-mana_cost)
		return TRUE
	else
		return FALSE

/datum/action/cooldown/spell/conjure_item/psionic/before_cast(atom/cast_on)
	. = ..()
	if(!check_for_mana())
		return SPELL_CANCEL_CAST

/datum/action/cooldown/spell/conjure_item/psionic/cast(atom/cast_on)
	drain_mana()
	return ..()

// Для спеллов которые применяются на себя тыком кнопки a.k.a. выдача генов
/datum/action/cooldown/spell/psionic
	button_icon = 'tff_modular/modules/psionics/icons/spells.dmi'
	background_icon_state = "bg_tech_blue"
	overlay_icon_state = "bg_tech_blue_border"
	// Псионические способности (в основном) не блокируются, но выводят особенные сообщения тем, кто это может
	antimagic_flags = MAGIC_RESISTANCE_MIND

	school = SCHOOL_UNSET
	invocation_type = INVOCATION_NONE
	spell_requirements = NONE
	cooldown_reduction_per_rank = 0 SECONDS
	psionic = TRUE
	psionic_level = 1

/datum/action/cooldown/spell/psionic/before_cast(atom/cast_on)
	. = ..()
	if(!check_for_mana())
		return SPELL_CANCEL_CAST

// Спеллы для пострелушек
/datum/action/cooldown/spell/pointed/projectile/psionic
	button_icon = 'tff_modular/modules/psionics/icons/spells.dmi'
	background_icon_state = "bg_tech_blue"
	overlay_icon_state = "bg_tech_blue_border"
	// Псионические способности (в основном) не блокируются, но выводят особенные сообщения тем, кто это может
	antimagic_flags = MAGIC_RESISTANCE_MIND

	school = SCHOOL_UNSET
	invocation_type = INVOCATION_NONE
	spell_requirements = NONE
	cooldown_reduction_per_rank = 0 SECONDS
	psionic = TRUE
	cast_range = 7

/datum/action/cooldown/spell/pointed/projectile/psionic/before_cast(atom/cast_on)
	. = ..()
	if(!check_for_mana())
		return SPELL_CANCEL_CAST

// Направленные спеллы a.k.a. псионик выбирают цель на дистанции
/datum/action/cooldown/spell/pointed/psionic
	button_icon = 'tff_modular/modules/psionics/icons/spells.dmi'
	background_icon_state = "bg_tech_blue"
	overlay_icon_state = "bg_tech_blue_border"
	// Псионические способности (в основном) не блокируются, но выводят особенные сообщения тем, кто это может
	antimagic_flags = MAGIC_RESISTANCE_MIND
	school = SCHOOL_UNSET
	invocation_type = INVOCATION_NONE
	spell_requirements = NONE
	cooldown_reduction_per_rank = 0 SECONDS
	psionic = TRUE
	cast_range = 7

/datum/action/cooldown/spell/pointed/psionic/before_cast(atom/cast_on)
	. = ..()
	if(!check_for_mana())
		return SPELL_CANCEL_CAST

// Спеллы которыми надо коснуться чего либо. Перед активацией имеется "этап активации" заклинания.
/datum/action/cooldown/spell/touch/psionic
	button_icon = 'tff_modular/modules/psionics/icons/spells.dmi'
	background_icon_state = "bg_tech_blue"
	overlay_icon_state = "bg_tech_blue_border"
	// Псионические способности (в основном) не блокируются, но выводят особенные сообщения тем, кто это может
	antimagic_flags = MAGIC_RESISTANCE_MIND
	school = SCHOOL_UNSET
	invocation_type = INVOCATION_NONE
	spell_requirements = NONE
	psionic = TRUE
	var/channel_message
	var/currently_channeling = FALSE
	var/channel_time = 1 SECONDS
	var/channel_flags = IGNORE_USER_LOC_CHANGE|IGNORE_HELD_ITEM
	var/charge_overlay_icon = 'icons/effects/effects.dmi'
	var/charge_overlay_state = "lighting"
	var/mutable_appearance/charge_overlay_instance
	var/charge_sound = 'tff_modular/modules/psionics/sounds/power_evoke.ogg'
	var/sound/charge_sound_instance

/datum/action/cooldown/spell/touch/psionic/New(Target, original)
	. = ..()
	if(!channel_message)
		channel_message = span_notice("You start charging [src]...")

	if(charge_sound)
		charge_sound_instance = sound(charge_sound, channel = CHANNEL_CHARGED_SPELL)

	if(charge_overlay_icon && charge_overlay_state)
		charge_overlay_instance = mutable_appearance(charge_overlay_icon, charge_overlay_state, EFFECTS_LAYER)


/datum/action/cooldown/spell/touch/psionic/Destroy()
	if(owner)
		stop_channel_effect(owner)

	charge_overlay_instance = null
	charge_sound_instance = null
	return ..()

/datum/action/cooldown/spell/touch/psionic/Remove(mob/living/remove_from)
	stop_channel_effect(remove_from)
	return ..()

/datum/action/cooldown/spell/touch/psionic/is_action_active(atom/movable/screen/movable/action_button/current_button)
	return currently_channeling

/datum/action/cooldown/spell/touch/psionic/can_cast_spell(feedback = TRUE)
	. = ..()
	if(!.)
		return FALSE
	if(currently_channeling)
		if(feedback)
			to_chat(owner, span_warning("You're already channeling [src]!"))
		return FALSE
	if(!check_for_mana())
		return FALSE
	return TRUE


/datum/action/cooldown/spell/touch/psionic/before_cast(atom/cast_on)
	. = ..()
	if(. & SPELL_CANCEL_CAST)
		return
	if(!check_for_mana())
		return SPELL_CANCEL_CAST
	to_chat(owner, channel_message)

	if(charge_sound_instance)
		playsound(owner, charge_sound_instance, 50, FALSE)

	if(charge_overlay_instance)
		owner.add_overlay(charge_overlay_instance)

	currently_channeling = TRUE
	build_all_button_icons(UPDATE_BUTTON_STATUS)
	if(!do_after(owner, channel_time, timed_action_flags = channel_flags))
		stop_channel_effect(owner)
		return . | SPELL_CANCEL_CAST

/datum/action/cooldown/spell/touch/psionic/cast(atom/cast_on)
	. = ..()
	stop_channel_effect(owner)

/datum/action/cooldown/spell/touch/psionic/proc/stop_channel_effect(mob/for_who)
	if(charge_overlay_instance)
		for_who.cut_overlay(charge_overlay_instance)

	if(charge_sound_instance)
		for_who.stop_sound_channel(CHANNEL_CHARGED_SPELL)
		playsound(for_who, sound(null, repeat = 0, channel = CHANNEL_CHARGED_SPELL), 50, FALSE)

	currently_channeling = FALSE
	build_all_button_icons(UPDATE_BUTTON_STATUS)

/datum/action/cooldown/spell/touch/psionic/create_hand(mob/living/carbon/cast_on)
	. = ..()
	if(!.)
		return .
	return TRUE

/particles/droplets/psionic
	icon = 'icons/effects/particles/generic.dmi'
	icon_state = list("dot"=2,"drop"=1)
	width = 32
	height = 36
	count = 20
	spawning = 0.2
	lifespan = 1.5 SECONDS
	fade = 0.5 SECONDS
	color = "#00a2ff"
	position = generator(GEN_BOX, list(-9,-9,0), list(9,18,0), NORMAL_RAND)
	scale = generator(GEN_VECTOR, list(0.9,0.9), list(1.1,1.1), NORMAL_RAND)
	gravity = list(0, 0.95)
