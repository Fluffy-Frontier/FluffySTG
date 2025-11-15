/obj/item/gun/energy/disabler
	aimed_wield_slowdown = LIGHTEST_AIM_SLOWDOWN
	wield_slowdown = LIGHT_PISTOL_SLOWDOWN
	valid_attachments = list(
		/obj/item/attachment/laser_sight,
		/obj/item/attachment/rail_light,
		/obj/item/attachment/ammo_counter,
	)

/obj/item/gun/energy/e_gun/advtaser
	aimed_wield_slowdown = LIGHTEST_AIM_SLOWDOWN
	wield_slowdown = LIGHT_PISTOL_SLOWDOWN
	valid_attachments = list(
		/obj/item/attachment/laser_sight,
		/obj/item/attachment/rail_light,
		/obj/item/attachment/ammo_counter,
	)

/obj/item/gun/energy/e_gun/dragnet
	aimed_wield_slowdown = LIGHTEST_AIM_SLOWDOWN
	wield_slowdown = HEAVY_PISTOL_SLOWDOWN
	valid_attachments = list(
		/obj/item/attachment/laser_sight,
		/obj/item/attachment/rail_light,
		/obj/item/attachment/ammo_counter,
	)

/obj/item/gun/energy/disabler/smg
	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_FULLAUTO)
	aimed_wield_slowdown = LIGHTEST_AIM_SLOWDOWN
	wield_slowdown = HEAVY_PISTOL_SLOWDOWN
	recoil_unwielded = 0.1
	spread_unwielded = 8
	valid_attachments = list(
		/obj/item/attachment/laser_sight,
		/obj/item/attachment/rail_light,
		/obj/item/attachment/ammo_counter,
	)

/obj/item/gun/energy/blueshield
	aimed_wield_slowdown = LIGHTEST_AIM_SLOWDOWN
	wield_slowdown = HEAVY_PISTOL_SLOWDOWN
	recoil_unwielded = 0.1
	spread_unwielded = 7
	valid_attachments = list(
		/obj/item/attachment/ammo_counter,
	)

/obj/item/gun/energy/modular_laser_rifle/carbine
	aimed_wield_slowdown = LIGHTEST_AIM_SLOWDOWN
	wield_slowdown = HEAVY_PISTOL_SLOWDOWN
	recoil_unwielded = 0.2
	spread_unwielded = 7
	valid_attachments = list(
		/obj/item/attachment/laser_sight,
		/obj/item/attachment/rail_light,
		/obj/item/attachment/bayonet,
		/obj/item/attachment/energy_bayonet,
		/obj/item/attachment/ammo_counter,
		/obj/item/attachment/scope,
	)

/obj/item/gun/ballistic/automatic/pistol/plasma_marksman
	aimed_wield_slowdown = LIGHTEST_AIM_SLOWDOWN
	wield_slowdown = HEAVY_PISTOL_SLOWDOWN
	recoil_unwielded = 0.1
	valid_attachments = list(
		/obj/item/attachment/laser_sight,
		/obj/item/attachment/rail_light,
		/obj/item/attachment/bayonet,
		/obj/item/attachment/energy_bayonet,
		/obj/item/attachment/ammo_counter,
	)
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 19,
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

/obj/item/gun/ballistic/automatic/pistol/plasma_thrower
	aimed_wield_slowdown = LIGHTEST_AIM_SLOWDOWN
	wield_slowdown = SMG_SLOWDOWN
	recoil_unwielded = 0.3
	valid_attachments = list(
		/obj/item/attachment/laser_sight,
		/obj/item/attachment/rail_light,
		/obj/item/attachment/ammo_counter,
	)
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 19,
			"y" = 16,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 19,
			"y" = 17,
		),
		ATTACHMENT_SLOT_SCOPE = list(
			"x" = 16,
			"y" = 22,
		)
	)

/obj/item/gun/energy/e_gun
	aimed_wield_slowdown = LIGHTEST_AIM_SLOWDOWN
	wield_slowdown = RIFLE_SLOWDOWN
	recoil_unwielded = 0.3
	spread_unwielded = 8

/obj/item/gun/energy/e_gun/hos
	aimed_wield_slowdown = LIGHT_AIM_SLOWDOWN
	wield_slowdown = SMG_SLOWDOWN
	recoil_unwielded = 0.2
	spread_unwielded = 7

/obj/item/gun/energy/e_gun/mini
	aimed_wield_slowdown = LIGHTEST_AIM_SLOWDOWN
	wield_slowdown = LIGHT_PISTOL_SLOWDOWN
	recoil_unwielded = 0
	spread_unwielded = 5
	valid_attachments = list(
		/obj/item/attachment/ammo_counter,
	)

/obj/item/gun/energy/laser
	aimed_wield_slowdown = LIGHTEST_AIM_SLOWDOWN
	wield_slowdown = RIFLE_SLOWDOWN
	recoil_unwielded = 0.3
	spread_unwielded = 7

/obj/item/gun/energy/laser/captain
	aimed_wield_slowdown = LIGHT_AIM_SLOWDOWN
	wield_slowdown = SMG_SLOWDOWN
	recoil_unwielded = 0.2

/obj/item/gun/energy/xray
	aimed_wield_slowdown = LIGHTEST_AIM_SLOWDOWN
	wield_slowdown = RIFLE_SLOWDOWN
	recoil_unwielded = 0.3
	spread_unwielded = 8
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 27,
			"y" = 14,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 19,
			"y" = 18,
		),
		ATTACHMENT_SLOT_SCOPE = list(
			"x" = 16,
			"y" = 20,
		)
	)


/obj/item/gun/energy/laser/hellgun
	aimed_wield_slowdown = LIGHTEST_AIM_SLOWDOWN
	wield_slowdown = RIFLE_SLOWDOWN
	recoil_unwielded = 0.3
	spread_unwielded = 8slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 27,
			"y" = 16,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 17,
			"y" = 18,
		),
		ATTACHMENT_SLOT_SCOPE = list(
			"x" = 16,
			"y" = 22,
		)
	)

/obj/item/gun/energy/modular_laser_rifle
	aimed_wield_slowdown = LIGHT_AIM_SLOWDOWN
	wield_slowdown = RIFLE_SLOWDOWN
	recoil_unwielded = 0.5
	spread_unwielded = 9
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 32,
			"y" = 15,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 19,
			"y" = 18,
		),
		ATTACHMENT_SLOT_SCOPE = list(
			"x" = 18,
			"y" = 22,
		)
	)


/obj/item/gun/energy/ionrifle
	aimed_wield_slowdown = LIGHTEST_AIM_SLOWDOWN
	recoil_unwielded = 0.3
	spread_unwielded = 7



/obj/item/gun/energy/recharge/kinetic_accelerator
	slot_offsets = list(
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 24,
			"y" = 13,
		)
	)
