//Movable signals
///When someone talks into a radio
#define COMSIG_MOVABLE_RADIO_TALK_INTO "movable_radio_talk_into"				//from radio talk_into(): (obj/item/radio/radio, message, channel, list/spans, datum/language/language, direct)

//Mob signals
///Resting position for living mob updated
#define COMSIG_LIVING_UPDATED_RESTING "living_updated_resting" //from base of (/mob/living/proc/update_resting): (resting)
///Horror form bombastic flag
#define COMSIG_HORRORFORM_EXPLODE "horrorform_explode"
///Fired in combat_indicator.dm, used for syncing CI between mech and pilot
#define COMSIG_MOB_CI_TOGGLED "mob_ci_toggled"
/// When a hostile simple mob loses it's target.
#define COMSIG_HOSTILE_MOB_LOST_TARGET "hostile_mob_lost_target"
///When a client is given direct control of a mob via [/datum/admin_verb/cmd_give_direct_control()].
#define COMSIG_MOB_GIVE_DIRECT_CONTROL "mob_give_direct_control"

//Gun signals
///When a gun is switched to automatic fire mode
#define COMSIG_GUN_AUTOFIRE_SELECTED "gun_autofire_selected"
///When a gun is switched off of automatic fire mode
#define COMSIG_GUN_AUTOFIRE_DESELECTED "gun_autofire_deselected"
///The gun needs to update the gun hud!
#define COMSIG_UPDATE_AMMO_HUD "update_ammo_hud"

/// Used by /obj/item/melee/breaching_hammer
#define COMSIG_BREACHING "breaching_signal_woop_woop"
///The gun has jammed.
#define COMSIG_GUN_JAMMED "gun_jammed"

//Mutant stuff
///When a mutant is cured of the virus
#define COMSIG_MUTANT_CURED "mutant_cured"

// Power signals
/// Sent when an obj/item calls item_use_power: (use_amount, user, check_only)
#define COMSIG_ITEM_POWER_USE "item_use_power"
	#define NO_COMPONENT NONE
	#define COMPONENT_POWER_SUCCESS (1<<0)
	#define COMPONENT_NO_CELL  (1<<1)
	#define COMPONENT_NO_CHARGE (1<<2)

/// Sent when supermatter begins its delam countdown/when the suppression system is triggered: (var/trigger_reason)
#define COMSIG_MAIN_SM_DELAMINATING "delam_time"

// Health signals
/// /mob/living/proc/updatehealth()
#define COMSIG_MOB_RUN_ARMOR "mob_run_armor"
///from base of /turf/handle_fall(): (mob/faller)
#define COMSIG_TURF_MOB_FALL "turf_mob_fall"
///from base of /obj/effect/abstract/liquid_turf/Initialize() (/obj/effect/abstract/liquid_turf/liquids)
#define COMSIG_TURF_LIQUIDS_CREATION "turf_liquids_creation"
/// From base of /turf/proc/liquids_change(new_state)
#define COMSIG_TURF_LIQUIDS_CHANGE "turf_liquids_change"

/// listens to wet_stacks, if wetting a mob above 10 stacks it will signal the akula race trait to apply its buffs and nerfs
#define COMSIG_MOB_TRIGGER_WET_SKIN "mob_trigger_wet_skin"

//when someone casts their fishing rod
#define COMSIG_START_FISHING "start_fishing"
//when someone pulls back their fishing rod
#define COMSIG_FINISH_FISHING "finish_fishing"

/// From /obj/item/organ/stomach/after_eat(atom/edible)
#define COMSIG_STOMACH_AFTER_EAT "stomach_after_eat"

/// Used to trigger a signal to custom tongue quirk's proc.
#define COMSIG_SET_SAY_MODIFIERS "set_say_modifiers"

/// For when a Hemophage's pulsating tumor gets added to their body.
#define COMSIG_PULSATING_TUMOR_ADDED "pulsating_tumor_added"
/// For when a Hemophage's pulsating tumor gets removed from their body.
#define COMSIG_PULSATING_TUMOR_REMOVED "pulsating_tumor_removed"

/// when someone attempts to evolve through the rune
#define COMSIG_RUNE_EVOLUTION "rune_evolution"

/// To chambered round on gun's `process_fire()`: (list/iff_factions)
#define COMSIG_CHAMBERED_BULLET_FIRE "chambered_bullet_fire"

/// /datum/component/clockwork_trap signals: ()
#define COMSIG_CLOCKWORK_SIGNAL_RECEIVED "clock_received"

/// Called when a clock cultist uses a clockwork slab: (obj/item/clockwork/clockwork_slab/slab)
#define COMSIG_CLOCKWORK_SLAB_USED "clockwork_slab_used"

/// Engineering Override Access manual toggle
#define COMSIG_GLOB_FORCE_ENG_OVERRIDE "force_engineering_override"

/// Whenever we need to check if a mob is currently inside of soulcatcher.
#define COMSIG_SOULCATCHER_CHECK_SOUL "soulcatcher_check_soul"

/// Whenever we need to get the soul of the mob inside of the soulcatcher.
#define COMSIG_SOULCATCHER_SCAN_BODY "soulcatcher_scan_body"

// CORRUPTION SIGNALS

/// From /obj/structure/fleshmind/structure/proc/activate_ability() (src)
#define COMSIG_CORRUPTION_STRUCTURE_ABILITY_TRIGGERED "corruption_structure_ability_triggered"

/// From /mob/living/simple_animal/hostile/fleshmind/phaser/proc/phase_move_to(atom/target, nearby = FALSE)
#define COMSIG_PHASER_PHASE_MOVE "phaser_phase_move"
/// from /mob/living/simple_animal/hostile/fleshmind/phaser/proc/enter_nearby_closet()
#define COMSIG_PHASER_ENTER_CLOSET "phaser_enter_closet"

/// from /obj/structure/fleshmind/structure/core/proc/rally_troops()
#define COMSIG_FLESHMIND_CORE_RALLY "fleshmind_core_rally"

/// Whenever a baton successfully executes its nonlethal attack. WARNING HORRIBLE FUCKING CODE THIS IS ASS AAAAAAAAAAAAH
#define COMSIG_PRE_BATON_FINALIZE_ATTACK "pre_baton_finalize_attack"

/// Signal sent when a mob tries to de-prone
#define COMSIG_MOVABLE_REMOVE_PRONE_STATE "living_remove_prone_state"

/// Whenever the round ends
#define COMSIG_TICKER_ROUND_ENDED "ticker_round_ended"

///from base of atom/fire_act(): (exposed_temperature, exposed_volume)
#define COMSIG_ATOM_PRE_FIRE_ACT "atom_fire_act"

///from base of /datum/preference_middleware/jobs/proc/set_job_title() and /datum/preference_middleware/jobs/proc/set_job_preference: ()
#define COMSIG_JOB_PREF_UPDATED "job_pref_updated"
