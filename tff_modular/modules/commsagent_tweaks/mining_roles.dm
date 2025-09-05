/obj/effect/mob_spawn/ghost_role/human/lavaland_syndicate/comms
	loadout_enabled = TRUE
	quirks_enabled = TRUE
	random_appearance = FALSE

/obj/effect/mob_spawn/ghost_role/human/lavaland_syndicate/comms/special(mob/living/new_spawn)
	. = ..()
	new_spawn.grant_language(/datum/language/codespeak, source = LANGUAGE_SPAWNER)

/obj/effect/mob_spawn/ghost_role/human/lavaland_syndicate/comms/spacefix
	you_are_text = "You are a syndicate agent, assigned to a small listening post station situated near your hated enemy's top secret research facility: Space Station 13."
	flavour_text = "Monitor enemy activity as best you can, and try to keep a low profile. Use the communication equipment to provide support to any field agents, and sow disinformation to throw Nanotrasen off your trail. Do not let the base fall into enemy hands!"
	important_text = "DO NOT abandon the base."
	outfit = /datum/outfit/lavaland_syndicate/comms/space
	loadout_enabled = TRUE
	quirks_enabled = TRUE
	random_appearance = FALSE
	//No 85% chance to spawn a simplemob (which is just unneeded for a rare ruin) - so instead of butchering the original sleeper, we change this one

/obj/item/radio/headset/syndicate/alt/synd_and_dyne
	keyslot2 = /obj/item/encryptionkey/headset_syndicate/interdyne

/datum/outfit/lavaland_syndicate/comms
	uniform = /obj/item/clothing/under/syndicate
	ears = /obj/item/radio/headset/syndicate/alt/synd_and_dyne

/datum/outfit/lavaland_syndicate/comms/space
	mask = /obj/item/clothing/mask/chameleon
	ears = /obj/item/radio/headset/syndicate/alt/synd_and_dyne
