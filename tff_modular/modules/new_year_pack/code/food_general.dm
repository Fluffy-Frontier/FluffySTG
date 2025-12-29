/obj/item/food/salad/olivier
	name = "Olivier salad"
	desc = "Traditional pan-slavic cuisine usually served on important dates, often on New Year celebration. \
			True slavs serve this fantastic mix of  boiled eggs, mayonaise, meat, marinated pickles, potatoes, \
			peas and carrots - in a giant plastic bath tub called 'tazik'. But others decide to serve it in regular bowl."
	icon = TFF_FOOD_NY_ICON
	icon_state = "olivie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 12,
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/mayonnaise = 5,
	)
	foodtypes = VEGETABLES | MEAT | BREAKFAST
	tastes = list(
		"new year" = 2,
		"approaching pancreatitis" = 1,
		"creamy sausage" = 1,
	)
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/salad/vinegret
	name = "vinegret salad"
	desc = "Who would have thought red beet-root can be so tasty? Red-purplish salad mixed with nicely \
			diced red onion and carrot, in addition to red beet and peas. \
			Dressing is made of fantastic olive oil and vinegar."
	icon = TFF_FOOD_NY_ICON
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
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/salad/kraboviy
	name = "kraboviy salad"
	desc = "Pan-Slavic variation of Crab Louie salad, a popular festive dish. \
			It smells exactly the same, but there is a nuance - there are no crabs in it."
	icon = TFF_FOOD_NY_ICON
	icon_state = "kraboviy"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/mayonnaise = 5,
	)
	foodtypes = VEGETABLES | MEAT | BREAKFAST | SEAFOOD
	tastes = list(
		"crab meat" = 2,
		"eggs" = 1,
		"corn" = 1,
	)
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cake/shuba
	name = "shuba"
	desc = "Also known as Сarp under a fur coat, a layered salad composed of diced carp covered with \
			layers of grated boiled eggs, vegetables, chopped onions, and mayonnaise. \
			A great option if you want to install a pancreatic implant soon."
	icon = TFF_FOOD_NY_ICON
	icon_state = "shuba"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 14,
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/mayonnaise = 6,
	)
	foodtypes = MEAT | VEGETABLES | BREAKFAST | SEAFOOD
	tastes = list(
		"new year rush" = 1,
		"mayonnaise" = 1,
		"fish" = 1,
	)
	slice_type = /obj/item/food/cakeslice/shuba
	yield = 6
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/cakeslice/shuba
	name = "shuba slice"
	desc = "A wedge of 'herring under a fur coat', ready to go."
	icon = TFF_FOOD_NY_ICON
	icon_state = "shuba_slice"
	tastes = list(
		"new year rush" = 1,
		"mayonnaise" = 1,
		"fish" = 1,
	)
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cake/kholodetz
	name = "kholodetz"
	desc = "It is... Meat jelly, probably. It looks disgusting, but in the far corners of space it is \
			considered a festive dish. Usually served with mustard and a shot of vodka. Try it at your own risk."
	icon = TFF_FOOD_NY_ICON
	icon_state = "kholodetz"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/protein = 8,
	)
	foodtypes = MEAT | VEGETABLES | GORE
	tastes = list(
		"suspicious meat jelly" = 1,
		"inexplicable texture" = 1,
	)
	slice_type = /obj/item/food/cakeslice/kholodetz
	yield = 4
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cakeslice/kholodetz
	name = "kholodetz slice"
	desc = "A jiggling slice that challenges your courage."
	icon = TFF_FOOD_NY_ICON
	icon_state = "kholodetz_slice"
	tastes = list(
		"suspicious meat jelly" = 1,
		"inexplicable texture" = 1,
	)
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/christmas_ham
	name = "Christmas ham"
	desc = "Christmas turkey ham decorated with cranberries. When cut, you can see a spiral \
			pattern on the meat. An excellent appetiser for the New Year's table!"
	icon = TFF_FOOD_NY_ICON
	icon_state = "ham"
	w_class = WEIGHT_CLASS_NORMAL
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 16,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/bbqsauce = 5,
		/datum/reagent/consumable/blackpepper = 1,
	)
	foodtypes = MEAT | GRAIN | FRUIT
	tastes = list(
		"holiday sausage" = 2,
		"glazed berries" = 1,
		"bbq smoke" = 1,
	)
	crafting_complexity = FOOD_COMPLEXITY_4
	var/obj/item/food/christmas_ham/slice/slice_type = /obj/item/food/christmas_ham/slice
	var/slice_yield = 6

/obj/item/food/christmas_ham/make_processable()
	if (slice_type)
		AddElement(/datum/element/processable, TOOL_KNIFE, slice_type, slice_yield, 3 SECONDS, table_required = TRUE, screentip_verb = "Carve", sound_to_play = SFX_KNIFE_SLICE)

/obj/item/food/christmas_ham/slice
	name = "slice of Christmas ham"
	desc = "A succulent slice dotted with cranberries."
	icon = TFF_FOOD_NY_ICON
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
	food_flags = FOOD_FINGER_FOOD
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/christmas_ham/raw
	name = "raw Christmas ham"
	desc = "Uncooked ham stuffed with berries and seasoning, ready for the oven."
	icon = TFF_FOOD_NY_ICON
	icon_state = "ham"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/bbqsauce = 5,
		/datum/reagent/consumable/blackpepper = 1,
	)
	foodtypes = MEAT | RAW | GRAIN | FRUIT
	tastes = list("raw ham" = 1, "berries" = 1)
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/christmas_ham/raw/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/christmas_ham, 70 SECONDS, TRUE, TRUE)

/obj/item/food/sweets/candy_cane
	name = "candy cane"
	desc = "Traditional Christmas candy made from sugar and peppermint."
	icon = TFF_FOOD_NY_ICON
	icon_state = "candycane"
	food_reagents = list(
		/datum/reagent/consumable/sugar = 10,
		/datum/reagent/consumable/menthol = 2,
	)
	foodtypes = SUGAR | TOXIC
	tastes = list(
		"sugar" = 2,
		"mint" = 1,
	)
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/red_caviar
	name = "red caviar"
	desc = "The origin is unknown. It smells of alien frogs and arrogance. Probably an imitation... or not."
	icon = TFF_FOOD_NY_ICON
	icon_state = "caviar_isolated"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/salt = 1,
	)
	tastes = list(
		"salty caviar" = 2,
		"alien arrogance" = 1,
	)
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/canned_red_caviar
	name = "canned red caviar"
	desc = "The beautiful green can has an inscription in the skrell language. Possible translation: only for export."
	icon = TFF_FOOD_NY_ICON
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
	update_canned_red_caviar_icon_state()
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
	desc = "The perfect combination of a slice of bread, delicate butter, and fish caviar. \
			It is usually served at festive tables all over the world. \
			The origin of the caviar is unknown, but it is definitely not salmon."
	icon = TFF_FOOD_NY_ICON
	icon_state = "butterbrod"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/cream = 1,
		/datum/reagent/consumable/salt = 1,
	)
	foodtypes = GRAIN | DAIRY | SEAFOOD
	tastes = list(
		"crispy bread" = 1,
		"creamy butter" = 1,
		"salty caviar" = 2,
	)
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_3

/*
	Мандарин и его производные
*/

/obj/item/food/grown/citrus/mandarin
	seed = /obj/item/seeds/mandarin
	name = "mandarin"
	desc = "A small, vividly orange citrus that smells like winter holidays."
	icon = 'tff_modular/modules/new_year_pack/icons/food_mandarin.dmi'
	icon_state = "mandarin"
	juice_typepath = /datum/reagent/consumable/mandarin_juice
	wine_power = 55
	tastes = list(
		"sweet mandarin juice" = 8,
		"clove oil" = 2,
	)

/obj/item/seeds/orange
	mutatelist = list(/obj/item/seeds/lime, /obj/item/seeds/orange_3d, /obj/item/seeds/mandarin)

/obj/item/seeds/mandarin
	name = "mandarin seed pack"
	desc = "These seeds grow into sweet mandarins packed with fragrant oils."
	icon_state = "mandarin_seed"
	icon = 'tff_modular/modules/new_year_pack/icons/food_mandarin.dmi'
	species = "mandarin"
	plantname = "Mandarin Tree"
	product = /obj/item/food/grown/citrus/mandarin
	lifespan = 60
	endurance = 55
	yield = 5
	potency = 25
	growing_icon = 'tff_modular/modules/new_year_pack/icons/food_mandarin.dmi'
	icon_grow = "mandarin-grow"
	icon_dead = "mandarin-dead"
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	reagents_add = list(
		/datum/reagent/consumable/nutriment/vitamin = 0.05,
		/datum/reagent/consumable/nutriment = 0.05,
	)

/datum/reagent/consumable/mandarin_juice
	name = "Mandarin Juice"
	description = "Bright, sweet mandarin juice with lingering winter spices."
	color = "#ff9b3a"
	taste_description = "sweet mandarin oil and cloves"
	quality = DRINK_GOOD
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
