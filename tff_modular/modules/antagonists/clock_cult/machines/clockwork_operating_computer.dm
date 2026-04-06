//operating computer that starts with all surgeries excluding a few like necrotic revival
/obj/machinery/computer/operating/clockwork
	name = "Clockwork Operating Computer"
	desc = "A device containing (most) of the surgery secrets of the universe."
	icon_keyboard = "ratvar_key1"
	icon_state = "ratvarcomputer1"
	clockwork = TRUE
	advanced_surgeries = list(
	/datum/surgery/advanced/lobotomy,
	/datum/surgery/advanced/pacify,
	/datum/surgery/advanced/viral_bonding,
	/datum/surgery/advanced/wing_reconstruction,
	/datum/surgery/healing/brute/upgraded/femto,
	/datum/surgery/healing/burn/upgraded/femto,
	/datum/surgery/healing/combo/upgraded/femto,
	/datum/surgery/robot_healing/experimental,
	/datum/surgery/revival
	)
