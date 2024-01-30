#define CITATION_PAYMENT_PERIOD 10 MINUTES

/datum/crime/citation
	var/payment_timer_id

/datum/crime/citation/proc/create_payment_countdown(target_name)
	if(payment_timer_id || CITATION_PAYMENT_PERIOD <= 0)
		return
	src.payment_timer_id = addtimer(CALLBACK(src, PROC_REF(create_crime_if_unpayed), target_name), CITATION_PAYMENT_PERIOD, TIMER_DELETE_ME)

/datum/crime/citation/proc/create_crime_if_unpayed(target_name)
	var/datum/record/crew/target = find_record(target_name)
	// Already payed or invalidated by Warden or HoS (or no record provided somehow)
	if (!src.valid || src.fine == 0 || !target)
		return
	valid = FALSE

	var/datum/crime/new_crime = new(name = "Просроченный платёж", details = "Просрочена оплата штрафа '[src.name]' от [src.time]", author = "Citation Server")
	target.crimes += new_crime
	target.wanted_status = WANTED_ARREST

	update_matching_security_huds(target.name)

// Integration into main codebase
/datum/crime/citation/alert_owner(mob/sender, atom/source, target_name, message)
	. = ..()
	create_payment_countdown(target_name)

#undef CITATION_PAYMENT_PERIOD
