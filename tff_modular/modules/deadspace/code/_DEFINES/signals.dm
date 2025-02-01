#define ismarkereye(A) (istype(A, /mob/camera/marker_signal)) //youknow


//from base of (/atom/proc/set_density): (old_density, new_density)
#define COMSIG_ATOM_SET_DENSITY "atom_set_density"
//from (/obj/structure/corruption/Initialize): (corruption)
#define COMSIG_TURF_NECRO_CORRUPTED "turf_necro_corrupted"
//from (/obj/structure/corruption/Destroy): (corruption)
#define COMSIG_TURF_NECRO_UNCORRUPTED "turf_necro_uncorrupted"

/// Shown to all mobs not just the user
#define DO_PUBLIC (1<<5) //ffdefines/code/flags.dm

/// As of now only used when placing marker structures
/mob
	var/datum/mouse_move_intercept //code/modules/mob/mob_defines.dm
