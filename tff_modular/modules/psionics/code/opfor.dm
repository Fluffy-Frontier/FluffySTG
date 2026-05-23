/datum/opposing_force_equipment/uplink/psionic
	item_type = /obj/effect/gibspawner/generic
	name = "Psionic Tier 1"
	description = "A set of useful psionic abilities."
	admin_note = "Gives the owner the psionics of the 1 tier. The 1 tier psionic is available to all veterans."
	var/datum/psionic/psionic_type = /datum/psionic/sensitive

/datum/opposing_force_equipment/uplink/psionic/on_issue(mob/living/target)
	. = ..()
	target.add_psionic(psionic_type)

/datum/opposing_force_equipment/uplink/psionic/tier_2
	name = "Psionic Tier 2"
	description = "A set of useful and dangerous psionic abilities."
	admin_note = "Gives the owner the psionics of the 2 tier. The 2 tier psionic is dangerous and available only to antagonists."

/datum/uplink_item/bundles_tc/psionic
	name = "Psionic Awaken"
	desc = "Upon purchase, it grants you 2 tier psionic."
	item = ABSTRACT_UPLINK_ITEM
	surplus = 0
	progression_minimum = 15 MINUTES
	limited_stock = 1
	cost = 35
	restricted = FALSE
	purchasable_from = UPLINK_TRAITORS

/datum/uplink_item/bundles_tc/psionic/spawn_item(spawn_path, mob/user, datum/uplink_handler/uplink_handler, atom/movable/source)
	var/mob/living/buyer = user
	buyer.add_psionic(/datum/psionic/harmonious)
	return source
