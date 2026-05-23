#define SENSITIVE_PSIONIC "Sensitive Psionic"
#define HARMONIOUS_PSIONIC "Harmonious Psionic"

/mob/living
	var/datum/psionic/psi_sensivity

/mob/living/proc/add_psionic(psi_type, remove_old)
	if(!psi_type)
		psi_type = new /datum/psionic/sensitive()
	if(!istype(psi_type, /datum/psionic))
		return FALSE
	if(get_psionic())
		remove_psionic()
	var/datum/psionic/new_psi = new psi_type()
	new_psi.apply_to(src)

	return FALSE

/mob/living/proc/remove_psionic()
	if(!psi_sensivity)
		return FALSE
	QDEL_NULL(psi_sensivity)

/mob/living/proc/get_psionic()
	if(!psi_sensivity)
		return FALSE
	return psi_sensivity

/datum/psionic
	// Текущий владелец псионики
	var/mob/living/psi_owner
	// Текущий уровень маны
	var/mana_level = 10
	// Максимально возможный уровень маны
	var/max_mana = 10
	// Уровень псионических способностей
	var/psionic_level = 0
	// Строка для описания уровня
	var/psionic_level_string
	// Псионические очки, нужные для получения способностей
	var/psi_point = 0
	// Требуется ли выдать лицензию
	var/license = FALSE
	/// Два вара скопированные из item_quirk для правильной выдачи лицензии
	var/list/where_items_spawned
	var/open_backpack = FALSE
	// Магазин
	var/datum/psionic_shop/psi_shop_datum
	// Включалка магазина
	var/datum/action/psionic_shop/psi_shop_action
	// Список заклинаний
	var/list/datum/action/cooldown/spell/learned_spells = list()
	// Эта переменная, если равна FALSE, не позволяет как-либо усилить псионика.
	var/zona_bovinae = TRUE

/datum/psionic/proc/apply_to(mob/living/granted_to)
	if(!granted_to)
		CRASH("Tried to add psionic without owner")

	psi_owner = granted_to
	granted_to.psi_sensivity = src
	ADD_TRAIT(granted_to, TRAIT_PSIONIC_USER, PSIONIC_TRAIT)
	RegisterSignal(granted_to, COMSIG_MOB_HUD_CREATED, PROC_REF(on_hud_created))
	RegisterSignal(granted_to, COMSIG_LIVING_LIFE, PROC_REF(psionic_life))

	if(license)
		var/obj/item/card/psionic_license/new_license = new(granted_to)
		give_item_to_holder(new_license, list(LOCATION_BACKPACK = ITEM_SLOT_BACK, LOCATION_HANDS = ITEM_SLOT_HANDS), flavour_text = "Make sure not to lose it. You can not remake this on the station.")

	if(granted_to.hud_used)
		on_hud_created()

	add_shop()

/datum/psionic/proc/add_shop()
	psi_shop_datum = new(psi_owner, src, psionic_level)
	psi_shop_action = new(psi_shop_datum)
	psi_shop_action.Grant(psi_owner)

/datum/psionic/proc/on_hud_created(datum/source)
	SIGNAL_HANDLER
	var/datum/hud/psi_hud = psi_owner.hud_used
	psi_hud.add_screen_object(/atom/movable/screen/psionic/psionic_energy, HUD_PSI_DISPLAY, HUD_GROUP_INFO)
	psi_hud.add_screen_object(/atom/movable/screen/psionic/psionic_signal, HUD_PSI_SIGNAL, HUD_GROUP_INFO)
	psi_hud.show_hud(psi_hud.hud_version)
	UnregisterSignal(psi_owner, COMSIG_MOB_HUD_CREATED)

/datum/psionic/proc/give_item_to_holder(obj/item/license, list/valid_slots, flavour_text = null, default_location = "at your feet", notify_player = TRUE)
	if(ispath(license))
		license = new license(get_turf(psi_owner))

	var/mob/living/carbon/human/human_holder = psi_owner

	var/where = human_holder.equip_in_one_of_slots(license, valid_slots, qdel_on_fail = FALSE, indirect_action = TRUE) || default_location

	if(where == LOCATION_BACKPACK)
		open_backpack = TRUE

	if(notify_player)
		LAZYADD(where_items_spawned, span_horizonblue("You have \a [license] [where]. [flavour_text]"))

/datum/psionic/Destroy(force)
	. = ..()
	UnregisterSignal(psi_owner, COMSIG_MOB_HUD_CREATED)
	UnregisterSignal(psi_owner, COMSIG_LIVING_LIFE, PROC_REF(psionic_life))
	QDEL_NULL(psi_shop_action)
	QDEL_NULL(psi_shop_datum)
	for(var/datum/action/cooldown/spell/spells_to_remove in psi_owner.actions)
		if(!spells_to_remove.psionic)
			continue
		spells_to_remove.Remove(psi_owner)

	if(psi_owner.hud_used)
		var/datum/hud/psi_hud = psi_owner.hud_used
		psi_hud.remove_screen_object(HUD_PSI_DISPLAY)
		psi_hud.remove_screen_object(HUD_PSI_SIGNAL)

	REMOVE_TRAIT(psi_owner, TRAIT_PSIONIC_USER, PSIONIC_TRAIT)

/datum/psionic/proc/psionic_life(seconds_per_tick)
	SIGNAL_HANDLER

	if(is_suppressed()) // Подавление пси-энергии
		mana_level = 1 // Мы не ставим 0, потому что при 0 начинается боль
		update_hud()
		return FALSE
	if(mana_level <= 0)
		psi_owner.adjust_stamina_loss(200)
		psi_owner.SetStun(5 SECONDS)
		psi_owner.apply_status_effect(/datum/status_effect/psionic_exhaustion)
		update_hud()
		return FALSE
	var/delta_time = DELTA_WORLD_TIME(SSmobs)
	var/mob/living/carbon/human/human_holder = psi_owner
	var/additional_mana = 1

	if(psi_owner.has_status_effect(/datum/status_effect/drugginess)) // Наркота даёт бафф к генерации маны
		additional_mana *= 1.5
	if(HAS_TRAIT(psi_owner, TRAIT_PSIONIC_IMPLANT)) // Если есть имплант для увеличения регена маны
		additional_mana *= 1.5
	if(human_holder.is_blind())
		additional_mana *= 1.5
	adjust_psi_energy((1 * additional_mana) * delta_time)
	update_hud()

/datum/psionic/proc/adjust_psi_energy(amount)
	if(!isnum(amount))
		return
	mana_level = clamp(mana_level + amount, 0, max_mana)

/datum/psionic/sensitive
	max_mana = 50
	psionic_level = 1
	psionic_level_string = SENSITIVE_PSIONIC
	license = TRUE
	psi_point = 7

/datum/psionic/sensitive/no_license
	license = FALSE

/datum/psionic/harmonious
	max_mana = 100
	psionic_level = 2
	psionic_level_string = HARMONIOUS_PSIONIC
	license = FALSE
	psi_point = 14

/datum/psionic/proc/is_suppressed()
	if(HAS_TRAIT(psi_owner, TRAIT_PSIONIC_EXHAUSTION))
		return TRUE
	if(HAS_TRAIT(psi_owner, TRAIT_PSIONIC_SUPPRESSED))
		return TRUE
	return FALSE

/datum/psionic/proc/detect_psionic()
	if(psi_owner.psi_sensivity.is_suppressed())
		return FALSE

	var/list/mob/living/psionics = list()
	for(var/mob/living/possible_psionic in range(6, psi_owner.loc))
		if(!possible_psionic.psi_sensivity)
			continue
		if(possible_psionic == psi_owner)
			continue
		if(possible_psionic.psi_sensivity.is_suppressed())
			continue
		psionics += possible_psionic

	if(!length(psionics))
		return FALSE

	return TRUE

/datum/psionic/proc/research_spell(datum/action/cooldown/spell/spell_path)
	if(!ispath(spell_path, /datum/action/cooldown/spell))
		CRASH("Psionic research_spell attempted to purchase an invalid typepath! (got: [spell_path])")
	if(spell_path.psionic_level > get_level())
		to_chat(psi_owner, span_horizonblue("We have not enough psi rank to get this spell!"))
		return FALSE
	if(learned_spells[spell_path])
		to_chat(psi_owner, span_horizonblue("We have already researched this spell!"))
		return FALSE
	if(psi_point < initial(spell_path.point_cost))
		to_chat(psi_owner, span_horizonblue("We cant research this spell now!"))
		return FALSE
	psi_owner.playsound_local(psi_owner.loc, 'tff_modular/modules/psionics/sounds/power_evoke.ogg', 50, TRUE)

	var/success = give_spell(spell_path)
	if(success)
		psi_point -= initial(spell_path.point_cost)
	return success

/datum/psionic/proc/give_spell(spell_path)
	var/datum/action/cooldown/spell/new_action = new spell_path()

	if(!new_action)
		to_chat(psi_owner, "This is awkward. Psionic spell research failed, please report this bug to a coder!")
		CRASH("Psionic give_spell was unable to grant a new psionic action for path [spell_path]!")

	learned_spells[spell_path] = new_action
	new_action.Grant(psi_owner)

	return TRUE

/datum/psionic/proc/get_level()
	return psionic_level

/datum/status_effect/psionic_exhaustion
	id = "psionic_exhaustion"
	duration = 15 SECONDS
	alert_type = null
	var/icon/instabilityicon

/datum/status_effect/psionic_exhaustion/on_apply()
	. = ..()
	instabilityicon = icon('tff_modular/modules/psionics/icons/spells.dmi', "instability")
	owner.add_overlay(instabilityicon)
	ADD_TRAIT(owner, TRAIT_PSIONIC_EXHAUSTION, PSIONIC_TRAIT)

/datum/status_effect/psionic_exhaustion/on_remove()
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_PSIONIC_EXHAUSTION, PSIONIC_TRAIT)
	owner.cut_overlay(instabilityicon)

#undef SENSITIVE_PSIONIC
#undef HARMONIOUS_PSIONIC
