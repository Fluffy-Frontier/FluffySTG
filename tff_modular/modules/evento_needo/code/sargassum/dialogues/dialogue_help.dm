#define RELATIONSHIP_NEGATIVE (1 << 0)
#define RELATIONSHIP_NEUTRAL (1 << 1)
#define RELATIONSHIP_POSITIVE (1 << 2)

#define DIALOG_TIME_LIMIT 1 MINUTES

/datum/current_dialog
	var/mob/living/player
	var/currently_talking = FALSE
	var/datum/dialog/dialog
	//Готовый список команд
	var/list/entries = list()
	var/datum/dialog_options/current_node = null
	var/list/old_options = list()
	var/last_talk_time
	var/timer
	var/greeted = FALSE
	var/can_forget = FALSE
	var/current_step = 1
	var/list/things_to_remember = list()
	var/relationship = 0

/datum/current_dialog/New(/datum/dialog/parent, mob/living/player)
	. = ..()
	src.player = player
	//src.dialog = parent
	start_dialog()

/datum/current_dialog/proc/start_dialog(mob/living/player)
	RegisterSignal(player, COMSIG_MOVABLE_MOVED, PROC_REF(check_in_range))
	currently_talking = TRUE

/datum/current_dialog/proc/stop_dialog(mob/living/player)
	UnregisterSignal(player, COMSIG_MOVABLE_MOVED)
	currently_talking = FALSE

/datum/current_dialog/proc/check_in_range(mob/living/player)
	SIGNAL_HANDLER

	//if(!dialog.sanity_check)
	//	stop_dialog()

/datum/current_dialog/Destroy()
	UnregisterSignal(player, COMSIG_MOVABLE_MOVED)
	player = null
	old_options = null
	return ..()

/datum/current_dialog/proc/start_forgeting(mob/living/player)
	return

/datum/current_dialog/proc/remember_this(mob/living/player, datum/weakref/thing)
	var/atom/refed_thing = thing?.resolve()
	if(isnull(refed_thing))
		return
	LAZYADD(things_to_remember[refed_thing.type], list(refed_thing))

/datum/current_dialog/proc/forget_this(mob/living/player, datum/weakref/thing)
	var/atom/refed_thing = thing?.resolve()
	if(isnull(things_to_remember[refed_thing]))
		list_clear_empty_weakrefs(things_to_remember)
		return
	LAZYREMOVE(things_to_remember[refed_thing], refed_thing)

/datum/current_dialog/proc/what_i_remember(datum/weakref/thing)
	var/atom/refed_thing = thing?.resolve()
	if(isnull(refed_thing))
		return null
	return things_to_remember[refed_thing]

/datum/current_dialog/proc/get_relationship_stage()
	switch(relationship)
		if(-15 to -5)
			return RELATIONSHIP_NEGATIVE
		if(-5 to 5)
			return RELATIONSHIP_NEUTRAL
		if(5 to 15)
			return RELATIONSHIP_POSITIVE

/datum/current_dialog/proc/check_if_old()
	if(last_talk_time + DIALOG_TIME_LIMIT > world.time)
		return TRUE
	return FALSE

///datum/current_dialog/proc/start_forgeting()
//	if(can_forget)
//		timer = addtimer(src, PROC_REF(forget), 5 MINUTES, TIMER_UNIQUE)
//
///datum/current_dialog/proc/forget()
//	deltimer(timer)
