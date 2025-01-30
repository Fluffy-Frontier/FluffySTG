// Модульный оверрайд, чтобы отключить возможность взлома МУЛЬТИТУЛОМ для внешней консоли
/obj/item/circuitboard/computer/cargo/request/multitool_act(mob/living/user)
	return TRUE
