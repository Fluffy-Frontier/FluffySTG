///check if a z level is reebe
#define is_reebe_level(z) SSmapping.level_trait(z, ZTRAIT_REEBE)
/// is something a cogscarab
#define iscogscarab(checked) (istype(checked, /mob/living/basic/drone/cogscarab))
/// is something an eminence
#define iseminence(checked) (istype(checked, /mob/living/eminence))

#define is_safe_level(z) SSmapping.level_trait(z, ZTRAIT_FORCED_SAFETY)
///Set weakref_var to null if it fails to give a resolve() value, resolver should be set to the var looking to resolve the weakref
#define WEAKREF_NULL_IF_UNRESOLVED(weakref_var, resolver) weakref_var?.resolve();\
	if(!##resolver) { \
		##weakref_var = null;\
	}
#define IS_SAFE_NUM(a) IS_FINITE(a)
// traits
// boolean - marks a level as having that property if present
#define ZTRAIT_REEBE "Reebe"
/// Marks a level as being "safe", even if it is a station z level.
/// Nukes will not kill players on such levels.
#define ZTRAIT_FORCED_SAFETY "Forced Safety"
///List of ztraits the reebe Z level has
#define ZTRAITS_REEBE list(ZTRAIT_REEBE = TRUE, \
						ZTRAIT_NOPHASE = TRUE, \
						ZTRAIT_BOMBCAP_MULTIPLIER = 0.5, \
						ZTRAIT_RESERVED = TRUE, \
						ZTRAIT_BASETURF = /turf/open/indestructible/reebe_flooring)
//clockwork wall deconstruction
#define COVER_COG_REMOVED 1
#define TRANSMISSION_COGS_REMOVED 2
#define GEARS_UNBOLTED 3
#define INNER_PANEL_REMOVED 4
#define GEARS_UNWOUND 5
/// maximum amount of cogscarabs the clock cult can have
#define MAXIMUM_COGSCARABS 6

#define CLOCK_PASSIVE_POWER_PER_COG 3

#define CLOCK_MAX_POWER_PER_COG STANDARD_CELL_CHARGE * 0.05

#define MAX_CLOCK_VITALITY 400
/// Clockwork Golem Species
#define SPECIES_GOLEM_CLOCKWORK "clockgolem"
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

#define CHANNEL_SOUND_EFFECTS 1010
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
/// from base of atom/ratvar_act()
#define COMSIG_ATOM_RATVAR_ACT "atom_ratvar_act"

/// from base of atom/eminence_act() : (mob/living/eminence/user)
#define COMSIG_ATOM_EMINENCE_ACT "atom_eminence_act"
/// Used to externally force /datum/element/light_eater to handle eating a light without physical contact. Used by nightmares. (food, eater, silent)
#define COMSIG_LIGHT_EATER_EAT "light_eater_eat"

/// the comsig for clockwork items checking turf
#define COMSIG_CHECK_TURF_CLOCKWORK "check_turf_clockwork"
///sent by the ark SS whenever an anchoring crystal charges (/obj/structure/destructible/clockwork/anchoring_crystal/charged_crystal)
#define COMSIG_ANCHORING_CRYSTAL_CHARGED "anchoring_crystal_charged"

#define COMSIG_ATOM_SLAB_ACT			"atom_slab_act"

///sent by the ark SS whenever an anchoring crystal is created (/obj/structure/destructible/clockwork/anchoring_crystal/charged_crystal)
#define COMSIG_ANCHORING_CRYSTAL_CREATED "anchoring_crystal_created"
// Traits related directly to Clockwork Cult
#define TRAIT_BRONZE_TURF			"bronze_turf"
/// Given to Clockwork Golems, gives them a reduction on invoke time for certain scriptures.
#define TRAIT_FASTER_SLAB_INVOKE	"faster_slab_invoke"
/// Prevents the invocation of clockwork scriptures.
#define TRAIT_NO_SLAB_INVOKE		"no_slab_invoke"
/// Has an item been enchanted by a clock cult Stargazer?
#define TRAIT_STARGAZED				"stargazed"
/// Soul consumed by sigil of vitality
#define TRAIT_NO_SOUL_BY_VITALITY	"no_soul_by_vitality"
// Traits Sources
#define STARGAZER_TRAIT 			"stargazer_trait"
/// Trait source for the vanguard scripture
#define VANGUARD_TRAIT 				"vanguard_trait"
/// Trait source from the clockwork sigil
#define SIGIL_TRAIT					"sigil_trait"
// Roles
#define ROLE_ROUNDSTART_CLOCK_CULTIST "Roundstart Clockwork Cultist"
#define ROLE_MIDROUND_CLOCK_CULTIST "Midround Clockwork Cultist"
