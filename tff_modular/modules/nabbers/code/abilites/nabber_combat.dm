#define ICON_STATE_COMBAT_ON "nabber_combat_on"
#define ICON_STATE_COMBAT_OFF "nabber_combat_off"


/obj/item/melee/nabber_blade
	name = "Mantis arm"
	desc = "A grotesque matn made out of bone and flesh that cleaves through people as a hot knife through butter."
	icon = 'tff_modular/modules/nabbers/icons/items.dmi'
	icon_state = "mantis_arm_r"
	item_flags = ABSTRACT | DROPDEL
	w_class = WEIGHT_CLASS_HUGE
	force = 15
	throwforce = 0 //Просто предохранимся
	throw_range = 0
	throw_speed = 0
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")
	sharpness = SHARP_EDGED
	wound_bonus = 10
	bare_wound_bonus = 20

/obj/item/melee/nabber_blade/alt
	icon_state = "mantis_arm_l"

/obj/item/melee/nabber_blade/Initialize(mapload,silent,synthetic)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, ABSTRACT_ITEM_TRAIT)
	AddComponent(/datum/component/butchering, \
	speed = 10 SECONDS, \
	effectiveness = 80, \
	)

/obj/item/melee/nabber_blade/afterattack(atom/target, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	if(istype(target, /obj/structure/table))
		var/obj/structure/table/T = target
		T.deconstruct(FALSE)

	else if(istype(target, /obj/machinery/computer))
		var/obj/machinery/computer/C = target
		C.attack_alien(user)

/datum/action/cooldown/nabber_combat
	name = "Toggle mantis arms"
	desc = "Pump blood from manipulating arms into mantis arms, becoming a menace in close combat but loosing ability to interact."
	cooldown_time = 7 SECONDS

	button_icon = 'tff_modular/modules/nabbers/icons/actions.dmi'
	var/active = FALSE
	var/mob/living/carbon/human/nabber


/datum/action/cooldown/nabber_combat/Grant(mob/granted_to)
	. = ..()
	if(owner)
		nabber = owner
	RegisterSignal(granted_to, list(COMSIG_HUMAN_BURNING, COMSIG_LIVING_DEATH), PROC_REF(stop_combat))
	button_icon_state = ICON_STATE_COMBAT_OFF

/datum/action/cooldown/nabber_combat/Destroy()
	. = ..()
	UnregisterSignal(owner, list(COMSIG_HUMAN_BURNING, COMSIG_LIVING_DEATH))

/datum/action/cooldown/nabber_combat/Trigger(trigger_flags, atom/target)
	if(!nabber)
		return

	if(active)
		stop_combat()
		return

	if(nabber.on_fire) // Проверяем, что юзер не в огне.
		nabber.balloon_alert(owner, "On fire!")
		return

	if(nabber.num_hands < 2)
		nabber.balloon_alert(nabber, "Need both hands!")
		return

	if(nabber.alpha < 255)
		nabber.balloon_alert(owner, "Can't now!")
		return

	var/obj/item/held = nabber.get_active_held_item()
	var/obj/item/inactive = nabber.get_inactive_held_item()

	if(held || inactive)
		nabber.balloon_alert(nabber, "hands occupied!")
		return

	toggle_combat()
	..()

/datum/action/cooldown/nabber_combat/proc/update_icon_state(new_state)
	button_icon_state = new_state
	nabber.update_action_buttons()

/datum/action/cooldown/nabber_combat/proc/stop_combat()
	SIGNAL_HANDLER
	if(!nabber)
		return

	if(!active)
		return

	if(nabber.on_fire)
		nabber.balloon_alert(owner, "On fire!")

	nabber.Stun(cooldown_time)
	nabber.visible_message(span_notice("[nabber] starts to pump blood out their mantis arms!"), span_notice("You start pumping blood out your mantis arms. Stay still!"), span_hear("You hear ramping up screech!"))
	nabber.remove_status_effect(/datum/status_effect/nabber_combat)

	update_icon_state(ICON_STATE_COMBAT_OFF)
	playsound(nabber, 'tff_modular/modules/nabbers/sounds/nabberscream.ogg', 70)

	// Удаляем клинки.
	for(var/obj/item/held in nabber.held_items)
		if(istype(held, /obj/item/melee/nabber_blade))
			qdel(held)

	active = FALSE

/datum/action/cooldown/nabber_combat/proc/toggle_combat()
	//Применение визуального эффекта.
	nabber.apply_status_effect(/datum/status_effect/nabber_combat)
	nabber.visible_message(span_warning("[nabber] starts to pump blood into their mantis arms!"), span_userdanger("You start pumping blood into your mantis arms and emmitting defensive screech! Stay still!"), span_hear("You hear ramping up screech!"))
	nabber.Stun(cooldown_time)

	playsound(nabber, 'tff_modular/modules/nabbers/sounds/nabberscream.ogg', 70)
	addtimer(CALLBACK(src, PROC_REF(active_combat)), cooldown_time)

/datum/action/cooldown/nabber_combat/proc/active_combat()
	if(!nabber)
		return

	if(isdead(nabber))
		nabber.remove_status_effect(/datum/status_effect/nabber_combat)
		return

	update_icon_state(ICON_STATE_COMBAT_ON)
	playsound(nabber, 'tff_modular/modules/nabbers/sounds/nabberscream.ogg', 70)

	nabber.visible_message(span_warning("[nabber] raised their mantis arms ready for combat!"), span_userdanger("You raise your mantis arms, ready for combat."), span_hear("You hear terrible a screech!"))

	var/c = nabber.dna.features["mcolor"]
	var/obj/item/melee/nabber_blade/active_hand = new
	var/obj/item/melee/nabber_blade/alt/inactive_hand = new

	active_hand.color = c
	inactive_hand.color = c

	nabber.put_in_active_hand(active_hand)
	nabber.put_in_inactive_hand(inactive_hand)

	active = TRUE

#undef ICON_STATE_COMBAT_ON
#undef ICON_STATE_COMBAT_OFF
