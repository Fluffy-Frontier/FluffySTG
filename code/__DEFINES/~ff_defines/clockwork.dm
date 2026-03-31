///check if a z level is reebe
#define is_reebe_level(z) SSmapping.level_trait(z, ZTRAIT_REEBE)
// Clock cultist
#define IS_CLOCK(mob) ((FACTION_CLOCK in mob.faction) || mob?.mind?.has_antag_datum(/datum/antagonist/clock_cultist))
/// is something a cogscarab
#define iscogscarab(checked) (istype(checked, /mob/living/basic/drone/cogscarab))
/// is something an eminence
#define iseminence(checked) (istype(checked, /mob/living/eminence))
/// maximum amount of cogscarabs the clock cult can have
#define MAXIMUM_COGSCARABS 6
#define SPELLTYPE_ABSTRACT "Abstract"
#define SPELLTYPE_SERVITUDE "Servitude"
#define SPELLTYPE_PRESERVATION "Preservation"
#define SPELLTYPE_STRUCTURES "Structures"

#define SIGIL_TRANSMISSION_RANGE 4

#define CLOCK_PASSIVE_POWER_PER_COG 3

#define CLOCK_MAX_POWER_PER_COG STANDARD_CELL_CHARGE * 0.05

#define MAX_CLOCK_VITALITY 400
/// Clockwork Golem Species
#define SPECIES_GOLEM_CLOCKWORK "clockwork_golem"
///base state the ark is created in, any state besides this will be a hostile environment
#define ARK_STATE_BASE 0
///state for the grace period after the cult has reached its member count max and have enough activing anchoring crystals to summon
#define ARK_STATE_CHARGING 1
///state for after the cult has been annouced and are preparing for the portals to open
#define ARK_STATE_GRACE 2
///state for the first half of the assault
#define ARK_STATE_ACTIVE 3
///state for the halfway point of ark activation
#define ARK_STATE_SUMMONING 4
///the ark has either finished opening or been destroyed in this state
#define ARK_STATE_FINAL 5

///max damage taken per hit by "important" clock structures
#define MAX_IMPORTANT_CLOCK_DAMAGE 30

///how many anchoring crystals need to be active before the ark can open
#define ANCHORING_CRYSTALS_TO_SUMMON 2

///the map path of the reebe map
#define REEBE_MAP_PATH "_maps/fluffy_frontier/templates/reebe.dmm"

///how long in seconds do anchoring crystals take to charge after being placed, 6 minutes
#define ANCHORING_CRYSTAL_CHARGE_DURATION 360 SECONDS

///how long between uses of the anchoring crystal scripture, also how long the hostile environment lasts if the crystal is not destroyed
#define ANCHORING_CRYSTAL_COOLDOWN ANCHORING_CRYSTAL_CHARGE_DURATION + 1 MINUTES

///up to how many tiles away will the ark stop certain things from breaking turfs
#define ARK_TURF_DESTRUCTION_BLOCK_RANGE 10

///how many clockwork airlocks is the cult allowed to create on reebe
#define MAXIMUM_REEBE_AIRLOCKS 50

///called when /datum/element/turf_checker detects a new state on constant checking (new_state) TRUE for a valid turf FALSE for an invalid
#define COMSIG_TURF_CHECKER_UPDATE_STATE "turf_checker_update_state"
#define COMPONENT_CHECKER_VALID_TURF (1<<0)
#define COMPONENT_CHECKER_INVALID_TURF (2<<0)

/// Used to externally force /datum/element/light_eater to handle eating a light without physical contact. Used by nightmares. (food, eater, silent)
#define COMSIG_LIGHT_EATER_EAT "light_eater_eat"
/// Called when a clock cultist uses a clockwork slab: (obj/item/clockwork/clockwork_slab/slab)
#define COMSIG_CLOCKWORK_SLAB_USED "clockwork_slab_used"

/// the comsig for clockwork items checking turf
#define COMSIG_CHECK_TURF_CLOCKWORK "check_turf_clockwork"
///sent by the ark SS whenever an anchoring crystal charges (/obj/structure/destructible/clockwork/anchoring_crystal/charged_crystal)
#define COMSIG_ANCHORING_CRYSTAL_CHARGED "anchoring_crystal_charged"

///sent by the ark SS whenever an anchoring crystal is created (/obj/structure/destructible/clockwork/anchoring_crystal/charged_crystal)
#define COMSIG_ANCHORING_CRYSTAL_CREATED "anchoring_crystal_created"

///Set weakref_var to null if it fails to give a resolve() value, resolver should be set to the var looking to resolve the weakref
#define WEAKREF_NULL_IF_UNRESOLVED(weakref_var, resolver) weakref_var?.resolve();\
	if(!##resolver) { \
		##weakref_var = null;\
	}

// Traits related directly to Clockwork Cult
/// Given to Clockwork Golems, gives them a reduction on invoke time for certain scriptures.
#define TRAIT_FASTER_SLAB_INVOKE	"faster_slab_invoke"
/// Prevents the invocation of clockwork scriptures.
#define TRAIT_NO_SLAB_INVOKE		"no_slab_invoke"
/// Has an item been enchanted by a clock cult Stargazer?
#define TRAIT_STARGAZED				"stargazed"
