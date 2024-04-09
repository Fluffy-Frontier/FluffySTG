/*
// May I be cursed, but I am to lazy to copypast atom/allowed() code now
/datum/computer_file/program/proc/allowed(mob/accessor)
    var/list/tmp_req_access = computer.req_access
    var/list/tmp_req_one_access = computer.req_one_access
    computer.req_access = null
    computer.req_one_access = run_access
    . = computer.allowed(accessor)
    computer.req_access = tmp_req_access
    computer.req_one_access = tmp_req_one_access
*/

/datum/computer_file/program/proc/can_run_Adjacent(mob/accessor, loud, access_to_check, downloading, list/access)
    // TODO: atom/allowed() handles syndie borgs. We - not.
    if (can_run(accessor, loud, access_to_check, downloading, access))
        return TRUE

    // atom/allowed() copycode
    var/obj/item/active_item = accessor.get_active_held_item()
    var/obj/item/inactive_item = accessor.get_inactive_held_item()
    if((active_item && can_run(accessor, loud, access_to_check, downloading, active_item?.GetAccess())) || (inactive_item && can_run(accessor, loud, access_to_check, downloading, inactive_item?.GetAccess())))
        return TRUE
    else if(ishuman(accessor))
        var/mob/living/carbon/human/human_accessor = accessor
        if(can_run(accessor, loud, access_to_check, downloading, human_accessor.wear_id?.GetAccess()))
            return TRUE
    else if(isanimal(accessor))
        var/mob/living/simple_animal/animal = accessor
        if(can_run(accessor, loud, access_to_check, downloading, animal.access_card?.GetAccess()))
            return TRUE
    else if(isbrain(accessor))
        var/obj/item/mmi/brain_mmi = get(accessor.loc, /obj/item/mmi)
        if(brain_mmi && ismecha(brain_mmi.loc))
            var/obj/vehicle/sealed/mecha/big_stompy_robot = brain_mmi.loc
            return can_run(accessor, loud, access_to_check, downloading, big_stompy_robot.accesses)
    return FALSE
