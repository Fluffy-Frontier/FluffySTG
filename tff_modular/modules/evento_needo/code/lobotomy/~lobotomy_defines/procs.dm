
// Shows a blurb to every client
/proc/show_global_blurb(duration, blurb_text, fade_time = 5, text_color = "white", outline_color = "black", text_align = "left", screen_location = "LEFT+1,BOTTOM+2")
	for(var/client/C in GLOB.clients)
		show_blurb(C, duration, blurb_text, fade_time, text_color, outline_color, text_align, screen_location)
/proc/show_blurb(client/C, duration, blurb_text, fade_time = 5, text_color = "white", outline_color = "black", text_align = "left", screen_location = "LEFT+1,BOTTOM+2")
	if(!C)
		return

	var/style = "font-family: 'Fixedsys'; text-align: [text_align]; color: [text_color]; -dm-text-outline: 1 [outline_color]; font-size: 11px;"
	var/text = blurb_text
	text = uppertext(text)

	var/obj/effect/overlay/T = new()
	T.alpha = 0
	T.maptext_height = 64
	T.maptext_width = 424
	T.layer = FLOAT_LAYER
	T.plane = HUD_PLANE
	T.appearance_flags = APPEARANCE_UI_IGNORE_ALPHA
	T.screen_loc = screen_location

	C.screen += T
	animate(T, alpha = 255, time = 4)
	T.maptext = "<span style=\"[style]\">[text]</span>"

	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(fade_blurb), C, T, fade_time), duration)

/mob/living/carbon/human/proc/show_aso_blurb(text, duration = 1.5 SECONDS)
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(show_blurb), client, duration, text, 1 SECONDS, "red", "black", "left", around_player), 20)


/proc/fade_blurb(client/C, obj/T, fade_time = 5)
	animate(T, alpha = 0, time = fade_time)
	sleep(fade_time)
	C.screen -= T
	qdel(T)

// Returns a list of all safe directions based off of the turf given
// Included in stuff like Blue Sicko's Tempestuous Danza or The Claw weapon's serum W
/proc/GetSafeDir(turf/target)
	var/turf/list = list()
	for(var/dir in GLOB.alldirs)
		var/turf/T = get_step(target, dir)
		if(!IsSafeTurf(T))
			continue
		list += dir
	return list

// Checks if the current turf is "Safe"
// Future notes: Convert to a list and check if T is in that list?
/proc/IsSafeTurf(turf/T)
	if(!T)
		return FALSE
	if(T.density)
		return FALSE
	if(T in typesof(/turf/open/water)) // No water
		return FALSE
	if(T in typesof(/turf/open/space)) // No space
		return FALSE
	var/obj/structure/window/W = locate() in T // No windows
	var/obj/machinery/door/D = locate() in T // No doors
	var/obj/machinery/vending/V = locate() in T // No vending
	var/obj/structure/table/glass/G = locate() in T // No glass tables
	if(W || D || V || G)
		return FALSE
	return TRUE

// Ditto, for sanity
/proc/RoundSanity(mob/living/carbon/human/H)
	if(H.stat == DEAD || (HAS_TRAIT(H, TRAIT_FAKEDEATH)))
		return "sanity-dead"
	if(H.sanity_lost)
		return "sanity-insane" // Went insane
	var/maxi_health = H.maxSanity
	var/resulthealth = (H.sanityhealth / maxi_health) * 100
	switch(resulthealth)
		if(100 to INFINITY)
			return "sanity100"
		if(90.625 to 100)
			return "sanity93.75"
		if(84.375 to 90.625)
			return "sanity87.5"
		if(78.125 to 84.375)
			return "sanity81.25"
		if(71.875 to 78.125)
			return "sanity75"
		if(65.625 to 71.875)
			return "sanity68.75"
		if(59.375 to 65.625)
			return "sanity62.5"
		if(53.125 to 59.375)
			return "sanity56.25"
		if(46.875 to 53.125)
			return "sanity50"
		if(40.625 to 46.875)
			return "sanity43.75"
		if(34.375 to 40.625)
			return "sanity37.5"
		if(28.125 to 34.375)
			return "sanity31.25"
		if(21.875 to 28.125)
			return "sanity25"
		if(15.625 to 21.875)
			return "sanity18.75"
		if(9.375 to 15.625)
			return "sanity12.5"
		else
			return "sanity6.25"

/atom/proc/InitializeAIController()
	if(ispath(ai_controller))
		ai_controller = new ai_controller(src)

/obj/item/proc/Sweep(atom/target, mob/living/carbon/human/user, params)
	if(!istype(user) || user.combat_mode || swingstyle == WEAPONSWING_NONE || get_turf(target) == get_turf(user))
		return target.attackby(src, user, params)

	if(!isturf(target) && !ismob(target))
		return target.attackby(src, user, params)

	user.changeNext_move(CLICK_CD_MELEE * 0.75) // Room for those who miss

	var/list/hit_turfs = list()

	if(swingstyle >= WEAPONSWING_THRUST)
		hit_turfs = get_thrust_turfs(target, user)
	else
		hit_turfs = get_sweep_turfs(target, user)

	var/list/potential_targets = list()

	for(var/turf/T in hit_turfs)
		for(var/mob/M in T)
			potential_targets |= M

	potential_targets -= user

	var/mob/to_smack = GetTarget(user, potential_targets, target)

	if(!to_smack)
		SweepMiss(target, user)
		return TRUE

	var/old_animation = run_item_attack_animation
	run_item_attack_animation = FALSE
	. = to_smack.attackby(src, user, params)
	run_item_attack_animation = old_animation

	log_combat(user, target, "swung at", src.name, " and hit [to_smack]")
	add_fingerprint(user)
	return

/obj/item/proc/SweepMiss(atom/target, mob/living/carbon/human/user)
	user.visible_message(span_danger("[user] [swingstyle > WEAPONSWING_LARGESWEEP ? "thrusts" : "swings"] at [target]!"),\
		span_danger("You [swingstyle > WEAPONSWING_LARGESWEEP ? "thrust" : "swing"] at [target]!"), null, COMBAT_MESSAGE_RANGE, user)
	playsound(src, 'sound/items/weapons/thudswoosh.ogg', 60, TRUE)
	user.do_attack_animation(target, used_item = src, no_effect = TRUE)
/obj/item/proc/GetTarget(mob/user, list/potential_targets = list(), atom/clicked)
	if(ismob(clicked))
		. = clicked

	for(var/mob/living/simple_animal/hostile/H in potential_targets) // Hostile List
		if(.)
			break
		if(HAS_TRAIT(H, TRAIT_GODMODE))
			continue
		if(user.faction_check_atom(H))
			continue
		if(H.stat == DEAD)
			continue
		. = H
		break

	for(var/mob/living/L in potential_targets) // Standing List
		if(.)
			break
		if(L.resting)
			continue
		if(L.stat == DEAD)
			continue
		. = L
		break

	for(var/mob/living/L in potential_targets) // Laying Down List
		if(.)
			break
		. = L
		break

	return

/obj/item/proc/get_sweep_turfs(atom/target, mob/user)
	var/target_turf = get_step_towards(user, target)
	// Icon Setup
	var/swipe_icon = "swipe_"
	if(user.active_hand_index % 2 == 0)
		swipe_icon += "r"
	else
		swipe_icon += "l"

	if(swingstyle == WEAPONSWING_LARGESWEEP)
		swipe_icon += "_large"
		var/start = WEST
		var/end = EAST

		switch(get_dir(user, target))
			if(NORTH)
				start = EAST
				end = WEST
			if(SOUTH)
				start = WEST
				end = EAST
			if(EAST)
				start = SOUTH
				end = NORTH
			if(WEST)
				start = NORTH
				end = SOUTH
			if(NORTHEAST)
				start = SOUTH
				end = WEST
			if(NORTHWEST)
				start = EAST
				end = SOUTH
			if(SOUTHEAST)
				start = WEST
				end = NORTH
			if(SOUTHWEST)
				start = NORTH
				end = EAST

		if((user.get_held_index_of_item(src) % 2) - 1) // What hand we're in determines the check order of our swing
			var/temp = start
			start = end
			end = temp

		. = list(get_step(target_turf, start), target_turf, get_step(target_turf, end))
	else
		. = list(target_turf)

	new /obj/effect/temp_visual/swipe(get_step(user, SOUTHWEST), get_dir(user, target), swingcolor ? swingcolor : COLOR_GRAY, swipe_icon)

	return

/obj/item/proc/get_thrust_turfs(atom/target, mob/user)
	. = get_line(get_step_towards(user, target), target)
	for(var/turf/T in .)
		var/obj/effect/temp_visual/thrust/TT = new(T, swingcolor ? swingcolor : COLOR_GRAY)
		var/matrix/M = matrix(TT.transform)
		M.Turn(get_angle(user, target)-90)
		TT.transform = M
	return
