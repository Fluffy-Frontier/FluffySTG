// Упакованный умный холодильник для хранения дисков и плата к нему
// Создаем новый объект (все полетит к чертям в случае рефактора апстримов)

/obj/item/flatpack/smartfridge/disks_tff
    name = "flatpack (Disk Compartmentalizer)"
    board = /obj/item/circuitboard/machine/smartfridge  // Существующая в билде плата

// Пытаемся избежать ввода новой платы для той же самой машинерии

/obj/item/flatpack/smartfridge/disks_tff/Initialize(mapload)
    . = ..()
	// Изменяем дженерик имя
    name = "flatpack (Disk Compartmentalizer)"
    // Пытаемся изменить тип платы. Ингейм действие отвертки по плате просто меняет ее build_path в VV
    var/obj/item/circuitboard/machine/smartfridge/newboard = board
    newboard.build_path = /obj/machinery/smartfridge/disks
