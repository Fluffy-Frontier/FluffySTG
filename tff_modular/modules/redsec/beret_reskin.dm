//Все береты являются грейскейлами, поэтому нужен свой кастомный рескин.
//Да-да, всё ради одного беретика.......
/obj/item/clothing/head/beret/
	var/list/color_variants
	var/recolored = FALSE

/obj/item/clothing/head/beret/AltClick(mob/user)
	. = ..()
	if(recolored) //буквально повторение функционала рескинов. Без повторных перекрашиваний.
		return
	if(!LAZYLEN(color_variants))
		return

	var/list/beret_recolors = list()
	for(var/color in color_variants)
		var/image/beret_preview = image(icon = SSgreyscale.GetColoredIconByType(greyscale_config, color_variants[color]), icon_state = icon_state)
		beret_recolors += list("[color]" = beret_preview)
	var/pick = show_radial_menu(user, src, beret_recolors, custom_check = CALLBACK(src, PROC_REF(check_reskin_menu), user), radius = 38, require_near = TRUE)
	if(!pick)
		return
	var/new_color = color_variants[pick]

	set_greyscale(new_color)
	recolored = TRUE

	if(ishuman(user))
		var/mob/living/carbon/human/wearer = user
		wearer.regenerate_icons()

/obj/item/clothing/head/beret/sec/peacekeeper //и теперь, у нас есть возможность прописывать свои варианты. ура-а-а....
	color_variants = list(
		"Blue Beret" = "#3F3C40#375989",
		"Red Beret" = "#a52f29#F2F2F2"
	)

/obj/item/clothing/head/beret/sec/navywarden
	color_variants = list(
		"Blue Beret" = "#3C485A#FF0000#00AEEF",
		"Black Beret" = "#3F3C40#FF0000#00AEEF"
	)

/obj/item/clothing/head/hats/hos/beret
	color_variants = list(
		"Yellow Badge" = "#3F3C40#FFCE5B",
		"Red Badge" = "#3F3C40#DB2929"
	)
