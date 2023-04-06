/obj/item/airlock_painter/decal/inscript
	name = "tile sprayer"
	desc = "An airlock painter, reprogramed to use a different style of paint in order to spray colors on floor tiles as well, in addition to repainting doors. Decals break when the floor tiles are removed."
	desc_controls = "Alt-Click to remove the ink cartridge."
	icon_state = "tile_sprayer"
	stored_dir = 2
	stored_color = "#D4D4D432"
	stored_decal = "tile_corner"
	spritesheet_type = /datum/asset/spritesheet/decals/inscript
	supports_custom_color = TRUE
	color_list = list(
		list("Neutral", "#D4D4D4"),
		list("Dark", "#0e0f0f"),
		list("Bar Burgundy", "#791500"),
		list("Sec Blue", "#486091"),
		list("Cargo Brown", "#A46106"),
		list("Engi Yellow", "#EFB341"),
		list("Service Green", "#9FED58"),
		list("Med Blue", "#52B4E9"),
		list("R&D Purple", "#D381C9")
	)
	decal_list = list(
		list("O2", "oxygen"),
		list("CO2", "carbon_dioxide"),
		list("N2", "nitrogen"),
		list("Air", "air"),
		list("N2O", "nitrous_oxide"),
		list("Plas", "plasma"),
		list("Mix", "mix"),
		list("Radiation", "radiation-w"),
		list("HoP", "hop"),
		list("Bar", "bar"),
		list("Cargo", "cargo"),
		list("Med", "med"),
		list("Sci", "sci"),
		list("Sec", "sec"),
		list("Mine", "mine"),
		list("Zero", "zero"),
		list("One", "one"),
		list("Two", "two"),
		list("Three", "three"),
		list("Four", "four"),
		list("Five", "five"),
		list("Six", "six"),
		list("Seven", "seven"),
		list("Eight", "eight"),
		list("Nine", "nine")
	)
	nondirectional_decals = list(
	)

	var/static/regex/rgba_regex = new(@"(#[0-9a-fA-F]{6})([0-9a-fA-F]{2})")

	var/default_alpha = 210

/obj/item/airlock_painter/decal/inscript/paint_floor(turf/open/floor/target)
	var/source_decal = stored_decal
	var/source_dir = stored_dir
	if(copytext(stored_decal, -3) == "__4")
		source_decal = splicetext(stored_decal, -3, 0, "")
		source_dir = turn(stored_dir, 45)

	var/decal_color = stored_color
	var/decal_alpha = default_alpha
	if(rgba_regex.Find(decal_color))
		decal_color = rgba_regex.group[1]
		decal_alpha = text2num(rgba_regex.group[2], 16)

	target.AddElement(/datum/element/decal, '~ff/floor_decals/icons/turf/decals.dmi', source_decal, source_dir, null, null, decal_alpha, decal_color, null, FALSE, null)

/datum/asset/spritesheet/decals/inscript
	name = "floor_tile_decals"
	painter_type = /obj/item/airlock_painter/decal/inscript

/datum/asset/spritesheet/decals/inscript/insert_state(decal, dir, color)
	var/source_decal = decal
	var/source_dir = dir
	if(copytext(decal, -3) == "__4")
		source_decal = splicetext(decal, -3, 0, "")
		source_dir = turn(dir, 45)

	var/obj/item/airlock_painter/decal/inscript/tile_type = painter_type
	var/render_color = color
	var/render_alpha = initial(tile_type.default_alpha)
	if(tile_type.rgba_regex.Find(color))
		render_color = tile_type.rgba_regex.group[1]
		render_alpha = text2num(tile_type.rgba_regex.group[2], 16)

	var/icon/colored_icon = icon('~ff/floor_decals/icons/turf/decals.dmi', source_decal, dir=source_dir)
	colored_icon.ChangeOpacity(render_alpha * 0.008)
	if(color == "custom")
		colored_icon.Blend(icon('icons/effects/random_spawners.dmi', "rainbow"), ICON_MULTIPLY)
	else
		colored_icon.Blend(render_color, ICON_MULTIPLY)

	colored_icon = blend_preview_floor(colored_icon)
	Insert("[decal]_[dir]_[replacetext(color, "#", "")]", colored_icon)
