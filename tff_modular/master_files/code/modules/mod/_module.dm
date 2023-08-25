/**
 * Расширеие генирации спрайта для модулей МОДа, если специя надевшего - это тешари.
 * Код выполняет сразу после оргинального прока. rpoc/handle_module_icon()
 * Аргументы
 * standing - текщий набор спрайтов модулей, что будет установлен на пользоветаля.
 * module_icon_stane - айкон стейт для модуля
 */
/obj/item/mod/module/handle_module_icon(mutable_appearance/standing, module_icon_state)
	. = ..()
	if(!istesharialt(mod.wearer))
		return
	// Чтожь, окей - первое, с чего мы начнем - это очистим текущий набор спрайтов. В дальейншем мы будем передать лист спрайтов.
	. = list()
	// Путь к хранилищу спрайтов модулей. Которыми мы хотим заменить оригинал.
	var/new_icon = 'tff_modular/master_files/icons/mob/clothing/species/teshari/mod_modules.dmi'
	//Создаем новую иконку модуля.
	var/mutable_appearance/module_icon = mutable_appearance(new_icon, module_icon_state, layer = standing.layer + 0.1)
	//Восстаналиваем цвет.
	module_icon.appearance_flags |= RESET_COLOR

	. += module_icon
	//Возращаем обновленные спрайты модулей.
	return .
