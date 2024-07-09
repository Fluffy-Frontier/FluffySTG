///Spike traps! Even with a random!
/obj/structure/punji_sticks/spikes_soft
	name = "Anctient spikes"
	icon_state = "woodspike"
	max_integrity = 9

/obj/structure/trap/damage/spikes_soft
	name = "Anctient runic spikes"
	desc = "A simple trap carved with some menacing symbols."
	icon = 'icons/obj/service/hydroponics/equipment.dmi'
	icon_state = "woodspike"
	color = "#77FF77"
	light_color = "#77FF77"
	alpha = 180
	max_integrity = 9

/obj/structure/trap/fire/spikes_soft
	name = "Anctient runic spikes"
	desc = "A simple trap carved with some menacing symbols."
	icon = 'icons/obj/service/hydroponics/equipment.dmi'
	icon_state = "woodspike"
	color = "#FF1111"
	light_color = "#FF1111"
	alpha = 180
	max_integrity = 9

/obj/structure/trap/cult/spikes_soft
	name = "Anctient runic spikes"
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
	light_range = 3
	light_system = 2
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK|ITEM_SLOT_BELT
	block_sound = 'sound/weapons/parry.ogg'
	item_flags = NO_BLOOD_ON_ITEM | SLOWS_WHILE_IN_HAND | IMMUTABLE_SLOW
	resistance_flags = INDESTRUCTIBLE
	sharpness = SHARP_EDGED
	slowdown = 1.32
	drag_slowdown = 1.32

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
			force += 78
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
