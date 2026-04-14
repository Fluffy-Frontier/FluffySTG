/// From base of /mob/living/simple_animal/attack_hand() and /mob/living/basic/attack_hand() when petting (non-combat): (mob/living/pet)
#define COMSIG_LIVING_PET_ANIMAL "living_pet_animal"
/// From base of carbon_defense.dm when hugging: (mob/living/carbon/hugged)
#define COMSIG_LIVING_HUG_CARBON "living_hug_carbon"
/// From base of /datum/element/art when appraising art: (atom/art_piece)
#define COMSIG_LIVING_APPRAISE_ART "living_appraise_art"
/// Source trait while Feeding
#define FEED_TRAIT "feed_trait"
/// Hides TRAIT_GENELESS if it's only from the same sources as TRAIT_FAKEGENES.
#define TRAIT_FAKEGENES "fakegenes"
/// You have special interactions with vampires and the occult.
#define TRAIT_OCCULTIST "occultist"
/// The user is "vampire aligned" - i.e a vampire or vassal.
/// Basically just check for `HAS_MIND_TRAIT(user, TRAIT_VAMPIRE_ALIGNED)` instead of `IS_VAMPIRE(user) || IS_VASSAL(user)`
#define TRAIT_VAMPIRE_ALIGNED "vampire_aligned"
#define DOAFTER_SOURCE_PERSUASION_RACK "doafter_persuasion_rack"
/// Checks if the given mob is a vampire
#define IS_VAMPIRE(mob) (mob?.mind?.has_antag_datum(/datum/antagonist/vampire))
/// Checks if the given mob is a vassal
#define IS_VASSAL(mob) (mob?.mind?.has_antag_datum(/datum/antagonist/vassal))
#define CAT_VAMPIRE "Vampire"
#define DOAFTER_SOURCE_ARCHIVE_OF_THE_KINDRED "doafter_archive_of_the_kindred"
/// This area can always be claimed as a vampire lair regardless of Z-level and such
#define ALWAYS_VALID_VAMPIRE_LAIR (1<<21)
#define LOG_CATEGORY_UPLINK_VAMPIRE "uplink-vampire"
#define FACTION_VAMPIRE "Vampire"
#define ROLE_VAMPIRE "Vampire"
#define ROLE_VAMPIRIC_ACCIDENT "Vampiric Accident"
#define ROLE_VAMPIRE_LATEJOIN "Vampire LateJoin"
#define BLOODSUCKER_RESTRICTED_SPECIES list( \
	/datum/species/synthetic, \
	/datum/species/plasmaman, \
	/datum/species/shadow/nightmare, \
	/datum/species/abductor, \
	/datum/species/android, \
	/datum/species/golem, \
	/datum/species/shadow, \
	/datum/species/skeleton, \
	/datum/species/zombie, \
	/datum/species/mutant, \
	/datum/species/dullahan, \
	/datum/species/hemophage \
)
#define span_awe(str) ("<span class='awe'>" + str + "</span>")
/// Uncomment this to enable testing of Vampire features (such as vassalizing people with a mind instead of a client).
//#define VAMPIRE_TESTING
#if defined(VAMPIRE_TESTING) && defined(CIBUILDING)
	#error VAMPIRE_TESTING is enabled, disable this!
#endif
#ifdef TESTING
	#define VAMPIRE_TESTING
#endif

// Blood-level defines
/// Determines Vampire regeneration rate
#define BS_BLOOD_VOLUME_MAX_REGEN 700
/// Cost to torture someone halfway, in blood. Called twice for full cost
#define TORTURE_BLOOD_HALF_COST 8
/// Cost to convert someone after successful torture, in blood
#define TORTURE_CONVERSION_COST 50
/// Once blood is this low, will enter a Frenzy
#define FRENZY_THRESHOLD_ENTER 25
/// Once blood is this high, will exit the Frenzy. Intentionally high, we want to kill the person we feed off of
#define FRENZY_THRESHOLD_EXIT 500
/// How much blood drained from the vampire each lifetick
#define VAMPIRE_PASSIVE_BLOOD_DRAIN 0.1
/// The number that incoming levels are divided by when comitting the Amaranth. Example: 2 would divide the victims level by 2, and give that to the diablerist
#define DIABLERIE_DIVISOR 1.5
/// Amount of vitae drunk from another player required to level up.
#define VITAE_GOAL_STANDARD 200

/// Default amount of damage the vampire's punch/kick damage increases with each level.
#define VAMPIRE_UNARMED_DMG_INCREASE_ON_RANKUP 0.5

/// How many starting levels do we want each one to have?
#define VAMPIRE_STARTING_LEVELS 3
/// How many free levels the vampire gets gradually.
#define VAMPIRE_FREE_LEVELS 3
/// Vampire's default stamina resist.
#define VAMPIRE_INHERENT_STAMINA_RESIST 0.75

/// When do we warn them about their low blood?
#define VAMPIRE_LOW_BLOOD_WARNING 300

/// Minimum blood required for vampires oozelings to auto-revive.
#define OOZELING_MIN_REVIVE_BLOOD_THRESHOLD (FRENZY_THRESHOLD_ENTER * 5)
/// How long it takes for an vampire oozeling to auto-revive, when left alone.
#define OOZELING_VAMPIRE_REVIVE_TIME (1.5 MINUTES)
/// How many times faster an oozeling vampire will revive if their core is being held by a non-vampire/non-ally.
#define OOZELING_VAMPIRE_REVIVE_HELD_MULTIPLIER 0.5
/// How many times faster an oozeling vampire will revive if their core is being held by an ally.
#define OOZELING_VAMPIRE_REVIVE_ALLY_MULTIPLIER 1.2
/// How many times faster an oozeling vampire will revive if their core is in a coffin.
#define OOZELING_VAMPIRE_REVIVE_COFFIN_MULTIPLIER 2.5

// vassal defines
/// If someone passes all checks and can be vassalized
#define VASSALIZATION_ALLOWED 0
/// If someone has to accept vassalization
#define VASSALIZATION_DISLOYAL 1
/// If someone is not allowed under any circimstances to become a vassal
#define VASSALIZATION_BANNED 2

// Humanity gains (The actual tracking lists and such are in the datum duh)
// These are supposed to be somewhat nontrivial, to the point of sometimes not being viable.
/// Hugging of separate people
#define HUMANITY_HUGGING_TYPE "hug"

/// Petting of separate animals
#define HUMANITY_PETTING_TYPE "pet"

/// Watching of art
#define HUMANITY_ART_TYPE "art"

#define HUMANITY_GAIN_TYPES list(HUMANITY_HUGGING_TYPE, HUMANITY_PETTING_TYPE, HUMANITY_ART_TYPE)

/// Default Humanity
#define VAMPIRE_DEFAULT_HUMANITY 7

// Cooldown defines
// Used to prevent spamming vampires
/// Spam prevention for healing messages.
#define VAMPIRE_SPAM_HEALING 15 SECONDS
/// Spam prevention for Sol Masquerade messages.
#define VAMPIRE_SPAM_MASQUERADE 60 SECONDS

/// Spam prevention for Sol messages.
#define VAMPIRE_SPAM_SOL 30 SECONDS

// Clan defines
#define CLAN_BRUJAH "Brujah Clan"
#define CLAN_TOREADOR "Toreador Clan"
#define CLAN_NOSFERATU "Nosferatu Clan"
#define CLAN_TREMERE "Tremere Clan"
#define CLAN_GANGREL "Gangrel Clan"
#define CLAN_VENTRUE "Ventrue Clan"
#define CLAN_MALKAVIAN "Malkavian Clan"
#define CLAN_TZIMISCE "Tzimisce Clan"
#define CLAN_HECATA "Hecata Clan"
#define CLAN_LASOMBRA "Lasombra Clan"

// Power defines
/// This Power can't be used in Torpor
#define BP_CANT_USE_IN_TORPOR (1<<0)
/// This Power can't be used in Frenzy.
#define BP_CANT_USE_IN_FRENZY (1<<1)
/// This Power can't be used with a stake in you
#define BP_CANT_USE_WHILE_STAKED (1<<2)
/// This Power can't be used while incapacitated
#define BP_CANT_USE_WHILE_INCAPACITATED (1<<3)
/// This Power can't be used while unconscious
#define BP_CANT_USE_WHILE_UNCONSCIOUS (1<<4)

/// This is a Default Power that all Vampires get.
#define VAMPIRE_DEFAULT_POWER (1<<1)

/// This Power is a Toggled Power
#define BP_AM_TOGGLE (1<<0)
/// This Power is a Single-Use Power
#define BP_AM_SINGLEUSE (1<<1)
/// This Power has a Static cooldown
#define BP_AM_STATIC_COOLDOWN (1<<2)
/// This Power doesn't cost bloot to run while unconscious
#define BP_AM_COSTLESS_UNCONSCIOUS (1<<3)
/// This Power has a cooldown that is more dynamic than a typical power
#define BP_AM_VERY_DYNAMIC_COOLDOWN (1<<4)

///Called when a Vampire reaches Final Death.
#define COMSIG_VAMPIRE_FINAL_DEATH "vampire_final_death"
	///Whether the vampire should not be dusted when arriving Final Death
	#define DONT_DUST (1<<0)

// Vampire Signals
/// Called when a Vampire breaks the Masquerade
#define COMSIG_VAMPIRE_BROKE_MASQUERADE "comsig_vampire_broke_masquerade"

// Signals & Defines
/// Sent whenever vampires get a "natural" rank up.
#define COMSIG_SOL_RANKUP_VAMPIRES "sol_rankup_vampires"
/// Sent when tracking humanity gain progress: (type, subject)
#define COMSIG_VAMPIRE_TRACK_HUMANITY_GAIN "comsig_vampire_track_humanity_gain"

/// Called on the mind when a Vampire chooses a clan: (datum/antagonist/vampire, datum/vampire_clan)
#define COMSIG_VAMPIRE_CLAN_CHOSEN "vampire_clan_chosen"

#define DANGER_LEVEL_FIRST_WARNING 1
#define DANGER_LEVEL_SECOND_WARNING 2
#define DANGER_LEVEL_THIRD_WARNING 3
#define DANGER_LEVEL_SOL_ROSE 4
#define DANGER_LEVEL_SOL_ENDED 5

// Clan defines
/// Drinks blood the normal Vampire way.
#define VAMPIRE_DRINK_NORMAL "vampire_drink_normal"
/// Drinks blood but is snobby, refusing to drink from mindless
#define VAMPIRE_DRINK_SNOBBY "vampire_drink_snobby"
// Masquerade ability given at this point or above
#define VAMPIRE_HUMANITY_MASQUERADE_POWER 7

// Traits
/// Falsifies Health analyzer blood levels
#define TRAIT_MASQUERADE "masquerade"
/// For people in the middle of being staked
#define TRAIT_BEINGSTAKED "beingstaked"
/// This vampire is currently in a frenzy,
#define TRAIT_FRENZY "frenzy"
/// This vampire is currently in torpor.
#define TRAIT_TORPOR "torpor"
/// This vampire can tell if another vampire has committed diablere on examine.
#define TRAIT_SEE_DIABLERIE "see_diablerie"

#define CLIENT_COLOR_SOURCE_VAMPIRE "client_color_source_vampire"
// Trait sources
/// Source trait for all vampire traits
#define TRAIT_VAMPIRE "trait_vampire"

// Macros
#define IS_CURATOR(mob) istype(mob?.mind?.assigned_role, /datum/job/curator)
/// Logging for vampire powers unlocked.
/proc/log_vampire_power(text, list/data)
	logger.Log(LOG_CATEGORY_UPLINK_VAMPIRE, text, data)

/// Trait that says you're shaded by something (ie partially in the dark)
#define TRAIT_SHADED "shaded"

#define IS_VAMPIRE_HUNTER(mob) (IS_CURATOR(mob))

#define LANGUAGE_VAMPIRE "vampire"
#define LANGUAGE_VASSAL "vassal"

/// /turf/proc/is_softly_lit() but inlined
#define IS_SOFTLY_LIT(turf) (turf.lighting_object && !(turf.luminosity || turf.dynamic_lumcount))
/// Similar to turf.get_lumcount(), but it checks for soft lighting first, and just assumes the lumcount is 0 if it is.
#define GET_SIMPLE_LUMCOUNT(turf) (IS_SOFTLY_LIT(turf) ? 0 : turf.get_lumcount())

//Incapacitated status effect flags
/// If the incapacitated status effect will ignore a mob in restraints (handcuffs)
#define IGNORE_RESTRAINTS (1<<0)
/// If the incapacitated status effect will ignore a mob in stasis (stasis beds)
#define IGNORE_STASIS (1<<1)
/// If the incapacitated status effect will ignore a mob being agressively grabbed
#define IGNORE_GRAB (1<<2)
/// If the incapacited status effect will ignore a mob in softcrit
#define IGNORE_SOFTCRIT (1<<3)
#define IS_SAFE_NUM(a) IS_FINITE(a)

#define BODY_ZONES_LIMBS list(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
///from base of atom/expose_reagents(): (/list, /datum/reagents, methods, volume_modifier, show_message)
#define COMSIG_ATOM_AFTER_EXPOSE_REAGENTS "atom_after_expose_reagents"
#define MOVABLE_PHYSICS_PRECISION 0.01
#define MOVABLE_PHYSICS_MINIMAL_VELOCITY 1

// movable physics component flags
/// Remove the component as soon as there's zero velocity, useful for movables that will no longer move after being initially moved (blood splatters)
#define MPHYSICS_QDEL_WHEN_NO_MOVEMENT (1<<0)
/// Movement has started, don't call start_movement() again
#define MPHYSICS_MOVING (1<<1)
/// The component has been "paused" and will not process
#define MPHYSICS_PAUSED (1<<2)
///from base of atom/movable/newtonian_move(): (inertia_direction, start_delay)
#define COMSIG_MOVABLE_NEWTONIAN_MOVE "movable_newtonian_move"
	#define COMPONENT_MOVABLE_NEWTONIAN_BLOCK (1<<0)
///from base of [/atom/proc/expose_reagents]: (/atom, /list, methods, volume_modifier, show_message)
#define COMSIG_REAGENTS_EXPOSE_ATOM "reagents_expose_atom"
#define COMSIG_LIVING_TRACKER_REMOVED "tracker_removed"
#define ui_team_finder "CENTER,CENTER"
