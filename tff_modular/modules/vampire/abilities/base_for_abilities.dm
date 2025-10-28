#define FACTION_VAMPIRE "vampire"
// Основа для способностей вампира.
/datum/action/cooldown/vampire
	button_icon = 'tff_modular/modules/vampire/actions.dmi'
	background_icon = 'tff_modular/modules/vampire/actions.dmi'
	overlay_icon = 'tff_modular/modules/vampire/actions.dmi'
	background_icon_state = "bg_vampire"
	// Количество требуемой крови для активации способности.
	var/required_blood = 0

// Проверка на доступность. Если нет достаточного количества крови - недоступна.
/datum/action/cooldown/vampire/IsAvailable(feedback)
	. = ..()
	if (!.)
		return
	var/mob/living/carbon/human/vamp_human = owner
	var/datum/antagonist/vampire/vamp = vamp_human.mind?.has_antag_datum(/datum/antagonist/vampire)
	if(vamp.current_blood_level < required_blood)
		to_chat(vamp_human, span_danger("You have not enough blood to use this action."))
		return FALSE
	return TRUE

// Функция отвечающая за потребление крови.
/datum/action/cooldown/vampire/Activate(atom/target)
	. = ..()
	var/mob/living/carbon/human/vamp_human = owner
	var/datum/antagonist/vampire/vamp = vamp_human.mind?.has_antag_datum(/datum/antagonist/vampire)
	vamp.current_blood_level -= required_blood

//-----------------------------------------------------------------------------//

// Основа для вампирских статус эффектов.
/atom/movable/screen/alert/status_effect/vampire
	icon = 'tff_modular/modules/vampire/actions.dmi'

//-----------------------------------------------------------------------------//

// Основа подклассов
/datum/vampire_subclass
	/// Лист способностей которые открываются по мере достижения крови.
	var/list/standard_powers
	/// Сила стаминурона способности "Glare"
	var/glare_power_mod = 1

// Функция для добавления способностей класса
/datum/vampire_subclass/proc/add_subclass_ability(mob/living/who_giving)
	var/datum/antagonist/vampire/vamp = who_giving.mind?.has_antag_datum(/datum/antagonist/vampire)
	for(var/thing in standard_powers)
		if(locate(thing) in vamp.powers)
			continue
		if(vamp.general_blood_level >= standard_powers[thing])
			vamp.force_add_ability(thing)

//-----------------------------------------------------------------------------//
