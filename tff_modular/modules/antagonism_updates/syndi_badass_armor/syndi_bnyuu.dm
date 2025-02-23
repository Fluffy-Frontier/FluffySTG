/obj/item/storage/box/syndibunny
	name = "Syndicate bunny assassin outfit"
	desc = "A box containing a high tech specialized syndicate... bunny suit?"
	icon_state = "syndiebox"

/obj/item/storage/box/syndibunny/PopulateContents()
	generate_items_inside(list(
		/obj/item/clothing/under/syndicate/syndibunny = 1,
		/obj/item/clothing/suit/armor/security_tailcoat/syndi = 1,
		/obj/item/clothing/neck/bunny/bunnytie/syndicate = 1,
		/obj/item/clothing/head/playbunnyears/syndicate = 1,
		/obj/item/clothing/shoes/fancy_heels/syndi = 1,
		/obj/item/clothing/gloves/combat = 1,
	), src)
