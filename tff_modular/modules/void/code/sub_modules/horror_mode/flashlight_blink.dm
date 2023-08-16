/obj/item/flashlight
	var/flicking = FALSE

/obj/item/flashlight/proc/make_flick(amount = rand(10, 15))
	if(flicking)
		return
	flicking = TRUE
	for(var/i in 1 to amount)
		if(on)
			turn_off()
		else
			turn_on(FALSE)
		sleep(rand(5, 10))
	flicking = FALSE

