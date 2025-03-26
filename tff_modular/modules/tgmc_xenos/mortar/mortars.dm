/obj/structure/mortar
	name = "\improper M402 mortar"
	desc = "A manual, crew-operated mortar system intended to rain down 80mm goodness on anything it's aimed at. Uses an advanced targeting computer. Insert round to fire."
	icon = 'tff_modular/modules/tgmc_xenos/mortar/icons/mortar.dmi'
	icon_state = "mortar_m402"
	anchored = TRUE
	density = TRUE

	// Initial target coordinates
	var/targ_x = 0
	var/targ_y = 0
	// Automatic offsets from target
	var/offset_x = 0
	var/offset_y = 0
	/// Number of turfs to offset from target by 1
	var/offset_per_turfs = 20
	// Dial adjustments from target
	var/dial_x = 0
	var/dial_y = 0
	/// Constant, assuming perfect parabolic trajectory. ONLY THE DELAY BEFORE INCOMING WARNING WHICH ADDS 45 TICKS
	var/travel_time = 4.5 SECONDS
	var/busy = FALSE
	/// Used for deconstruction and aiming sanity
	var/firing = FALSE

	var/camouflage

/obj/structure/mortar/Initialize()
	. = ..()
	// Makes coords appear as 0 in UI
	targ_x = deobfuscate_x(0)
	targ_y = deobfuscate_y(0)

	var/new_icon_state
	switch(camouflage)
		if("classic")
			new_icon_state = "c_" + initial(icon_state)
		if("desert")
			new_icon_state = "d_" + initial(icon_state)
		if("snow")
			new_icon_state = "s_" + initial(icon_state)
		if("urban")
			new_icon_state = "u_" + initial(icon_state)
		else
			new_icon_state = initial(icon_state)

	icon_state = new_icon_state

/obj/structure/mortar/interact(mob/user)
	if(busy)
		to_chat(user, span_warning("Someone else is currently using [src]."))
		return FALSE
	if(firing)
		to_chat(user, span_warning("[src]'s barrel is still steaming hot. Wait a few seconds and stop firing it."))
		return FALSE

	return ..()

/obj/structure/mortar/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Mortar", "Mortar Interface")
		ui.open()

/obj/structure/mortar/ui_data(mob/user)
	. = list()

	.["data_target_x"] = obfuscate_x(targ_x)
	.["data_target_y"] = obfuscate_y(targ_y)
	.["data_dial_x"] = dial_x
	.["data_dial_y"] = dial_y

/obj/structure/mortar/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()

	switch(action)
		if("set_target")
			handle_target(usr, text2num(params["target_x"]), text2num(params["target_y"]))
			return TRUE

		if("set_offset")
			handle_dial(usr, text2num(params["dial_x"]), text2num(params["dial_y"]))
			return TRUE

/obj/structure/mortar/proc/handle_target(mob/user, temp_targ_x = 0, temp_targ_y = 0)
	if(!can_fire_at(user, test_targ_x = deobfuscate_x(temp_targ_x), test_targ_y = deobfuscate_y(temp_targ_y)))
		return

	user.visible_message(span_notice("[user] starts adjusting [src]'s firing angle and distance."), span_notice("You start adjusting [src]'s firing angle and distance to match the new coordinates."))
	busy = TRUE

	playsound(loc, 'sound/items/tools/ratchet.ogg', 25, 1)

	var/success = do_after(user, 3 SECONDS, src)
	busy = FALSE
	if(!success)
		return
	user.visible_message(span_notice("[user] finishes adjusting [src]'s firing angle and distance."), span_notice("You finish adjusting [src]'s firing angle and distance to match the new coordinates."))
	targ_x = deobfuscate_x(temp_targ_x)
	targ_y = deobfuscate_y(temp_targ_y)
	var/offset_x_max = floor(abs((targ_x) - x)/offset_per_turfs) //Offset of mortar shot, grows by 1 every 20 tiles travelled
	var/offset_y_max = floor(abs((targ_y) - y)/offset_per_turfs)
	offset_x = rand(-offset_x_max, offset_x_max)
	offset_y = rand(-offset_y_max, offset_y_max)

/obj/structure/mortar/proc/handle_dial(mob/user, temp_dial_x = 0, temp_dial_y = 0)
	if(!can_fire_at(user, test_dial_x = temp_dial_x, test_dial_y = temp_dial_y))
		return

	user.visible_message(span_notice("[user] starts dialing [src]'s firing angle and distance."), span_notice("You start dialing [src]'s firing angle and distance to match the new coordinates."))
	busy = TRUE

	playsound(loc, 'sound/items/tools/ratchet.ogg', 25, 1)

	var/success = do_after(user, 1.5 SECONDS, src)
	busy = FALSE
	if(!success)
		return
	user.visible_message(span_notice("[user] finishes dialing [src]'s firing angle and distance."), span_notice("You finish dialing [src]'s firing angle and distance to match the new coordinates."))

	dial_x = temp_dial_x
	dial_y = temp_dial_y

/obj/structure/mortar/attackby(obj/item/attacking_item, mob/living/user)
	if(istype(attacking_item, /obj/item/mortar_shell))
		var/obj/item/mortar_shell/mortar_shell = attacking_item
		var/turf/target_turf = locate(targ_x + dial_x + offset_x, targ_y + dial_y + offset_y, z)
		if(busy)
			to_chat(user, span_warning("Someone else is currently using [src]."))
			return

		var/turf/deviation_turf = locate(target_turf.x + pick(-1,0,0,1), target_turf.y + pick(-1,0,0,1), target_turf.z)
		if(deviation_turf)
			target_turf = deviation_turf

		user.visible_message(span_notice("[user] starts loading \a [mortar_shell.name] into [src]."), span_notice("You start loading \a [mortar_shell.name] into [src]."))
		playsound(loc, 'tff_modular/modules/tgmc_xenos/mortar/sound/gun_mortar_reload.ogg', 75, 1)
		busy = TRUE
		var/success = do_after(user, 1.5 SECONDS, src)
		busy = FALSE
		if(success)
			user.visible_message(span_notice("[user] loads \a [mortar_shell.name] into [src]."), span_notice("You load \a [mortar_shell.name] into [src]."))
			visible_message("[icon2html(src, viewers(src))] [span_danger("The [name] fires!")]")
			user.transferItemToLoc(mortar_shell, src)
			playsound(loc, 'tff_modular/modules/tgmc_xenos/mortar/sound/gun_mortar_fire.ogg', 125, 1)
			busy = FALSE
			firing = TRUE
			flick(icon_state + "_fire", src)
			mortar_shell.sender = user
			mortar_shell.forceMove(src)

			for(var/mob/mob in range(7))
				shake_camera(mob, 3, 1)

			addtimer(CALLBACK(src, PROC_REF(handle_shell), target_turf, mortar_shell), travel_time)

	if(attacking_item.tool_behaviour == TOOL_WRENCH)
		if(busy)
			to_chat(user, span_warning("Someone else is currently using [src]."))
			return FALSE
		if(firing)
			to_chat(user, span_warning("[src]'s barrel is still steaming hot. Wait a few seconds and stop firing it."))
			return FALSE
		playsound(loc, 'sound/items/tools/ratchet.ogg', 25, 1)
		user.visible_message(span_notice("[user] starts undeploying [src]."), span_notice("You start undeploying [src]."))
		if(do_after(user, 4 SECONDS, src))
			user.visible_message(span_notice("[user] undeploys [src]."), span_notice("You undeploy [src]."))
			playsound(loc, 'sound/items/Deconstruct.ogg', 25, 1)
			new /obj/item/mortar_kit(loc)
			qdel(src)

/obj/structure/mortar/proc/handle_shell(turf/target, obj/item/mortar_shell/shell)
	playsound(target, 'tff_modular/modules/tgmc_xenos/mortar/sound/gun_mortar_travel.ogg', 75, 1)
	var/relative_dir
	for(var/mob/mob in range(15, target))
		if(get_turf(mob) == target)
			relative_dir = 0
		else
			relative_dir = angle2dir(get_angle(get_turf(mob), get_turf(target)))
		mob.show_message( \
			span_danger("A SHELL IS COMING DOWN <u>[relative_dir ? uppertext(("TO YOUR " + dir2text(relative_dir))) : uppertext("right above you")]</u>!"), MSG_VISUAL, \
			span_danger("YOU HEAR SOMETHING COMING DOWN <u>[relative_dir ? uppertext(("TO YOUR " + dir2text(relative_dir))) : uppertext("right above you")]</u>!"), MSG_AUDIBLE \
		)
	sleep(2 SECONDS)

	for(var/mob/mob in range(10, target))
		if(get_turf(mob) == target)
			relative_dir = 0
		else
			relative_dir = angle2dir(get_angle(get_turf(mob), get_turf(target)))
		mob.show_message( \
			span_userdanger("A SHELL IS ABOUT TO IMPACT <u>[relative_dir ? uppertext(("TO YOUR " + dir2text(relative_dir))) : uppertext("right above you")]</u>!"), MSG_VISUAL, \
			span_userdanger("YOU HEAR SOMETHING VERY CLOSE COMING DOWN <u>[relative_dir ? uppertext(("TO YOUR " + dir2text(relative_dir))) : uppertext("right above you")]</u>!"), MSG_AUDIBLE \
		)
	sleep(2.5 SECONDS)
	shell.detonate(target)
	firing = FALSE

/obj/structure/mortar/proc/can_fire_at(mob/user, test_targ_x = targ_x, test_targ_y = targ_y, test_dial_x, test_dial_y)
	var/dialing = test_dial_x || test_dial_y
	if(test_dial_x + test_targ_x > world.maxx || test_dial_x + test_targ_x < 0)
		to_chat(user, span_warning("You cannot [dialing ? "dial to" : "aim at"] this coordinate, it is outside of the area of operations."))
		return FALSE
	if(test_dial_x < -10 || test_dial_x > 10 || test_dial_y < -10 || test_dial_y > 10)
		to_chat(user, span_warning("You cannot [dialing ? "dial to" : "aim at"] this coordinate, it is too far away from the original target."))
		return FALSE
	if(test_dial_y + test_targ_y > world.maxy || test_dial_y + test_targ_y < 0)
		to_chat(user, span_warning("You cannot [dialing ? "dial to" : "aim at"] this coordinate, it is outside of the area of operations."))
		return FALSE
	if(get_dist(src, locate(test_targ_x + test_dial_x, test_targ_y + test_dial_y, z)) < 10)
		to_chat(user, span_warning("You cannot [dialing ? "dial to" : "aim at"] this coordinate, it is too close to your mortar."))
		return FALSE
	if(busy)
		to_chat(user, span_warning("Someone else is currently using this mortar."))
		return FALSE
	return TRUE

/////
//The portable mortar item
/obj/item/mortar_kit
	name = "\improper M402 mortar portable kit"
	desc = "A manual, crew-operated mortar system intended to rain down 80mm goodness on anything it's aimed at. Needs to be set down first"
	icon = 'tff_modular/modules/tgmc_xenos/mortar/icons/mortar.dmi'
	icon_state = "mortar_m402_carry"
	inhand_icon_state = "mortar_m402_carry"
	lefthand_file = 'tff_modular/modules/tgmc_xenos/mortar/icons/shells_lefthand.dmi'
	righthand_file = 'tff_modular/modules/tgmc_xenos/mortar/icons/shells_righthand.dmi'
	w_class = WEIGHT_CLASS_HUGE

/obj/item/mortar_kit/attack_self(mob/user)
	. = ..()
	var/turf/deploy_turf = get_turf(user)
	if(!deploy_turf)
		return
	user.visible_message(span_notice("[user] starts deploying [src]."), span_notice("You start deploying [src]."))
	playsound(deploy_turf, 'sound/items/Deconstruct.ogg', 25, 1)
	if(do_after(user, 4 SECONDS, user))
		var/obj/structure/mortar/mortar = new /obj/structure/mortar(deploy_turf)
		user.visible_message(span_notice("[user] deploys [src]."), span_notice("You deploy [src]."))
		playsound(deploy_turf, 'tff_modular/modules/tgmc_xenos/mortar/sound/gun_mortar_unpack.ogg', 25, 1)
		mortar.setDir(user.dir)
		qdel(src)


// Mortar crates
/obj/structure/closet/crate/secure/weapon/mortar_kit
	name = "\improper M402 mortar kit"
	desc = "A crate containing a basic set of a mortar and some shells, to get an engineer started."

/obj/structure/closet/crate/secure/weapon/mortar_kit/PopulateContents()
	. = ..()
	new /obj/item/mortar_kit(src)
	new /obj/item/mortar_shell/he(src)
	new /obj/item/mortar_shell/he(src)
	new /obj/item/mortar_shell/frag(src)
	new /obj/item/mortar_shell/frag(src)
	new /obj/item/mortar_shell/incendiary(src)
	new /obj/item/mortar_shell/incendiary(src)
	new /obj/item/binoculars/rangefinder(src)
	new /obj/item/binoculars/rangefinder(src)

/obj/structure/closet/crate/secure/weapon/mortar_ammo
	name = "\improper M402 mortar ammo crate"
	desc = "A crate containing live mortar shells with various payloads. DO NOT DROP. KEEP AWAY FROM FIRE SOURCES."

/obj/structure/closet/crate/secure/weapon/mortar_ammo/PopulateContents()
	. = ..()
	new /obj/item/mortar_shell/he(src)
	new /obj/item/mortar_shell/he(src)
	new /obj/item/mortar_shell/he(src)
	new /obj/item/mortar_shell/he(src)
	new /obj/item/mortar_shell/frag(src)
	new /obj/item/mortar_shell/frag(src)
	new /obj/item/mortar_shell/frag(src)
	new /obj/item/mortar_shell/frag(src)
	new /obj/item/mortar_shell/incendiary(src)
	new /obj/item/mortar_shell/incendiary(src)
	new /obj/item/mortar_shell/incendiary(src)
	new /obj/item/mortar_shell/incendiary(src)

/obj/structure/closet/crate/secure/weapon/mortar_special_ammo
	name = "\improper M402 mortar special ammo crate"
	desc = "A crate containing live mortar shells with various payloads. DO NOT DROP. KEEP AWAY FROM FIRE SOURCES."

/obj/structure/closet/crate/secure/weapon/mmortar_special_ammo/PopulateContents()
	. = ..()
	new /obj/item/mortar_shell/smoke(src)
	new /obj/item/mortar_shell/smoke(src)
	new /obj/item/mortar_shell/smoke(src)
	new /obj/item/mortar_shell/smoke(src)
	new /obj/item/mortar_shell/flashbang(src)
	new /obj/item/mortar_shell/flashbang(src)
	new /obj/item/mortar_shell/flashbang(src)
	new /obj/item/mortar_shell/flashbang(src)
