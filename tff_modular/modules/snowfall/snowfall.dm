// Безопасный снегопад! Без урона и не так сильно перекрывает видимость, в отличие от снежной бури. ff в начале, потому что апстримы могут свой с похожим именем сделать...
/datum/weather/snow_storm/ff_snowfall
	name = "snowfall"
	desc = "Little snowflakes are falling from the sky. So calm and peaceful..."
	probability = 0

	telegraph_duration = 0

	weather_message  = span_warning("Little snowflakes are falling from the sky...")
	weather_overlay = "light_snow"
	weather_duration_lower = 1800
	weather_duration_upper = 3000

	end_message = span_warning("Less snowflakes fall from the sky...")
	end_duration = 100

	weather_temperature = BODYTEMP_COLD_DAMAGE_LIMIT + 1
	weather_flags = (WEATHER_MOBS | WEATHER_BAROMETER | WEATHER_TEMPERATURE_BYPASS_CLOTHING)

/datum/weather/snow_storm/ff_snowfall/forever
	probability = 0
	weather_flags = parent_type::weather_flags | WEATHER_ENDLESS
