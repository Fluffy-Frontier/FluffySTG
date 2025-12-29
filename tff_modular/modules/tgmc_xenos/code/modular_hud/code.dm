GLOBAL_LIST_INIT(additional_observer_huds, list())
GLOBAL_LIST_INIT(additional_combo_huds, list())

/**
 * Эта штука добавляет указанный худ в глобальные списки из `code\datums\hud.dm`. Так же позволяет сделать дангный худ видимым для гостов/админов
 * Arguments:
 * - atom_hud_path: путь /datum/atom_hud/data/... требумого худа
 * - data_hud_define: дефайн атом_худа
 * - trait_define: дефайн трейта
 * - for_observer: будет ли виден этот худ гостам
 * - for_combohud: будет ли виден этот худ тем, кто включил комбохуд
 */
/proc/register_new_data_hud(atom_hud_path, data_hud_define, trait_define, for_observer = FALSE, for_combohud = FALSE)
	GLOB.huds += new atom_hud_path()
	GLOB.trait_to_hud += list("[trait_define]" = data_hud_define)

	if(for_observer)
		GLOB.additional_observer_huds += trait_define
	if(for_combohud)
		GLOB.additional_combo_huds += trait_define

/proc/init_additional_huds()
	register_new_data_hud(/datum/atom_hud/data/xeno, DATA_HUD_XENO, TRAIT_XENO_HUD, for_observer = TRUE, for_combohud = TRUE) // TRAIT_XENO_HUD - 12


/client/enable_combo_hud()
	if(combo_hud_enabled)
		return
	mob.add_traits(GLOB.additional_combo_huds, ADMIN_TRAIT)
	return ..()

/client/disable_combo_hud()
	if(!combo_hud_enabled)
		return
	mob.remove_traits(GLOB.additional_combo_huds, ADMIN_TRAIT)
	return ..()


/mob/dead/observer/show_data_huds()
	. = ..()
	add_traits(GLOB.additional_observer_huds, REF(src))

/mob/dead/observer/remove_data_huds()
	. = ..()
	remove_traits(GLOB.additional_observer_huds, REF(src))

