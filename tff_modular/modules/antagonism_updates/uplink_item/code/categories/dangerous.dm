
/datum/uplink_item/dangerous/aps_traitor
	name = "Stechkin APS Machine Pistol"
	desc = "An ancient Soviet machine pistol, refurbished for the modern age. Uses 9mm auto rounds in 15-round magazines and is compatible \
			with suppressors. The gun fires in three round bursts."
	item = /obj/item/gun/ballistic/automatic/pistol/aps
	cost = /datum/uplink_item/medium_cost::cost
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS)



/datum/uplink_item/dangerous/smgc20r_traitor
	name = "C-20r Submachine Gun"
	desc = "A fully-loaded Scarborough Arms bullpup submachine gun. The C-20r fires .45 rounds with a \
			24-round magazine and is compatible with suppressors."
	item = /obj/item/gun/ballistic/automatic/c20r/unrestricted
	cost = /datum/uplink_item/medium_cost/weaponry::cost
	purchasable_from = ~UPLINK_ALL_SYNDIE_OPS
	progression_minimum = 30 MINUTES

/datum/uplink_item/dangerous/shotgun_traitor
	name = "Bulldog Shotgun"
	desc = "A fully-loaded semi-automatic drum-fed shotgun. Compatible with all 12g rounds. Designed for close \
			quarter anti-personnel engagements."
	item = /obj/item/gun/ballistic/shotgun/bulldog/unrestricted
	cost = /datum/uplink_item/medium_cost/weaponry::cost
	progression_minimum = 50 MINUTES
	purchasable_from = ~UPLINK_ALL_SYNDIE_OPS


/datum/uplink_item/role_restricted/mail_counterfeit_kit
	name = "GLA Brand Mail Counterfeit Kit"
	desc = "A box containing five devices capable of counterfeiting NT's mail. Can be used to store items within as an easy means of smuggling contraband. \
			Additionally, you may choose to \"arm\" the item inside, causing the item to be used the moment the mail is opened as if the person had just used it in hand. \
			The most common usage of this feature is with grenades, as it forces the grenade to prime. Bonus points if the grenade is set to instantly detonate. \
			Comes with an integrated micro-computer for configuration purposes."
	item = /obj/item/storage/box/syndie_kit/mail_counterfeit
	cost = /datum/uplink_item/low_cost::cost
	uplink_item_flags = SYNDIE_TRIPS_CONTRABAND
	restricted_roles = list(JOB_CARGO_TECHNICIAN, JOB_QUARTERMASTER)
	surplus = 5

/datum/uplink_item/device_tools/borer_egg
	name = "Borer Egg"
	desc = "Creates a borer egg that can give you various powers!"
	item = /obj/effect/mob_spawn/ghost_role/borer_egg/traitor
	cost = /datum/uplink_item/high_cost::cost
