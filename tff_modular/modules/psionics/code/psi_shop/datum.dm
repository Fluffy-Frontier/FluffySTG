/datum/psionic_shop
	var/name = "Psi Mind"
	var/datum/psionic/psi_datum
	var/mob/living/psi_owner
	var/list/possible_spells

/datum/psionic_shop/New(psionic_mob, psionic_datum)
	. = ..()
	psi_datum = psionic_datum
	psi_owner = psionic_mob
	possible_spells = get_possible_spells()

/proc/get_possible_spells()
	var/static/list/filtered_spells = list()

	var/static/list/spell_options
	if(!spell_options)
		spell_options = subtypesof(/datum/action/cooldown/spell)
		for(var/datum/action/cooldown/spell/spell as anything in spell_options)
			if(!spell.psionic)
				continue
			if(spell.locked)
				continue
			filtered_spells += spell

	return filtered_spells

/datum/psionic_shop/Destroy()
	psi_datum = null
	psi_owner = null
	possible_spells = null
	return ..()

/datum/psionic_shop/ui_state(mob/user)
	return GLOB.always_state

/datum/psionic_shop/ui_status(mob/user, datum/ui_state/state)
	if(!psi_datum)
		return UI_CLOSE
	return UI_INTERACTIVE

/datum/psionic_shop/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "PsionicShop", name)
		ui.open()

/datum/psionic_shop/ui_static_data(mob/user)
	var/list/data = list()

	var/static/list/spells
	if(isnull(spells))
		spells = list()
		for(var/datum/action/cooldown/spell/spell_path as anything in possible_spells)
			var/list/spell_data = list(
				"name" = spell_path.name,
				"desc" = spell_path.desc,
				"helptext" = spell_path.helptext,
				"path" = spell_path,
				"point_required" = spell_path.point_cost,
				"category" = spell_path.category,
			)

			spells += list(spell_data)

		sortTim(spells, /proc/cmp_assoc_list_name)

	data["many_spells"] = spells
	return data

/datum/psionic_shop/ui_data(mob/user)
	var/list/data = list()

	data["researched_spells"] = assoc_to_keys(psi_datum.learned_spells)
	data["psi_points_count"] = psi_datum.psi_point

	return data

/datum/psionic_shop/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	switch(action)
		if("research")
			psi_datum.research_spell(text2path(params["path"]))

	return TRUE

/datum/action/psionic_shop
	name = "Psionic Shop"
	button_icon = 'tff_modular/modules/psionics/icons/spells.dmi'
	button_icon_state = "controlled"
	background_icon_state = "bg_tech_blue"
	overlay_icon_state = "bg_tech_blue_border"
	check_flags = NONE

/datum/action/psionic_shop/New(Target)
	. = ..()
	if(!istype(Target, /datum/psionic_shop))
		stack_trace("psionic_shop action created with non-emporium.")
		qdel(src)

/datum/action/psionic_shop/Trigger(mob/clicker, trigger_flags)
	. = ..()
	if(!.)
		return
	target.ui_interact(owner)

