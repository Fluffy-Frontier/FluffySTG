/*
	execution stage datum

	vars
		duration: attempt to exit the stage when this much time has passed after entering it

	contains procs:
		enter:	Called to enter this stage. After a stage is entered, it is added to the entered_stages list on the execution
		safety:	Called whenever the parent execution does a safety check. This can be useful if this stage adds extra safety conditions
		can_advance: called once duration expires, checking if we can advance yet
		exit: called just before we exit this stage and enter the next one

		cancel: Called when the parent execution is interrupted/cancelled/etc. Cancel and complete will never be called in the same execution
		complete: Called when the parent execution successfully finishes all stages and is done

		stop: Called when the parent execution finishes in any circumstance. This will ALWAYS be called, in addition to one of cancel or complete
*/
/datum/execution_stage
	//The component instance we're attached to
	var/datum/component/execution/host

	//How long to remain in this stage before moving to the next one
	var/duration = 1 SECONDS

	//In the case that we fail to advance when our duration ends
	var/retry_time = 1 SECONDS

	var/max_retries = 10

	//If not null, this overrides the range of the execution while active
	var/range = null

/datum/execution_stage/New(var/datum/component/execution/host)
	src.host = host
	.=..()

/datum/execution_stage/Destroy()
	host = null
	.=..()

/datum/execution_stage/proc/enter()
	return TRUE


//Here, do safety checks to see if everything is in order for being able to advance to the next stage. Return true/false appropriately
/datum/execution_stage/proc/can_advance()
	return EXECUTION_CONTINUE


//Here, do safety checks to see if its okay to continue the execution move
/datum/execution_stage/proc/safety()
	return EXECUTION_CONTINUE

//Called when we finish this stage and move to the next one
/datum/execution_stage/proc/exit()
	return TRUE


//Called on this stage when the execution is interrupted. Use this to add consequences of failure
/datum/execution_stage/proc/interrupt()
	return TRUE

//Called on this stage when the execution is completed. NOT when this specific stage finishes, that's exit()
/datum/execution_stage/proc/complete()
	return TRUE

//Called when the execution finishes, by both interrupt and complete. Use this to clean up assets and effects
/datum/execution_stage/proc/stop()
	return TRUE

//Called to make a stage advance early, before its duration is up
/datum/execution_stage/proc/advance()
	host.try_advance_stage()

/*
	A finisher is a special stage which marks the endpoint of an execution move.
	It should typically kill the victim, or at least deal the strongest blow that will be dealt

	When a finisher stage is entered, the execution is considered a success, rewards are distributed,
	and the execution becomes non-interruptible for the remaining stages.

	Any stages after a finisher are basically a victory lap and shouldn't contain too much meaningful effects, just winding down

*/
/datum/execution_stage/finisher


/datum/execution_stage/finisher/enter()
	host.complete()
	.=..()
