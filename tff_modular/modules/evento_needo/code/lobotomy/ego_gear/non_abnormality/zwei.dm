/obj/item/clothing/suit/armor/ego_gear/city/zweijunior
	name = "Zwei Association casual jacket"
	desc = "Armor worn by initiate zwei association fixers when not on duty."
	icon_state = "zweicasual"
	new_armor = list(BURN = 30, BRAIN = 0, BRUTE = 0, TOX = 0)


/obj/item/clothing/suit/armor/ego_gear/city/zwei
	name = "Zwei Association armor"
	desc = "Armor worn by zwei association fixers."
	icon_state = "zwei"
	new_armor = list(BURN = 40, BRAIN = 20, BRUTE = 20, TOX = 0)


/obj/item/clothing/suit/armor/ego_gear/city/zweiriot
	name = "Zwei Association riot armor"
	desc = "Armor worn by zwei association fixers when they are suppressing riots or unrest. It slows you down slightly, but offers excellent defenses"
	icon_state = "zweiriot"
	slowdown = 0.7
	new_armor = list(BURN = 70, BRAIN = 40, BRUTE = 40, TOX = 20)


/obj/item/clothing/suit/armor/ego_gear/city/zweivet
	name = "Zwei Association veteran armor"
	desc = "Armor worn by zwei association veteran fixers."
	icon_state = "zweivet"
	new_armor = list(BURN = 50, BRAIN = 30, BRUTE = 30, TOX = 20)


/obj/item/clothing/suit/armor/ego_gear/city/zweivet/Initialize()
	. = ..()
	if(prob(50))
		icon_state = "zweishort"
		worn_icon_state = icon_state


/obj/item/clothing/suit/armor/ego_gear/city/zweileader
	name = "Zwei Association director armor"
	desc = "Armor worn by zwei association directors."
	icon_state = "zweileader"
	new_armor = list(BURN = 70, BRAIN = 40, BRUTE = 40, TOX = 20)


//for the ERT.
/obj/item/clothing/suit/armor/ego_gear/city/zwei/noreq
	equip_slowdown = 0
	attribute_requirements = list()

/obj/item/clothing/suit/armor/ego_gear/city/zweivet/noreq
	equip_slowdown = 0
	attribute_requirements = list()

/obj/item/clothing/suit/armor/ego_gear/city/zweileader/noreq
	equip_slowdown = 0
	attribute_requirements = list()


//Zwei West
/obj/item/clothing/suit/armor/ego_gear/city/zweiwest
	name = "Zwei knight armor"
	desc = "Armor worn by zwei west association fixers. It slows you down slightly, but offers excellent defenses"
	icon_state = "zweiwest"
	slowdown = 0.4
	neck = /obj/item/clothing/neck/ego_neck/zweiwest
	new_armor = list(BURN = 50, BRAIN = 30, BRUTE = 30, TOX = 10)


/obj/item/clothing/suit/armor/ego_gear/city/zweiwestvet
	name = "Zwei veteran knight armor "
	desc = "Armor worn by zwei west association fixers. It slows you down slightly, but offers excellent defenses"
	icon_state = "zweiwest_veteran"
	slowdown = 0.4
	neck = /obj/item/clothing/neck/ego_neck/zweiwest
	new_armor = list(BURN = 60, BRAIN = 40, BRUTE = 40, TOX = 30)


/obj/item/clothing/suit/armor/ego_gear/city/zweiwestleader
	name = "Zwei knight director armor"
	desc = "Armor worn by zwei association fixers when they are suppressing riots or unrest. It slows you down slightly, but offers excellent defenses"
	icon_state = "zweiwest_director"
	slowdown = 0.4
	neck = /obj/item/clothing/neck/ego_neck/zweiwest
	new_armor = list(BURN = 70, BRAIN = 50, BRUTE = 50, TOX = 40)



/obj/item/clothing/neck/ego_neck/zweiwest
	name = "zwei knight cape"
	desc = "A cape worn by Zwei west."
	icon_state = "zweiwest"
