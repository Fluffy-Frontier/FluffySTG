/obj/item/syndicate_teleporter
	name = "experimental teleporter"
	desc = "A reverse-engineered version of the Nanotrasen handheld teleporter. Lacks the advanced safety features of its counterpart. A three-headed serpent can be seen on the back."
	icon = 'icons/obj/devices/tracker.dmi'
	icon_state = "syndi-tele"
	throwforce = 5
	w_class = WEIGHT_CLASS_SMALL
	throw_speed = 4
	throw_range = 10
	obj_flags = CONDUCTS_ELECTRICITY
	inhand_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	//Uses of the device left
	var/charges = 4
	//The maximum number of stored uses
	var/max_charges = 4
	///Minimum distance to teleport user forward
	var/minimum_teleport_distance = 4
	///Maximum distance to teleport user forward
	var/maximum_teleport_distance = 8
	//How far the emergency teleport checks for a safe position
	var/parallel_teleport_distance = 3
	// How much blood lost per teleport (out of base 560 blood)
	var/bleed_amount = 45 //FF edit. original - 20
