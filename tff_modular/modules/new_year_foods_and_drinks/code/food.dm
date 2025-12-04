#define food_ng_ICON 'tff_modular/modules/new_year_foods_and_drinks/icons/food_ng.dmi'

/obj/item/food/salad/olivier
	name = "Olivier salad"
	desc = "A heaping bowl of diced potatoes, eggs, sausage, pickles, and far too much mayonnaise."
	icon = food_ng_ICON
	icon_state = "olivie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 12,
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/mayonnaise = 5,
	)
	tastes = list(
		"new year" = 2,
		"approaching pancreatitis" = 1,
		"creamy sausage" = 1,
	)
	foodtypes = VEGETABLES | MEAT | DAIRY
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/salad/vinegret
	name = "vinegret salad"
	desc = "Red beet-root tossed with peas, carrots, pickles, and olive oil."
	icon = food_ng_ICON
	icon_state = "vinegret"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 11,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/vinegar = 3,
	)
	tastes = list(
		"earthy beet" = 1,
		"pickled vegetables" = 1,
		"olive oil" = 1,
	)
	foodtypes = VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/salad/kraboviy
	name = "kraboviy salad"
	desc = "A crab-free crab salad; fish, eggs, corn, and mayo do the heavy lifting."
	icon = food_ng_ICON
	icon_state = "kraboviy"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/mayonnaise = 5,
	)
	tastes = list(
		"crab meat" = 2,
		"eggs" = 1,
		"corn" = 1,
	)
	foodtypes = MEAT | SEAFOOD | VEGETABLES | DAIRY
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/cake/shuba
	name = "shuba"
	desc = "Layered herring under a coat of vegetables and mayonnaise."
	icon = food_ng_ICON
	icon_state = "shuba"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 14,
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/mayonnaise = 6,
	)
	tastes = list(
		"new year rush" = 1,
		"mayonnaise" = 1,
		"fish" = 1,
	)
	foodtypes = VEGETABLES | MEAT | SEAFOOD | DAIRY
	slice_type = /obj/item/food/cakeslice/shuba
	yield = 6
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/cakeslice/shuba
	name = "shuba slice"
	desc = "A wedge of 'herring under a fur coat', ready to go."
	icon = food_ng_ICON
	icon_state = "shuba_slice"
	tastes = list(
		"new year rush" = 1,
		"mayonnaise" = 1,
		"fish" = 1,
	)
	foodtypes = VEGETABLES | MEAT | SEAFOOD | DAIRY
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cake/kholodetz
	name = "kholodetz"
	desc = "Suspicious, shimmering meat jelly. A traditional dare."
	icon = food_ng_ICON
	icon_state = "kholodetz"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/protein = 8,
	)
	tastes = list(
		"suspicious meat jelly" = 1,
		"inexplicable texture" = 1,
	)
	foodtypes = MEAT | GORE
	slice_type = /obj/item/food/cakeslice/kholodetz
	yield = 4
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cakeslice/kholodetz
	name = "kholodetz slice"
	desc = "A jiggling slice that challenges your courage."
	icon = food_ng_ICON
	icon_state = "kholodetz_slice"
	tastes = list(
		"suspicious meat jelly" = 1,
		"inexplicable texture" = 1,
	)
	foodtypes = MEAT | GORE
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/christmas_ham
	name = "Christmas ham"
	desc = "A spiral-cut ham lacquered with berries and barbecue glaze."
	icon = food_ng_ICON
	icon_state = "ham"
	w_class = WEIGHT_CLASS_NORMAL
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 16,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/bbqsauce = 5,
		/datum/reagent/consumable/blackpepper = 1,
	)
	tastes = list(
		"holiday sausage" = 2,
		"glazed berries" = 1,
		"bbq smoke" = 1,
	)
	foodtypes = MEAT | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT * 2)
	var/obj/item/food/christmas_ham/slice/slice_type = /obj/item/food/christmas_ham/slice
	var/slice_yield = 6

/obj/item/food/christmas_ham/make_processable()
    if (slice_type)
        AddElement(/datum/element/processable, TOOL_KNIFE, slice_type, slice_yield, 3 SECONDS, table_required = TRUE, screentip_verb = "Carve", sound_to_play = SFX_KNIFE_SLICE)

/obj/item/food/christmas_ham/slice
	name = "slice of Christmas ham"
	desc = "A succulent slice dotted with cranberries."
	icon = food_ng_ICON
	icon_state = "ham_slice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/bbqsauce = 1,
	)
	tastes = list(
		"holiday sausage" = 2,
		"glazed berries" = 1,
	)
	foodtypes = MEAT | SUGAR
	food_flags = FOOD_FINGER_FOOD
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/christmas_ham/raw
	name = "raw Christmas ham"
	desc = "Uncooked ham stuffed with berries and seasoning, ready for the oven."
	icon = food_ng_ICON
	icon_state = "ham"
	foodtypes = MEAT | RAW
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/bbqsauce = 5,
		/datum/reagent/consumable/blackpepper = 1,
	)
	tastes = list("raw ham" = 1, "berries" = 1)
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/christmas_ham/raw/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/christmas_ham, rand(70 SECONDS, 80 SECONDS), TRUE, TRUE)

/obj/item/food/sweets/candy_cane
	name = "candy cane"
	desc = "Striped sugar twisted with peppermint."
	icon = food_ng_ICON
	icon_state = "candycane"
	food_reagents = list(
		/datum/reagent/consumable/sugar = 10,
		/datum/reagent/consumable/menthol = 2,
	)
	tastes = list(
		"sugar" = 2,
		"mint" = 1,
	)
	foodtypes = SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/red_caviar
	name = "red caviar"
	desc = "Bioluminescent fish roe with a conceited aroma."
	icon = food_ng_ICON
	icon_state = "caviar_isolated"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/salt = 1,
	)
	tastes = list(
		"salty caviar" = 2,
		"alien arrogance" = 1,
	)
	foodtypes = SEAFOOD
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/canned_red_caviar
	name = "canned red caviar"
	desc = "A green tin marked with Skrell text. It rattles with promise."
	icon = food_ng_ICON
	icon_state = "skrellcaviar"
	w_class = WEIGHT_CLASS_SMALL
	preserved_food = TRUE
	var/servings_left = 6
	var/opened = FALSE

/obj/item/food/canned_red_caviar/attack_self(mob/living/user, list/modifiers)
	. = ..()
	dispense_serving(user)
	return ITEM_INTERACT_SUCCESS

/obj/item/food/canned_red_caviar/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(user.get_active_held_item() == src)
		return .
	if(servings_left <= 0)
		return .
	user.visible_message(span_notice("[user] scoops a spoonful of caviar from [src]."))
	dispense_serving(user)

/obj/item/food/canned_red_caviar/proc/dispense_serving(mob/living/user)
	if(servings_left <= 0)
		to_chat(user, span_warning("[src] is empty."))
		return
	var/turf/target = get_turf(user) || get_turf(src)
	var/obj/item/food/red_caviar/portion = new(target)
	if(user)
		user.put_in_hands(portion)
	servings_left--
	opened = TRUE
	update_canned_red_caviar_icon_state() // renamed
	if(servings_left <= 0)
		to_chat(user, span_notice("[src] is picked clean."))

/obj/item/food/canned_red_caviar/proc/update_canned_red_caviar_icon_state()
	if(servings_left <= 0)
		icon_state = "skrellcaviar_empty"
	else if(opened)
		icon_state = "skrellcaviar_open"
	else
		icon_state = "skrellcaviar"

/obj/item/food/sandwich/caviar_butterbrod
	name = "caviar butterbrod"
	desc = "A toasted slice layered with butter and shimmering red caviar."
	icon = food_ng_ICON
	icon_state = "butterbrod"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/cream = 1,
		/datum/reagent/consumable/salt = 1,
	)
	tastes = list(
		"crispy bread" = 1,
		"creamy butter" = 1,
		"salty caviar" = 2,
	)
	foodtypes = GRAIN | DAIRY | SEAFOOD
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/grown/citrus/mandarin
    seed = /obj/item/seeds/tff_mandarin
    name = "mandarin"
    desc = "A small, vividly orange citrus that smells like winter holidays."
    icon = food_ng_ICON
    icon_state = "mandarin"
    foodtypes = FRUIT | ORANGES
    juice_typepath = /datum/reagent/consumable/mandarin_juice
    wine_power = 55
    tastes = list(
        "sweet mandarin juice" = 8,
        "clove oil" = 2,
    )

#undef food_ng_ICON

