/obj/item/gun/ballistic/automatic/pistol/pepperball
	valid_attachments = list(
		/obj/item/attachment/laser_sight,
		/obj/item/attachment/rail_light,
		/obj/item/attachment/ammo_counter,
	)

/obj/item/gun/ballistic/automatic/pistol/type207
	aimed_wield_slowdown = LIGHTEST_AIM_SLOWDOWN
	wield_slowdown = LIGHT_PISTOL_SLOWDOWN
	valid_attachments = list(
		/obj/item/attachment/laser_sight,
		/obj/item/attachment/rail_light,
		/obj/item/attachment/ammo_counter,
	)

/obj/item/gun/ballistic/automatic/type213
	aimed_wield_slowdown = LIGHTEST_AIM_SLOWDOWN
	wield_slowdown = HEAVY_PISTOL_SLOWDOWN
	valid_attachments = list(
		/obj/item/attachment/laser_sight,
		/obj/item/attachment/rail_light,
		/obj/item/attachment/ammo_counter,
	)

//Макаров
/obj/item/gun/ballistic/automatic/pistol
	aimed_wield_slowdown = LIGHTEST_AIM_SLOWDOWN
	wield_slowdown = LIGHT_PISTOL_SLOWDOWN

//Guepe
/obj/item/gun/ballistic/automatic/pistol/sol
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 20,
			"y" = 17,
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

/obj/item/gun/ballistic/automatic/pistol/m1911
	aimed_wield_slowdown = LIGHT_AIM_SLOWDOWN
	valid_attachments = list(
		/obj/item/attachment/laser_sight,
		/obj/item/attachment/rail_light,
		/obj/item/attachment/bayonet,
		/obj/item/attachment/energy_bayonet,
		/obj/item/attachment/ammo_counter,
	)
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 23,
			"y" = 18,
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

/obj/item/gun/ballistic/revolver/takbok
	aimed_wield_slowdown = LIGHTEST_AIM_SLOWDOWN
	wield_slowdown = HEAVY_PISTOL_SLOWDOWN
	spread_unwielded = 8

/obj/item/gun/ballistic/automatic/pistol/trappiste
	aimed_wield_slowdown = LIGHTEST_AIM_SLOWDOWN
	wield_slowdown = HEAVY_PISTOL_SLOWDOWN
	spread_unwielded = 8

/obj/item/gun/ballistic/automatic/pistol/zashch
	aimed_wield_slowdown = LIGHTEST_AIM_SLOWDOWN
	wield_slowdown = HEAVY_PISTOL_SLOWDOWN
	spread_unwielded = 8
	recoil_unwielded = 0.5
	valid_attachments = list(
		/obj/item/attachment/laser_sight,
		/obj/item/attachment/rail_light,
		/obj/item/attachment/bayonet,
		/obj/item/attachment/energy_bayonet,
		/obj/item/attachment/ammo_counter,
	)
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 23,
			"y" = 19,
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

/obj/item/gun/ballistic/revolver
	aimed_wield_slowdown = LIGHTEST_AIM_SLOWDOWN
	wield_slowdown = PISTOL_SLOWDOWN

/obj/item/gun/energy/laser/thermal/inferno
	aimed_wield_slowdown = LIGHTEST_AIM_SLOWDOWN
	wield_slowdown = LIGHT_PISTOL_SLOWDOWN
	spread_unwielded = 8
	dual_wield_spread = 1
	valid_attachments = list(
		/obj/item/attachment/ammo_counter,
	)

/obj/item/gun/energy/laser/thermal/cryo
	aimed_wield_slowdown = LIGHTEST_AIM_SLOWDOWN
	wield_slowdown = LIGHT_PISTOL_SLOWDOWN
	spread_unwielded = 8
	dual_wield_spread = 1
	valid_attachments = list(
		/obj/item/attachment/ammo_counter,
	)

/obj/item/gun/ballistic/automatic/c20r
	aimed_wield_slowdown = AIM_SLOWDOWN
	wield_slowdown = LIGHT_RIFLE_SLOWDOWN
	spread_unwielded = 9
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 27,
			"y" = 14,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 18,
			"y" = 17,
		),
		ATTACHMENT_SLOT_SCOPE = list(
			"x" = 16,
			"y" = 21,
		)
	)

/obj/item/gun/ballistic/automatic/l6_saw
	aimed_wield_slowdown = HEAVY_AIM_SLOWDOWN
	wield_slowdown = HMG_SLOWDOWN
	recoil_unwielded = 0.65
	recoil = 2
	valid_attachments = list(
		/obj/item/attachment/laser_sight,
		/obj/item/attachment/rail_light,
		/obj/item/attachment/bayonet,
		/obj/item/attachment/energy_bayonet,
		/obj/item/attachment/ammo_counter,
		/obj/item/attachment/sling,
	)
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 27,
			"y" = 15,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 16,
			"y" = 17,
		),
		ATTACHMENT_SLOT_SCOPE = list(
			"x" = 14,
			"y" = 22,
		)
	)

/obj/item/gun/ballistic/automatic/lanca
	aimed_wield_slowdown = MEDIUM_AIM_SLOWDOWN
	wield_slowdown = RIFLE_SLOWDOWN
	gun_firemodes = list(FIREMODE_SEMIAUTO)
	recoil_unwielded = 0.5
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 31,
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

/obj/item/gun/ballistic/automatic/miecz
	aimed_wield_slowdown = AIM_SLOWDOWN
	wield_slowdown = LIGHT_RIFLE_SLOWDOWN
	recoil_unwielded = 0.3
	valid_attachments = list(
		/obj/item/attachment/laser_sight,
		/obj/item/attachment/rail_light,
		/obj/item/attachment/bayonet,
		/obj/item/attachment/energy_bayonet,
		/obj/item/attachment/ammo_counter,
		/obj/item/attachment/scope,
		/obj/item/attachment/long_scope,
		/obj/item/attachment/sling,
	)
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 31,
			"y" = 14,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 20,
			"y" = 17,
		),
		ATTACHMENT_SLOT_SCOPE = list(
			"x" = 18,
			"y" = 20,
		)
	)

/obj/item/gun/ballistic/automatic/napad
	aimed_wield_slowdown = LIGHT_AIM_SLOWDOWN
	wield_slowdown = LIGHT_RIFLE_SLOWDOWN
	recoil_unwielded = 0.5
	valid_attachments = list(
		/obj/item/attachment/laser_sight,
		/obj/item/attachment/rail_light,
		/obj/item/attachment/bayonet,
		/obj/item/attachment/energy_bayonet,
		/obj/item/attachment/ammo_counter,
		/obj/item/attachment/scope,
		/obj/item/attachment/long_scope,
		/obj/item/attachment/sling,
	)
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 31,
			"y" = 16,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 18,
			"y" = 19,
		),
		ATTACHMENT_SLOT_SCOPE = list(
			"x" = 18,
			"y" = 26,
		)
	)

/obj/item/gun/ballistic/automatic/nt20
	aimed_wield_slowdown = AIM_SLOWDOWN
	wield_slowdown = LIGHT_RIFLE_SLOWDOWN
	recoil_unwielded = 0.2
	valid_attachments = list(
		/obj/item/attachment/laser_sight,
		/obj/item/attachment/rail_light,
		/obj/item/attachment/bayonet,
		/obj/item/attachment/energy_bayonet,
		/obj/item/attachment/ammo_counter,
		/obj/item/attachment/scope,
		/obj/item/attachment/long_scope,
		/obj/item/attachment/sling,
	)
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 25,
			"y" = 16,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 18,
			"y" = 17,
		),
		ATTACHMENT_SLOT_SCOPE = list(
			"x" = 16,
			"y" = 22,
		)
	)

/obj/item/gun/ballistic/automatic/wylom
	aimed_wield_slowdown = AIM_SLOWDOWN
	wield_slowdown = DMR_SLOWDOWN
	recoil = 0.2
	spread_unwielded = 17
	gun_firemodes = list(FIREMODE_SEMIAUTO)
	valid_attachments = list(
		/obj/item/attachment/laser_sight,
		/obj/item/attachment/rail_light,
		/obj/item/attachment/ammo_counter,
		/obj/item/attachment/sling,
	)
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 31,
			"y" = 15,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 18,
			"y" = 18,
		),
		ATTACHMENT_SLOT_SCOPE = list(
			"x" = 18,
			"y" = 22,
		)
	)

//Синдано
/obj/item/gun/ballistic/automatic/sol_smg
	aimed_wield_slowdown = LIGHT_AIM_SLOWDOWN
	wield_slowdown = SMG_SLOWDOWN
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
			"x" = 26,
			"y" = 14,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 18,
			"y" = 17,
		),
		ATTACHMENT_SLOT_SCOPE = list(
			"x" = 16,
			"y" = 21,
		)
	)

/obj/item/gun/ballistic/automatic/wt550
	aimed_wield_slowdown = AIM_SLOWDOWN
	wield_slowdown = LIGHT_RIFLE_SLOWDOWN
	recoil_unwielded = 0.2
	valid_attachments = list(
		/obj/item/attachment/laser_sight,
		/obj/item/attachment/rail_light,
		/obj/item/attachment/bayonet,
		/obj/item/attachment/energy_bayonet,
		/obj/item/attachment/ammo_counter,
		/obj/item/attachment/scope,
		/obj/item/attachment/long_scope,
		/obj/item/attachment/sling,
	)
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 29,
			"y" = 16,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 18,
			"y" = 17,
		),
		ATTACHMENT_SLOT_SCOPE = list(
			"x" = 13,
			"y" = 23,
		)
	)

/obj/item/gun/ballistic/automatic/xhihao_smg
	aimed_wield_slowdown = LIGHTEST_AIM_SLOWDOWN
	wield_slowdown = LIGHT_RIFLE_SLOWDOWN
	recoil = 0.7
	//SEMI-BURST
	gun_firemodes = list(FIREMODE_SEMIAUTO)
	valid_attachments = list(
		/obj/item/attachment/laser_sight,
		/obj/item/attachment/rail_light,
		/obj/item/attachment/bayonet,
		/obj/item/attachment/energy_bayonet,
		/obj/item/attachment/ammo_counter,
		/obj/item/attachment/scope,
		/obj/item/attachment/long_scope,
		/obj/item/attachment/sling,
	)

//MMR-2543
/obj/item/gun/ballistic/automatic/sol_rifle
	aimed_wield_slowdown = LIGHT_AIM_SLOWDOWN
	wield_slowdown = LIGHT_RIFLE_SLOWDOWN
	recoil_unwielded = 0.2
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 30,
			"y" = 15,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 19,
			"y" = 17,
		),
		ATTACHMENT_SLOT_SCOPE = list(
			"x" = 24,
			"y" = 22,
		)
	)

//NT BR-38
/obj/item/gun/ballistic/automatic/battle_rifle
	aimed_wield_slowdown = LIGHTEST_AIM_SLOWDOWN
	wield_slowdown = LIGHT_RIFLE_SLOWDOWN
	recoil_unwielded = 0.1
	spread_unwielded = 8

//Риот и М64
/obj/item/gun/ballistic/shotgun/riot
	aimed_wield_slowdown = LIGHTEST_AIM_SLOWDOWN
	wield_slowdown = SHOTGUN_SLOWDOWN
	recoil_unwielded = 0.5

/obj/item/gun/ballistic/shotgun/bulldog
	aimed_wield_slowdown = LIGHTEST_AIM_SLOWDOWN
	wield_slowdown = RIFLE_SLOWDOWN
	recoil_unwielded = 0.7

/obj/item/gun/ballistic/shotgun/automatic/combat
	aimed_wield_slowdown = LIGHTEST_AIM_SLOWDOWN
	wield_slowdown = RIFLE_SLOWDOWN
	recoil_unwielded = 0.7

/obj/item/gun/ballistic/shotgun/doublebarrel
	aimed_wield_slowdown = AIM_SLOWDOWN
	wield_slowdown = SHOTGUN_SLOWDOWN
	recoil_unwielded = 0.5
	valid_attachments = list(
		/obj/item/attachment/laser_sight,
		/obj/item/attachment/rail_light,
		/obj/item/attachment/ammo_counter,
	)

//Катюша и Ягер
/obj/item/gun/ballistic/shotgun/katyusha
	aimed_wield_slowdown = LIGHT_AIM_SLOWDOWN
	wield_slowdown = SHOTGUN_SLOWDOWN
	recoil_unwielded = 0.7
