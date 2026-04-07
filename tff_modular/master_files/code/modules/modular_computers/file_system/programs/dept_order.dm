/datum/computer_file/program/department_order/can_see_pack(datum/supply_pack/to_check)
    . = ..()
    if(to_check.not_dept_order)
        return FALSE
