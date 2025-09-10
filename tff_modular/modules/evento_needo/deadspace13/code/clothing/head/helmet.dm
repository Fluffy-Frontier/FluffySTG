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

/obj/item/clothing/head/helmet/titan_helm
	name = "security helmet"
	desc = "A blue helmet with a bright light blue visor that hides the face. Goes with the matching suit, has a bit of armor"
	icon = 'tff_modular/modules/evento_needo/deadspace13/icons/obj/clothing/hats.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/deadspace13/icons/onmob/head.dmi'
	icon_state = "titan_helmet"

/obj/item/clothing/head/helmet/titan_helm/colonel
	name = "colonel security helmet"
	desc = "A blue helmet with a bright light blue visor that hides the face. Goes with the matching suit, has a bit of armor"
	icon = 'tff_modular/modules/evento_needo/deadspace13/icons/obj/clothing/hats.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/deadspace13/icons/onmob/head.dmi'
	icon_state = "titan_colonel_helmet"

/obj/item/clothing/head/helmet/hunk
	name = "HUNK helmet"
	desc = "It's headwear specifically designed to protect against biohazards close range attacks."
	icon = 'tff_modular/modules/evento_needo/deadspace13/icons/obj/clothing/hats.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/deadspace13/icons/onmob/head.dmi'
	icon_state = "hunk_helmet"
