#define isnecromorph(A) (is_species(A, /datum/species/necromorph))

// Anything aboe this layer is not "on" a turf for the purposes of washing
#define NECROMORPH_CORRUPTION_LAYER 2.56

// Subsystems Fire
#define FIRE_PRIORITY_CORRUPTION 34

#define NECROMORPH_ACID_POWER 0.7	//Damage per unit of necromorph organic acid, used by many things
#define NECROMORPH_FRIENDLY_FIRE_FACTOR 0.5	//All damage dealt by necromorphs TO necromorphs, is multiplied by this
#define NECROMORPH_ACID_COLOR "#946b36"

//Faction strings
#define FACTION_NECROMORPH "necromorph"
#define ROLE_NECROMORPH "necromorph"

//Necromorph species
#define SPECIES_NECROMORPH "necromorph"
#define SPECIES_NECROMORPH_SLASHER "slasher"

#define SPECIES_NECROMORPH_SLASHER_ENHANCED "enhanced_slasher"
#define SPECIES_NECROMORPH_SPITTER "spitter"
#define SPECIES_NECROMORPH_PUKER "puker"
#define SPECIES_NECROMORPH_BRUTE "brute"
#define SPECIES_NECROMORPH_EXPLODER "exploder"
#define SPECIES_NECROMORPH_EXPLODER_ENHANCED "enhanced_exploder"
#define SPECIES_NECROMORPH_HUNTER "hunter"
#define SPECIES_NECROMORPH_INFECTOR "infector"
#define SPECIES_NECROMORPH_INFECTOR_ENHANCED "enhanced_infector"
#define SPECIES_NECROMORPH_TWITCHER "twitcher"
#define SPECIES_NECROMORPH_TWITCHER_ORACLE "oracle_twitcher"
#define SPECIES_NECROMORPH_LEAPER "leaper"
#define SPECIES_NECROMORPH_LEAPER_ENHANCED "enhanced_leaper"
#define SPECIES_NECROMORPH_LEAPER_HOPPER "hopper"
#define	SPECIES_NECROMORPH_LURKER "lurker"
#define SPECIES_NECROMORPH_TRIPOD "tripod"
#define SPECIES_NECROMORPH_FODDER "fodder"
#define SPECIES_NECROMORPH_UBERMORPH "ubermorph"


//Graphical variants
#define SPECIES_NECROMORPH_EXPLODER_ENHANCED_RIGHT "enhanced_right_exploder"
#define SPECIES_NECROMORPH_EXPLODER_ENHANCED_LEFT "enhanced_left_exploder"
#define SPECIES_NECROMORPH_EXPLODER_RIGHT "right_exploder"
#define SPECIES_NECROMORPH_EXPLODER_LEFT "left_exploder"

#define SHAKE_ANIMATION_OFFSET 4

///The percentage of damage at which a bodypart can start to be dismembered.
#define LIMB_DISMEMBERMENT_PERCENT 0.9

//Safety check flags
#define EXECUTION_CANCEL -1	//The whole move has gone wrong, abort
#define EXECUTION_RETRY 0	//Its not right yet but will probably fix itself, delay and keep trying
#define EXECUTION_CONTINUE 1	//Its fine, keep going
#define EXECUTION_SUCCESS 2 //We have achieved victory conditions. Try to skip to the end
#define EXECUTION_SAFETY var/result = safety_check();\
if (result == EXECUTION_CANCEL && can_interrupt){\
	interrupt();\
	return}

#define EXECUTION_DAMAGE_VULNERABILITY 1.5

//Execution status vars
#define STATUS_NOT_STARTED 0
#define STATUS_STARTING 1
#define STATUS_PRE_FINISH 2
#define STATUS_POST_FINISH 3
#define STATUS_ENDED 4

/atom/proc/shake_animation()
		var/direction = prob(50) ? -1 : 1
		animate(src, pixel_x = pixel_x + SHAKE_ANIMATION_OFFSET * direction, time = 1, easing = QUAD_EASING | EASE_OUT, flags = ANIMATION_PARALLEL)
		animate(pixel_x = pixel_x - (SHAKE_ANIMATION_OFFSET * 2 * direction), time = 1)
		animate(pixel_x = pixel_x + SHAKE_ANIMATION_OFFSET * direction, time = 1, easing = ELASTIC_EASING)
