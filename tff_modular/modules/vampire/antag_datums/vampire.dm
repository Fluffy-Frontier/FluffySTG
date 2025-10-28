#define FORMAT_BLOOD_LEVEL_HUD_MAPTEXT(value) MAPTEXT("<div align='center' valign='middle' style='position:relative; top:0px; left:6px'><font color='#FFDDDD'>[round(value,1)]</font></div>")

/datum/antagonist/vampire
	name = "Vampire"
	show_in_antagpanel = TRUE
	show_name_in_check_antagonists = TRUE
	show_to_ghosts = TRUE
	antagpanel_category = "Bluespace Vampires"
	// trait added when applying antagonist
	var/antagonist_traits = list(TRAIT_VIRUSIMMUNE, TRAIT_NOHUNGER, TRAIT_NOBREATH, TRAIT_RESISTCOLD, TRAIT_RADIMMUNE)
	// how much blood we achieved
	var/general_blood_level = 0
	// how much blood we currently have
	var/current_blood_level = 0
	var/atom/movable/screen/vampire_blood_level/blood_display
	var/datum/vampire_subclass/subclass
	var/datum/action/cooldown/vampire/drain_blood/drinking = new
	var/list/powers = list()
	// abilities given by progression
	var/list/progression = list(
		/datum/action/cooldown/vampire/rejuvenate = 0,
		/datum/action/cooldown/vampire/glare = 0,
		/datum/vampire_passive/night_vision = 100,
		/datum/action/cooldown/vampire/specialize = 150,
		/datum/vampire_passive/thermal_vision = 200,
		/datum/vampire_passive/regen = 250,
		/datum/vampire_passive/xray = 750,
	)

/datum/antagonist/vampire/greet()
	. = ..()
	owner.announce_objectives()
	to_chat(owner.current, span_notice("Warning - the antagonist is in the process of being developed. Please report any bugs to the sillyzhook discord.")) // Don't forget to delete it before the full merge

	to_chat(owner.current, span_danger("I'm a vampire. \
		My life was cursed by a vampire of the highest rank, \
		and since then I have been haunted by an eternal hunger that cannot be satisfied with ordinary food. \
		Only someone else's blood brings me unspeakable pleasure, absorbing the life force of the victims, \
		it temporarily quenches my endless thirst. I hate the one who cursed me and I want revenge, but to achieve my goal, \
		I need to become stronger, because he is strong. The blood of mortals gives me strength, opens up new abilities, and leads me to a cherished goal. \
		It is advisable for me to be secretive, because my curse is a reason for different states to conduct experiments, keep me in eternal imprisonment or kill me."))

/datum/antagonist/vampire/on_gain()
	. = ..()
	create_objectives()

/datum/antagonist/vampire/proc/create_objectives()
	var/datum/objective/collect_blood/collecting_blood = new /datum/objective/collect_blood()
	collecting_blood.vampire = owner
	var/datum/objective/alive = new /datum/objective/survive()
	objectives += alive
	objectives += collect_blood

/datum/antagonist/vampire/apply_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/carbon/vampire = mob_override || owner.current
	vampire.add_traits(antagonist_traits, JOB_TRAIT)
	drinking.Grant(vampire)
	if(vampire.hud_used)
		on_hud_created(vampire)
	else
		RegisterSignal(vampire, COMSIG_MOB_HUD_CREATED, PROC_REF(on_hud_created))
	check_vampire_upgrade()
	vampire.faction += FACTION_VAMPIRE

/datum/antagonist/vampire/remove_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/carbon/vampire = mob_override || owner.current
	vampire.remove_traits(antagonist_traits, JOB_TRAIT)
	remove_all_powers(vampire)
	drinking.Remove(vampire)
	qdel(blood_display)

/datum/antagonist/vampire/proc/remove_all_powers()
	for(var/datum/action/power in powers)
		remove_ability(power)

/datum/antagonist/vampire/proc/remove_ability(path)
	var/mob/living/carbon/vampire = owner.current
	if(path && (path in powers))
		if(istype(path, /datum/action))
			var/datum/action/ability = path
			ability.Remove(vampire)
			qdel(ability)
		if(istype(path, /datum/vampire_passive))
			var/datum/vampire_passive/passive = path
			passive.on_remove(vampire)
			qdel(passive)

	powers -= path
	vampire.update_sight()

/datum/antagonist/vampire/proc/force_add_ability(path)
	if(locate(path) in powers)
		return FALSE
	var/mob/living/carbon/human/vampire = owner.current
	var/spell = new path(vampire)
	powers += spell
	if(istype(spell, /datum/action))
		var/datum/action/ability = spell
		ability.Grant(vampire)
	if(istype(spell, /datum/vampire_passive))
		var/datum/vampire_passive/passive = spell
		passive.owner = vampire
		passive.on_apply(vampire)

/datum/antagonist/vampire/proc/check_vampire_upgrade()
	for(var/ptype as anything in progression)
		var/level = progression[ptype]
		if(general_blood_level >= level)
			force_add_ability(ptype)

	if(!subclass)
		return
	subclass.add_subclass_ability(owner.current)

/datum/antagonist/vampire/proc/adjust_blood(amount, general = TRUE)
	if(general)
		general_blood_level += amount
	current_blood_level += amount
	check_vampire_upgrade()

/datum/antagonist/vampire/proc/on_hud_created(mob/source)
	SIGNAL_HANDLER
	var/datum/hud/blood_hud = source.hud_used
	blood_display = new(null, blood_hud)
	blood_hud.infodisplay += blood_display
	blood_hud.show_hud(blood_hud.hud_version)

/atom/movable/screen/vampire_blood_level
	name = "Blood Level"
	icon_state = "blood_display"
	screen_loc = ui_blooddisplay

/atom/movable/screen/vampire_blood_level/Initialize(mapload, datum/hud/hud_owner)
	. = ..()
	if(isnull(hud_owner))
		return INITIALIZE_HINT_QDEL
	RegisterSignal(hud_owner.mymob, COMSIG_LIVING_LIFE, PROC_REF(on_mob_life))

/atom/movable/screen/vampire_blood_level/proc/on_mob_life(mob/living/source, seconds_per_tick, times_fired)
	SIGNAL_HANDLER

	if(!isliving(source))
		return
	var/datum/antagonist/vampire/drinker = source.mind.has_antag_datum(/datum/antagonist/vampire)
	maptext = FORMAT_BLOOD_LEVEL_HUD_MAPTEXT(drinker.current_blood_level)

/datum/objective/collect_blood
	objective_name = "Collect Blood"
	explanation_text = "Collect 1000 units of blood."
	var/mob/living/carbon/human/vampire = null

/datum/objective/collect_blood/check_completion()
	var/datum/antagonist/vampire/vamp = vampire.mind?.has_antag_datum(/datum/antagonist/vampire)
	if(vamp.general_blood_level >= 1000)
		return TRUE
	return FALSE
