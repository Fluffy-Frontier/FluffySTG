/obj/item/clothing/accessory/cqd_holster
	name = "CQD holster"
	icon = 'tff_modular/modules/cqd_holsters/icons/cqd_holster.dmi'
	worn_icon = 'tff_modular/modules/cqd_holsters/icons/cqd_holster_worn.dmi'
	icon_state = "cqd-holster"
	var/obj/item/holstered_item
	above_suit = FALSE

/obj/item/clothing/accessory/cqd_holster/Initialize(mapload)
	. = ..()
	create_storage(storage_type = /datum/storage/cqd_holster_storage)

// Тут желательно перехватывать ситуации разные.
/obj/item/clothing/accessory/cqd_holster/on_uniform_equip(obj/item/clothing/under/U, user)
	. = ..()
	// Если всё нормально - то он будет использовать дефолтный спрайт.
	worn_icon_state = null

	if(isteshari(user))
		worn_icon_state = "hidden"
	
/obj/item/clothing/accessory/cqd_holster/detach(obj/item/clothing/under/U, user)
	// А это костыльный обход багули, который я подглядел у кармашка для ручек.
	var/drop_loc = drop_location()
	for(var/atom/movable/held as anything in src)
		held.forceMove(drop_loc)
		to_chat(user, span_alert("You had dropped [held] while detaching [src]."))
	return ..()
	
