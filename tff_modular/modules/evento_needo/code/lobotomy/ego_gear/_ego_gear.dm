/obj/item/clothing/suit/armor/ego_gear
	name = "ego gear"
	desc = "You aren't meant to see this."
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/ego_gear/suits.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/Teguicons/clothing/ego_gear/suit.dmi'
	blood_overlay_type = null
	flags_inv = HIDEJUMPSUIT
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS|HEAD 	// We protect all because magic
	cold_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS|HEAD
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS|HEAD
	w_class = WEIGHT_CLASS_BULKY								//No more stupid 10 egos in bag
	allowed = list(/obj/item/gun, /obj/item/ego_weapon, /obj/item/melee)
	drag_slowdown = 1
	var/equip_slowdown = 3 SECONDS
	var/new_armor = list()
	var/obj/item/clothing/head/ego_hat/hat = null // Hat type, see clothing/head/_ego_head.dm
	var/obj/item/clothing/neck/ego_neck/neck = null // Neckwear, see clothing/neck/_neck.dm
	var/list/attribute_requirements = list()
	var/equip_bonus
	actions_types = list(

	)

/obj/item/clothing/suit/armor/ego_gear/Initialize(mapload)
	for(var/key in new_armor)
		set_armor_rating(key, new_armor[key])
	return ..()

/obj/item/clothing/suit/armor/ego_gear/mob_can_equip(mob/living/user, slot, disable_warning = FALSE, bypass_equip_delay_self = FALSE, ignore_equipped = FALSE, indirect_action)
	//if(!ishuman(M))
	//	return FALSE
	//var/mob/living/carbon/human/H = M
	//if(slot_flags & slot) // Equipped to right slot, not just in hands
	//	//if(!CanUseEgo(H))
	//	//	return FALSE
	//	if(equip_slowdown > 0 && (M == user || !user))
	//		if(!do_after(H, equip_slowdown, target = H))
	//			return FALSE
	return ..()

/obj/item/clothing/suit/armor/ego_gear/item_action_slot_check(slot)
	if(slot == ITEM_SLOT_OCLOTHING) // Abilities are only granted when worn properly
		return TRUE

/obj/item/clothing/suit/armor/ego_gear/equipped(mob/user, slot)
	. = ..()
	if(slot == ITEM_SLOT_OCLOTHING)
		return
	if(hat)
		var/obj/item/clothing/head/headgear = user.get_item_by_slot(ITEM_SLOT_HEAD)
		if(!istype(headgear, hat))
			return
		headgear.Destroy()
	if(neck)
		var/obj/item/clothing/neck/neckwear = user.get_item_by_slot(ITEM_SLOT_NECK)
		if(!istype(neckwear, neck))
			return
		neckwear.Destroy()

/obj/item/clothing/suit/armor/ego_gear/dropped(mob/user)
	. = ..()
	if(hat)
		var/obj/item/clothing/head/headgear = user.get_item_by_slot(ITEM_SLOT_HEAD)
		if(!istype(headgear, hat))
			return
		headgear.Destroy()
	if(neck)
		var/obj/item/clothing/neck/neckwear = user.get_item_by_slot(ITEM_SLOT_NECK)
		if(!istype(neckwear, neck))
			return
		neckwear.Destroy()

/obj/item/clothing/suit/armor/ego_gear/proc/CanUseEgo(mob/living/carbon/human/user)
	if(!ishuman(user))
		return FALSE
	if(user.mind)
		if(user.mind.assigned_role == "Sephirah") //This is an RP role
			return FALSE

	var/mob/living/carbon/human/H = user
	if(!SpecialEgoCheck(H))
		return FALSE
	return TRUE

/obj/item/clothing/suit/armor/ego_gear/proc/SpecialEgoCheck(mob/living/carbon/human/H)
	return TRUE

/obj/item/clothing/suit/armor/ego_gear/proc/SpecialGearRequirements()
	return

/obj/item/clothing/suit/armor/ego_gear/examine(mob/user)
	. = ..()
	if(LAZYLEN(attribute_requirements))
		if(!ishuman(user))	//You get a notice if you are a ghost or otherwise
			. += span_notice("It has <a href='byond://?src=[REF(src)];list_attributes=1'>certain requirements</a> for the wearer.")
		//else if(CanUseEgo(user))	//It's green if you can use it
		//	. += span_nicegreen("It has <a href='byond://?src=[REF(src)];list_attributes=1'>certain requirements</a> for the wearer.")
		else				//and red if you cannot use it
			. += span_danger("You cannot use this EGO!")
			. += span_danger("It has <a href='byond://?src=[REF(src)];list_attributes=1'>certain requirements</a> for the wearer.")

/obj/item/clothing/suit/armor/ego_gear/Topic(href, href_list)
	. = ..()
	if(href_list["list_attributes"])
		var/display_text = "<span class='warning'><b>It requires the following attributes:</b></span>"
		for(var/atr in attribute_requirements)
			if(attribute_requirements[atr] > 0)
				display_text += "\n <span class='warning'>[atr]: [attribute_requirements[atr]].</span>"
		display_text += SpecialGearRequirements()
		to_chat(usr, display_text)


/obj/item/clothing/suit/armor/ego_gear/adjustable
	var/list/alternative_styles = list()
	var/index = 1

/obj/item/clothing/suit/armor/ego_gear/adjustable/Initialize()
	. = ..()
	alternative_styles |= icon_state
	index = alternative_styles.len

/obj/item/clothing/suit/armor/ego_gear/adjustable/examine(mob/user)
	. = ..()
	. += "<span class='notice'>It can be adjusted by right-clicking the armor.</span>"

/obj/item/clothing/suit/armor/ego_gear/adjustable/verb/AdjustStyle()
	set name = "Adjust EGO Style"
	set category = null
	set src in usr
	Adjust()

/obj/item/clothing/suit/armor/ego_gear/adjustable/proc/Adjust()
	if(!ishuman(usr))
		return
	if(alternative_styles.len <= 1)
		to_chat(usr, "<span class='notice'>Has no other styles!</span>")
		return
	index++
	if(index > alternative_styles.len)
		index = 1
	icon_state = alternative_styles[index]
	to_chat(usr, "<span class='notice'>You adjust [src] to a new style~!</span>")
	var/mob/living/carbon/human/H = usr
	H.update_body()
