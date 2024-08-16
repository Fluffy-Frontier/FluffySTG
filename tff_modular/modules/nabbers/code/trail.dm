// Вывод кода следов ГБСов в модуль
/obj/effect/decal/cleanable/blood/footprints/update_name(updates)
  switch(footprint_sprite)
    if(FOOTPRINT_SPRITE_CLAWS)
      name = "clawprints"
    if(FOOTPRINT_SPRITE_SHOES)
      name = "footprints"
    if(FOOTPRINT_SPRITE_PAWS)
      name = "pawprints"
    if(FOOTPRINT_SPRITE_TAIL)
      name = "tailprint"
  dryname = "dried [name]"
  return ..()

/obj/effect/decal/cleanable/blood/footprints
	icon = 'tff_modular/modules/nabbers/icons/effects/footprints.dmi'
