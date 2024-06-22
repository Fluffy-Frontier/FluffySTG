/proc/generate_code_phrase(return_list=FALSE)//Proc is used for phrase and response in master_controller.dm
	if(!return_list)
		. = ""
	else
		. = list()

	var/words = pick(//How many words there will be. Minimum of two. 2, 4 and 5 have a lesser chance of being selected. 3 is the most likely.
		50; 2,
		200; 3,
		50; 4,
		25; 5
	)

	var/list/safety = list(1,2,3)//Tells the proc which options to remove later on.

	var/nouns = strings(RUS_CODEWORDS, "nouns")
	var/objects = strings(RUS_CODEWORDS, "objects")
	var/adjectives = strings(RUS_CODEWORDS, "adjectives")
	var/threats = strings(RUS_CODEWORDS, "threats")
	var/foods = strings(RUS_CODEWORDS, "food")
	var/drinks = strings(RUS_CODEWORDS, "drinks")
	var/locations = strings(RUS_CODEWORDS, "locations")

	var/list/names = list()
	for(var/datum/record/crew/target in GLOB.manifest.general)//Picks from crew manifest.
		names += target.name

	var/maxwords = words//Extra var to check for duplicates.

	for(words,words>0,words--)//Randomly picks from one of the choices below.

		if(words == 1 && (1 in safety) && (2 in safety))//If there is only one word remaining and choice 1 or 2 have not been selected.
			safety = list(pick(1,2))//Select choice 1 or 2.
		else if(words == 1 && maxwords == 2)//Else if there is only one word remaining (and there were two originally), and 1 or 2 were chosen,
			safety = list(3)//Default to list 3

		switch(pick(safety))//Chance based on the safety list.
			if(1)//1 and 2 can only be selected once each to prevent more than two specific names/places/etc.
				switch(rand(1,2))//Mainly to add more options later.
					if(1)
						if(length(names) && prob(70))
							. += pick(names)
						else
							. += generate_random_name()
					if(2)
						var/datum/job/job = pick(SSjob.joinable_occupations)
						if(job)
							. += job.title //Returns a job.
						else
							stack_trace("Failed to pick(SSjob.joinable_occupations) on generate_code_phrase()")
							. += "Bug"
				safety -= 1
			if(2)
				switch(rand(1,3))//Food, drinks, or places. Only selectable once.
					if(1)
						. += LOWER_TEXT(pick(drinks))
					if(2)
						. += LOWER_TEXT(pick(foods))
					if(3)
						. += LOWER_TEXT(pick(locations))
				safety -= 2
			if(3)
				switch(rand(1,4))//Abstract nouns, objects, adjectives, threats. Can be selected more than once.
					if(1)
						. += LOWER_TEXT(pick(nouns))
					if(2)
						. += LOWER_TEXT(pick(objects))
					if(3)
						. += LOWER_TEXT(pick(adjectives))
					if(4)
						. += LOWER_TEXT(pick(threats))
		if(!return_list)
			if(words == 1)
				. += "."
			else
				. += ", "
