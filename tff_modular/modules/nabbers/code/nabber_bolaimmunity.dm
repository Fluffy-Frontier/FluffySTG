/// Special type of legcuffs that do not affect movement or doesnt show up, but block other legcuffs
/obj/item/restraints/legcuffs/gas_placeholder
	name = "serpentid thick tail"
	desc = "You should not see this."
	gender = PLURAL
	inhand_icon_state = "nabber_r_leg"
	lefthand_file = 'tff_modular/modules/nabbers/icons/bodyparts/nabber_parts_greyscale.dmi'
	righthand_file = 'tff_modular/modules/nabbers/icons/bodyparts/nabber_parts_greyscale.dmi'
	w_class = WEIGHT_CLASS_TINY
	slowdown = 0
	alpha = 0
	invisibility = INVISIBILITY_ABSTRACT
	item_flags = DROPDEL | ABSTRACT

	var/mob/living/carbon/human/nabber = null

/obj/item/restraints/legcuffs/gas_placeholder/Initialize(mapload)
	ADD_TRAIT(src, TRAIT_NODROP, ABSTRACT_ITEM_TRAIT)
	return ..()

/obj/item/restraints/legcuffs/gas_placeholder/proc/register_owner(mob/living/carbon/human/nabber)
	if(!nabber || !isnabber(nabber))
		return FALSE
	RegisterSignal(nabber, COMSIG_MOB_REMOVING_CUFFS, PROC_REF(handle_nabber_removing_cuffs), TRUE)
	RegisterSignal(src, COMSIG_ITEM_PRE_UNEQUIP, PROC_REF(handle_nabber_unequip_cuffs), TRUE)
	src.nabber = nabber
	return TRUE

/obj/item/restraints/legcuffs/gas_placeholder/Destroy(force)
	. = ..()
	if(nabber)
		UnregisterSignal(nabber, list(COMSIG_MOB_REMOVING_CUFFS, COMSIG_ITEM_PRE_UNEQUIP))

/obj/item/restraints/legcuffs/gas_placeholder/proc/handle_nabber_removing_cuffs()
	SIGNAL_HANDLER
	return COMSIG_MOB_BLOCK_CUFF_REMOVAL

/obj/item/restraints/legcuffs/gas_placeholder/proc/handle_nabber_unequip_cuffs(datum/soure, force, atom/newloc, no_move, invdrop, silent)
	SIGNAL_HANDLER
	if(!force)
		return COMPONENT_ITEM_BLOCK_UNEQUIP

/datum/species/nabber/can_equip(obj/item/I, slot, disable_warning, mob/living/carbon/human/H, bypass_equip_delay_self, ignore_equipped, indirect_action)
	if(slot == ITEM_SLOT_LEGCUFFED)
		return FALSE
	return ..()

/obj/item/restraints/legcuffs/gas_placeholder/canStrip(mob/stripper, mob/owner)
	INVOKE_ASYNC(src, PROC_REF(touch_ze_bug), stripper, owner)
	return ..()

/obj/item/restraints/legcuffs/gas_placeholder/proc/touch_ze_bug(mob/stripper, mob/owner)
	owner.visible_message(
		span_purple("[stripper] touches tail of [owner]!"),
		span_purple("[stripper] touches your tail."),
		blind_message = span_hear("You hear lewd bug noisses."),
	)
	playsound(get_turf(owner), 'modular_nova/modules/modular_items/lewd_items/sounds/vax2.ogg', 50, TRUE)
