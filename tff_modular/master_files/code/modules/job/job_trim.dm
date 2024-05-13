// Файл для модификации трима и доступа у профок.

/datum/id_trim/job/quartermaster/New()
	. = ..()
	
	minimal_access |= ACCESS_WEAPONS
