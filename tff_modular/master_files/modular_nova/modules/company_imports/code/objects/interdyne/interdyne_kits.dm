/obj/item/storage/medkit/tactical/premium/interdyne/PopulateContents()
	if(empty)
		return
	var/list/items_inside = list(
		/obj/item/stack/medical/suture/medicated = 2,
		/obj/item/stack/medical/mesh/advanced = 2,
		/obj/item/healthanalyzer/advanced = 1,
		/obj/item/stack/medical/wrap/gauze = 1,
		/obj/item/scalpel/advanced = 1,
		/obj/item/retractor/advanced = 1,
		/obj/item/cautery/advanced = 1,
		/obj/item/bonesetter = 1,
		/obj/item/stack/medical/wrap/sticky_tape/surgical = 1,
		/obj/item/reagent_containers/medigel/sterilizine = 1,
		/obj/item/stack/medical/bone_gel = 1,
	)
	generate_items_inside(items_inside, src)
