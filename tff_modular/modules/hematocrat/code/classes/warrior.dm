// Класс воина. Играется от голых рук и отбрасываний. Планируется как танк.

// Броня. Дает сопротивление к ранам и замедлениям.
/datum/action/cooldown/hematocrat/armor
	name = "Armor up"
	desc = "This ability makes your skin a little bit harder, protecting you partially from wounds and slowdowns!"
	button_icon = 'icons/mob/actions/actions_spells.dmi'
	button_icon_state = "splattercasting"
	cooldown_time = 5 SECONDS
	var/active = FALSE
	var/static/list/armor_traits = list(TRAIT_HARDLY_WOUNDED, TRAIT_IGNORESLOWDOWN)

/datum/action/cooldown/hematocrat/armor/Remove(mob/removed_from)
	. = ..()
	if(active)
		var/mob/living/carbon/human/living_owner = removed_from
		living_owner.remove_traits(list(armor_traits))

/datum/action/cooldown/hematocrat/armor/Activate(atom/target)
	. = ..()
	if(active)
		deactivate()
		return FALSE
	var/mob/living/carbon/human/living_owner = owner
	living_owner.balloon_alert(living_owner, "Armor up")
	living_owner.add_traits(list(armor_traits), ACTION_TRAIT)
	active = TRUE
	return TRUE

/datum/action/cooldown/hematocrat/armor/proc/deactivate()
	if(!active)
		return FALSE
	active = FALSE
	var/mob/living/carbon/living_owner = owner
	living_owner.balloon_alert(living_owner, "armor down")
	living_owner.remove_traits(list(armor_traits), ACTION_TRAIT)

// Смэшер. Дает бафф к урону кулаков +15, дает отталкивание на 1 тайл, но забирает возможность пользоваться некоторыми батонами и всем дальним оружием.
/datum/action/cooldown/hematocrat/smasher
	name = "Smasher"
	desc = "Your fists become thicker and stronger, making it a dangerous weapon."
	cooldown_time = 1 SECONDS
	var/active = FALSE
	var/static/list/smasher_traits = list(TRAIT_CHUNKYFINGERS, TRAIT_FIST_MINING)

/datum/action/cooldown/hematocrat/smasher/Remove(mob/removed_from)
	. = ..()
	if(active)
		UnregisterSignal(removed_from, COMSIG_LIVING_UNARMED_ATTACK)
		removed_from.remove_traits(list(smasher_traits), ACTION_TRAIT)

/datum/action/cooldown/hematocrat/smasher/Activate(atom/target)
	. = ..()
	var/mob/living/carbon/living_owner = owner
	if(active)
		UnregisterSignal(living_owner, COMSIG_LIVING_UNARMED_ATTACK)
		living_owner.remove_traits(list(smasher_traits), ACTION_TRAIT)
		active = FALSE
		return FALSE
	RegisterSignal(living_owner, COMSIG_LIVING_UNARMED_ATTACK, PROC_REF(attack_hand))
	living_owner.add_traits(list(smasher_traits), ACTION_TRAIT)
	active = TRUE

/datum/action/cooldown/hematocrat/smasher/proc/attack_hand(mob/living/source, atom/target, proximity, modifiers)
	SIGNAL_HANDLER

	var/mob/living/carbon/human/attacker = source
	var/mob/living/carbon/human/who_attack = target

	if(!isliving(who_attack))
		return

	if(!attacker.combat_mode || !proximity)
		return NONE
	if(!attacker.can_unarmed_attack())
		return COMPONENT_SKIP_ATTACK

	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		var/atom/throw_target = get_edge_target_turf(who_attack, attacker.dir)
		who_attack.throw_at(throw_target, 1, 20, attacker)
		return

	attacker.do_attack_animation(who_attack, ATTACK_EFFECT_SMASH)
	var/atom/throw_target = get_edge_target_turf(who_attack, attacker.dir)
	who_attack.throw_at(throw_target, 1, 20, attacker)
	who_attack.apply_damage(15, attacker.get_attack_type())
