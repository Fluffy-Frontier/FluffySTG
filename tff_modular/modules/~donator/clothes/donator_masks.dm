/obj/item/clothing/mask/gas/syndicate/catcrin
	name = "Tactical Catcrin Gasmask"
	desc = "A mask with a red visor and special filters. It seems to have a kind of cat whiskers on it. In the left corner of the visor are written the initials - AG-003288"
	icon_state = "catcrin"
	icon = 'tff_modular/master_files/icons/donator/obj/clothing/masks.dmi'
	worn_icon = 'tff_modular/master_files/icons/donator/mob/clothing/masks.dmi'
	actions_types = list(/datum/action/item_action/maskhalt)

/datum/action/item_action/maskhalt
	name = "HALT!"

/obj/item/clothing/mask/gas/syndicate/catcrin/verb/maskhalt()
	set category = "Object"
	set name = "HALT!"
	set src in usr
	if(!isliving(usr))
		return
	if(!can_use(usr))
		return

	var/frase
	frase = input("Какую фразу вы хотите сказать через преобразователь в маске?","") as text

	if(frase)
		usr.audible_message("<b>[usr]</b> exclaims, \"<font color='red' size='4'><b>[frase]</b></font>\"")
		switch(rand(0,3))
			if(0)
				playsound(src.loc, 'tff_modular/modules/~donator/sound/catcrin_halt0.ogg', 100, 1)
			if(1)
				playsound(src.loc, 'tff_modular/modules/~donator/sound/catcrin_halt1.ogg', 100, 1)
			if(2)
				playsound(src.loc, 'tff_modular/modules/~donator/sound/catcrin_halt2.ogg', 100, 1)
			if(3)
				playsound(src.loc, 'tff_modular/modules/~donator/sound/catcrin_halt3.ogg', 100, 1)

/obj/item/clothing/mask/gas/syndicate/catcrin/ui_action_click(mob/user, action)
	if(istype(action, /datum/action/item_action/maskhalt))
		maskhalt()
