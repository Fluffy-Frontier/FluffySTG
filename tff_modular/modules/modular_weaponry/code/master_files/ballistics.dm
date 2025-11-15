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
		/obj/item/attachment/long_scope,
	)

	slot_available = list(
		ATTACHMENT_SLOT_RAIL = 1,
		ATTACHMENT_SLOT_MUZZLE = 1,
		ATTACHMENT_SLOT_SCOPE = 1,
	)

	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 29,
			"y" = 14,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 18,
			"y" = 17,
		),
		ATTACHMENT_SLOT_SCOPE = list(
			"x" = 18,
			"y" = 22,
		)
	)

/obj/item/gun/ballistic/automatic
	actions_types = list()
	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_FULLAUTO)


/obj/item/gun/ballistic/automatic/pistol
	valid_attachments = list(
		/obj/item/attachment/laser_sight,
		/obj/item/attachment/rail_light,
		/obj/item/attachment/bayonet,
		/obj/item/attachment/energy_bayonet,
		/obj/item/attachment/ammo_counter,
		/obj/item/attachment/silencer,
	)
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 23,
			"y" = 16,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 19,
			"y" = 18,
		),
		ATTACHMENT_SLOT_SCOPE = list(
			"x" = 16,
			"y" = 22,
		)
	)

	gun_firemodes = list(FIREMODE_SEMIAUTO)

/obj/item/gun/ballistic/revolver
	valid_attachments = list(
		/obj/item/attachment/ammo_counter,
	)

/obj/item/gun/ballistic/shotgun
	valid_attachments = list(
		/obj/item/attachment/laser_sight,
		/obj/item/attachment/rail_light,
		/obj/item/attachment/ammo_counter,
		/obj/item/attachment/sling,
	)
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 29,
			"y" = 14,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 16,
			"y" = 17,
		),
		ATTACHMENT_SLOT_SCOPE = list(
			"x" = 18,
			"y" = 22,
		)
	)
