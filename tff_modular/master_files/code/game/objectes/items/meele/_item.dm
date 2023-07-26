/obj/item/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(!ismob(target))
		return
	if(!HAS_TRAIT(user, TRAIT_WEAK_BODY))
		return
	if(!isliving(user))
		return
	var/mob/living/l = user
	var/obj/item/inactive = l.get_inactive_held_item()
	// Крайне простая проверка на то, что оружие - двуручное и не энерегтическое. Энергетическое оружие легкое и не слишком перегружает носителя.
	if(istype(inactive, /obj/item/offhand) && !istype(src, /obj/item/melee/energy))
		l.visible_message(span_danger("[l.name] fall aftet attack [target], [src.name] to heavy for [l.p_their()]"), span_danger("You attack [target], but [src.name] to heavy for you."))
		l.Knockdown(3 SECONDS)
