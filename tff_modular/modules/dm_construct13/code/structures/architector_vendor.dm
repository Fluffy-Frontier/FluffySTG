/obj/machinery/vending/tool/super
	name = "You (best) tool"
	desc = "A architector tool for free!"
	max_integrity = 99999
	products = list(
		/obj/item/physic_manipulation_tool/advanced = 999,
		/obj/item/phystool = 999,
		/obj/item/clothing/glasses/debug/architector_glasses = 999
	)
	default_price = PAYCHECK_ZERO
	resistance_flags = INDESTRUCTIBLE

/obj/machinery/vending/tool/super/screwdriver_act(mob/living/user, obj/item/attack_item)
	return FALSE
