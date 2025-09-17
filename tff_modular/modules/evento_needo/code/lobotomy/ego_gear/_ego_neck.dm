
// EGO neckwear
/obj/item/clothing/neck/ego_neck
	name = "ego neckwear"
	desc = "an ego neckwear that you shouldn't be seeing!"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/clothing/ego_gear/neck.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/Teguicons/mob/ego_gear/neck.dmi'
	icon_state = ""
	var/perma = FALSE

/obj/item/clothing/neck/ego_neck/Destroy()
	if(perma)
		return ..()
	dropped()
	return ..()

/obj/item/clothing/neck/ego_neck/equipped(mob/user, slot)
	if(perma)
		return ..()
	if(slot != ITEM_SLOT_NECK)
		Destroy()
		return
	. = ..()
