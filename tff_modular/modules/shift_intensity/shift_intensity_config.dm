/// Определяет, работает ли [SSshift_intensity] или нет
/datum/config_entry/flag/shift_intensity

/// Определяет, может ли голосование за [SSshift_intensity] быть начато кем-либо или нет
/datum/config_entry/flag/allow_shift_intensity_vote

/// Время (в децисекундах) до начала раунда, после которого SSshiftcolorvote будет пытаться запустить голосование
/datum/config_entry/number/shift_intensity_vote_starttime
	min_val = 50
	default = 1000

/// Количество игроков, необходимое для старта голосования
/datum/config_entry/number/shift_intensity_vote_minimum_players
	default = 20
