// Способность для выбора классов

/datum/action/cooldown/choose_class
	name = "choose class"
	desc = "A skill that allows you to choose your class. After selecting a class, it cannot be changed."
	button_icon = 'icons/mob/actions/actions_spells.dmi'
	button_icon_state = "transformslime"
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
		class_image = image(icon = 'icons/mob/actions/actions_items.dmi', icon_state = "bci_shield"),
		class_info = span_info("Warrior is a strong class aimed at combat. This class is considered the strongest because of its ability to turn any station items into powerful weapons. The class ignores slowdowns. \
							It can launch bloody projectiles at a victim, paralyzing them. He can also produce a special version of adrenaline, which accelerates and protects against stun."),
		classes = classes,
		)

		classes_list(
		class_name = "Assassin",
		class_image  = image(icon = 'icons/mob/actions/actions_items.dmi', icon_state = "bci_wireless"),
		class_info = span_info("The assassin is bad at fighting due to his lack of combat skills, but he is an excellent burglar and thief. \
								He is able to steal items from an enemy's backpack from a distance, hack machinery and airlocks, create a cloud of smoke, \
								become partially invisible, has HUDs, night vision, and X-ray."),
		classes = classes,
		)

		classes_list(
		class_name = "Blood Brother",
		class_image  = image(icon = 'icons/mob/actions/actions_items.dmi', icon_state = "bci_heart"),
		class_info = span_info("Blood Brother is a weak class in combat, but strong in support. He is able to heal the wounds of his \
								hematocrats within a radius of 7 tiles, teleport and heal targets with hand."),
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
	switch(brother_class)
		if("Warrior")
			ADD_TRAIT(owner, TRAIT_HEMATOCRAT, ACTION_TRAIT)
			var/datum/action/cooldown/spell/sanguine_strike/bbweaponcharge/strike = new
			var/datum/action/cooldown/spell/stimpack/bbescape/escape = new
			var/datum/action/cooldown/spell/aoe/magic_missile/bbmissle/missle = new
			missle.Grant(owner)
			escape.Grant(owner)
			strike.Grant(owner)
			ADD_TRAIT(owner, TRAIT_IGNORESLOWDOWN, ACTION_TRAIT)

		if("Assassin")
			ADD_TRAIT(owner, TRAIT_HEMATOCRAT, ACTION_TRAIT)
			var/datum/action/cooldown/bbstealth/stealth = new
			var/datum/action/cooldown/spell/smoke/lesser/bbsmoke/smoke = new
			var/datum/action/cooldown/spell/pointed/burglar_finesse/bbsteal/steal = new
			var/datum/action/cooldown/spell/pointed/bbhack/hack = new
			var/datum/action/cooldown/bbvision/vision = new
			var/datum/action/cooldown/mob_cooldown/dash/bbdash/dash = new
			dash.Grant(owner)
			vision.Grant(owner)
			stealth.Grant(owner)
			smoke.Grant(owner)
			hack.Grant(owner)
			steal.Grant(owner)

		if("Blood Brother")
			ADD_TRAIT(owner, TRAIT_HEMATOCRAT, ACTION_TRAIT)
			var/datum/action/cooldown/bbaura/aura = new
			var/datum/action/cooldown/spell/jaunt/ethereal_jaunt/bbjaunt/jaunt = new
			var/datum/action/cooldown/spell/touch/flesh_restoration/restor = new
			restor.Grant(owner)
			aura.Grant(owner)
			jaunt.Grant(owner)

		else
			CRASH("Class choose was made invalid / incorrect class choosen type. Got: [brother_class]")
