/datum/uplink_item/stealthy_weapons/cqc_traitor
	name = "CQC Manual"
	desc = "A manual that teaches a single user tactical Close-Quarters Combat before self-destructing."
	item = /obj/item/book/granter/martial/cqc
	cost = 18
	surplus = 17
	progression_minimum = 30 MINUTES
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS)
	cant_discount = TRUE
