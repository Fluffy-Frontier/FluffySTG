// Упакованный умный холодильник для хранения дисков и плата к нему
// Создаем новый объект (все полетит к чертям в случае рефактора апстримов)

/obj/item/flatpack/smartfridge/disks_tff
    name = "flatpack (Disk Compartmentalizer)"
    board = /obj/item/circuitboard/machine/smartfridge  // Существующая в билде плата

// Пытаемся избежать ввода новой платы для той же самой машинерии

/obj/item/flatpack/smartfridge/disks_tff/Initialize(mapload)
    . = ..(mapload, new /obj/item/circuitboard/machine/smartfridge())
// Изменяем дженерик имя
    name = "flatpack (Disk Compartmentalizer)"
    // Пытаемся изменить тип платы. Ингейм действие отвертки по плате просто меняет ее build_path в VV
    var/obj/item/circuitboard/machine/smartfridge/newboard = board
    var/position = newboard.fridges_name_paths.Find(/obj/machinery/smartfridge/disks)
    newboard.build_path = newboard.fridges_name_paths[position]
