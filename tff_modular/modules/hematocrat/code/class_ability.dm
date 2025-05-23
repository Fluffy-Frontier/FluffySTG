// Способность для выбора классов

/datum/action/cooldown/choose_class
	name = "choose class"
	desc = "A skill that allows you to choose your class. After selecting a class, it cannot be changed."
	button_icon = 'tff_modular/modules/hematocrat/icons/hematocraticons.dmi'
	button_icon_state = "class"
	background_icon = 'icons/mob/actions/backgrounds.dmi'
	background_icon_state = "bg_fugu"
	overlay_icon = 'icons/mob/actions/backgrounds.dmi'
	overlay_icon_state = "bg_fugu_border"
	cooldown_time = 10 MINUTES

/datum/action/cooldown/choose_class/Activate(atom/target)
	if(HAS_TRAIT(owner, TRAIT_HEMATOCRAT))
		to_chat(owner, span_notice("Why do you need even more power? Greed is punishable."))
		return FALSE

	var/static/list/classes
	if(!classes)
		classes = list()

		classes_list(
			class_name = "Warrior",
			class_image = image(icon = 'tff_modular/modules/hematocrat/icons/hematocraticons.dmi', icon_state = "warrior"),
			class_info = span_info("Warrior is a strong class aimed at combat. This class is considered the strongest because of its ability to turn any station items into powerful weapons. The class ignores slowdowns. \
				Warrior also can attack nearby enemies and cutting off their limbs. His adrenaline gives him stun protection and accelerates its movement."),
			classes = classes,
		)

		classes_list(
			class_name = "Assassin",
			class_image  = image(icon = 'tff_modular/modules/hematocrat/icons/hematocraticons.dmi', icon_state = "assassin"),
			class_info = span_info("The assassin is bad at fighting due to his lack of combat skills, but he is an excellent burglar and thief. \
				He is able to steal items from an enemy's backpack from a distance, hack machinery and airlocks, create a cloud of smoke, \
				become partially invisible, has HUDs, night vision, and X-ray."),
			classes = classes,
		)

		classes_list(
			class_name = "Blood Brother",
			class_image  = image(icon = 'tff_modular/modules/hematocrat/icons/hematocraticons.dmi', icon_state = "healer"),
			class_info = span_info("Blood Brother is a weak class in combat, but strong in support. He is able to heal the wounds of his \
				hematocrat-brothers within a radius of 7 tiles, teleport, heal targets with hand."),
			classes = classes,
		)

	var/brother_class = show_radial_menu(owner, owner, classes, radius = 38, require_near = TRUE, tooltips = TRUE)
	if(QDELETED(src) || QDELETED(owner) || !IsAvailable(feedback = TRUE) || isnull(brother_class))
		return

	give_new_class(brother_class)

	return TRUE

/datum/action/cooldown/choose_class/proc/classes_list(class_name, class_image, class_info, list/classes)
	var/datum/radial_menu_choice/class_option = new()

	class_option.name = class_name
	class_option.image = class_image
	class_option.info = class_info

	classes[class_name] = class_option

/datum/action/cooldown/choose_class/proc/give_new_class(brother_class)
	var/mob/living/carbon/living_owner = owner
	switch(brother_class)
		if("Warrior")
			ADD_TRAIT(owner, TRAIT_HEMATOCRAT, ACTION_TRAIT)
			var/static/list/warrior_actions = list(
				/datum/action/cooldown/spell/sanguine_strike/weaponcharge,
				/datum/action/cooldown/hematocrat_adrenaline,
				/datum/action/cooldown/slash,
			)
			living_owner.grant_actions_by_list(warrior_actions)
			ADD_TRAIT(owner, TRAIT_IGNORESLOWDOWN, ACTION_TRAIT)

		if("Assassin")
			ADD_TRAIT(owner, TRAIT_HEMATOCRAT, ACTION_TRAIT)
			var/static/list/assassin_actions = list(
				/datum/action/cooldown/bbstealth,
				/datum/action/cooldown/spell/smoke/bbsmoke,
				/datum/action/cooldown/spell/pointed/burglar_finesse/bbsteal,
				/datum/action/cooldown/spell/pointed/bbhack,
				/datum/action/cooldown/bbvision,
				/datum/action/cooldown/mob_cooldown/dash/bbdash,
			)
			living_owner.grant_actions_by_list(assassin_actions)

		if("Blood Brother")
			ADD_TRAIT(owner, TRAIT_HEMATOCRAT, ACTION_TRAIT)
			var/static/list/healer_actions = list(
				/datum/action/cooldown/hematocrat_aura,
				/datum/action/cooldown/spell/jaunt/ethereal_jaunt/red_jaunt,
				/datum/action/cooldown/spell/touch/flesh_restoration,
			)
			living_owner.grant_actions_by_list(healer_actions)

		else
			CRASH("Class choose was made invalid / incorrect class choosen type. Got: [brother_class]")

	qdel(src)
