/obj/machinery/vending/tool/super
	name = "You (best) tool"
	desc = "A architector tool for free!"
	max_integrity = 99999
	products = list(
		/obj/item/physic_manipulation_tool = 9999,
		/obj/item/phystool = 9999,
	)
	default_price = PAYCHECK_ZERO

/obj/machinery/vending/tool/super/screwdriver_act(mob/living/user, obj/item/attack_item)
	return FALSE
