/*
*  Сама кобура.
*/

/obj/item/clothing/accessory/cqd_holster
	name = "CQD holster"
	desc = "CQD model holster made of durable materials and has tactical weapon attachment points. CQD stands for Concealed Quick Draw, this holster model developed for more comfortable weapon carry among authorized personnel."
	icon = 'tff_modular/modules/cqd_holsters/icons/cqd_holster.dmi'
	worn_icon = 'tff_modular/modules/cqd_holsters/icons/cqd_holster_worn.dmi'
	icon_state = "cqd-holster"
	worn_icon_state = null
	above_suit = FALSE
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/clothing/accessory/cqd_holster/Initialize(mapload)
	. = ..()
	create_storage(storage_type = /datum/storage/cqd_holster_storage)

// Тут на всякий случай будет проверка на наличие хранилища у формы, чтобы не сломать ничего.
/obj/item/clothing/accessory/cqd_holster/attach(obj/item/clothing/under/attach_to, mob/living/attacher)
	if(attach_to.atom_storage)
		return FALSE
	. = ..()
	
// Этот прок вызываеться при успешном надевании аксессуара, а также при надевании формы. Его я использую для перехвата разных ситуаций специфичных.
// Например чтобы скрыть внешний спрайтик для набберов и тешари.
/obj/item/clothing/accessory/cqd_holster/on_uniform_equipped(obj/item/clothing/under/U, user)
	. = ..()
	// Если всё нормально - то он будет использовать значение icon_state
	worn_icon_state = null

	if(isteshari(user))
		worn_icon_state = "hidden"
	if(isnabber(user))
		worn_icon_state = "hidden"
	
/obj/item/clothing/accessory/cqd_holster/detach(obj/item/clothing/under/U)
	// А это костыльный обход багули, который я подглядел у кармашка для ручек.
	var/drop_loc = drop_location()
	for(var/atom/movable/held as anything in src)
		held.forceMove(drop_loc)
	return ..()

/*
*  Эстетичная кобура
*/

/obj/item/clothing/accessory/cqd_holster/aesthetic
	name = "aesthetic CQD holster"
	desc = "CQD model holster made of durable materials and has tactical weapon attachment points. CQD stands for Concealed Quick Draw, this holster model developed for more comfortable weapon carry among authorized personnel. This one partly made of leather for aesthetics."
	icon = 'tff_modular/modules/cqd_holsters/icons/cqd_holster_aesthetic.dmi'
	worn_icon = 'tff_modular/modules/cqd_holsters/icons/cqd_holster_worn_aesthetic.dmi'

/*
*  Синдикатовская кобура
*/

/obj/item/clothing/accessory/cqd_holster/syndicate
	name = "blood-red CQD holster"
	desc = "CQD model holster made of durable materials and has tactical weapon attachment points. CQD stands for Concealed Quick Draw, this holster model developed for more comfortable weapon carry among authorized personnel. This one made of much more sophisticated materials and has strange red coloring."
	icon = 'tff_modular/modules/cqd_holsters/icons/cqd_holster_syndicate.dmi'
	worn_icon = 'tff_modular/modules/cqd_holsters/icons/cqd_holster_worn_syndicate.dmi'
