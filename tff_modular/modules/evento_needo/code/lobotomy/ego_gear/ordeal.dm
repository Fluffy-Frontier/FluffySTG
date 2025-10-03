/obj/item/clothing/suit/armor/ego_gear/adjustable/claw
	name = "claw armor"
	desc = "A simple suit and tie with several injectors attached. The fabric is near indestructable."
	icon_state = "claw"
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/clothing/ego_gear/lc13_armor.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/Teguicons/mob/ego_gear/lc13_armor.dmi'
	new_armor = list(BURN = 90, BRAIN = 100, BRUTE = 90, TOX = 90) // The arbiter's henchman
	equip_slowdown = 0 // In accordance of arbiter armor
	hat = /obj/item/clothing/head/ego_hat/claw_head
	alternative_styles = list("claw", "claw_baral")

/obj/item/clothing/head/ego_hat/claw_head
	name = "mask of the claw"
	desc = "A faceless mask with an injector stuck on top of it."
	icon_state = "claw"
	flags_cover = MASKCOVERSEYES | MASKCOVERSMOUTH | PEPPERPROOF
	flags_inv = HIDEEYES|HIDEFACE|HIDEFACIALHAIR|HIDESNOUT

// Ordeal armor for non post midnight midnights. There's not really a stat total besides 240

/obj/item/clothing/suit/armor/ego_gear/ordeal
	icon = 'tff_modular/modules/evento_needo/icons/Teguicons/clothing/ego_gear/ordeal.dmi'
	worn_icon = 'tff_modular/modules/evento_needo/icons/Teguicons/mob/ego_gear/ordeal.dmi'

/obj/item/clothing/suit/armor/ego_gear/ordeal/eternal_feast
	name = "Endless feast"
	desc = "Made out of tough scales and flesh of a powerful ordeal. Wearing it makes you feel hungry as well."
	icon_state = "eternal_feast"
	new_armor = list(BURN = 50, BRAIN = 70, BRUTE = 80, TOX = 40) // 240


/obj/item/clothing/suit/armor/ego_gear/ordeal/painful_purpose
	name = "Painful purpose"
	desc = "A heavy armor made as solace of the end of all."
	icon_state = "painful_purpose"
	new_armor = list(BURN = 80, BRAIN = 50, BRUTE = 40, TOX = 70) // 240


/obj/item/clothing/suit/armor/ego_gear/ordeal/meaningless_march
	name = "Meaningless march"
	desc = "Want to know how I got these scars?"
	icon_state = "meaningless_march"
	new_armor = list(BURN = 80, BRAIN = 70, BRUTE = 50, TOX = 40) // 230


/obj/item/clothing/suit/armor/ego_gear/ordeal/god_delusion
	name = "Delusionist's end"
	desc = "An eerie glow emanates from it."
	icon_state = "delusion_black"
	new_armor = list(BURN = 40, BRAIN = 60, BRUTE = 80, TOX = 60) // 200

//unused version of it
/obj/item/clothing/suit/armor/ego_gear/ordeal/god_delusion/true_god//200 total can shift between 4 armor modes with a 120 second cooldown. A sidegrade to season greeting with both having 4 forms and an 8 in one damage type per form but delusionist's end has much worse total armor but has the ability to freely switch with its ability.
	name = "True Delusionist's end"
	desc = "This is a placeholder."
	icon_state = "delusion_red"

	actions_types = list(
		/datum/action/cooldown/spell_action/god_delusion,
	)

	var/mob/current_holder
	var/current_damage = "red"
	var/list/damage_list = list(
		"red" = list("A runic armor with an eerie red glow."),
		"white" = list("A runic armor with an eerie white glow."),
		"black" = list("A runic armor with an eerie black glow."),
		"pale" = list("A runic armor with an eerie pale glow.")
		)

/obj/item/clothing/suit/armor/ego_gear/ordeal/god_delusion/true_god/Initialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)
	Transform()

/obj/item/clothing/suit/armor/ego_gear/ordeal/god_delusion/true_god/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(!user)
		return
	current_holder = user

/obj/item/clothing/suit/armor/ego_gear/ordeal/god_delusion/true_god/dropped(mob/user)
	. = ..()
	current_holder = null

/obj/item/clothing/suit/armor/ego_gear/ordeal/god_delusion/true_god/proc/Transform()
	icon_state = "delusion_[current_damage]"
	update_icon_state()
	if(current_holder)
		to_chat(current_holder, span_notice("[src] suddenly shifts color!"))
	desc = damage_list[current_damage][1]
	switch(current_damage)
		if("red")
			playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/ordeals/violet/midnight_red_attack.ogg', 50, FALSE, 32)
		if("white")
			playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/ordeals/violet/midnight_white_attack.ogg', 50, FALSE, 32)
		if("black")
			playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/ordeals/violet/midnight_black_attack1.ogg', 50, FALSE, 32)
		if("pale")
			playsound(get_turf(src), 'tff_modular/modules/evento_needo/sounds/Tegusounds/ordeals/violet/midnight_pale_attack.ogg', 50, FALSE, 32)

// Radial menu
/datum/action/cooldown/spell_action/god_delusion
	name = "Color Shift"
	desc = "Lets the user change the current form and damage resistances of the armor."
	button_icon_state = null
	base_icon_state = null
	cooldown_time = 120 SECONDS
	var/selection_icons = 'tff_modular/modules/evento_needo/icons/Teguicons/clothing/ego_gear/ordeal.dmi'

/datum/action/cooldown/spell_action/god_delusion/Activate(target, mob/user)
	var/list/armament_icons = list(
		"red" = image(icon = selection_icons, icon_state = "delusion_red"),
		"white"  = image(icon = selection_icons, icon_state = "delusion_white"),
		"black"  = image(icon = selection_icons, icon_state = "delusion_black"),
		"pale"  = image(icon = selection_icons, icon_state = "delusion_pale")
	)
	armament_icons = sort_list(armament_icons)
	var/choice = show_radial_menu(user, user , armament_icons, custom_check = CALLBACK(src, PROC_REF(CheckMenu), user), radius = 42, require_near = TRUE)
	if(!choice || !CheckMenu(user))
		return
	var/obj/item/clothing/suit/armor/ego_gear/ordeal/god_delusion/true_god/T = user.get_item_by_slot(ITEM_SLOT_OCLOTHING)
	if(istype(T))
		T.current_damage = choice
		T.Transform()
	return ..()

/datum/action/cooldown/spell_action/god_delusion/proc/CheckMenu(mob/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated)
		return FALSE
	return TRUE

/obj/item/clothing/suit/armor/ego_gear/ordeal/familial_strength
	name = "Familial Strength"
	desc = "A heavy armor from the mother of all sweepers."
	icon_state = "familial_strength"
	new_armor = list(BURN = 70, BRAIN = 30, BRUTE = 80, TOX = 60) // 240


/obj/item/clothing/suit/armor/ego_gear/ordeal/wonderland
	name = "Wonderland"
	desc = "It's hard to look at it right."
	icon_state = "wonderland"
	new_armor = list(BURN = 50, BRAIN = 40, BRUTE = 70, TOX = 80) // 240


