/mob/living/basic/chokobo
	name = "Chokobo"
	desc = "CHICKEN"
	icon = 'tff_modular/modules/chokobo/icons/chokobo.dmi'
	icon_state = "base"
	icon_living = "base"
	icon_dead = "base_dead"
	greyscale_config = /datum/greyscale_config/chokobo
	speed = 0.5
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	maxHealth = 200
	health = 200
	melee_damage_lower = 10
	melee_damage_upper = 15
	combat_mode = TRUE
	mob_size = MOB_SIZE_LARGE
	worn_slot_flags = ITEM_SLOT_BACK
	held_w_class = WEIGHT_CLASS_BULKY
	unsuitable_atmos_damage = 0
	minimum_survivable_temperature = BODYTEMP_COLD_ICEBOX_SAFE
	maximum_survivable_temperature = INFINITY
	attack_sound = 'sound/items/weapons/punch1.ogg'
	faction = list(FACTION_NEUTRAL)
	speak_emote = list("cheerps")
	butcher_results = list(
		/obj/item/food/meat/slab/chicken = 4,
		/obj/item/stack/sheet/bone = 2,
	)
	ai_controller = /datum/ai_controller/basic_controller/chokobo
	var/choko_resting = FALSE
	var/icon_resting = "base_rest"
	var/list/colors = list()
	var/static/list/main_colors = list("#fbf57a", "#64add0", "#4b692f", "#96251f", "#3a3a3a", "#fdfdfd", "#fbd136", "#c1c6da", "#756343", "#88559c", "#d77bba",)
	var/static/list/secondary_colors = list("#d9a066", "#5f5f5f", "#c3c7d9", "#af9a52",)

/mob/living/basic/chokobo/Initialize(mapload)
	. = ..()
	colors += pick(main_colors)
	colors += pick(secondary_colors)
	set_greyscale(colors)
	AddElement(/datum/element/ridable, /datum/component/riding/creature/chokobo)

/obj/item/slime_extract/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!istype(interacting_with, /mob/living/basic/chokobo))
		return ..()
	var/mob/living/basic/chokobo/chokobo = interacting_with
	switch(src.type)
		if (/obj/item/slime_extract/grey)
			chokobo.colors[1] = "#5f5f5f"
			chokobo.set_greyscale(chokobo.colors)
		if (/obj/item/slime_extract/green)
			chokobo.colors[1] = "#4b692f"
			chokobo.set_greyscale(chokobo.colors)
		if (/obj/item/slime_extract/purple)
			chokobo.colors[1] = "#88559c"
			chokobo.set_greyscale(chokobo.colors)
		if (/obj/item/slime_extract/gold)
			chokobo.colors[1] = "#fbd136"
			chokobo.set_greyscale(chokobo.colors)
		if (/obj/item/slime_extract/pink)
			chokobo.colors[1] = "#d77bba"
			chokobo.set_greyscale(chokobo.colors)
		if (/obj/item/slime_extract/red)
			chokobo.colors[1] = "#96251f"
			chokobo.set_greyscale(chokobo.colors)
		if (/obj/item/slime_extract/blue)
			chokobo.colors[1] = "#64add0"
			chokobo.set_greyscale(chokobo.colors)
		else
			return ITEM_INTERACT_FAILURE
	qdel(src)
	return ITEM_INTERACT_SUCCESS
