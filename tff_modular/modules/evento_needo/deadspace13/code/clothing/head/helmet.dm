/obj/item/clothing/head/helmet/pcsi
	name = "P.C.S.I helmet"
	desc = "A ceramic helmet with the badge of P.C.S.I emblazoned on the forehead."
	icon = 'tff_modular/modules/evento_needo/deadspace13/icons/obj/clothing/hats.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/deadspace13/icons/onmob/head.dmi'

/obj/item/clothing/head/helmet/pcsi/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/seclite_attachable, light_icon_state = "flight")

/obj/item/clothing/head/helmet/pcsi_hood
	name = "P.C.S.I hood"
	desc = "A ceramic hood with the badge of P.C.S.I emblazoned on the forehead. Sturdy, but a bullet to the face will still probably kill the wearer."
	icon = 'tff_modular/modules/evento_needo/deadspace13/icons/obj/clothing/hats.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/deadspace13/icons/onmob/head.dmi'
	icon_state = "helmet_pcsi"

/obj/item/clothing/head/helmet/cseco
	name = "PCSI beret"
	desc = "A brown beret with the badge of P.C.S.I."
	icon = 'tff_modular/modules/evento_needo/deadspace13/icons/obj/clothing/hats.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/deadspace13/icons/onmob/head.dmi'
	icon_state = "beret_cseco"

/obj/item/clothing/head/helmet/retro_command
	name = "command beret"
	desc = "an older looking command beret."
	icon = 'tff_modular/modules/evento_needo/deadspace13/icons/obj/clothing/hats.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/deadspace13/icons/onmob/head.dmi'
	icon_state = "retro_command_beret"
