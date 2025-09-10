/mob/living/proc/add_clothing_class(obj/item/clothing/thing)
	var/class = thing.class
	if(class in clothing_classes)
		clothing_classes[class] += thing.class_value
	else
		clothing_classes[class] = thing.class_value
	update_clothing_classes()

/mob/living/proc/remove_clothing_class(obj/item/clothing/thing)
	var/class = thing.class
	clothing_classes[class] -= thing.class_value
	if(!clothing_classes[class])
		clothing_classes -= class
	update_clothing_classes()

/mob/living/proc/update_clothing_classes()
	major_clothing_class = max(clothing_classes)

/mob/living/proc/get_major_clothing_class()
	return major_clothing_class

/mob/living/proc/get_major_clothing_class_value()
	return clothing_classes[major_clothing_class]

/mob/living/proc/get_clothing_class_level(class)
	if(!class)
		return 1
	var/value = clothing_classes[class]
	switch(value)
		if(1 to 20)
			return 1
		if(21 to 40)
			return 2
		if(41 to 60)
			return 3
		if(61 to 80)
			return 4
		if(81 to 100)
			return 5
