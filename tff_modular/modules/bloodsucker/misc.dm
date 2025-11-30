#define TRAIT_COFFIN_ENLARGED "coffin_enlarged"

#define TRAIT_TORPOR "torpor"

#define TRAIT_SHADED "shaded"

#define TRAIT_GARLIC_REAGENT "garlic_reagent"

/datum/action
	/// Extended description of the action, usually shown in an antag UI.
	var/power_explanation = ""

/datum/antagonist
	var/antag_panel_title = "Antagonist Panel"
	var/antag_panel_description = "This is the antagonist panel. It contains all the abilities you have access to as an antagonist. Use them wisely."

/datum/antagonist/proc/ability_ui_data(actions = list())
	var/list/data = list()
	data["title"] = "[antag_panel_title]\n[antag_panel_data()]"
	data["description"] = antag_panel_description
	for(var/datum/action/cooldown/power as anything in actions)
		var/list/power_data = list()

		power_data["power_name"] = power.name
		power_data["power_icon"] = power.button_icon_state
		if(istype(power, /datum/action/cooldown/bloodsucker))
			var/datum/action/cooldown/bloodsucker/bloodsucker_power = power
			power_data["power_explanation"] = bloodsucker_power.get_power_explanation()

		data["powers"] += list(power_data)
	return data

/mob
	/// Can they interact with station electronics
	var/has_unlimited_silicon_privilege = FALSE

/datum/mood_event/drankblood
	description = "<span class='nicegreen'>I have fed greedly from that which nourishes me.</span>\n"
	mood_change = 10
	timeout = 8 MINUTES

/datum/mood_event/drankblood_bad
	description = "<span class='boldwarning'>I drank the blood of a lesser creature. Disgusting.</span>\n"
	mood_change = -4
	timeout = 3 MINUTES

/datum/mood_event/drankblood_dead
	description = "<span class='boldwarning'>I drank dead blood. I am better than this.</span>\n"
	mood_change = -7
	timeout = 8 MINUTES

/datum/mood_event/drankblood_synth
	description = "<span class='boldwarning'>I drank synthetic blood. What is wrong with me?</span>\n"
	mood_change = -7
	timeout = 8 MINUTES

/datum/mood_event/drankkilled
	description = "<span class='boldwarning'>I fed off of a dead person. I feel... less human.</span>\n"
	mood_change = -15
	timeout = 10 MINUTES

/datum/mood_event/madevamp
	description = "<span class='boldwarning'>A mortal has reached an apotheosis- undeath- by my own hand.</span>\n"
	mood_change = 15
	timeout = 20 MINUTES

/datum/mood_event/coffinsleep
	description = "<span class='nicegreen'>I slept in a coffin during the day. I feel whole again.</span>\n"
	mood_change = 10
	timeout = 6 MINUTES

/datum/mood_event/coffinsleep/quirk
	mood_change = 4

/datum/mood_event/daylight_bad_sleep
	description = "<span class='boldwarning'>I slept poorly in a makeshift coffin during the day.</span>\n"
	mood_change = -3
	timeout = 6 MINUTES

/datum/mood_event/daylight_sun_scorched
	description = "<span class='boldwarning'>I have been scorched by the unforgiving rays of the sun.</span>\n"
	mood_change = -6
	timeout = 6 MINUTES

///Candelabrum's mood event to non Bloodsucker/Ghouls
/datum/mood_event/vampcandle
	description = "<span class='boldwarning'>Something is making your mind feel... loose.</span>\n"
	mood_change = -15
	timeout = 5 MINUTES

/datum/mood_event/nosferatu_examined
	mood_change = -10
	timeout = 5 MINUTES

/datum/mood_event/nosferatu_examined/add_effects(target, level = 0)
	description = span_danger("You feel a deep sense of revulsion at the sight of [target].")
	mood_change = level * -5


/**
 * # Status effect
 *
 * This is the status effect given to Bloodsuckers in a Frenzy
 * This deals with everything entering/exiting Frenzy is meant to deal with.
 */

/atom/movable/screen/alert/status_effect/frenzy
	name = "Frenzy"
	desc = "You are in a Frenzy! You are entirely Feral and, depending on your Clan, fighting for your life! Find and drink blood, or you will suffer a Final Death!"
	icon = 'tff_modular/modules/bloodsucker/icons/bloodsucker.dmi'
	icon_state = "power_recover"
	alerttooltipstyle = "cult"

/datum/status_effect/frenzy
	id = "Frenzy"
	status_type = STATUS_EFFECT_UNIQUE
	duration = STATUS_EFFECT_PERMANENT
	alert_type = /atom/movable/screen/alert/status_effect/frenzy
	///Boolean on whether they were an AdvancedToolUser, to give the trait back upon exiting.
	var/was_tooluser = FALSE
	/// The stored Bloodsucker antag datum
	var/datum/antagonist/bloodsucker/bloodsuckerdatum
	var/trait_list = list(TRAIT_MUTE, TRAIT_DEAF, TRAIT_STRONG_GRABBER)

/datum/status_effect/frenzy/get_examine_text()
	return span_notice("They seem... inhumane, and feral!")

/atom/movable/screen/alert/status_effect/masquerade/MouseEntered(location,control,params)
	desc = initial(desc)
	return ..()

/datum/status_effect/frenzy/on_apply()
	var/mob/living/carbon/human/user = owner
	bloodsuckerdatum = IS_BLOODSUCKER(user)

	// Disable ALL Powers and notify their entry
	bloodsuckerdatum.DisableAllPowers(forced = TRUE)
	to_chat(owner, span_userdanger("<FONT size = 3>Blood! You need Blood, now! You enter a total Frenzy! You will DIE if you do not get BLOOD."))
	to_chat(owner, span_announce("* Bloodsucker Tip: While in Frenzy, you quickly accrue burn damage, instantly Aggresively grab, have stun resistance, cannot speak, hear, or use any powers outside of Feed and Trespass (If you have it)."))
	owner.balloon_alert(owner, "you enter a frenzy! Drink blood, or you will die!")
	SEND_SIGNAL(bloodsuckerdatum, COMSIG_BLOODSUCKER_ENTERS_FRENZY)

	// Give the other Frenzy effects
	owner.add_traits(trait_list, FRENZY_TRAIT)
	if(HAS_TRAIT(owner, TRAIT_ADVANCEDTOOLUSER))
		was_tooluser = TRUE
		REMOVE_TRAIT(owner, TRAIT_ADVANCEDTOOLUSER, SPECIES_TRAIT)
	owner.add_movespeed_modifier(/datum/movespeed_modifier/frenzy_speedup)
	owner.add_client_colour(/datum/client_colour/manual_heart_blood, REF(src))
	var/obj/cuffs = user.get_item_by_slot(ITEM_SLOT_HANDCUFFED)
	var/obj/legcuffs = user.get_item_by_slot(ITEM_SLOT_LEGCUFFED)
	if((user.handcuffed && cuffs) || (user.legcuffed && legcuffs))
		user.clear_cuffs(cuffs, TRUE)
		user.clear_cuffs(legcuffs, TRUE)
	bloodsuckerdatum.frenzied = TRUE
	return ..()

/datum/status_effect/frenzy/on_remove()
	owner.balloon_alert(owner, "you come back to your senses.")
	owner.remove_traits(trait_list, FRENZY_TRAIT)
	if(was_tooluser)
		ADD_TRAIT(owner, TRAIT_ADVANCEDTOOLUSER, SPECIES_TRAIT)
		was_tooluser = FALSE
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/frenzy_speedup)
	owner.remove_client_colour(REF(src))

	SEND_SIGNAL(bloodsuckerdatum, COMSIG_BLOODSUCKER_EXITS_FRENZY)
	bloodsuckerdatum.frenzied = FALSE
	return ..()

/datum/status_effect/frenzy/tick()
	var/mob/living/carbon/human/user = owner
	// If duration is not -1, that means we're about to loose frenzy, let's give them some safe time.
	if(!bloodsuckerdatum.frenzied || duration > 0 || user.stat != CONSCIOUS )
		return
	user.adjustFireLoss(1 + (bloodsuckerdatum.GetHumanityLost() / 10))

/datum/language/vampiric
	name = "Enochian"
	desc = "Rumored to be created by the Dark Father, Caine himself as a way to talk to his Childer, the truth, like many things in unlife is uncertain. Spoken by creatures of the night."
	key = "L"//Capital L, lowercase l is for ashies.
	space_chance = 40
	default_priority = 90

	flags = TONGUELESS_SPEECH | LANGUAGE_HIDE_ICON_IF_NOT_UNDERSTOOD
	syllables = list(
		"luk","cha","no","kra","pru","chi","busi","tam","pol","spu","och",
		"umf","ora","stu","si","ri","li","ka","red","ani","lup","ala","pro",
		"to","siz","nu","pra","ga","ump","ort","a","ya","yach","tu","lit",
		"wa","mabo","mati","anta","tat","tana","prol",
		"tsa","si","tra","te","ele","fa","inz",
		"nza","est","sti","ra","pral","tsu","ago","esch","chi","kys","praz",
		"froz","etz","tzil",
		"t'","k'","t'","k'","th'","tz'"
		)

	icon_state = "bloodsucker"
	icon = 'tff_modular/modules/bloodsucker/icons/language.dmi'
	secret = TRUE

/**
 * # Phobetor Brain Trauma
 *
 * Beefmen's Brain trauma, causing phobetor tears to traverse through.
 */

/datum/brain_trauma/special/bluespace_prophet/phobetor
	name = "Sleepless Dreamer"
	desc = "The patient, after undergoing untold psychological hardship, believes they can travel between the dreamscapes of this dimension."
	scan_desc = "awoken sleeper"
	gain_text = "<span class='notice'>Your mind snaps, and you wake up. You <i>really</i> wake up."
	lose_text = "<span class='warning'>You succumb once more to the sleepless dream of the unwoken."

	///Created tears, only checking the FIRST one, not the one it's created to link to.
	var/list/created_firsts = list()

///When the trauma is removed from a mob.
/datum/brain_trauma/special/bluespace_prophet/phobetor/on_lose(silent)
	. = ..()
	for(var/obj/effect/client_image_holder/phobetor/phobetor_tears as anything in created_firsts)
		qdel(phobetor_tears)

/datum/brain_trauma/special/bluespace_prophet/phobetor/on_life(seconds_per_tick, times_fired)
	if(!COOLDOWN_FINISHED(src, portal_cooldown))
		return
	COOLDOWN_START(src, portal_cooldown, 10 SECONDS)
	var/list/turf/possible_tears = list()
	for(var/turf/nearby_turfs as anything in RANGE_TURFS(8, owner))
		if(nearby_turfs.density)
			continue
		possible_tears += nearby_turfs
	if(!LAZYLEN(possible_tears))
		return

	var/turf/first_tear
	var/turf/second_tear
	first_tear = return_valid_floor_in_range(owner, 6, 0, TRUE)
	if(!first_tear)
		return
	second_tear = return_valid_floor_in_range(first_tear, 20, 6, TRUE)
	if(!second_tear)
		return

	var/obj/effect/client_image_holder/phobetor/first = new(first_tear, owner)
	var/obj/effect/client_image_holder/phobetor/second = new(second_tear, owner)

	first.linked_to = second
	first.seer = owner
	first.desc += " This one leads to [get_area(second)]."
	first.name += " ([get_area(second)])"
	created_firsts += first

	second.linked_to = first
	second.seer = owner
	second.desc += " This one leads to [get_area(first)]."
	second.name += " ([get_area(first)])"

	// Delete Next Portal if it's time (it will remove its partner)
	var/obj/effect/client_image_holder/phobetor/first_on_the_stack = created_firsts[1]
	if(created_firsts.len && world.time >= first_on_the_stack.created_on + first_on_the_stack.exist_length)
		var/targetGate = first_on_the_stack
		created_firsts -= targetGate
		qdel(targetGate)

/datum/brain_trauma/special/bluespace_prophet/phobetor/proc/return_valid_floor_in_range(atom/targeted_atom, checkRange = 8, minRange = 0, check_floor = TRUE)
	// FAIL: Atom doesn't exist. Aren't you real?
	if(!istype(targeted_atom))
		return FALSE
	var/delta_x = rand(minRange,checkRange)*pick(-1,1)
	var/delta_y = rand(minRange,checkRange)*pick(-1,1)
	var/turf/center = get_turf(targeted_atom)

	var/target = locate((center.x + delta_x),(center.y + delta_y), center.z)
	if(check_turf_is_valid(target, check_floor))
		return target
	return FALSE

/**
 * Used as a helper that checks if you can successfully teleport to a turf.
 * Returns a boolean, and checks for if the turf has density, if the turf's area has the NOTELEPORT flag,
 * and if the objects in the turf have density.
 * If check_floor is TRUE in the argument, it will return FALSE if it's not a type of [/turf/open/floor].
 * Arguments:
 * * turf/open_turf - The turf being checked for validity.
 * * check_floor - Checks if it's a type of [/turf/open/floor]. If this is FALSE, lava/chasms will be able to be selected.
 */
/datum/brain_trauma/special/bluespace_prophet/phobetor/proc/check_turf_is_valid(turf/open_turf, check_floor = TRUE)
	if(check_floor && !istype(open_turf, /turf/open/floor))
		return FALSE
	if(open_turf.density)
		return FALSE
	var/area/turf_area = get_area(open_turf)
	if(turf_area.area_flags & NOTELEPORT)
		return FALSE
	// Checking for Objects...
	for(var/obj/object in open_turf)
		if(object.density)
			return FALSE
	return TRUE

/**
 * # Phobetor Tears
 *
 * The phobetor tears created by the Brain trauma.
 */

/obj/effect/client_image_holder/phobetor
	name = "phobetor tear"
	desc = "A subdimensional rip in reality, which gives extra-spacial passage to those who have woken from the sleepless dream."
	image_icon = 'tff_modular/modules/bloodsucker/icons/phobetor_tear.dmi'
	image_state = "phobetor_tear"
	// Place this above shadows so it always glows.
	image_layer = ABOVE_MOB_LAYER

	/// How long this will exist for
	var/exist_length = 50 SECONDS
	/// The time of this tear's creation
	var/created_on
	/// The phobetor tear this is linked to
	var/obj/effect/client_image_holder/phobetor/linked_to
	/// The person able to see this tear.
	var/mob/living/carbon/seer

/obj/effect/client_image_holder/phobetor/Initialize(mapload)
	. = ..()
	created_on = world.time

/obj/effect/client_image_holder/phobetor/Destroy()
	if(linked_to)
		linked_to.linked_to = null
		QDEL_NULL(linked_to)
	return ..()

/obj/effect/client_image_holder/phobetor/proc/check_location_seen(atom/subject, turf/target_turf)
	if(!target_turf)
		return FALSE
	if(!isturf(target_turf))
		return FALSE
	if(!target_turf.lighting_object || !target_turf.get_lumcount() >= 0.1)
		return FALSE
	for(var/mob/living/nearby_viewers in viewers(target_turf))
		if(nearby_viewers == subject)
			continue
		if(!isliving(nearby_viewers) || !nearby_viewers.mind)
			continue
		if(nearby_viewers.has_unlimited_silicon_privilege || nearby_viewers.is_blind())
			continue
		return TRUE
	return FALSE

/obj/effect/client_image_holder/phobetor/attack_hand(mob/living/user, list/modifiers)
	if(user != seer || !linked_to)
		return
	if(user.loc != src.loc)
		to_chat(user, "Step into the Tear before using it.")
		return
	for(var/obj/item/implant/tracking/imp in user.implants)
		to_chat(user, span_warning("[imp] gives you the sense that you're being watched."))
		return
	// Is this, or linked, stream being watched?
	if(check_location_seen(user, get_turf(user)))
		to_chat(user, span_warning("Not while you're being watched."))
		return
	if(check_location_seen(user, get_turf(linked_to)))
		to_chat(user, span_warning("Your destination is being watched."))
		return
	to_chat(user, span_notice("You slip unseen through [src]."))
	user.playsound_local(null, 'sound/effects/magic/wand_teleport.ogg', 30, FALSE, pressure_affected = FALSE)
	user.forceMove(get_turf(linked_to))

/datum/crafting_recipe/blackcoffin
	name = "Black Coffin"
	result = /obj/structure/closet/crate/coffin/blackcoffin
	tool_behaviors = list(TOOL_WELDER, TOOL_SCREWDRIVER)
	reqs = list(
		/obj/item/stack/sheet/cloth = 1,
		/obj/item/stack/sheet/mineral/wood = 5,
		/obj/item/stack/sheet/iron = 1,
	)
	time = 15 SECONDS
	category = CAT_FURNITURE

/datum/crafting_recipe/securecoffin
	name = "Secure Coffin"
	result = /obj/structure/closet/crate/coffin/securecoffin
	tool_behaviors = list(TOOL_WELDER, TOOL_SCREWDRIVER)
	reqs = list(
		/obj/item/stack/rods = 1,
		/obj/item/stack/sheet/plasteel = 5,
		/obj/item/stack/sheet/iron = 5,
	)
	time = 15 SECONDS
	category = CAT_FURNITURE

/datum/crafting_recipe/meatcoffin
	name = "Meat Coffin"
	result = /obj/structure/closet/crate/coffin/meatcoffin
	tool_behaviors = list(TOOL_KNIFE, TOOL_ROLLINGPIN)
	reqs = list(
		/obj/item/food/meat/slab = 5,
		/obj/item/restraints/handcuffs/cable = 1,
	)
	time = 15 SECONDS
	category = CAT_FURNITURE
	crafting_flags = parent_type::crafting_flags | CRAFT_MUST_BE_LEARNED

/datum/crafting_recipe/metalcoffin
	name = "Metal Coffin"
	result = /obj/structure/closet/crate/coffin/metalcoffin
	reqs = list(
		/obj/item/stack/sheet/iron = 6,
		/obj/item/stack/rods = 2,
	)
	time = 10 SECONDS
	category = CAT_FURNITURE

/datum/crafting_recipe/ghoulrack
	name = "Persuasion Rack"
	result = /obj/structure/bloodsucker/ghoulrack
	tool_behaviors = list(TOOL_WELDER, TOOL_WRENCH)
	reqs = list(
		/obj/item/stack/sheet/mineral/wood = 3,
		/obj/item/stack/sheet/iron = 2,
		/obj/item/restraints/handcuffs/cable = 2,
	)
	time = 15 SECONDS
	category = CAT_FURNITURE
	crafting_flags = parent_type::crafting_flags | CRAFT_MUST_BE_LEARNED

/datum/crafting_recipe/candelabrum
	name = "Candelabrum"
	result = /obj/structure/bloodsucker/candelabrum
	tool_behaviors = list(TOOL_WELDER, TOOL_WRENCH)
	reqs = list(
		/obj/item/stack/sheet/iron = 3,
		/obj/item/stack/rods = 1,
		/obj/item/flashlight/flare/candle = 1,
	)
	time = 10 SECONDS
	category = CAT_FURNITURE
	crafting_flags = parent_type::crafting_flags | CRAFT_MUST_BE_LEARNED

/datum/crafting_recipe/bloodthrone
	name = "Blood Throne"
	result = /obj/structure/bloodsucker/bloodthrone
	tool_behaviors = list(TOOL_WRENCH)
	reqs = list(
		/obj/item/stack/sheet/cloth = 3,
		/obj/item/stack/sheet/iron = 5,
		/obj/item/stack/sheet/mineral/wood = 1,
	)
	time = 5 SECONDS
	category = CAT_FURNITURE
	crafting_flags = parent_type::crafting_flags | CRAFT_MUST_BE_LEARNED


/datum/species
	var/sort_bottom = FALSE
//Whether or not a given species is sorted to the bottom of the list. We mainly want to do this for species that are used only for ghostroles, and template species.

/// Called once the target is made into a bloodsucker. Used for removing conflicting species organs mostly
/datum/species/proc/on_bloodsucker_gain(mob/living/carbon/human/target)
	return null

/datum/species/proc/on_bloodsucker_loss(mob/living/carbon/human/target)
	return null

/// Replaces a couple organs to normal variants to not cause issues. Not super happy with this, alternative is disallowing vampiric races from being bloodsuckers
/datum/species/proc/humanize_organs(mob/living/carbon/human/target, organs = list())
	if(!organs || !length(organs))
		organs = list(
			ORGAN_SLOT_HEART = /obj/item/organ/heart,
			ORGAN_SLOT_LIVER = /obj/item/organ/liver,
			ORGAN_SLOT_STOMACH = /obj/item/organ/stomach,
			ORGAN_SLOT_TONGUE = /obj/item/organ/tongue,
		)
	mutantheart = organs[ORGAN_SLOT_HEART]
	mutantliver = organs[ORGAN_SLOT_LIVER]
	mutantstomach = organs[ORGAN_SLOT_STOMACH]
	mutanttongue = organs[ORGAN_SLOT_TONGUE]
	for(var/organ_slot in organs)
		var/obj/item/organ/old_organ = target.get_organ_slot(organ_slot)
		var/organ_path = organs[organ_slot]
		if(old_organ?.type == organ_path)
			continue
		var/obj/item/organ/new_organ = SSwardrobe.provide_type(organ_path)
		new_organ.Insert(target, FALSE, DELETE_IF_REPLACED)

/datum/species/proc/normalize_organs(mob/living/carbon/human/target)
	mutantheart = initial(mutantheart)
	mutantliver = initial(mutantliver)
	mutantstomach = initial(mutantstomach)
	mutanttongue = initial(mutanttongue)
	regenerate_organs(target, replace_current = TRUE)


/datum/species/get_species_description()
	SHOULD_CALL_PARENT(FALSE)

	//stack_trace("Species [name] ([type]) did not have a description set, and is a selectable roundstart race! Override get_species_description.")
	return list("No species description set, file a bug report!",)

/datum/species/lizard/on_bloodsucker_gain(mob/living/carbon/human/target, datum/species/current_species)
	bodytemp_heat_damage_limit = BODYTEMP_HEAT_DAMAGE_LIMIT
	bodytemp_cold_damage_limit = BODYTEMP_COLD_DAMAGE_LIMIT

/datum/species/lizard/on_bloodsucker_loss(mob/living/carbon/human/target)
	bodytemp_heat_damage_limit = initial(bodytemp_heat_damage_limit)
	bodytemp_cold_damage_limit = initial(bodytemp_cold_damage_limit)

/datum/species/jelly/on_bloodsucker_gain(mob/living/carbon/human/target)
	humanize_organs(target)

/datum/species/jelly/on_bloodsucker_loss(mob/living/carbon/human/target)
	// regenerate_organs with replace doesn't seem to automatically remove invalid organs unfortunately
	normalize_organs()

/datum/species/human/vampire/on_bloodsucker_gain(mob/living/carbon/human/target, datum/species/current_species)
	to_chat(target, span_warning("Your vampire features have been removed, your nature as a bloodsucker abates the lesser vampirism curse."))
	humanize_organs(target, current_species)

/datum/species/human/vampire/on_bloodsucker_loss(mob/living/carbon/human/target)
	normalize_organs(target)

// BLOODSUCKER SPECIFIC FIXES
/datum/species/hemophage/on_bloodsucker_gain(mob/living/carbon/human/target)
	to_chat(target, span_warning("Your hemophage features have been removed, your nature as a bloodsucker abates the hemophage virus."))
	// Without this any new organs would get corrupted again.
	target.RemoveElement(/datum/element/tumor_corruption)
	for(var/obj/item/organ/organ in target.organs)
		organ.RemoveElement(/datum/element/tumor_corruption)
	humanize_organs(target)

/datum/species/hemophage/on_bloodsucker_loss(mob/living/carbon/human/target)
	normalize_organs(target)

/datum/movespeed_modifier/frenzy_speedup
	blacklisted_movetypes = (FLYING|FLOATING)
	multiplicative_slowdown = -0.4

/datum/movespeed_modifier/mesmerize_slowdown
	blacklisted_movetypes = (FLYING|FLOATING)
	multiplicative_slowdown = 0.5


/// UI obj holders for all your maptext needs
/atom/movable/screen/text
	name = null
	icon = null
	icon_state = null
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	screen_loc = "CENTER-7,CENTER-7"
	maptext_height = 480
	maptext_width = 480

/// A screen object that shows the time left on a timer
/atom/movable/screen/text/screen_timer
	screen_loc = "CENTER-7,CENTER-7"
	/// The actual displayed content of the maptext, use ${timer}, and it'll be replaced with formatted time left
	var/maptext_string
	/// Timer ID that we're tracking, the time left of this is displayed as maptext
	var/timer_id
	/// The list of mobs in whose client.screens we are added to
	var/list/timer_mobs = list()

/atom/movable/screen/text/screen_timer/Initialize(
		mapload,
		list/mobs,
		timer,
		text,
		offset_x = 150,
		offset_y = -70,
	)
	. = ..(mapload, null)

	if(!islist(mobs) && mobs)
		mobs = list(mobs)
	// Copy the list just in case the arguments list is a list we don't want to modify
	if(length(mobs))
		mobs = mobs.Copy()
	if(!timer)
		return INITIALIZE_HINT_QDEL
	maptext_string = text
	timer_id = timer
	maptext_x = offset_x
	maptext_y = offset_y
	update_maptext()
	if(length(mobs))
		apply_to(mobs)

/atom/movable/screen/text/screen_timer/process()
	if(!timeleft(timer_id))
		qdel(src)
		return
	update_maptext()

/// Adds the object to the client.screen of all mobs in the list, and registers the needed signals
/atom/movable/screen/text/screen_timer/proc/apply_to(list/mobs)
	if(!mobs)
		return
	if(!islist(mobs))
		mobs = list(mobs)
	if(!length(timer_mobs) && length(mobs))
		START_PROCESSING(SSprocessing, src)
	for(var/player in mobs)
		if(player in timer_mobs)
			continue
		if(istype(player, /datum/weakref))
			var/datum/weakref/ref = player
			player = ref.resolve()
		attach(player)
		RegisterSignal(player, COMSIG_MOB_LOGIN, PROC_REF(attach)) // doesn't currently cleanup properly
		timer_mobs += WEAKREF(player)

/// Removes the object from the client.screen of all mobs in the list, and unregisters the needed signals, while also stopping processing if there's no more mobs in the screen timers mob list
/atom/movable/screen/text/screen_timer/proc/remove_from(list/mobs)
	if(!mobs)
		return
	if(!islist(mobs))
		mobs = list(mobs)
	for(var/player in mobs)
		// when the player is a weakref, assume it's the same pointer that we use in the timer_mobs list
		var/datum/weakref/found_weakref
		if(istype(player, /datum/weakref))
			var/datum/weakref/ref = player
			found_weakref = ref
		// otherwise we have to search through and resolve each one and compare it
		else
			for(var/datum/weakref/possible_match as anything in timer_mobs)
				if(player == possible_match.resolve())
					found_weakref = possible_match
					break
		timer_mobs -= found_weakref
		var/found_player = found_weakref.resolve()
		if(!found_player)
			return
		UnregisterSignal(found_player, COMSIG_MOB_LOGIN)
		de_attach(found_player)
	if(!length(timer_mobs))
		STOP_PROCESSING(SSprocessing, src)

/// Updates the maptext to show the current time left on the timer
/atom/movable/screen/text/screen_timer/proc/update_maptext()
	var/time_formatted = time2text(timeleft(timer_id), "mm:ss")
	var/timer_text = replacetextEx(maptext_string, "${timer}", time_formatted)
	// If we don't find ${timer} in the string, just use the time formatted
	var/result_text = MAPTEXT("[timer_text]")
	apply_change(result_text)

/atom/movable/screen/text/screen_timer/proc/apply_change(result_text)
	maptext = result_text

/// Adds the object to the client.screen of the mob, or removes it if add_to_screen is FALSE
/atom/movable/screen/text/screen_timer/proc/attach(mob/source, add_to_screen = TRUE)
	SIGNAL_HANDLER
	if(!source?.client)
		return
	var/client/client = source.client
	// this checks if the screen is already added or removed
	if(!can_attach(client, add_to_screen))
		return
	if(!ismob(source))
		CRASH("Invalid source passed to screen_timer/attach()!")
	do_attach(client, add_to_screen)

/atom/movable/screen/text/screen_timer/proc/can_attach(client/client, add_to_screen)
	return add_to_screen == (src in client.screen)

/atom/movable/screen/text/screen_timer/proc/do_attach(client/client, add_to_screen)
	if(add_to_screen)
		client.screen += src
	else
		client.screen -= src

/// Signal handler to run attach with specific args
/atom/movable/screen/text/screen_timer/proc/de_attach(mob/source)
	SIGNAL_HANDLER
	attach(source, FALSE)

/atom/movable/screen/text/screen_timer/Destroy()
	if(length(timer_mobs))
		remove_from(timer_mobs)

	STOP_PROCESSING(SSprocessing, src)
	. = ..()

/atom/movable/screen/text/screen_timer/attached
	maptext_x = 0
	maptext_y = 16
	maptext_height = 32
	maptext_width = 32
	var/following_object
	var/image/text_image

/atom/movable/screen/text/screen_timer/attached/Initialize(
		mapload,
		list/mobs,
		timer,
		text,
		offset_x,
		offset_y,
		following_object,
	)
	if(following_object && get_turf(following_object))
		attach_self_to(following_object, offset_x, offset_y)
	else
		return INITIALIZE_HINT_QDEL
	. = ..()

/atom/movable/screen/text/screen_timer/attached/can_attach(client/client)
	return !(src in client.images)

// attached screen timers are a visible timer in the gameworld that are only visible to the mobs listed in the timer_mobs list
/atom/movable/screen/text/screen_timer/attached/do_attach(client/client, add_to_screen)
	if(add_to_screen)
		client.images += text_image
	else
		client.images -= text_image

/atom/movable/screen/text/screen_timer/attached/proc/attach_self_to(atom/movable/target, maptext_x, maptext_y)
	text_image = image(src, target)

	text_image.maptext_x = maptext_x
	text_image.maptext_y = maptext_y

	text_image.maptext_height = maptext_height
	text_image.maptext_width = maptext_width

	SET_PLANE_EXPLICIT(text_image, ABOVE_HUD_PLANE, target)

/atom/movable/screen/text/screen_timer/attached/apply_change(result_text)
	..()
	text_image?.maptext = result_text

/atom/movable/screen/text/screen_timer/attached/proc/hide_timer(atom/movable/target)
	unregister_follower()

/atom/movable/screen/text/screen_timer/attached/proc/unregister_follower()
	following_object = null
	text_image = null

/atom/movable/screen/text/screen_timer/attached/proc/update_glide_speed(atom/movable/tracked)
	set_glide_size(tracked.glide_size)

/atom/movable/screen/text/screen_timer/attached/proc/timer_follow(atom/movable/tracked, atom/mover, atom/oldloc, direction)
	abstract_move(get_turf(tracked))

/atom/movable/screen/text/screen_timer/attached/Destroy()
	if(following_object)
		unregister_follower()
	. = ..()
