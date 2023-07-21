/**
 * ВАЖНО!!
 * ЭТОТ КОД - ПРОСТО ИЗМЕНЁННЫЙ КОД АКТУАЛИЗАТОРА!
 * В СЛУЧАЕ ПРОБЛЕМ - ПЕРЕНОСИТЕ ИЗМЕНЕНИЯ С ОРИГИНАЛА СЮДА!
 */

/datum/mood_event/custom_rev_deconvert_fail
	description = "SOME STUPID DEVICE MESSED WITH MY BRAIN FOR NO REASON!"
	mood_change = -15
	timeout = 10 MINUTES

/datum/design/board/custom_rev_deconvert_device
	name = "Machine Design (ActiviZero2000 Device)"
	desc = "The circuit board for a ActiviZero2000 Device by Mind-CTRL."
	id = "custom_rev_deconvert_device"
	build_path = /obj/item/circuitboard/machine/custom_rev_deconvert_device
	category = list(RND_CATEGORY_INITIAL + RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_SECURITY)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/obj/item/circuitboard/machine/custom_rev_deconvert_device
	name = "ActiviZero2000 Device (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SECURITY
	build_path = /obj/machinery/custom_rev_deconvert_device
	req_components = list(/datum/stock_part/micro_laser = 1)

/obj/machinery/custom_rev_deconvert_device
	name = "ActiviZero2000 Device"
	desc = "Based on decommissioned Self-Actualization Device, this thing built to fight with diffirent types of activism among the crew on the station. \n\
	\n\
	ON FAIL WILL CAUSE SEVERE MENTAL SUFFERING!"
	icon = 'modular_skyrat/modules/self_actualization_device/icons/self_actualization_device.dmi'
	icon_state = "sad_open"
	circuit = /obj/item/circuitboard/machine/self_actualization_device
	state_open = FALSE
	density = TRUE
	/// Is someone being processed inside of the machine?
	var/processing = FALSE
	/// How long does it take to break out of the machine?
	var/breakout_time = 15 SECONDS
	/// How long does the machine take to work?
	var/processing_time = 20 SECONDS
	/// The interval that advertisements are said by the machine's speaker.
	var/next_fact = 8
	/// A list containing advertisements that the machine says while working.
	var/static/list/advertisements = list(\
	"Having troubles with unplesant activists' activity?", \
	"ActiviZero2000 Device will save you from troubles!" , \
	"Be careful! Will cause severe mental damage to wrong person! Use device wisely!" \
	)

/obj/machinery/custom_rev_deconvert_device/update_appearance(updates)
	. = ..()
	if(occupant)
		icon_state = processing ? "sad_on" : "sad_off"
	else
		icon_state = state_open ? "sad_open" : "sad_closed"



/obj/machinery/custom_rev_deconvert_device/Initialize(mapload)
	. = ..()
	update_appearance()

/obj/machinery/custom_rev_deconvert_device/close_machine(atom/movable/target, density_to_set = TRUE)
	..()
	playsound(src, 'sound/machines/click.ogg', 50)
	if(!occupant)
		return FALSE
	if(!ishuman(occupant))
		occupant.forceMove(drop_location())
		set_occupant(null)
		return FALSE
	to_chat(occupant, span_notice("You enter [src]."))
	update_appearance()

/obj/machinery/custom_rev_deconvert_device/examine(mob/user)
	. = ..()
	. += span_notice("ALT-Click to turn ON when closed.")

/obj/machinery/custom_rev_deconvert_device/AltClick(mob/user)
	. = ..()
	if(!powered() || !occupant || state_open)
		return FALSE

	to_chat(user, "You power on [src].")
	addtimer(CALLBACK(src, PROC_REF(eject_new_you)), processing_time, TIMER_OVERRIDE|TIMER_UNIQUE)
	processing = TRUE
	update_appearance()

/obj/machinery/custom_rev_deconvert_device/container_resist_act(mob/living/user)
	if(state_open)
		open_machine()
		return FALSE

	to_chat(user, span_notice("The emergency release is not responding! You start pushing against the hull!"))
	user.changeNext_move(CLICK_CD_BREAKOUT)
	user.last_special = world.time + CLICK_CD_BREAKOUT
	user.visible_message(span_notice("You see [user] kicking against the door of [src]!"), \
		span_notice("You lean on the back of [src] and start pushing the door open... (this will take about [DisplayTimeText(breakout_time)].)"), \
		span_hear("You hear a metallic creaking from [src]."))

	if(do_after(user, breakout_time, target = src))
		if(!user || user.stat != CONSCIOUS || user.loc != src || state_open)
			return
		user.visible_message(span_warning("[user] successfully broke out of [src]!"), \
			span_notice("You successfully break out of [src]!"))
		open_machine()

/obj/machinery/custom_rev_deconvert_device/interact(mob/user)
	if(state_open)
		close_machine()
		return

	if(!processing)
		open_machine()
		return

/obj/machinery/custom_rev_deconvert_device/process(seconds_per_tick)
	if(!processing)
		return
	if(!powered() || !occupant || !iscarbon(occupant))
		open_machine()
		return

	next_fact--
	if(next_fact <= 0)
		next_fact = rand(initial(next_fact), 2 * initial(next_fact))
		say(pick(advertisements))
		playsound(loc, 'sound/machines/chime.ogg', 30, FALSE)

	use_power(500)

/// Дековерт тут.
/obj/machinery/custom_rev_deconvert_device/proc/eject_new_you()
	if(state_open || !occupant || !powered())
		return
	processing = FALSE

	if(!ishuman(occupant))
		open_machine()
		return FALSE

	// КОД ДЕКОНВЕРТАЦИИ.

	var/mob/living/carbon/human/occupant_mob = occupant
	var/datum/mind/occupant_mind = occupant_mob.mind
	if(!occupant_mind)
		open_machine()
		return FALSE

	var/success = FALSE
	for(var/datum/antagonist/custom_rev/antag as anything in occupant_mind.antag_datums)
		if(!istype(antag, /datum/antagonist/custom_rev))
			continue
		if(!antag.rev_team)
			continue
		if(antag.rev_team.ignore_deconvert_machine)
			continue
		occupant_mind.remove_antag_datum(antag)
		occupant_mind.current.log_message("has been deconverted from the [antag.rev_team.name] by deconvert machinery!", LOG_GAME, color="red")
		success = TRUE
	
	if(success)
		say("OPERATION WAS SUCCESSFUL, OCCUPANT WAS RE-EDUCATED!")
	else
		say("OPERATION HAS FAILED!")
		to_chat(occupant_mob, span_danger("YOU FEEL TERRIBLE!"))
		occupant_mob.adjust_confusion_up_to(3 MINUTES, 6 MINUTES)
		occupant_mob.adjust_jitter_up_to(3 MINUTES, 6 MINUTES)
		occupant_mob.adjust_hallucinations_up_to(4 MINUTES, 8 MINUTES)
		occupant_mob.add_mood_event("deconvert_fail", /datum/mood_event/custom_rev_deconvert_fail)

	// КОНЕЦ КОДА ДЕКОНВЕРТАЦИИ.
	
	open_machine()
	playsound(src, 'sound/machines/microwave/microwave-end.ogg', 100, FALSE)

/obj/machinery/custom_rev_deconvert_device/screwdriver_act(mob/living/user, obj/item/used_item)
	. = TRUE
	if(..())
		return

	if(occupant)
		to_chat(user, span_warning("[src] is currently occupied!"))
		return

	if(default_deconstruction_screwdriver(user, icon_state, icon_state, used_item))
		update_appearance()
		return

	return FALSE

/obj/machinery/self_actualization_device/crowbar_act(mob/living/user, obj/item/used_item)
	if(occupant)
		to_chat(user, span_warning("[src] is currently occupied!"))
		return

	if(default_deconstruction_crowbar(used_item))
		return TRUE

