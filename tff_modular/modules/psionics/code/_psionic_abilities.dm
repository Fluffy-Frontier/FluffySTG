// Тут хранятся некрасивые базовые классы и прочее. Не смотрите сюда.

/datum/action/cooldown/spell
	// Сколько маны стоит кастануть спелл
	var/mana_cost = 10
	// Некоторые спеллы могут отнимать стамину
	var/stamina_cost = 0
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
	var/category = "utility"
	// Цена
	var/point_cost = 1
	// Текст помощи
	var/helptext = ""
	// Доступ
	var/locked = TRUE

/datum/action/cooldown/spell/Grant(mob/grant_to)
	. = ..()
	if(psionic)
		var/mob/living/our_psionic = grant_to
		psionic_datum = our_psionic.get_psionic()
		cast_power = psionic_datum.psionic_level

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
	locked = FALSE

/datum/action/cooldown/spell/conjure_item/psionic/New(Target, power)
	. = ..()
	cast_power = power

// Проверяем достаточно ли маны
/datum/action/cooldown/spell/proc/check_for_mana()
	var/mob/living/carbon/human/caster = owner
	var/datum/psionic/psi_holder = caster.get_psionic()
	if(psi_holder)
		return TRUE
	else
		return FALSE

// Сосём ману у псионика
/datum/action/cooldown/spell/proc/drain_mana()
	var/mob/living/carbon/human/caster = owner
	var/datum/psionic/psi_holder = caster.get_psionic()
	caster.adjust_stamina_loss(stamina_cost, forced = TRUE)
	if(psi_holder)
		psi_holder.adjust_psi_energy(-mana_cost)
		return TRUE
	else
		return FALSE

/datum/action/cooldown/spell/conjure_item/psionic/can_cast_spell(feedback)
	. = ..()
	if(!.)
		return FALSE

	if(!check_for_mana())
		return FALSE
	else
		return TRUE

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
	locked = FALSE

/datum/action/cooldown/spell/psionic/New(Target, power, additional_school)
	. = ..()
	cast_power = power

/datum/action/cooldown/spell/psionic/can_cast_spell(feedback)
	. = ..()
	if(!.)
		return FALSE

	if(!check_for_mana())
		return FALSE
	else
		return TRUE

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
	locked = FALSE
	cast_range = 7

/datum/action/cooldown/spell/pointed/projectile/psionic/New(Target, power, additional_school)
	. = ..()
	cast_power = power

/datum/action/cooldown/spell/pointed/projectile/psionic/can_cast_spell(feedback)
	. = ..()
	if(!.)
		return FALSE

	if(!check_for_mana())
		return FALSE
	else
		return TRUE

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
	locked = FALSE
	cast_range = 7

/datum/action/cooldown/spell/pointed/psionic/New(Target, power, additional_school)
	. = ..()
	cast_power = power

/datum/action/cooldown/spell/pointed/psionic/can_cast_spell(feedback)
	. = ..()
	if(!.)
		return FALSE

	if(!check_for_mana())
		return FALSE
	else
		return TRUE

// Спеллы которыми надо каснуться чего либо
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
	locked = FALSE

/datum/action/cooldown/spell/touch/psionic/New(Target, power, additional_school)
	. = ..()
	cast_power = power

/datum/action/cooldown/spell/touch/psionic/can_cast_spell(feedback)
	. = ..()
	if(!.)
		return FALSE

	if(!check_for_mana())
		return FALSE
	else
		return TRUE

/datum/action/cooldown/spell/touch/psionic/create_hand(mob/living/carbon/cast_on)
	. = ..()
	if(!.)
		return .
	var/obj/item/bodypart/transfer_limb = cast_on.get_active_hand()
	if(IS_ROBOTIC_LIMB(transfer_limb))
		to_chat(cast_on, span_notice("You fail to channel your psionic powers through your inorganic hand."))
		return FALSE

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
