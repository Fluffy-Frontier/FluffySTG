//Security skinsuits! This file is for helmets only

/obj/item/clothing/head/helmet/skinhelm
	name = "security skinhelm"
	desc = "Sleek panoramic eva-like combat helmet, oftenly used with skinsuits"
	icon = 'tff_modular/modules/security_skinsuits/icons/obj/skinhelms.dmi'
	worn_icon = 'tff_modular/modules/security_skinsuits/icons/mob/skinhelms.dmi'
	worn_icon_muzzled = 'tff_modular/modules/security_skinsuits/icons/mob/skinhelms_muzzled.dmi'
	icon_state = "skinhelm"
	base_icon_state = "skinhelm"
	flags_inv = HIDESNOUT|HIDEMASK|HIDEEYES|HIDEFACE
	visor_flags_inv = HIDEHAIR|HIDEFACIALHAIR
	actions_types = list(/datum/action/item_action/toggle)
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION

/obj/item/clothing/head/helmet/skinhelm/attack_self(mob/user)
	adjust_visor(user)

/obj/item/clothing/head/helmet/skinhelm/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/seclite_attachable, light_icon_state = "flight")
	AddComponent(/datum/component/hat_stabilizer, loose_hat = FALSE) //То есть можно брать шлем с беретом к примеру

/obj/item/clothing/head/helmet/skinhelm/hos
	name = "head of security's skinhelm"
	desc = "Sleek panoramic eva-like combat helmet, oftenly used with skinsuits. This one has some gold stripes!"
	icon_state = "skinhelm_hos"
	base_icon_state = "skinhelm_hos"

/obj/item/clothing/head/helmet/skinhelm/ward
	name = "warden skinhelm"
	desc = "Sleek panoramic eva-like combat helmet, oftenly used with skinsuits. This one has some silver stripes!"
	icon_state = "skinhelm_ward"
	base_icon_state = "skinhelm_ward"

/obj/item/clothing/head/helmet/skinhelm/orange
	name = "hazard 'orange' skinhelm"
	desc = "Sleek panoramic eva-like combat helmet, oftenly used with skinsuits. This one has a lot of orange stripes!"
	icon_state = "skinhelm_orange"
	base_icon_state = "skinhelm_orange"
