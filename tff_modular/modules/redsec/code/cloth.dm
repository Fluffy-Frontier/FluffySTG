/datum/atom_skin/policeofficercap
	abstract_type = /datum/atom_skin/policeofficercap
/datum/atom_skin/policeofficercap/blue
	preview_name = "Police Officer Cap"
	new_icon_state = "policeofficercap"
	new_worn_icon = "policeofficercap"
/datum/atom_skin/policeofficercap/red
	preview_name = "Red Officer Cap"
	new_icon_state = "fedcapsec"
	new_worn_icon = "fedcapsec"
/datum/atom_skin/policeofficercap/sillitoe
	preview_name = "Traffic officer cap"
	new_icon_state = "policetrafficcap"
	new_worn_icon = "policetrafficcap"
/datum/atom_skin/policeofficercap/blackblue
	preview_name = "Black-Blue Officer Cap"
	new_icon_state = "policeofficerpatrolcap"
	new_worn_icon = "policeofficerpatrolcap"
/datum/atom_skin/policeofficercap/blackred
	preview_name = "Black-Red Officer Cap"
	new_icon_state = "policeofficerpatrolcap_red"
	new_worn_icon = "policeofficerpatrolcap_red"
/datum/atom_skin/policeofficercap/cadet
	preview_name = "Cadet Cap"
	new_icon_state = "policecadetcap"
	new_worn_icon = "policecadetcap"
/obj/item/clothing/head/hats/warden/police/patrol
	icon = 'tff_modular/modules/redsec/icons/hats.dmi'
	worn_icon = 'tff_modular/modules/redsec/icons/head.dmi'
/obj/item/clothing/head/hats/warden/police/patrol/setup_reskins()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/policeofficercap)
