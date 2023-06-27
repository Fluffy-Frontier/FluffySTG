/obj/item/custom_rev_brochure
	name = "some strange brochure"
	desc = "Strange brochure made of durable material. There is something written on it, but for some reason you can't really understand anything."
	icon = 'tff_modular/modules/custom_revolution/icons/items.dmi'
	icon_state = "brochure"
	var/datum/weakref/creator_antag_ref
	var/datum/weakref/team_ref

/obj/item/custom_rev_brochure/proc/link_to_headrev(datum/antagonist/custom_rev/head/antag)
	creator_antag_ref = WEAKREF(antag)
	team_ref = WEAKREF(antag.rev_team)
	antag.convert_brochures_list += src

/obj/item/custom_rev_brochure/proc/fancy_destroy()
	do_sparks(6, FALSE, src)
	for(var/mob/M in view(1, src))
		to_chat(M, span_danger("[src] suddenly disappears in sparks!"), confidential = TRUE)
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

	if(!rev_team_rs.ignore_mindshield && HAS_TRAIT(user, TRAIT_MINDSHIELD))
		to_chat(user, span_alert("Вы никак не можете разобрать то, что написано в брошюре. Весь текст похож на бессвязный бред и вам от него малость не по себе."))
		return FALSE
		
	var/confirm = tgui_alert(user, "Брошюра призывает вас вступить куда-то...", "Вы в деле?", list("Принять", "Отказаться"))
	if(confirm == "Принять")
		if(is_banned_from(user.ckey, list(BAN_ANTAGONIST, ROLE_REV)))
			to_chat(user, span_alert("Что-то свыше мешает вашему вступлению..."))
			return FALSE
		var/datum/antagonist/custom_rev/rev = new /datum/antagonist/custom_rev
		rev.rev_team = rev_team_rs
		user.mind.add_antag_datum(rev)
		fancy_destroy()
		return TRUE
	to_chat(user, span_alert("Вы перебороли желание вступить куда-то..."))
	. = FALSE
	
		





		