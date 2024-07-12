///Spike traps! Even with a random!
/obj/structure/punji_sticks/spikes_soft
	name = "Ancient spikes"
	icon_state = "woodspike"
	max_integrity = 9

/obj/structure/trap/damage/spikes_soft
	name = "Ancient runic spikes"
	desc = "A simple trap carved with some menacing symbols."
	icon = 'icons/obj/service/hydroponics/equipment.dmi'
	icon_state = "woodspike"
	color = "#77FF77"
	light_color = "#77FF77"
	alpha = 180
	max_integrity = 9

/obj/structure/trap/fire/spikes_soft
	name = "Ancient runic spikes"
	desc = "A simple trap carved with some menacing symbols."
	icon = 'icons/obj/service/hydroponics/equipment.dmi'
	icon_state = "woodspike"
	color = "#FF1111"
	light_color = "#FF1111"
	alpha = 180
	max_integrity = 9

/obj/structure/trap/cult/spikes_soft
	name = "Ancient runic spikes"
	desc = "A simple trap carved with some menacing symbols."
	icon = 'icons/obj/service/hydroponics/equipment.dmi'
	icon_state = "woodspike"
	color = "#FF9911"
	light_color = "#FF9911"
	alpha = 180
	max_integrity = 9

/obj/effect/spawner/random/structure/spikes
	name = "Random spike traps spawner"
	icon = 'icons/obj/service/hydroponics/equipment.dmi'
	icon_state = "woodspike"
	spawn_loot_chance = 50
	loot = list(
		/obj/structure/punji_sticks/spikes_soft = 50,
		/obj/structure/trap/fire/spikes_soft = 35,
		/obj/structure/trap/damage/spikes_soft = 20,
		/obj/structure/trap/cult/spikes_soft = 5,
	)


/obj/structure/ore_vein/stone/longregen
	name = "large rocks"
	desc = "Various types of high quality stone that could probably make a good construction material if dug up and refined."
	regeneration_time = 24 MINUTES
	mining_time = 18 SECONDS

/obj/structure/ore_vein/iron/longregen
	name = "rusted rocks"
	desc = "The rusty brown color on these rocks gives away the fact they are full of iron!"
	icon_state = "iron1"
	base_icon_state = "iron"
	ore_descriptor = "iron"
	ore_type = /obj/item/stack/ore/iron
	regeneration_time = 24 MINUTES
	mining_time = 18 SECONDS

/obj/structure/ore_vein/silver/longregen
	name = "silvery-blue rocks"
	desc = "These rocks have the giveaway blued-silver look of, well, raw silver."
	icon_state = "silver1"
	base_icon_state = "silver"
	ore_descriptor = "silver"
	ore_type = /obj/item/stack/ore/silver
	regeneration_time = 24 MINUTES
	mining_time = 18 SECONDS

/obj/structure/ore_vein/gold/longregen
	name = "gold streaked rocks"
	desc = "Fairly normal looking rocks... aside from the streaks of shining gold running through some of them!."
	icon_state = "gold1"
	base_icon_state = "gold"
	ore_descriptor = "gold"
	ore_type = /obj/item/stack/ore/gold
	regeneration_time = 24 MINUTES
	mining_time = 18 SECONDS

/obj/structure/ore_vein/plasma/longregen
	name = "plasma rich rocks"
	desc = "Rocks with unrefined plasma visible on the outside of several... Do be careful with open flames near this."
	icon_state = "plasma1"
	base_icon_state = "plasma"
	ore_descriptor = "plasma"
	ore_type = /obj/item/stack/ore/plasma
	regeneration_time = 24 MINUTES
	mining_time = 18 SECONDS

/obj/structure/ore_vein/diamond/longregen
	name = "diamond studded rocks"
	desc = "While nowhere near as rare as you'd think, the diamonds studding these rocks are still both useful and valuable."
	icon_state = "diamond1"
	base_icon_state = "diamond"
	ore_descriptor = "diamond"
	ore_type = /obj/item/stack/ore/diamond
	regeneration_time = 24 MINUTES
	mining_time = 18 SECONDS

/obj/effect/spawner/random/structure/orevein_longregen
	name = "Random ore vein spawner"
	desc = "Random ore with 24min to regen"
	icon = 'modular_nova/modules/stone/icons/ore.dmi'
	icon_state = "diamond1"
	base_icon_state = "diamond"
	spawn_loot_chance = 50
	loot = list(
		/obj/structure/ore_vein/stone/longregen = 50,
		/obj/structure/ore_vein/iron/longregen = 40,
		/obj/structure/ore_vein/silver/longregen = 30,
		/obj/structure/ore_vein/gold/longregen = 20,
		/obj/structure/ore_vein/plasma/longregen = 10,
		/obj/structure/ore_vein/diamond/longregen = 5,
	)

///Soooord!
/obj/item/melee/frozen_moonlight
	name = "Frozen Moonlight"
	desc = "A legendary sword of yore, still imbued with astral magic after all these years."

	icon = 'icons/obj/weapons/sword.dmi'
	icon_state = "swordon"
	inhand_icon_state = "swordon"
	worn_icon_state = "swordon"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	color = "#7777FF"
	light_color = "#7777FF"
	light_range = 4
	light_system = 2
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK|ITEM_SLOT_BELT
	block_sound = 'sound/weapons/parry.ogg'
	item_flags = NO_BLOOD_ON_ITEM | SLOWS_WHILE_IN_HAND | IMMUTABLE_SLOW
	resistance_flags = INDESTRUCTIBLE
	sharpness = SHARP_EDGED
	slowdown = 1.24
	drag_slowdown = 1.24

	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")

	attack_speed = 18
	force = 42
	throwforce = 18
	wound_bonus = 24
	bare_wound_bonus = 16
	armour_penetration = 16
	block_chance = 18

	var/static/list/lunar_nemesis_factions = list("mining", "boss")
	var/roll_stamcost = 7
	var/roll_range = 3

/obj/item/melee/frozen_moonlight/attack(mob/living/target, mob/living/carbon/human/user)
	var/lunar_is_nemesis_faction = FALSE
	for(var/found_faction in target.faction)
		if(found_faction in lunar_nemesis_factions)
			lunar_is_nemesis_faction = TRUE
			force += 98
			break
	. = ..()
	if(lunar_is_nemesis_faction)
		force -= 78


/obj/item/melee/frozen_moonlight/examine()
	. = list("<span style='color:#9988FF;'>This is the [icon2html(src, usr)] <b>Frozen Moonlight</b>.\n A legendary runic sword of yore. \n It's still imbued with astral magic after all these years. \n <b>Fight for E'luna!</b>")
	. += "</span>"
	. += span_warning(" Forged to face demonic legions. Protects agile warriors.")
	return .

/obj/item/melee/frozen_moonlight/ranged_interact_with_atom_secondary(atom/interacting_with, mob/living/user, list/modifiers)
	if(user.IsImmobilized())
		return NONE
	var/turf/where_to = get_turf(interacting_with)
	user.apply_damage(damage = roll_stamcost, damagetype = STAMINA)
	user.Immobilize(0.1 SECONDS) // you dont get to adjust your roll
	user.throw_at(where_to, range = roll_range, speed = 1, force = MOVE_FORCE_NORMAL)
	user.apply_status_effect(/datum/status_effect/dodgeroll_iframes)
	playsound(user, SFX_BODYFALL, 40, TRUE)
	playsound(user, SFX_RUSTLE, 40, TRUE)
	return ITEM_INTERACT_SUCCESS

/datum/status_effect/dodgeroll_iframes
	id = "dodgeroll_dodging"
	alert_type = null
	status_type = STATUS_EFFECT_REFRESH
	duration = 1.5 SECONDS

/datum/status_effect/dodgeroll_iframes/on_apply()
	RegisterSignal(owner, COMSIG_LIVING_CHECK_BLOCK, PROC_REF(whiffa))
	return TRUE

/datum/status_effect/dodgeroll_iframes/on_remove()
	UnregisterSignal(owner, COMSIG_LIVING_CHECK_BLOCK)
	return ..()

/datum/status_effect/dodgeroll_iframes/proc/whiffa()
	SIGNAL_HANDLER
	owner.balloon_alert_to_viewers("Miss!")
	playsound(src, 'sound/weapons/thudswoosh.ogg', 44, TRUE, -1)
	return SUCCESSFUL_BLOCK
