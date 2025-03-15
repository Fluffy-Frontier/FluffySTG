#define ismarkersignal(A) (istype(A, /mob/eye/marker_signal)) //youknow
#define ismarkermark(A) (istype(A, /mob/eye/marker_signal/marker))

//from base of (/atom/proc/set_density): (old_density, new_density)
#define COMSIG_ATOM_SET_DENSITY "atom_set_density"
//from (/obj/structure/corruption/Initialize): (corruption)
#define COMSIG_TURF_NECRO_CORRUPTED "turf_necro_corrupted"
//from (/obj/structure/corruption/Destroy): (corruption)
#define COMSIG_TURF_NECRO_UNCORRUPTED "turf_necro_uncorrupted"

/// As of now only used when placing marker structures
/mob
	var/datum/mouse_move_intercept //code/modules/mob/mob_defines.dm
