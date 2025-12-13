
/datum/bloodsucker_clan/brujah
	name = CLAN_BRUJAH
	description = "The Brujah Clan has proven to be the strongest in melee combat, boasting a powerful punch. \n\
		They also appear to be more calm than the others and can enter frenzy anytime, entering their 'frenzies' dont seem affects much. \n\
		Be wary, as they are fearsome warriors, rebels and anarchists. \n\
		The Favorite Ghoul gains a massive increase in brute damage from punching."
	join_icon_state = "base"
	join_description = "You deal massive damage with your fists, and also gain the ability to enter Frenzy."
	frenzy_stamina_mod = 0.2
	var/datum/action/cooldown/bloodsucker/enter_frenzy/ability = new

/datum/bloodsucker_clan/brujah/New(datum/antagonist/bloodsucker/owner_datum)
	. = ..()
	var/mob/living/carbon/human/carbon_owner = bloodsuckerdatum.owner.current
	var/obj/item/bodypart/left_arm = carbon_owner.get_bodypart(BODY_ZONE_L_ARM)
	var/obj/item/bodypart/right_arm = carbon_owner.get_bodypart(BODY_ZONE_R_ARM)
	left_arm.unarmed_damage_low += 15
	left_arm.unarmed_damage_high += 15
	right_arm.unarmed_damage_low += 15
	right_arm.unarmed_damage_high += 15
	ability.Grant(carbon_owner)

/datum/bloodsucker_clan/brujah/Destroy(force)
	. = ..()
	var/mob/living/carbon/human/carbon_owner = bloodsuckerdatum.owner.current
	var/obj/item/bodypart/left_arm = carbon_owner.get_bodypart(BODY_ZONE_L_ARM)
	var/obj/item/bodypart/right_arm = carbon_owner.get_bodypart(BODY_ZONE_R_ARM)
	left_arm.unarmed_damage_low -= 15
	left_arm.unarmed_damage_high -= 15
	right_arm.unarmed_damage_low -= 15
	right_arm.unarmed_damage_high -= 15
	ability.Remove(carbon_owner)

/datum/bloodsucker_clan/brujah/favorite_ghoul_gain(datum/antagonist/bloodsucker/source, datum/antagonist/ghoul/ghouldatum)
	. = ..()
	var/mob/living/carbon/human/thing = ghouldatum
	var/obj/item/bodypart/left_arm = thing.get_bodypart(BODY_ZONE_L_ARM)
	var/obj/item/bodypart/right_arm = thing.get_bodypart(BODY_ZONE_R_ARM)
	left_arm.unarmed_damage_low += 15
	left_arm.unarmed_damage_high += 15
	right_arm.unarmed_damage_low += 15
	right_arm.unarmed_damage_high += 15
	ability.Grant(thing)

/datum/bloodsucker_clan/brujah/favorite_ghoul_loss(datum/antagonist/bloodsucker/source, datum/antagonist/ghoul/ghouldatum)
	. = ..()
	var/mob/living/carbon/human/thing = ghouldatum
	var/obj/item/bodypart/left_arm = thing.get_bodypart(BODY_ZONE_L_ARM)
	var/obj/item/bodypart/right_arm = thing.get_bodypart(BODY_ZONE_R_ARM)
	left_arm.unarmed_damage_low -= 15
	left_arm.unarmed_damage_high -= 15
	right_arm.unarmed_damage_low -= 15
	right_arm.unarmed_damage_high -= 15
	ability.Remove(thing)
