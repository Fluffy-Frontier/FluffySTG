/atom/movable/bark(list/hearers, distance, volume, pitch)
	if(!CONFIG_GET(flag/enable_global_barks))
		return
	. = ..()
