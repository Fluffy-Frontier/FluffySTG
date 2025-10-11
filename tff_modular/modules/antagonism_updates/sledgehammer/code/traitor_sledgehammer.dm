/obj/item/melee/traitor_sledgehammer
    name = "saboteur's sledgehammer"
    desc = "A terrifying sledgehammer designed for traitorous sabotage. Requires both hands to wield effectively."
    icon_state = "gorlex_sledgehammer"
    base_icon_state = "gorlex_sledgehammer"
    icon = 'tff_modular/modules/antagonism_updates/sledgehammer/icon/blunt.dmi'
    worn_icon = 'tff_modular/modules/antagonism_updates/sledgehammer/icon/blunt.dmi'
    lefthand_file = 'tff_modular/modules/antagonism_updates/sledgehammer/icon/blunt_lefthand.dmi'
    righthand_file = 'tff_modular/modules/antagonism_updates/sledgehammer/icon/blunt_righthand.dmi'
    resistance_flags = FIRE_PROOF
    sharpness = NONE
    w_class = WEIGHT_CLASS_BULKY
    slot_flags = ITEM_SLOT_BACK
    force = 0 // Can't attack when not wielded!
    var/force_wielded = 65
    var/armour_penetration_wielded = 60
    var/stamina_damage = 40
    throwforce = 25
    throw_speed = 3
    attack_verb_continuous = list("obliterates", "smashes", "shatters", "crushes")
    attack_verb_simple = list("obliterate", "smash", "shatter", "crush")
    hitsound = list('tff_modular/modules/antagonism_updates/sledgehammer/sound/heavyblunt_hit1.ogg', 'tff_modular/modules/antagonism_updates/sledgehammer/sound/heavyblunt_hit2.ogg', 'tff_modular/modules/antagonism_updates/sledgehammer/sound/heavyblunt_hit3.ogg')
    pickup_sound = 'tff_modular/modules/antagonism_updates/sledgehammer/sound/heavy_pickup.ogg'
    var/last_attack_time = 0
    var/cooldown = 2 SECONDS

/obj/item/melee/traitor_sledgehammer/Initialize(mapload)
    . = ..()
    demolition_mod = 3 // Override the parent value
    AddComponent(/datum/component/two_handed, \
        force_unwielded = 0, \
        force_wielded = force_wielded, \
        ap_unwielded = 0, \
        ap_wielded = armour_penetration_wielded \
    )
    update_icon_state()

/obj/item/melee/traitor_sledgehammer/update_icon_state()
    inhand_icon_state = "[base_icon_state][HAS_TRAIT(src, TRAIT_WIELDED)]"
    return ..()

/obj/item/melee/traitor_sledgehammer/pre_attack(atom/A, mob/living/user, list/modifiers, list/attack_modifiers)
    if(!HAS_TRAIT(src, TRAIT_WIELDED))
        user.balloon_alert(user, "You must be wielding [src] to use it!")
        return TRUE
    if(world.time < last_attack_time + cooldown)
        user.balloon_alert(user, "The sledgehammer is too heavy to swing again so soon!")
        return TRUE
    return ..()

/obj/item/melee/traitor_sledgehammer/melee_attack_chain(mob/user, atom/target, params)
    if(!HAS_TRAIT(src, TRAIT_WIELDED))
        return ..()

    force = force_wielded
    armour_penetration = armour_penetration_wielded
    . = ..()
    force = initial(force)
    armour_penetration = initial(armour_penetration)

/obj/item/melee/traitor_sledgehammer/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
    if(!proximity_flag || !HAS_TRAIT(src, TRAIT_WIELDED))
        return ..()

    // Update last_attack_time for successful melee attacks
    last_attack_time = world.time
    playsound(src, pick(hitsound), 150, TRUE)

    if(isliving(target))
        var/mob/living/living_target = target
        living_target.adjustStaminaLoss(stamina_damage)
        if(living_target.getStaminaLoss() >= 100)
            living_target.Knockdown(3 SECONDS)
            to_chat(user, "<span class='danger'>You knock [living_target] down with the force of your blow!</span>")

    return ..()
