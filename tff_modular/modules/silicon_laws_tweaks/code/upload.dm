/obj/machinery/computer/upload/Initialize(mapload)
	. = ..()
	if(!mapload && is_station_level(z))
		priority_announce(
				text = "We detected a new [name]. \n\
				\n\
				It seems that signal came from [get_area_name(src)]. \n\
				As a reminder, equipment such as [name] can be tracked using GPS device. \n\
				\n\
				Have a secure day.",
				sender_override = "Nanotrasen Cyber Security",
				color_override = "red")

/obj/machinery/computer/upload/attackby(obj/item/O, mob/user, params)
	if(istype(O, /obj/item/ai_module))
		if(!do_after(user, 6 SECONDS, target = user))
			return FALSE
	. = ..()
