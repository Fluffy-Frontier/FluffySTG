// EGO hat type, attached to whatever armor that manifests it.
/obj/item/clothing/head/ego_hat
	name = "ego hat"
	desc = "an ego hat that you shouldn't be seeing!"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/clothing/ego_gear/head.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/Teguicons/mob/ego_gear/head.dmi'
	icon_state = ""
	flags_inv = HIDEMASK
	var/perma = FALSE // So we can stack all LC13 related hats under the same obj path

/obj/item/clothing/head/ego_hat/Destroy()
	if(perma)
		return ..()
	dropped()
	return ..()

/obj/item/clothing/head/ego_hat/equipped(mob/user, slot)
	if(perma)
		return ..()
	if(slot != ITEM_SLOT_HEAD)
		Destroy()
		return
	. = ..()

/obj/item/clothing/head/ego_hat/helmet // Subtype to cover the entire head
	flags_inv = HIDEHAIR|HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	flags_cover = HEADCOVERSEYES|HEADCOVERSMOUTH

	cold_protection = HEAD
	min_cold_protection_temperature = HELMET_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = HELMET_MAX_TEMP_PROTECT
	strip_delay = 60
	clothing_flags = SNUG_FIT | STACKABLE_HELMET_EXEMPT
