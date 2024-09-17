/// Special type of legcuffs that do not affect movement or doesnt show up, but block other legcuffs
/obj/item/restraints/legcuffs/gas_placeholder
	name = "serpentid thick tail"
	desc = "You should not see this."
	gender = PLURAL
	icon_state = NONE
	inhand_icon_state = "nabber_r_leg"
	lefthand_file = 'tff_modular/modules/nabbers/icons/bodyparts/nabber_parts_greyscale.dmi'
	righthand_file = 'tff_modular/modules/nabbers/icons/bodyparts/nabber_parts_greyscale.dmi'
	w_class = WEIGHT_CLASS_TINY
	slowdown = 0
	item_flags = DROPDEL | ABSTRACT

/obj/item/restraints/legcuffs/gas_placeholder/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, ABSTRACT_ITEM_TRAIT)

/obj/item/restraints/legcuffs/gas_placeholder/update_icon_state()
	icon_state = NONE
	return ..()

/mob/living/carbon/human/cuff_resist(obj/item/cuffs, breakouttime = 1 MINUTES, cuff_break = 0)
	if(isnabber(src))
		if(istype(cuffs, /obj/item/restraints/legcuffs/gas_placeholder))
			return FALSE
	return ..()

/mob/living/carbon/human/doUnEquip(obj/item/unequip_item, force, newloc, no_move, invdrop, silent)
	if(isnabber(src))
		if(istype(unequip_item, /obj/item/restraints/legcuffs/gas_placeholder))
			return FALSE
	return ..()

/// У ГБСов этот слот всегда должен быть занять заглушкой, которую нельзя снять
/mob/living/carbon/human/update_worn_legcuffs(update_obscured = TRUE)
	if(isnabber(src))
		return FALSE
	else
		return ..()

/datum/species/nabber/can_equip(obj/item/I, slot, disable_warning, mob/living/carbon/human/H, bypass_equip_delay_self, ignore_equipped, indirect_action)
	if(slot == ITEM_SLOT_LEGCUFFED)
		return FALSE
	. = ..()

// Это ужас
/obj/item/restraints/legcuffs/gas_placeholder/canStrip(mob/stripper, mob/owner)
	INVOKE_ASYNC(src, PROC_REF(touch_ze_bug), stripper, owner)
	return ..()

/obj/item/restraints/legcuffs/gas_placeholder/proc/touch_ze_bug(mob/stripper, mob/owner)
	owner.visible_message(
						  span_purple("[stripper] лапает хвост ГБСа. Кажется зря."),
						  span_purple("[stripper] лапает мой хвост! Кажется зря."),
						  blind_message = span_hear("You hear lewd bug noises."),
						)
	playsound(get_turf(owner), 'modular_nova/modules/modular_items/lewd_items/sounds/vax2.ogg', 50, TRUE)
