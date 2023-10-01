//все карты для блеклиста добавляются в этот дефайн. Это удаляет карты из списка для area_spawn автомаппера крыс.
//Того самого автомаппера, который добаляет на ТГшные карты шкафы БЩ, вендор командный и прочее. Вписывать название карты, которое в map_name в конфиге самой карты.
#define FF_BLACKLISTED_STATIONS list("NSS Journey", "SS13 Construct")

// По идеи - код автомаппера навряд ли будут в скором времени менять, но если крысы внесут какие-то серьёзные правки, которые вызовут анал-карнавал - то:
// Либо тыкайте наш dev, чтобы фиксили и подгоняли всё для работы с изменённой/обновлённой версией кода автомаппера.
// Либо же берите СкайРатовскую версию файла `modular_skyrat\modules\automapper\code\automapper_subsystem.dm`, чтобы не задерживать обновление билда.

// Собственно, вот такое вот чудо-юдо я сделал, чтобы реализовать наш отдельный автомаппер.
// Данная реализация позволит в дальнейшем добавлять свои шаблоны для автомаппера, не трогая основной конфиг и файлы СкайРатов.
// Также плюсом ко всему этому - возможность выгружать и отключать определённые шаблоны Крыс, чтобы заменить их на свои варианты.

// У меня не вышло всё просто заоверрайдить, это вызывало какой-то пиздец.
/datum/controller/subsystem/automapper/proc/load_custom_config()
	// Внесение переменных с интересующими нас путями.
	var/ff_config_file = "_maps/fluffy_frontier/automapper/automapper_config.toml"
	var/temporary_config_file = "_maps/skyrat/automapper/temporary_automapper_config.toml"

	// Соединение двух конфигов.
	var/spliced_config
	spliced_config += file2text(config_file)
	spliced_config += "\n"
	spliced_config += file2text(ff_config_file)

	// Исключение определённых шаблонов из конфига.
	// Если нужно будет - я чуть-чуть распишу что тут да как тут.
	var/list/config_as_list = splittext(spliced_config, "\n")
	var/list/templates_to_remove = list()
	for(var/untrimmed_str in config_as_list)
		var/str = trim(untrimmed_str)
		if(findtext(str, "#UNREG") != 1)
			continue
		var/list/s_str = splittext(str, "=")
		templates_to_remove += "\[templates.[trim(s_str[2])]]"
	var/is_removing = FALSE
	var/parsed_config
	for(var/untrimmed_str in config_as_list)
		var/str = trim(untrimmed_str)
		if(is_removing)
			if(findtext(str, "\[templates.") == 1)
				is_removing = FALSE
			else
				continue
		for(var/rtmp in templates_to_remove)
			if(findtext(str, rtmp) == 1)
				is_removing = TRUE
		if(is_removing)
			continue
		parsed_config += str
		parsed_config += "\n"

	// Загрузка финального конфига.
	text2file(parsed_config, temporary_config_file)
	loaded_config = rustg_read_toml_file(temporary_config_file)
	fdel(temporary_config_file)

//Грязный модульный способ добавить нашинские карты в блеклист.
/datum/area_spawn/try_spawn()
	blacklisted_stations += FF_BLACKLISTED_STATIONS
	. = ..()

/datum/area_spawn_over/try_spawn()
	blacklisted_stations += FF_BLACKLISTED_STATIONS
	. = ..()
#undef FF_BLACKLISTED_STATIONS
