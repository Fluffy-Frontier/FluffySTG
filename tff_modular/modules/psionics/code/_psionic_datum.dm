#define SENSITIVE_PSIONIC "Sensitive Psionic"
#define HARMONIOUS_PSIONIC "Harmonious Psionic"

/datum/quirk/psionic
	name = "Psionic Abilities"
	desc = "Either you were born like this or gained powers from implants/training or other events - you are a psionic. \
			Your mind can access the world that lies beyond our mortal plane. One day voices from within had pierced your skull \
			like a tide wave turns a sailboat over in open sea, but you withstanded it and received abilities your father haven't \
			even dreamed of. From now on a special type of energy is stored in your mind, body and soul and you have control over it."
	value = 0
	medical_record_text = "Patient possesses connection to another plain of reality."
	quirk_flags = QUIRK_HIDE_FROM_SCAN|QUIRK_HUMAN_ONLY|QUIRK_PROCESSES // Сканеры не видят псиоников. Только псионик школы может точно определить, является ли живое существо псиоником
	gain_text = span_cyan("You mind feels uneasy, but... so powerful.")
	lose_text = span_warning("You lost something that kept your connection with other realms.")
	icon = "fa-star"
	mob_trait = TRAIT_PSIONIC_USER
	nova_stars_only = TRUE
	allow_for_donator = TRUE

/datum/quirk/psionic/add(client/client_source)
	quirk_holder.add_psionic(/datum/psionic/sensitive)

/datum/quirk/psionic/remove()
	. = ..()
	quirk_holder.remove_psionic()

/mob/living
	var/datum/psionic/psi_sensivity

/mob/living/proc/add_psionic(psi_type)
	if(!psi_type)
		psi_type = new /datum/psionic/sensitive()
	if(istype(psi_type, /datum/psionic))
		return FALSE
	if(get_psionic())
		return FALSE
	var/datum/psionic/new_psi = new psi_type()
	new_psi.apply_to(src)

	return FALSE

/mob/living/proc/remove_psionic()
	if(!psi_sensivity)
		return FALSE
	qdel(psi_sensivity)

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
	var/license = TRUE
	/// Два вара скопированные из item_quirk для правильной выдачи лицензии
	var/list/where_items_spawned
	var/open_backpack = FALSE
	// Магазин
	var/datum/psionic_shop/psi_shop_datum
	var/datum/action/psionic_shop/psi_shop_action
	// Список заклинаний
	var/list/datum/action/cooldown/spell/learned_spells = list()

/datum/psionic/proc/apply_to(mob/living/granted_to)
	if(!granted_to)
		CRASH("Tried to add psionic without owner")

	psi_owner = granted_to
	psi_owner.psi_sensivity = src

	RegisterSignal(psi_owner, COMSIG_MOB_HUD_CREATED, PROC_REF(on_hud_created))
	RegisterSignal(psi_owner, COMSIG_LIVING_LIFE, PROC_REF(psionic_life))

	if(license)
		var/obj/item/card/psionic_license/new_license = new(psi_owner)
		give_item_to_holder(new_license, list(LOCATION_BACKPACK = ITEM_SLOT_BACK, LOCATION_HANDS = ITEM_SLOT_HANDS), flavour_text = "Make sure not to lose it. You can not remake this on the station.")

	if(psi_owner.hud_used)
		on_hud_created()

	add_shop()

/datum/psionic/proc/add_shop()
	psi_shop_datum = new(psi_owner, src)
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
		LAZYADD(where_items_spawned, span_boldnotice("You have \a [license] [where]. [flavour_text]"))

/datum/psionic/Destroy(force)
	. = ..()
	UnregisterSignal(psi_owner, COMSIG_MOB_HUD_CREATED)
	RegisterSignal(psi_owner, COMSIG_LIVING_LIFE, PROC_REF(psionic_life))
	if(!psi_owner.hud_used)
		return

	var/datum/hud/psi_hud = psi_owner.hud_used
	psi_hud.remove_screen_object(HUD_PSI_DISPLAY)
	psi_hud.remove_screen_object(HUD_PSI_SIGNAL)
	for(var/datum/action/cooldown/spell/spells_to_remove in psi_owner.actions)
		if(!spells_to_remove.psionic)
			continue
		spells_to_remove.Remove()
	QDEL_NULL(psi_shop_action)
	QDEL_NULL(psi_shop_datum)

/datum/psionic/proc/psionic_life(seconds_per_tick)
	SIGNAL_HANDLER

	if(is_suppressed()) // Подавление пси-энергии
		mana_level = 1 // Мы не ставим 0, потому что при 0 начинается боль
		update_hud()
		return FALSE
	if(mana_level <= 0)
		psi_owner.adjust_stamina_loss(200)

	var/delta_time = DELTA_WORLD_TIME(SSmobs)
	var/mob/living/carbon/human/human_holder = psi_owner
	var/additional_mana = 1

	if(psi_owner.has_status_effect(/datum/status_effect/drugginess)) // Наркота даёт бафф к генерации маны
		additional_mana *= 1.5
	if(HAS_TRAIT(psi_owner, TRAIT_PSIONIC_IMPLANT)) // Если есть имплант для увеличения регена маны
		additional_mana *= 2
	if(human_holder.is_blind())
		additional_mana *= 1.5
	adjust_psi_energy((1 * additional_mana) * delta_time)
	update_hud()

/datum/psionic/proc/adjust_psi_energy(amount)
	if(!isnum(amount))
		return
	mana_level = clamp(mana_level + amount, 0, max_mana)

/datum/psionic/sensitive
	max_mana = 25
	psionic_level = 1
	psionic_level_string = SENSITIVE_PSIONIC

/datum/psionic/harmonious
	max_mana = 100
	psionic_level = 2
	psionic_level_string = HARMONIOUS_PSIONIC
	license = FALSE

/datum/psionic/proc/is_suppressed()
	if(HAS_TRAIT(psi_owner, TRAIT_PSI_SUPPRESSED))
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

	if(learned_spells[spell_path])
		to_chat(psi_owner, span_warning("We have already researched this spell!"))
		return FALSE

	if(psi_point < initial(spell_path.point_cost))
		to_chat(psi_owner, span_warning("We cant research this spell now!"))
		return FALSE

	var/success = give_spell(spell_path)
	if(success)
		psi_point -= initial(spell_path.point_cost)
	return success

/datum/psionic/proc/give_spell(spell_path)
	var/datum/action/cooldown/spell/new_action = new spell_path()

	if(!new_action)
		to_chat(psi_owner, "This is awkward. Psionic power purchase failed, please report this bug to a coder!")
		CRASH("Psionic give_spell was unable to grant a new changeling action for path [spell_path]!")

	learned_spells[spell_path] = new_action
	new_action.Grant(psi_owner)

	return TRUE

#undef SENSITIVE_PSIONIC
#undef HARMONIOUS_PSIONIC
