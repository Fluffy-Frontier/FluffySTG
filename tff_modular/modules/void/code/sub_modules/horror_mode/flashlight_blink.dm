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

	turn_on(FALSE)
	flicking = FALSE

/obj/item/modular_computer
	var/flicking = FALSE

/obj/item/modular_computer/proc/make_flick(amount = rand(10, 15))
	if(flicking || !light_on)
		return
	flicking = TRUE
	for(var/i in 1 to amount)
		if(light_on)
			set_light_on(FALSE)
			update_appearance()
		else
			set_light_on(TRUE)
			update_appearance()
		sleep(rand(5, 10))

	set_light_on(TRUE)
	update_appearance()
	flicking = FALSE

/obj/item/mod/module/flashlight
	var/flicking = FALSE

/obj/item/mod/module/flashlight/proc/make_flick(amount = rand(10, 15))
	if(flicking || !light_on)
		return
	flicking = TRUE
	for(var/i in 1 to amount)
		if(light_on)
			set_light_flags(light_flags & ~LIGHT_ATTACHED)
			set_light_on(FALSE)
		else
			set_light_flags(light_flags | LIGHT_ATTACHED)
			set_light_on(active)
		sleep(rand(5, 10))

	set_light_flags(light_flags | LIGHT_ATTACHED)
	set_light_on(active)
	flicking = FALSE
