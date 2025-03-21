var/datum/martial_art/martial_to_learn = new /datum/martial_art/nabber_grab()

/obj/item/melee/nabber_blade
	name = "Mantis arm"
	desc = "A grotesque matn made out of bone and flesh that cleaves through people as a hot knife through butter."
	icon = 'tff_modular/modules/nabbers/icons/items.dmi'
	icon_state = "mantis_arm_r"
	item_flags = ABSTRACT | DROPDEL
	w_class = WEIGHT_CLASS_HUGE
	force = 25
	throwforce = 0 //Просто предохранимся
	throw_range = 0
	throw_speed = 0
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")
	sharpness = SHARP_EDGED
	wound_bonus = 15
	bare_wound_bonus = 25

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
	else if(istype(target, /obj/structure/chair))
		var/obj/structure/chair/C = target
		C.deconstruct()
	else if(istype(target, /obj/machinery/computer))
		var/obj/machinery/computer/C = target
		C.attack_alien(user)

/datum/action/cooldown/toggle_arms
	name = "Toggle mantis arms"
	desc = "Pump blood from manipulating arms into mantis arms, becoming a menace in close combat but loosing ability to interact."
	cooldown_time = 5 SECONDS

	var/obj/item/restraints/handcuffs/stored_handcuffs = null //Переменная для сохранения наручников

	button_icon = 'tff_modular/modules/nabbers/icons/actions.dmi'

/datum/action/cooldown/toggle_arms/New(Target, original)
	. = ..()
	button_icon_state = "arms_off"

/datum/action/cooldown/toggle_arms/Destroy()
	stored_handcuffs = null
	. = ..()

/datum/action/cooldown/toggle_arms/Activate(atom/target)
	var/mob/living/carbon/human/nabber = owner

	if(!nabber)
		return FALSE

	if(isdead(nabber) || nabber.incapacitated)
		if(!nabber.handcuffed)
			nabber.balloon_alert(nabber, "Incapacitated!")
			return FALSE

	if(nabber.num_hands < 2)
		nabber.balloon_alert(nabber, "Need both hands!")
		return	FALSE

	var/obj/item/held = nabber.get_active_held_item()
	var/obj/item/inactive = nabber.get_inactive_held_item()

	if(((held || inactive) && !nabber.drop_all_held_items()) && !(istype((inactive || held), /obj/item/melee/nabber_blade)))
		nabber.balloon_alert(nabber, "Hands occupied!")
		return	FALSE

	else if(istype((inactive || held), /obj/item/melee/nabber_blade))
		StartCooldown()
		down_arms()
		return TRUE

	rise_arms()
	StartCooldown()
	return TRUE

/datum/action/cooldown/toggle_arms/proc/rise_arms()
	var/mob/living/carbon/human/nabber = owner

	nabber.balloon_alert(nabber, "Begin pumping blood in!")
	nabber.visible_message(span_warning("[nabber] starts to pump blood into their mantis arms!"), span_warning("You start pumping blood into your mantis arms and emmitting defensive screech! Stay still!"), span_hear("You hear ramping up screech!"))
	playsound(nabber, 'tff_modular/modules/nabbers/sounds/nabberscream.ogg', 70)

	if(!do_after(nabber, 2 SECONDS, nabber, IGNORE_USER_LOC_CHANGE))
		StartCooldown()
		return FALSE

	//"Сохраняет" наручники надетые на ГБСа в ЕГО ТЕЛО и позволяет пользоваться косами + открепляет его от стула и подобного
	if(nabber.handcuffed)
		stored_handcuffs = nabber.handcuffed
		nabber.handcuffed.forceMove(nabber)
		nabber.set_handcuffed(null)
		if(nabber.buckled?.buckle_requires_restraints)
			nabber.buckled.unbuckle_mob(nabber)
		nabber.update_handcuffed()

	nabber.balloon_alert(nabber, "Arms rised!")
	nabber.visible_message(span_warning("[nabber] raised their mantis arms ready for combat!"), span_warning("You raise your mantis arms, ready for combat."), span_hear("You hear terrible a screech!"))
	playsound(nabber, 'tff_modular/modules/nabbers/sounds/nabberscream.ogg', 70)

	var/c = nabber.dna.features["mcolor"]
	var/obj/item/melee/nabber_blade/active_hand = new
	var/obj/item/melee/nabber_blade/alt/inactive_hand = new

	active_hand.color = c
	inactive_hand.color = c

	nabber.put_in_active_hand(active_hand)
	nabber.put_in_inactive_hand(inactive_hand)
	martial_to_learn.teach(nabber)

	RegisterSignal(owner, COMSIG_CARBON_POST_REMOVE_LIMB, PROC_REF(on_lose_hand))
	button_icon_state = "arms_on"
	nabber.update_action_buttons()

/datum/action/cooldown/toggle_arms/proc/down_arms(force = FALSE)
	var/mob/living/carbon/human/nabber = owner

	nabber.visible_message(span_notice("[nabber] starts to pump blood out their mantis arms!"), span_notice("You start pumping blood out your mantis arms. Stay still!"), span_hear("You hear ramping up screech!"))

	if(force) //Типикал бьонд код
		if(stored_handcuffs)
			stored_handcuffs.forceMove(stored_handcuffs.drop_location())
			stored_handcuffs = null
		nabber.Stun(5 SECONDS)
		for(var/obj/item/held in nabber.held_items)
			if(istype(held, /obj/item/melee/nabber_blade))
				qdel(held)
		button_icon_state = "arms_on"
		nabber.update_action_buttons()
		return	FALSE

	nabber.balloon_alert(nabber, "Starting pumping blood out!")

	if(!do_after(nabber, 2 SECONDS, nabber, IGNORE_USER_LOC_CHANGE))
		return	FALSE

	playsound(nabber, 'tff_modular/modules/nabbers/sounds/nabberscream.ogg', 70)
	for(var/obj/item/held in nabber.held_items)
		if(istype(held, /obj/item/melee/nabber_blade))
			qdel(held)

	UnregisterSignal(owner, COMSIG_CARBON_POST_REMOVE_LIMB)
	martial_to_learn.unlearn(nabber)
	nabber.balloon_alert(nabber, "Arms down!")
	button_icon_state = "arms_off"
	nabber.update_action_buttons()

	// Надевает наручники обратно если они были до перехода в косы
	if(stored_handcuffs)
		nabber.equip_to_slot(stored_handcuffs, ITEM_SLOT_HANDCUFFED)
		stored_handcuffs = null

/datum/action/cooldown/toggle_arms/proc/on_lose_hand()
	SIGNAL_HANDLER
	var/mob/living/carbon/human/nabber = owner

	if(nabber.num_hands >= 2)
		return FALSE

	nabber.visible_message(span_notice("[nabber] starts to pump blood out their mantis arms!"), span_notice("You start pumping blood out your mantis arms. Stay still!"), span_hear("You hear ramping up screech!"))
	playsound(nabber, 'tff_modular/modules/nabbers/sounds/nabberscream.ogg', 70)
	nabber.balloon_alert(nabber, "Lose hand!")
	nabber.Stun(5 SECONDS)
	for(var/obj/item/held in nabber.held_items)
		if(istype(held, /obj/item/melee/nabber_blade))
			qdel(held)

	martial_to_learn.unlearn(nabber)
	button_icon_state = "arms_off"
	nabber.update_action_buttons()

	if(stored_handcuffs)
		stored_handcuffs.forceMove(stored_handcuffs.drop_location())
		stored_handcuffs = null

	UnregisterSignal(owner, COMSIG_CARBON_POST_REMOVE_LIMB)
