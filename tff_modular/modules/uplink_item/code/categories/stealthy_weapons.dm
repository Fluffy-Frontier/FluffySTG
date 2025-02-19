/datum/uplink_item/stealthy_weapons/cqc_traitor
	name = "CQC Manual"
	desc = "A manual that teaches a single user tactical Close-Quarters Combat before self-destructing."
	item = /obj/item/book/granter/martial/cqc
	cost = 13
	surplus = 17
	progression_minimum = 30 MINUTES
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS)
	cant_discount = TRUE
/datum/uplink_item/stealthy_weapons/martialarts

/datum/uplink_item/stealthy_weapons/arm_mounted_taser
	name = "Arm mounted taser"
	desc = "A dual-mode taser designed to fire both short-range high-power electrodes and long-range disabler beams, ripped from a cyborg, fitted for human use"
	item = /obj/item/gun/energy/e_gun/advtaser/mounted
	cost = 4
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS)
