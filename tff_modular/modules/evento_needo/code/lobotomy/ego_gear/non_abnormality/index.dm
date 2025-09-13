/obj/item/clothing/suit/armor/ego_gear/city/index
	flags_inv = HIDEJUMPSUIT | HIDEGLOVES
	name = "index proselyte armor"
	desc = "Armor worn by index proselytes."
	icon_state = "index_proselyte"
	new_armor = list(BURN = 20, BRAIN = 20, BRUTE = 20, TOX = 30)


/obj/item/clothing/suit/armor/ego_gear/adjustable/index_proxy //Choose your Drip babey
	name = "index proxy armor"
	desc = "Armor worn by index proxies."
	icon_state = "index_proxy_open"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/ego_gear/lc13_armor.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/Teguicons/ego_gear/lc13_armor.dmi'
	new_armor = list(BURN = 30, BRAIN = 30, BRUTE = 30, TOX = 40)

	alternative_styles = list("index_proxy_open", "index_proxy_closed")

/obj/item/clothing/suit/armor/ego_gear/adjustable/index_proxy/examine(mob/user)
	. = ..()
	if(user.mind)
		if(user.mind.assigned_role in list("Disciplinary Officer", "Combat Research Agent")) //These guys get a bonus to equipping gacha.
			. += span_notice("Due to your abilities, you get a -20 reduction to stat requirements when equipping this armor.")

/obj/item/clothing/suit/armor/ego_gear/adjustable/index_proxy/CanUseEgo(mob/living/user)
	if(user.mind)
		if(user.mind.assigned_role in list("Disciplinary Officer", "Combat Research Agent")) //These guys get a bonus to equipping gacha.
			equip_bonus = 20
		else
			equip_bonus = 0
	. = ..()


/obj/item/clothing/suit/armor/ego_gear/city/index_mess
	name = "index messenger armor"
	desc = "Armor worn by index messengers."
	icon_state = "yan_cloak"
	new_armor = list(BURN = 50, BRAIN = 50, BRUTE = 50, TOX = 60)

