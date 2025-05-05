//Предмет для лутанья нашего антагуса
/obj/item/antag_granter/hematocrat_contract
	name = "strange scroll"
	desc = "A heavy scroll. It looks like you need to sign it with your blood..."
	icon = 'icons/obj/scrolls.dmi'
	icon_state = "scroll-ancient"
	antag_datum = /datum/antagonist/hematocrat/leader
	user_message = "As you sign the contract, you feel like your blood boiling!"

/datum/opposing_force_equipment/uplink/hematocrat_contract
	name = "Hematocrat Contract"
	item_type = /obj/item/antag_granter/hematocrat_contract
	description = "This agreement gives you abilities of controling flesh and blood, but you become a servant of unknown god-like creature!"
