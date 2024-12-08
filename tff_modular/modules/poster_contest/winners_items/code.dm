/datum/storage/pockets/painters_cloak
	max_slots = 6
	attack_hand_interact = FALSE
	max_specific_storage = WEIGHT_CLASS_NORMAL
	quickdraw = FALSE
	silent = TRUE

/obj/item/toy/crayon/spraycan/extralarge
	name = "large spray can"
	charges = 300

/datum/storage/pockets/painters_cloak/New(
	atom/parent,
	max_slots,
	max_specific_storage,
	max_total_storage,
)
	. = ..()
	set_holdable(list(
		/obj/item/toy/crayon,
		/obj/item/toy/crayon/spraycan,
		/obj/item/airlock_painter,
		/obj/item/toner,
		/obj/item/storage/crayons,
		/obj/item/chisel,
		/obj/item/paint_palette,
		/obj/item/paint,
		/obj/item/reagent_containers/cup/rag,
		/obj/item/reagent_containers/spray/cleaner,
		/obj/item/soap,
	))

/obj/item/clothing/neck/cloak/poster_contest
	name = "Artist's cape"
	desc = "A perfectly tailored cloak, radiating elegance and precision. The smooth fabric and flawless design make it appear untouched by imperfection."
	icon_state = "cape_icon"
	icon = 'tff_modular/modules/poster_contest/winners_items/icons.dmi'
	worn_icon_state = "cape"
	worn_icon = 'tff_modular/modules/poster_contest/winners_items/icons.dmi'
	worn_icon_teshari = 'tff_modular/modules/poster_contest/winners_items/tesh_icons.dmi'
	resistance_flags = FIRE_PROOF

/obj/item/clothing/neck/cloak/poster_contest/painted
	name = "Artist's cape in paint"
	desc = "A finely crafted cape that exudes a sense of individuality. Each stroke of dye, each subtle hue, feels deliberate, as if every imperfection tells a part of its story."
	worn_icon_state = "painted_cape"

/obj/item/clothing/neck/cloak/poster_contest/Initialize(mapload)
	. = ..()
	create_storage(storage_type = /datum/storage/pockets/painters_cloak)
	var/static/items_inside = list(
		/obj/item/toy/crayon/spraycan/extralarge = 5,
		/obj/item/paint/anycolor = 1,
	)
	generate_items_inside(items_inside, src)

/obj/item/clothing/head/poster_contest
	name = "Artist's beret"
	desc = "An immaculately crafted beret that embodies refinement. Its pristine condition and sharp lines give it a polished, professional look."
	icon_state = "beret_icon"
	icon = 'tff_modular/modules/poster_contest/winners_items/icons.dmi'
	worn_icon_state = "beret"
	worn_icon = 'tff_modular/modules/poster_contest/winners_items/icons.dmi'
	worn_icon_teshari = 'tff_modular/modules/poster_contest/winners_items/tesh_icons.dmi'
	resistance_flags = FIRE_PROOF

/obj/item/clothing/head/poster_contest/painted
	name = "Artist's beret in paint"
	desc = "A stylish beret, meticulously designed with an air of sophistication. Every stitch, every detail seems intentional, as though the fabric itself holds a spark of creative genius."
	worn_icon_state = "painted_beret"

/obj/item/poster/poster_contest
	icon = 'tff_modular/modules/poster_contest/poster_contest.dmi'
	name = "poster"
	poster_type = /obj/structure/sign/poster/official/random
	icon_state = "rolled_legit"

// Kesa

/obj/item/poster/poster_contest/who_i_am
	poster_type = /obj/structure/sign/poster/official/ff_contest/who_i_am

/obj/item/poster/poster_contest/kft_crazy_nuggets
	poster_type = /obj/structure/sign/poster/contraband/ff_contest/kft_crazy_nuggets
	icon_state = "rolled_traitor"

/obj/item/poster/poster_contest/no_one_will_help
	poster_type = /obj/structure/sign/poster/contraband/ff_contest/no_one_will_help
	icon_state = "rolled_traitor"

// Cash

/obj/item/poster/poster_contest/a_faint_reminder
	poster_type = /obj/structure/sign/poster/official/ff_contest/a_faint_reminder

/obj/item/poster/poster_contest/dumayte
	poster_type = /obj/structure/sign/poster/official/ff_contest/dumayte

/obj/item/poster/poster_contest/fem_sec
	poster_type = /obj/structure/sign/poster/contraband/ff_contest/fem_sec
	icon_state = "rolled_traitor"

// Maslina

/obj/item/poster/poster_contest/time_for_discoveries
	poster_type = /obj/structure/sign/poster/official/ff_contest/time_for_discoveries

/obj/item/poster/poster_contest/say_yes_erp
	poster_type = /obj/structure/sign/poster/official/ff_contest/say_yes_erp

/obj/item/poster/poster_contest/pan_slavic_carpet_1
	poster_type = /obj/structure/sign/poster/official/ff_contest/pan_slavic_carpet_1

/obj/item/storage/box/posterbox/ff_contest1

/obj/item/storage/box/posterbox/ff_contest1/PopulateContents()
	var/static/items_inside = list(
		/obj/item/poster/poster_contest/who_i_am = 2,
		/obj/item/poster/poster_contest/kft_crazy_nuggets = 2,
		/obj/item/poster/poster_contest/no_one_will_help = 2,
	)
	generate_items_inside(items_inside,src)

/obj/item/storage/box/posterbox/ff_contest2

/obj/item/storage/box/posterbox/ff_contest2/PopulateContents()
	var/static/items_inside = list(
		/obj/item/poster/poster_contest/a_faint_reminder = 2,
		/obj/item/poster/poster_contest/dumayte = 2,
		/obj/item/poster/poster_contest/fem_sec = 2,
	)
	generate_items_inside(items_inside,src)

/obj/item/storage/box/posterbox/ff_contest3

/obj/item/storage/box/posterbox/ff_contest3/PopulateContents()
	var/static/items_inside = list(
		/obj/item/poster/poster_contest/time_for_discoveries = 2,
		/obj/item/poster/poster_contest/say_yes_erp = 2,
		/obj/item/poster/poster_contest/pan_slavic_carpet_1 = 2,
	)
	generate_items_inside(items_inside,src)

// Loadout:

/datum/loadout_item/neck/painted_artist_cape
	name = "Painted Artist's Cape"
	item_path = /obj/item/clothing/neck/cloak/poster_contest/painted
	ckeywhitelist = list("maslin_", "Smol42", "CashRat", "tonya677", "bowlofsoup")

/datum/loadout_item/neck/artist_cape
	name = "Artist's Cape"
	item_path = /obj/item/clothing/neck/cloak/poster_contest
	ckeywhitelist = list("maslin_", "Smol42", "CashRat", "tonya677", "bowlofsoup")

/datum/loadout_item/head/artist_beret
	name = "Artist's Beret"
	item_path = /obj/item/clothing/head/poster_contest
	ckeywhitelist = list("maslin_", "Smol42", "CashRat", "tonya677", "bowlofsoup")

/datum/loadout_item/head/painted_artist_beret
	name = "Painted Artist's Beret"
	item_path = /obj/item/clothing/head/poster_contest/painted
	ckeywhitelist = list("maslin_", "Smol42", "CashRat", "tonya677", "bowlofsoup")

/datum/loadout_item/inhand/poster_contest1
	name = "Poster box"
	item_path = /obj/item/storage/box/posterbox/ff_contest1
	ckeywhitelist = list("tonya677")

/datum/loadout_item/inhand/poster_contest2
	name = "Poster box"
	item_path = /obj/item/storage/box/posterbox/ff_contest2
	ckeywhitelist = list("CashRat")

/datum/loadout_item/inhand/poster_contest3
	name = "Poster box"
	item_path = /obj/item/storage/box/posterbox/ff_contest3
	ckeywhitelist = list("maslin_")
