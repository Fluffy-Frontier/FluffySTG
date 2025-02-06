/datum/supply_order
	var/dep_name = ""

/datum/supply_order/New()
	. = ..()
	if(department_destination)
		src.dep_name = check_department(department_destination)

/datum/supply_order/proc/check_department(area_destination)
	for(var/datum/job_department/department in SSjob.joinable_departments)
		var/list/destinations = department.department_delivery_areas
		if(area_destination in destinations)
			return department.department_name
	return "Unknown Department"

/datum/deleted_order
	var/name
	var/id
	var/orderer
	var/orderer_rank
	var/paid_by
	var/cancel_reason
	var/canceller
	var/canceller_rank

/datum/deleted_order/New(
	name,
	id,
	orderer,
	orderer_rank,
	paid_by,
	cancel_reason,
	canceller,
	canceller_rank,
)
	src.name = name
	src.id = id
	src.orderer = orderer
	src.orderer_rank = orderer_rank
	src.paid_by = paid_by
	src.cancel_reason = cancel_reason
	src.canceller = canceller
	src.canceller_rank = canceller_rank
