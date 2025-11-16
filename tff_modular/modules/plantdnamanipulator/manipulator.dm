// Порт манипулятора растений. Вроде со скайрата, но фикс взят с бабберов.
// Оригинальные ПРы найти не вышло, к тому же все взято с нескольких пров и нескольких билдов, но оно где-то тут: https://github.com/Bubberstation/Bubberstation/pulls

/obj/machinery/plantgenes
	name = "plant DNA manipulator"
	desc = "An advanced device designed to manipulate plant genetic makeup."
	icon =  'icons/obj/service/hydroponics/equipment.dmi'
	icon_state = "dnamod"
	base_icon_state = "dnamod"
	var/working_state = "dnamod"
	var/nopower_state = "dnamod-off"
	density = TRUE
	circuit = /obj/item/circuitboard/machine/plantgenes
	pass_flags = PASSTABLE

	var/obj/item/seeds/seed
	var/obj/item/disk/plantgene/disk

	var/list/core_genes = list()
	var/list/reagent_genes = list()
	var/list/trait_genes = list()

	var/datum/plant_gene/target
	var/operation = ""
	var/max_potency = 50 // See RefreshParts() for how these work
	var/max_yield = 2
	var/min_production = 12
	var/max_endurance = 10 // IMPT: ALSO AFFECTS LIFESPAN
	var/min_wchance = 67
	var/min_wrate = 10

/datum/plant_gene/reagent
	mutability_flags = PLANT_GENE_GRAFTABLE | PLANT_GENE_REMOVABLE

/obj/machinery/plantgenes/RefreshParts() // Comments represent the max you can set per tier, respectively. seeds.dm [219] clamps these for us but we don't want to mislead the viewer.
	. = ..()
	for(var/datum/stock_part/servo/M in component_parts)
		if(M.tier > 3)
			max_potency = 95
		else
			max_potency = initial(max_potency) + (M.tier**3) // 53,59,77,95 	 Clamps at 100

		max_yield = initial(max_yield) + (M.tier*2) // 4,6,8,10 	Clamps at 10

	for(var/datum/stock_part/scanning_module/SM in component_parts)
		if(SM.tier > 3) //If you create t5 parts I'm a step ahead mwahahaha!
			min_production = 1
		else
			min_production = 12 - (SM.tier * 3) //9,6,3,1. Requires if to avoid going below clamp [1]

		max_endurance = initial(max_endurance) + (SM.tier * 25) // 35,60,85,100	Clamps at 10min 100max

	for(var/datum/stock_part/micro_laser/ML in component_parts)
		var/wratemod = ML.tier * 2.5
		min_wrate = FLOOR(10-wratemod,1) // 7,5,2,0	Clamps at 0 and 10	You want this low
		min_wchance = 67-(ML.tier*16) // 48,35,19,3 	Clamps at 0 and 67	You want this low

/obj/machinery/plantgenes/update_icon_state()
	icon_state = "[(nopower_state && !powered()) ? nopower_state : base_icon_state]"
	return ..()

/obj/machinery/plantgenes/update_overlays()
	. = ..()
	if(seed)
		. += "dnamod-dna"
	if(panel_open)
		. += "dnamod-open"

/obj/machinery/plantgenes/attackby(obj/item/I, mob/user, params)
	if(default_deconstruction_screwdriver(user, "dnamod", "dnamod", I))
		update_icon()
		return
	else if(default_unfasten_wrench(user, I))
		return
	if(default_deconstruction_crowbar(I))
		return
	if(iscyborg(user))
		return

	if(istype(I, /obj/item/seeds))
		if (operation)
			to_chat(user, "<span class='notice'>Please complete current operation.</span>")
			return
		if(!user.transferItemToLoc(I, src))
			return
		eject_seed(user)
		insert_seed(I)
		to_chat(user, "<span class='notice'>You insert [I] to the machine.</span>")
		interact(user)
	else if(istype(I, /obj/item/disk/plantgene))
		if (operation)
			to_chat(user, "<span class='notice'>Please complete current operation.</span>")
			return
		if(!user.transferItemToLoc(I, src))
			return
		eject_disk(user)
		disk = I
		to_chat(user, "<span class='notice'>You insert [I] to the machine.</span>")
		interact(user)
	else
		return ..()

//? Eventually refactor this into TGUI?
/obj/machinery/plantgenes/ui_interact(mob/user)
	. = ..()
	if(!user)
		return

	var/datum/browser/popup = new(user, "plantdna", "Plant DNA Manipulator", 450, 600)
	if(!(in_range(src, user) || issilicon(user)))
		popup.close()
		return

	var/dat = ""

	if(operation)
		if(!seed || (!target && operation != "insert"))
			operation = ""
			target = null
			interact(user)
			return
		if((operation == "replace" || operation == "insert") && (!disk || !disk.gene))
			operation = ""
			target = null
			interact(user)
			return

		dat += "<div class='line'><h3>Confirm Operation</h3></div>"
		dat += "<div class='statusDisplay'>Are you sure you want to [operation] "
		switch(operation)
			if("remove")
				dat += "<span class='highlight'>[target.get_name()]</span> gene from \the <span class='highlight'>[seed]</span>?<br>"
			if("extract")
				dat += "<span class='highlight'>[target.get_name()]</span> gene from \the <span class='highlight'>[seed]</span>?<br>"
				dat += "<span class='bad'>The sample will be destroyed in process!</span>"
				if(istype(target, /datum/plant_gene/core))
					var/datum/plant_gene/core/gene = target
					if(istype(target, /datum/plant_gene/core/potency))
						if(gene.value > max_potency)
							dat += "<br><br>This device's extraction capabilities are currently limited to <span class='highlight'>[max_potency]</span> potency. "
							dat += "Target gene will be degraded to <span class='highlight'>[max_potency]</span> potency on extraction."
					else if(istype(target, /datum/plant_gene/core/lifespan))
						if(gene.value > max_endurance)
							dat += "<br><br>This device's extraction capabilities are currently limited to <span class='highlight'>[max_endurance]</span> lifespan. "
							dat += "Target gene will be degraded to <span class='highlight'>[max_endurance]</span> Lifespan on extraction."
					else if(istype(target, /datum/plant_gene/core/endurance))
						if(gene.value > max_endurance)
							dat += "<br><br>This device's extraction capabilities are currently limited to <span class='highlight'>[max_endurance]</span> endurance. "
							dat += "Target gene will be degraded to <span class='highlight'>[max_endurance]</span> endurance on extraction."
					else if(istype(target, /datum/plant_gene/core/yield))
						if(gene.value > max_yield)
							dat += "<br><br>This device's extraction capabilities are currently limited to <span class='highlight'>[max_yield]</span> yield. "
							dat += "Target gene will be degraded to <span class='highlight'>[max_yield]</span> yield on extraction."
					else if(istype(target, /datum/plant_gene/core/production))
						if(gene.value < min_production)
							dat += "<br><br>This device's extraction capabilities are currently limited to <span class='highlight'>[min_production]</span> production. "
							dat += "Target gene will be degraded to <span class='highlight'>[min_production]</span> production on extraction."
					else if(istype(target, /datum/plant_gene/core/weed_rate))
						if(gene.value < min_wrate)
							dat += "<br><br>This device's extraction capabilities are currently limited to <span class='highlight'>[min_wrate]</span> weed rate. "
							dat += "Target gene will be degraded to <span class='highlight'>[min_wrate]</span> weed rate on extraction."
					else if(istype(target, /datum/plant_gene/core/weed_chance))
						if(gene.value < min_wchance)
							dat += "<br><br>This device's extraction capabilities are currently limited to <span class='highlight'>[min_wchance]</span> weed chance. "
							dat += "Target gene will be degraded to <span class='highlight'>[min_wchance]</span> weed chance on extraction."

			if("replace")
				dat += "<span class='highlight'>[target.get_name()]</span> gene with <span class='highlight'>[disk.gene.get_name()]</span>?<br>"
			if("insert")
				dat += "<span class='highlight'>[disk.gene.get_name()]</span> gene into \the <span class='highlight'>[seed]</span>?<br>"
		dat += "</div><div class='line'><a href='byond://?src=[REF(src)];gene=[REF(target)];op=[operation]'>Confirm</a> "
		dat += "<a href='byond://?src=[REF(src)];abort=1'>Abort</a></div>"
		popup.set_content(dat)
		popup.open()
		return

	dat+= "<div class='statusDisplay'>"

	dat += "<div class='line'><div class='statusLabel'>Plant Sample:</div><div class='statusValue'><a href='byond://?src=[REF(src)];eject_seed=1'>"
	dat += seed ? seed.name : "None"
	dat += "</a></div></div>"

	dat += "<div class='line'><div class='statusLabel'>Data Disk:</div><div class='statusValue'><a href='byond://?src=[REF(src)];eject_disk=1'>"
	if(!disk)
		dat += "None"
	else if(!disk.gene)
		dat += "Empty Disk"
	else
		dat += disk.gene.get_name()
	if(disk && disk.read_only)
		dat += " (RO)"
	dat += "</a></div></div>"

	dat += "<br></div>"

	if(seed)
		var/can_insert = disk && disk.gene && disk.gene.can_add(seed)
		var/can_extract = disk && !disk.read_only

		dat += "<div class='line'><h3>Core Genes</h3></div><div class='statusDisplay'><table>"
		for(var/a in core_genes)
			var/datum/plant_gene/G = a
			if(!G)
				continue
			dat += "<tr><td width='260px'>[G.get_name()]</td><td>"
			if(can_extract && G.mutability_flags & PLANT_GENE_GRAFTABLE)
				dat += "<a href='byond://?src=[REF(src)];gene=[REF(G)];op=extract'>Extract</a>"
			if(can_insert && istype(disk.gene, G.type) && G.mutability_flags & PLANT_GENE_REMOVABLE)
				dat += "<a href='byond://?src=[REF(src)];gene=[REF(G)];op=replace'>Replace</a>"
			dat += "</td></tr>"
		dat += "</table></div>"

		if(seed.yield != -1)
			dat += "<div class='line'><h3>Content Genes</h3></div><div class='statusDisplay'>"
			if(reagent_genes.len)
				dat += "<table>"
				for(var/a in reagent_genes)
					var/datum/plant_gene/G = a
					dat += "<tr><td width='260px'>[G.get_name()]</td><td>"
					if(can_extract && G.mutability_flags & PLANT_GENE_GRAFTABLE)
						dat += "<a href='byond://?src=[REF(src)];gene=[REF(G)];op=extract'>Extract</a>"
					if(G.mutability_flags & PLANT_GENE_REMOVABLE)
						dat += "<a href='byond://?src=[REF(src)];gene=[REF(G)];op=remove'>Remove</a>"
					dat += "</td></tr>"
				dat += "</table>"
			else
				dat += "No content-related genes detected in sample.<br>"
			dat += "</div>"
			if(can_insert && istype(disk.gene, /datum/plant_gene/reagent))
				dat += "<a href='byond://?src=[REF(src)];op=insert'>Insert: [disk.gene.get_name()]</a>"

			dat += "<div class='line'><h3>Trait Genes</h3></div><div class='statusDisplay'>"
			if(trait_genes.len)
				dat += "<table>"
				for(var/a in trait_genes)
					var/datum/plant_gene/G = a
					dat += "<tr><td width='260px'>[G.get_name()]</td><td>"
					if(can_extract && G.mutability_flags & PLANT_GENE_GRAFTABLE)
						dat += "<a href='byond://?src=[REF(src)];gene=[REF(G)];op=extract'>Extract</a>"
					if(G.mutability_flags & PLANT_GENE_REMOVABLE)
						dat += "<a href='byond://?src=[REF(src)];gene=[REF(G)];op=remove'>Remove</a>"
					dat += "</td></tr>"
				dat += "</table>"
			else
				dat += "No trait-related genes detected in sample.<br>"
			if(can_insert && istype(disk.gene, /datum/plant_gene/trait))
				dat += "<a href='byond://?src=[REF(src)];op=insert'>Insert: [disk.gene.get_name()]</a>"
			dat += "</div>"
	else
		dat += "<br>No sample found.<br><span class='highlight'>Please, insert a plant sample to use this device.</span>"
	popup.set_content(dat)
	popup.open()


/obj/machinery/plantgenes/Topic(href, list/href_list)
	if(..())
		return

	if(href_list["eject_seed"] && !operation)
		var/obj/item/I = usr.get_active_held_item()
		if(istype(I, /obj/item/seeds))
			if(!usr.transferItemToLoc(I, src))
				return
			eject_seed(usr)
			insert_seed(I)
			to_chat(usr, "<span class='notice'>You add [I] to the machine.</span>")
		else
			eject_seed(usr)
	else if(href_list["eject_disk"] && !operation)
		var/obj/item/I = usr.get_active_held_item()
		if(istype(I, /obj/item/disk/plantgene))
			if(!usr.transferItemToLoc(I, src))
				return
			eject_disk(usr)
			disk = I
			to_chat(usr, "<span class='notice'>You add [I] to the machine.</span>")
		else
			eject_disk(usr)
	else if(href_list["op"] == "insert" && disk && disk.gene && seed)
		if(!operation) // Wait for confirmation
			operation = "insert"
		else
			if(!istype(disk.gene, /datum/plant_gene/core) && disk.gene.can_add(seed))
				seed.genes += disk.gene.Copy()
				if(istype(disk.gene, /datum/plant_gene/reagent))
					seed.reagents_from_genes()
			update_genes()
			repaint_seed()
			operation = ""
			target = null

	else if(href_list["gene"] && seed)
		var/datum/plant_gene/G = seed.get_gene(href_list["gene"])
		if(!G || !href_list["op"] || !(href_list["op"] in list("remove", "extract", "replace")))
			interact(usr)
			return

		if(!operation || target != G) // Wait for confirmation
			target = G
			operation = href_list["op"]

		else if(operation == href_list["op"] && target == G)
			switch(href_list["op"])
				if("remove")
					if(!istype(G, /datum/plant_gene/core))
						seed.genes -= G
						if(istype(G, /datum/plant_gene/reagent))
							seed.reagents_from_genes()
					repaint_seed()
				if("extract")
					if(disk && !disk.read_only)
						seed.genes -= G
						var/datum/plant_gene/core/gene = G
						if(istype(G, /datum/plant_gene/core))
							if(istype(G, /datum/plant_gene/core/potency))
								gene.value = min(gene.value, max_potency)
							else if(istype(G, /datum/plant_gene/core/lifespan))
								gene.value = min(gene.value, max_endurance) //INTENDED
							else if(istype(G, /datum/plant_gene/core/endurance))
								gene.value = min(gene.value, max_endurance)
							else if(istype(G, /datum/plant_gene/core/production))
								gene.value = max(gene.value, min_production)
							else if(istype(G, /datum/plant_gene/core/yield))
								gene.value = min(gene.value, max_yield)
							else if(istype(G, /datum/plant_gene/core/weed_rate))
								gene.value = max(gene.value, min_wrate)
							else if(istype(G, /datum/plant_gene/core/weed_chance))
								gene.value = max(gene.value, min_wchance)
						disk.gene = gene
						to_chat(usr, "<span class='notice'>You add [gene] to the disk.</span>")
						disk.update_disk_name()
						qdel(seed)
						seed = null
						update_icon()
				if("replace")
					if(disk && disk.gene && istype(disk.gene, G.type) && istype(G, /datum/plant_gene/core))
						seed.genes -= G
						var/datum/plant_gene/core/C = disk.gene.Copy()
						seed.genes += C
						C.apply_stat(seed)
						repaint_seed()
				if("insert")
					if(disk && disk.gene && !istype(disk.gene, /datum/plant_gene/core) && disk.gene.can_add(seed))
						seed.genes += disk.gene.Copy()
						if(istype(disk.gene, /datum/plant_gene/reagent))
							seed.reagents_from_genes()
						disk.gene.apply_vars(seed)
						repaint_seed()


			update_genes()
			operation = ""
			target = null
	else if(href_list["abort"])
		operation = ""
		target = null

	interact(usr)

/obj/machinery/plantgenes/proc/insert_seed(obj/item/seeds/S)
	if(!istype(S) || seed)
		return
	S.forceMove(src)
	seed = S
	update_genes()
	update_icon()

/obj/machinery/plantgenes/proc/eject_disk(mob/living/carbon/user)
	if (disk && !operation)
		if(Adjacent(user))
			if (!user.put_in_hands(disk))
				disk.forceMove(drop_location())
		else
			disk.forceMove(drop_location())
		disk = null
		update_genes()

/obj/machinery/plantgenes/proc/eject_seed(mob/living/carbon/user)
	if (seed && !operation)
		if(Adjacent(user))
			if (!user.put_in_hands(seed))
				seed.forceMove(drop_location())
		else
			seed.forceMove(drop_location())
		seed = null
		update_genes()

/obj/machinery/plantgenes/proc/update_genes()
	core_genes = list()
	reagent_genes = list()
	trait_genes = list()

	if(seed)
		var/gene_paths = list(
			/datum/plant_gene/core/potency,
			/datum/plant_gene/core/yield,
			/datum/plant_gene/core/production,
			/datum/plant_gene/core/endurance,
			/datum/plant_gene/core/lifespan,
			/datum/plant_gene/core/weed_rate,
			/datum/plant_gene/core/weed_chance,
			)
		for(var/a in gene_paths)
			core_genes += seed.get_gene(a)

		for(var/datum/plant_gene/reagent/G in seed.genes)
			reagent_genes += G

		for(var/datum/plant_gene/trait/G in seed.genes)
			trait_genes += G

/obj/machinery/plantgenes/proc/repaint_seed()
	if(!seed)
		return
	if(copytext(seed.name, 1, 13) == "experimental")//13 == length("experimental") + 1
		return // Already modded name and icon
	seed.name = "experimental " + seed.name
	seed.icon_state = "seed-x"

/*
 *  Plant DNA disk
 */

/obj/item/disk/plantgene
	name = "plant data disk"
	desc = "A disk for storing plant genetic data."
	icon_state = "datadisk_hydro"
	custom_materials = list(/datum/material/iron=30, /datum/material/glass=10)
	var/datum/plant_gene/gene
	var/read_only = 0 //Well, it's still a floppy disk
	obj_flags = UNIQUE_RENAME

/obj/item/disk/plantgene/Initialize(mapload)
	. = ..()
	add_overlay("datadisk_gene")

/obj/item/disk/plantgene/proc/update_disk_name()
	if(gene)
		name = "[gene.get_name()] (plant data disk)"
	else
		name = "plant data disk"

/obj/item/disk/plantgene/attack_self(mob/user)
	read_only = !read_only
	to_chat(user, "<span class='notice'>You flip the write-protect tab to [src.read_only ? "protected" : "unprotected"].</span>")

/obj/item/disk/plantgene/examine(mob/user)
	. = ..()
	if(gene && (istype(gene, /datum/plant_gene/core/potency)))
		. += "<span class='notice'>Percent is relative to potency, not maximum volume of the plant.</span>"
	. += "The write-protect tab is set to [src.read_only ? "protected" : "unprotected"]."

// Гены растений:
/datum/plant_gene/trait/repeated_harvest/New(...)
	seed_blacklist += /obj/item/seeds/seedling
	seed_blacklist += /obj/item/seeds/seedling/evil
	. = ..()

/*
 * Returns the formatted name of the plant gene.
 *
 * Overridden by the various subtypes of plant genes to format their respective names.
 */
/datum/plant_gene/get_name()
	var/formatted_name
	if(!(mutability_flags & PLANT_GENE_REMOVABLE && mutability_flags & PLANT_GENE_MUTATABLE))
		if(mutability_flags & PLANT_GENE_REMOVABLE)
			formatted_name += "Fragile "
		else if(mutability_flags & PLANT_GENE_MUTATABLE)
			formatted_name += "Essential "
		else
			formatted_name += "Immutable "
	formatted_name += name
	return formatted_name

/datum/plant_gene/proc/apply_vars(obj/item/seeds/S) // currently used for fire resist, can prob. be further refactored
	return

// Core plant genes store 5 main variables: lifespan, endurance, production, yield, potency
/datum/plant_gene/core
	var/value

/datum/plant_gene/core/get_name()
	return "[name] [value]"

/datum/plant_gene/core/proc/apply_stat(obj/item/seeds/S)
	return

/datum/plant_gene/core/New(i = null)
	..()
	if(!isnull(i))
		value = i

/datum/plant_gene/core/Copy()
	var/datum/plant_gene/core/C = ..()
	C.value = value
	return C

/datum/plant_gene/core/can_add(obj/item/seeds/S)
	if(!..())
		return FALSE
	return S.get_gene(src.type)

/datum/plant_gene/core/lifespan
	name = "Lifespan"
	value = 25

/datum/plant_gene/core/lifespan/apply_stat(obj/item/seeds/S)
	S.lifespan = value

/datum/plant_gene/core/endurance
	name = "Endurance"
	value = 15

/datum/plant_gene/core/endurance/apply_stat(obj/item/seeds/S)
	S.endurance = value

/datum/plant_gene/core/production
	name = "Production Speed"
	value = 6

/datum/plant_gene/core/production/apply_stat(obj/item/seeds/S)
	S.production = value

/datum/plant_gene/core/yield
	name = "Yield"
	value = 3

/datum/plant_gene/core/yield/apply_stat(obj/item/seeds/S)
	S.yield = value

/datum/plant_gene/core/potency
	name = "Potency"
	value = 10

/datum/plant_gene/core/potency/apply_stat(obj/item/seeds/S)
	S.potency = value

/datum/plant_gene/core/instability
	name = "Stability"
	value = 10

/datum/plant_gene/core/instability/apply_stat(obj/item/seeds/S)
	S.instability = value

/datum/plant_gene/core/weed_rate
	name = "Weed Growth Rate"
	value = 1

/datum/plant_gene/core/weed_rate/apply_stat(obj/item/seeds/S)
	S.weed_rate = value

/datum/plant_gene/core/weed_chance
	name = "Weed Vulnerability"
	value = 5

/datum/plant_gene/core/weed_chance/apply_stat(obj/item/seeds/S)
	S.weed_chance = value

// Платы и исследования
/obj/item/circuitboard/machine/plantgenes
	name = "Plant DNA Manipulator (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SERVICE
	build_path = /obj/machinery/plantgenes
	req_components = list(
		/datum/stock_part/servo = 1,
		/datum/stock_part/micro_laser = 1,
		/obj/item/stack/sheet/glass = 1,
		/datum/stock_part/scanning_module = 1,
	)

/datum/design/board/plantgenes
	name = "Plant DNA Manipulator Board"
	desc = "The circuit board for a plant gene editing machine."
	id = "plantgene"
	build_path = /obj/item/circuitboard/machine/plantgenes
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_BOTANY
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/diskplantgene
	name = "Plant Data Disk"
	id = "diskplantgene"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 10)
	build_path = /obj/item/disk/plantgene
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_BIO_MATERIALS)

/datum/techweb_node/botanygene
	id = TECHWEB_NODE_BOTANY_ADV
	display_name = "Experimental Botanical Engineering"
	description = "Further advancement in plant cultivation techniques and machinery, enabling careful manipulation of plant DNA."
	prereq_ids = list(TECHWEB_NODE_PARTS_ADV, TECHWEB_NODE_SELECTION)
	design_ids = list(
		"diskplantgene",
		"plantgene",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_5_POINTS)

// Диски
/obj/item/storage/box/disks_plantgene
	name = "plant data disks box"
	illustration = "disk_kit"

/obj/item/storage/box/disks_plantgene/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/disk/plantgene(src)

/obj/item/seeds/Initialize(mapload, nogenes = FALSE)
	. = ..()
	if(!nogenes)
		genes += new /datum/plant_gene/core/lifespan(lifespan)
		genes += new /datum/plant_gene/core/endurance(endurance)
		genes += new /datum/plant_gene/core/weed_rate(weed_rate)
		genes += new /datum/plant_gene/core/weed_chance(weed_chance)
		if(yield != -1)
			genes += new /datum/plant_gene/core/yield(yield)
			genes += new /datum/plant_gene/core/production(production)
		if(potency != -1)
			genes += new /datum/plant_gene/core/potency(potency)
			genes += new /datum/plant_gene/core/instability(instability)
