/*
/ Тут будут разные перезаписи и иной код который будет выдавать кобуру кому либо.
*/

// Ящик БЩ
/obj/structure/closet/secure_closet/blueshield/New()
	. = ..()
	new /obj/item/clothing/accessory/cqd_holster(src)

// Ящик ХоСа
/obj/structure/closet/secure_closet/hos/PopulateContents()
	. = ..()
	new /obj/item/clothing/accessory/cqd_holster(src)

// Ящик Капитана
/obj/structure/closet/secure_closet/captains/PopulateContents()
	. = ..()
	new /obj/item/clothing/accessory/cqd_holster/aesthetic(src)

// Ящик НТРа
/obj/structure/closet/secure_closet/nanotrasen_consultant/station/PopulateContents()
	. = ..()
	new /obj/item/clothing/accessory/cqd_holster/aesthetic(src)

// Антажный вариант в аплинке
/datum/uplink_item/stealthy_tools/cqd_holster
	name = "blood-red CQD holster"
	desc = "CQD model holster made of durable materials and has tactical weapon attachment points. CQD stands for Concealed Quick Draw, this holster model developed for more comfortable weapon carry among authorized personnel. This one made of much more sophisticated materials and has strange red coloring."
	item = /obj/item/clothing/accessory/cqd_holster/syndicate
	cost = 1
	surplus = 30
