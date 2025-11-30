GLOBAL_LIST_INIT(additional_observer_huds, list())
GLOBAL_LIST_INIT(additional_combo_huds, list())

/// Эта штука добавляет указанный худ в глобальные списки из `code\datums\hud.dm`. Так же дает возмоно добавить указанный трейт худа в список худов гостов/админов
/proc/register_new_hud(atom_hud_path, data_hud, trait, for_observer = FALSE, for_combohud = FALSE)
	GLOB.huds.Insert(data_hud, new atom_hud_path())
	GLOB.trait_to_hud += list("[trait]" = data_hud)

	if(for_observer)
		GLOB.additional_observer_huds += trait
	if(for_combohud)
		GLOB.additional_combo_huds += trait

/proc/init_additional_huds()
	register_new_hud(/datum/atom_hud/data/xeno, DATA_HUD_XENO, TRAIT_XENO_HUD, TRUE, TRUE)


/client/enable_combo_hud()
	if (combo_hud_enabled)
		return
	mob.add_traits(GLOB.additional_combo_huds, ADMIN_TRAIT)
	return ..()

/client/disable_combo_hud()
	if (!combo_hud_enabled)
		return
	mob.remove_traits(GLOB.additional_combo_huds, ADMIN_TRAIT)
	return ..()


/mob/dead/observer/show_data_huds()
	. = ..()
	add_traits(GLOB.additional_observer_huds, REF(src))

/mob/dead/observer/remove_data_huds()
	. = ..()
	remove_traits(GLOB.additional_observer_huds, REF(src))

