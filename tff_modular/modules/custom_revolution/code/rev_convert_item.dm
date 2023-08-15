/obj/item/custom_rev_brochure
	// Важное уточнение! Название, спрайтик и прочее указаны в /datum/team/custom_rev_team
	// Во время привязки брошюрки к антагу (link_to_headrev) - происходит изменение переменных.
	name = "brochure"
	icon = 'tff_modular/modules/custom_revolution/icons/items.dmi'
	icon_state = "brochure"
	w_class = WEIGHT_CLASS_TINY
	var/datum/weakref/creator_antag_ref = new()
	var/datum/weakref/team_ref = new()

/obj/item/custom_rev_brochure/proc/link_to_headrev(datum/antagonist/custom_rev/head/antag)
	creator_antag_ref = WEAKREF(antag)
	team_ref = WEAKREF(antag.rev_team)
	antag.convert_brochures_list += src
	// Кастомизация
	name = antag.rev_team.brochure_name
	desc = antag.rev_team.brochure_desc
	icon_state = antag.rev_team.brochure_icon_state
	icon = antag.rev_team.brochure_icon

/obj/item/custom_rev_brochure/proc/fancy_destroy()
	do_sparks(6, FALSE, src)
	visible_message(span_danger("[src] suddenly disappears in sparks!"))
	qdel(src)

/obj/item/custom_rev_brochure/Destroy(force)
	. = ..()
	var/datum/antagonist/custom_rev/head/creator_antag = creator_antag_ref.resolve()
	if(isnull(creator_antag))
		return .
	creator_antag.convert_brochures_list -= src
	
/obj/item/custom_rev_brochure/attack_self(mob/user, modifiers)
	var/datum/team/custom_rev_team/rev_team_rs = team_ref.resolve()
	if(isnull(rev_team_rs))
		return FALSE
	if(isnull(user.mind))
		return FALSE
	if(user.mind.has_antag_datum(/datum/antagonist/custom_rev, TRUE))
		return FALSE
	if(!ishuman(user))
		return FALSE

	if(!rev_team_rs.ignore_mindshield && HAS_TRAIT(user, TRAIT_MINDSHIELD))
		to_chat(user, span_alert("You can't really figure out what written in this brochure and you feel odd for some reason."))
		return FALSE
		
	var/confirm = tgui_alert(user, rev_team_rs.brochure_message, "Are you in?", list("Accept", "Decline"))
	if(loc != user)
		return FALSE
	if(confirm == "Accept")
		if(is_banned_from(user.ckey, list(BAN_ANTAGONIST, ROLE_REV)))
			to_chat(user, span_alert("Some power from above is preventing you from joining..."))
			return FALSE
		var/datum/antagonist/custom_rev/rev = new /datum/antagonist/custom_rev
		rev.rev_team = rev_team_rs
		user.mind.add_antag_datum(rev)
		fancy_destroy()
		return TRUE
	to_chat(user, span_alert("You refused the offer."))
	. = FALSE
