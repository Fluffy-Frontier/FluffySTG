/obj/item/book/granter/action/spell/shapefox
	granted_action = /datum/action/cooldown/spell/shapeshift/fox
	action_name = "Fox Form"
	icon_state ="bookcharge"
	desc = "This book contains some elder kitsune knowledge."
	remarks = list(
		"Wek",
		"Bak"
	)

/obj/item/book/granter/action/spell/shapefox/recoil(mob/living/user)
	. = ..()
	to_chat(user,span_warning("[src] suddenly vanishes!"))
	qdel(src)
