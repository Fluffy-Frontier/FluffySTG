// Антаг датум
/datum/antagonist/devil
	name = "\improper The Soul Merchant"
	roundend_category = "The Soul Merchants"
	show_in_roundend = TRUE
	show_in_antagpanel = TRUE
	show_to_ghosts = TRUE
	antagpanel_category = "Hell"
	// how much souls we collected?
	var/list/souls_owned = list()
	var/souls = 0

/datum/antagonist/devil/on_gain()
	. = ..()
	give_items()

/datum/antagonist/devil/proc/add_soul(datum/antagonist/devil/soul_merchant, mob/living/soul)
	if(soul in souls_owned)
		return
	to_chat(soul_merchant, span_cult_italic("The contract has been signed by [soul]."))
	LAZYADD(souls_owned, soul)
	souls += 1
	log_admin("[soul.name] signed the devil's contract at [soul.loc]")

/datum/antagonist/devil/proc/give_items()
	var/mob/living/carbon/devil = owner.current
	if(!istype(devil))
		return
	. += devil_item_give(/obj/item/devil/pitchfork, devil)
	give_scroll(devil)

/proc/devil_item_give(obj/item/item_path, mob/living/carbon/human/mob)
	var/obj/item = new item_path(mob)
	var/where = mob.equip_conspicuous_item(item)
	if(!where)
		to_chat(mob, span_userdanger("Unfortunately, you weren't able to get [item]. This is very bad and you should adminhelp immediately (press F1)."))
		return FALSE

	to_chat(mob, span_danger("You have [item] in your [where]."))
	if(where == "backpack")
		mob.back.atom_storage?.show_contents(mob)
	var/datum/action/cooldown/spell/summonitem/devil/ayy_summon = new(mob.mind || mob)
	ayy_summon.mark_item(item)
	ayy_summon.Grant(mob)
	return TRUE

/datum/antagonist/devil/proc/give_scroll(mob/living/carbon/human/mob)
	var/obj/item/devil/contract/item = new (mob)
	var/where = mob.equip_conspicuous_item(item)
	if(!where)
		to_chat(mob, span_userdanger("Unfortunately, you weren't able to get [item]. This is very bad and you should adminhelp immediately (press F1)."))
		return FALSE

	to_chat(mob, span_danger("You have [item] in your [where]."))
	if(where == "backpack")
		mob.back.atom_storage?.show_contents(mob)
	var/datum/action/cooldown/spell/summonitem/devil/ayy_summon = new(mob.mind || mob)
	ayy_summon.mark_item(item)
	ayy_summon.Grant(mob)
	item.current_owner = mob
	return TRUE
