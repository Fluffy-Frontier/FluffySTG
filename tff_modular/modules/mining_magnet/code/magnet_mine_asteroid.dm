// Всё связанное с шахтёрским магнитным астеройдом
/datum/map_template/ruin/space/tff/magnet_mine
	id = "magnet_mine"
	prefix = "tff_modular/modules/mining_magnet/_maps/"
	suffix = "miner_magnet_asteroid.dmm"
	name = "Space outpost with Magnet"
	description = "Dont try place it on station, just be cool"
	always_place = TRUE
	allow_duplicates = FALSE

// Очень модульно добавляем шаттлу возможность прибыть на астеройд
/obj/machinery/computer/shuttle/mining/New()
	. = ..()
	possible_destinations = "[possible_destinations];lavaland_mining_asteroid"

// Зоны астеройда
/area/mine/magnet_mine
	ambient_buzz = 'sound/ambience/general/shipambience.ogg'

/area/mine/magnet_mine/manufacturing
	name = "Magnet Outpost Manufacturing Room"
	icon_state = "mining_production"

/area/mine/magnet_mine/refinery
	name = "Mining Magnet Outpost Refinery"
	icon_state = "mining_foundry"

/area/mine/magnet_mine/outpost
	name = "Mining Magnet Outpost"
	icon_state = "mining_lobby"

/area/mine/magnet_mine/dock
	name = "Magnet Outpost Shuttle Dock"
	icon_state = "mining_dock"

/area/mine/magnet_mine/power
	name = "Magnet Outpost Power Room"
	icon_state = "engie"

/area/mine/magnet_mine/quarters
	name = "Magnet Outpost Miner's Quarters"
	icon_state = "mining_living"

// Зоны астеройда без отдельного спрайта
/area/mine/magnet_mine/comms
	name = "Magnet Outpost Comms Room"

/area/mine/magnet_mine/solar
	name = "Magnet Outpost Solar Array"

/area/mine/magnet_mine/asteroid
	name = "Magnet Outpost Asteroid"

/area/mine/magnet_mine/control
	name = "Outpost Magnet Control"
