// #define HEMATOGEN_BAR_MAX_STACK 8
/obj/item/food/hematogen_bar
	name = "hematogen bar"
	desc = "A small chocolate bar... Is it one, actually?"
	icon = 'icons/obj/food/food_ingredients.dmi'
	icon_state = "dough"
	inhand_icon_state = null
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 4, /datum/reagent/medicine/hematogen_product = 5, /datum/reagent/consumable/sugar = 4)
	tastes = list("blood" = 1, "sugar" = 2)
	foodtypes = DAIRY | SUGAR | MEAT
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_CHEAP
	///Used as a base name while generating the icon states when stacked
	/* var/stack_name = "hematogen bars"

/*/ Stacks of HEMATOGEN BARS
/obj/item/food/hematogen/Initialize(mapload)
	. = ..()
	update_appearance()

/obj/item/food/hematogen/update_name()
	name = contents.len ? "hematogen bar" : initial(name)
	return ..()

/obj/item/food/hematogen/update_icon(updates = ALL)
	if(!(updates & UPDATE_OVERLAYS))
		return ..()

	updates &= ~UPDATE_OVERLAYS
	. = ..() // Don't update overlays. We're doing that here

	if(contents.len < LAZYLEN(overlays))
		overlays -= overlays[overlays.len]
	. |= UPDATE_OVERLAYS

/obj/item/food/hematogen/examine(mob/user)
	var/ingredients_listed = ""
	var/hematogenCount = contents.len
	switch(hematogenCount)
		if(0)
			desc = initial(desc)
		if(1 to 2)
			desc = "A little chunk of the doctors' and cook's collaboration."
		if(3 to 6)
			desc = "That's a half of bar. Just what the doctors recommend... How do you connect it?"
		if(7)
			desc = "A (nearly) full bar. Too sweet to handle!"
		if(HEMATOGEN_BAR_MAX_STACK to INFINITY)
			desc = "That's a full bar. Share a half with your friends!"
	. = ..()

/obj/item/food/hematogen/attackby(obj/item/item, mob/living/user, params)
	if(istype(item, /obj/item/food/hematogen))
		var/obj/item/food/hematogen/hematogen_bar = item
		if((contents.len >= HEMATOGEN_BAR_MAX_STACK) || ((hematogen_bar.contents.len + contents.len) > HEMATOGEN_BAR_MAX_STACK))
			to_chat(user, span_warning("The [src] already has all the chunks in!"))
		else
			if(!user.transferItemToLoc(hematogen_bar, src))
				return
			to_chat(user, span_notice("You add the hematogen bar chunk to the [src]."))
			hematogen_bar.name = initial(hematogen_bar.name)
			contents += hematogen_bar
			update_snack_overlays(hematogen_bar)
			if (hematogen_bar.contents.len)
				for(var/hematogen_bar_content in hematogen_bar.contents)
					hematogen_bar = hematogen_bar_content
					hematogen_bar.name = initial(hematogen_bar.name)
					contents += hematogen_bar
					update_snack_overlays(hematogen_bar)
			hematogen_bar = item
			hematogen_bar.contents.Cut()
		return
	else if(contents.len)
		var/obj/O = contents[contents.len]
		return O.attackby(item, user, params)
	..()

/obj/item/food/hematogen/proc/update_snack_overlays(obj/item/food/hematogen/hematogen_bar)
	var/mutable_appearance/hematogen_bar_visual = mutable_appearance(icon, "[hematogen_bar.stack_name][rand(1, 8)]")
	hematogen_bar_visual.pixel_x = rand(-1, 1)
	hematogen_bar_visual.pixel_y = 3 * contents.len - 1
	add_overlay(hematogen_bar_visual)
	update_appearance()

/obj/item/food/hematogen/attack(mob/target, mob/living/user, params, stacked = TRUE)
	if(user.combat_mode || !contents.len || !stacked)
		return ..()
	var/obj/item/item = contents[contents.len]
	. = item.attack(target, user, params, FALSE)
	update_appearance()

#undef HEMATOGEN_BAR_MAX_STACK
