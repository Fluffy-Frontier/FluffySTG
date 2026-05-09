/datum/species/synthetic/get_scream_sound(mob/living/carbon/human/synthetic)
	return 'modular_nova/modules/emotes/sound/voice/scream_silicon.ogg'

/datum/species/android/get_scream_sound(mob/living/carbon/human/android)
	return 'modular_nova/modules/emotes/sound/voice/scream_silicon.ogg'

/datum/species/lizard/get_scream_sound(mob/living/carbon/human/lizard)
	if(lizard.health < 50)
		if(lizard.gender == MALE)
			return pick(male_agony)
		return pick(female_agony)
	return pick(
		'modular_nova/modules/emotes/sound/voice/scream_lizard.ogg',
		'sound/mobs/humanoids/lizard/lizard_scream_1.ogg',
		'sound/mobs/humanoids/lizard/lizard_scream_2.ogg',
		'sound/mobs/humanoids/lizard/lizard_scream_3.ogg',
	)

/datum/species/skeleton/get_scream_sound(mob/living/carbon/human/skeleton)
	return 'modular_nova/modules/emotes/sound/voice/scream_skeleton.ogg'

/datum/species/fly/get_scream_sound(mob/living/carbon/human/fly)
	return 'sound/mobs/humanoids/moth/scream_moth.ogg'

/datum/species/moth/get_scream_sound(mob/living/carbon/human/moth)
	if(moth.health < 50)
		if(moth.gender == MALE)
			return pick(male_agony)
		return pick(female_agony)
	return 'sound/mobs/humanoids/moth/scream_moth.ogg'

/datum/species/insect/get_scream_sound(mob/living/carbon/human/insect)
	if(insect.health < 50)
		if(insect.gender == MALE)
			return pick(male_agony)
		return pick(female_agony)
	return 'sound/mobs/humanoids/moth/scream_moth.ogg'

/datum/species/jelly/get_scream_sound(mob/living/carbon/human/jelly)
	return 'modular_nova/modules/emotes/sound/emotes/jelly_scream.ogg'

/datum/species/vox/get_scream_sound(mob/living/carbon/human/vox)
	return 'modular_nova/modules/emotes/sound/emotes/voxscream.ogg'

/datum/species/vox_primalis/get_scream_sound(mob/living/carbon/human/vox_primalis)
	return 'modular_nova/modules/emotes/sound/emotes/voxscream.ogg'

/datum/species/xeno/get_scream_sound(mob/living/carbon/human/xeno)
	return 'sound/mobs/non-humanoids/hiss/hiss6.ogg'

/datum/species/zombie/get_scream_sound(mob/living/carbon/human/teshari)
	return 'modular_nova/modules/emotes/sound/emotes/zombie_scream.ogg'

/datum/species/teshari/get_scream_sound(mob/living/carbon/human/teshari)
	return 'modular_nova/modules/emotes/sound/emotes/raptorscream.ogg'
