/obj/item/custom_rev_brochure
	name = "some strange brochure"
	icon = 'icons/obj/toys/playing_cards.dmi'
	icon_state = "singlecard_down_syndicate"
	var/datum/weakref/creator_antag_ref
	var/datum/weakref/team_ref

/obj/item/custom_rev_brochure/Destroy(force)
	. = ..()
	var/datum/antagonist/custom_rev/head/creator_antag = creator_antag_ref.resolve()
	if(isnull(creator_antag))
		return .
	creator_antag.convert_items_list -= src
