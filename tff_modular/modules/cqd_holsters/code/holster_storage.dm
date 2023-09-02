/datum/storage/cqd_holster_storage
	max_slots = 1
	max_specific_storage = WEIGHT_CLASS_NORMAL

// прок перезаписан "белого списка".
/datum/storage/cqd_holster_storage/can_insert(obj/item/to_insert, mob/user, messages = TRUE, force = FALSE)
	. = ..()
	if(is_type_in_typecache(to_insert, exception_hold))
		return TRUE


/// Хранилище для кобуры в котором прописано то, что можно будет в неё убрать
/datum/storage/cqd_holster_storage/New()
	. = ..()

	// Объекты и их наследники которые по умолчанию можно будет убрать в кобуру.
	// Важное уточнение! Объекты из этого списка не 
	// будут игнорировать размер и иные ограничения.
	can_hold = typecacheof(list(
		// Большая часть пистолетов и револьверов
		/obj/item/gun/ballistic/revolver,
		/obj/item/gun/ballistic/automatic/pistol,

		// Энергетические стволы, которые normal sized.
		/obj/item/gun/energy,
	))

	// Объекты и их наследники которые по умолчанию НЕЛЬЗЯ будет убрать в кобуру.
	cant_hold = typecacheof(list()) // Тут пока пусто...

	// Объекты и их наследники которые в любом случае можно будет убрать в кобуру.
	// Важное уточнение! Объекты из этого списка БУДУТ игнорировать размер, "чёрный список" и иные ограничения.
	exception_hold = typecacheof(list(
		/obj/item/food/grown/banana, // Бананчег :D
		))


