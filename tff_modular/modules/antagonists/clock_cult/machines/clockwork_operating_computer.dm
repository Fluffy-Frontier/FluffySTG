//operating computer that starts with all surgeries excluding a few like necrotic revival
/obj/machinery/computer/operating/clockwork
	name = "Clockwork Operating Computer"
	desc = "A device containing (most) of the surgery secrets of the universe."
	icon_keyboard = "ratvar_key1"
	icon_state = "ratvarcomputer1"
	clockwork = TRUE

/obj/machinery/computer/operating/clockwork/screwdriver_act(mob/living/user, obj/item/I)
	return FALSE

/obj/machinery/computer/operating/clockwork/screwdriver_act_secondary(mob/living/user, obj/item/tool)
	return FALSE
