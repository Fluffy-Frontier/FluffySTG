/obj/machinery/jukebox/bar
	name = "jukebox"
	desc = "The survived prototype of classic music player. Label says: ONLY FOR BAR"
	req_access = list(ACCESS_BAR)
	anchored = FALSE
	var/whitelist_area = list(
		/area/station/service/bar,
	)

/obj/machinery/jukebox/bar/ui_status(mob/user)
	var/area/src_area = get_area(src)

	if(!(is_type_in_list(src_area, whitelist_area)))
		to_chat(user,span_warning("Error: Wrong area."))
		return UI_CLOSE
	if(!anchored)
		to_chat(user,span_warning("This device must be anchored by a wrench!"))
		return UI_CLOSE
	if(!allowed(user))
		to_chat(user,span_warning("Error: Access Denied."))
		user.playsound_local(src, 'sound/machines/compiler/compiler-failure.ogg', 25, TRUE)
		return UI_CLOSE
	if(!length(music_player.songs))
		to_chat(user,span_warning("Error: No music tracks have been authorized for your station. Petition Central Command to resolve this issue."))
		user.playsound_local(src, 'sound/machines/compiler/compiler-failure.ogg', 25, TRUE)
		return UI_CLOSE
	return ..()

/obj/machinery/jukebox/bar/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	var/area/src_area = get_area(src)

	if(!(is_type_in_list(src_area, whitelist_area)))
		to_chat(user,span_warning("Error: Wrong area."))
		return UI_CLOSE
	if(!ui)
		ui = new(user, src, "Jukebox", name)
		ui.open()

/datum/supply_pack/service/jukebox
	name = "Jukebox kit start"
	desc = "Make everyone happy by good music in your bar!"
	cost = CARGO_CRATE_VALUE * 15
	contains = list(/obj/machinery/jukebox/bar)
	crate_name = "jukebox crate"
	crate_type = /obj/structure/closet/crate/large
	access_view = ACCESS_BAR
