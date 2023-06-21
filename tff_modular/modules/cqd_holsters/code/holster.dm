/obj/item/clothing/accessory/cqd_holster
	name = "CQD holster"
	icon_state = "pocketprotector"
	var/obj/item/holstered_item

// Нужно для перехвата на случай, если кобура будет надет на особую ксено-расу, чтобы подкорректировать спрайт.
/obj/item/clothing/accessory/cqd_holster/on_uniform_equip(obj/item/clothing/under/U, user)
	. = ..()
	