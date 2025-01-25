//// реверт удалений из \code\modules\uplink\uplink_items\device_tools.dm

 // NOVA EDIT REMOVAL START // FF edit begin - reverted it back
/datum/uplink_item/device_tools/briefcase_launchpad
	name = "Briefcase Launchpad"
	desc = "A briefcase containing a launchpad, a device able to teleport items and people to and from targets up to eight tiles away from the briefcase. \
			Also includes a remote control, disguised as an ordinary folder. Touch the briefcase with the remote to link it."
	surplus = 0
	item = /obj/item/storage/briefcase/launchpad
	cost = 6

/datum/uplink_item/device_tools/syndicate_teleporter
	name = "Experimental Syndicate Teleporter"
	desc = "A handheld device that teleports the user 4-8 meters forward. \
			Beware, teleporting into a wall will trigger a parallel emergency teleport; \
			however if that fails, you may need to be stitched back together. \
			Comes with 4 charges, recharges randomly. Warranty null and void if exposed to an electromagnetic pulse."
	item = /obj/item/storage/box/syndie_kit/syndicate_teleporter
	limited_stock = 1
	cost = 8
// // NOVA EDIT REMOVAL END // FF edit End - reverted it back
/datum/uplink_item/device_tools/suspiciousphone
	name = "Protocol CRAB-17 Phone"
	desc = "The Protocol CRAB-17 Phone, a phone borrowed from an unknown third party, it can be used to crash the space market, funneling the losses of the crew to your bank account.\
	The crew can move their funds to a new banking site though, unless they HODL, in which case they deserve it."
	item = /obj/item/suspiciousphone
	restricted = TRUE
	cost = 7
	limited_stock = 1
// // NOVA EDIT REMOVAL END // FF edit End - reverted it back
