/obj/item/gun/ballistic

	valid_attachments = list(
		/obj/item/attachment/laser_sight,
		/obj/item/attachment/rail_light,
		/obj/item/attachment/bayonet,
		/obj/item/attachment/energy_bayonet,
		/obj/item/attachment/sling,
		/obj/item/attachment/ammo_counter,
		/obj/item/attachment/silencer,
		/obj/item/attachment/scope,
	)

	slot_available = list(
		ATTACHMENT_SLOT_RAIL = 1,
		ATTACHMENT_SLOT_MUZZLE = 1,
		ATTACHMENT_SLOT_SCOPE = 1,
	)

	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 29,
			"y" = 16,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 22,
			"y" = 16,
		),
		ATTACHMENT_SLOT_SCOPE = list(
			"x" = 18,
			"y" = 22,
		)
	)
