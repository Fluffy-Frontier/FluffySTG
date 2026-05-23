/datum/action/cooldown/spell/touch/psionic/electrocute
	name = "Psionic Electrocute"
	desc = "Administer a painful amount of psionic shock to the nervous system of a foe in melee range, causing burn and agony damage."
	button_icon_state = "tech_shockaura"
	cooldown_time = 20 SECONDS
	point_cost = 2
	mana_cost = 10
	psionic_level = 2
	hand_path = /obj/item/melee/touch_attack/psionic/chain_lighting
	locked = FALSE
	category = "Tier 2"
	channel_time = 1 SECONDS

/datum/action/cooldown/spell/touch/psionic/electrocute/cast_on_hand_hit(obj/item/melee/touch_attack/hand, atom/victim, mob/living/carbon/caster)
	. = ..()
	if(ishuman(victim))
		var/mob/living/carbon/human/human_living = victim
		human_living.adjust_fire_loss(20)
		human_living.electrocute_act(10, owner, jitter_time = 2 SECONDS, stutter_time = 2 SECONDS, stun_duration = 2 SECONDS)
		return TRUE
	else
		return FALSE
