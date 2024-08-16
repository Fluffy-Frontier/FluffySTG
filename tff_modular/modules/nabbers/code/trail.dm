// Вывод кода следов ГБСов в модуль
/obj/effect/decal/cleanable/blood/footprints/update_name(updates)
  ..()
  if(FOOTPRINT_SPRITE_TAIL)
    name = "tailprint"
  dryname = "dried [name]"
  return ..()

/obj/effect/decal/cleanable/blood/footprints
	icon = 'tff_modular/modules/nabbers/icons/effects/footprints.dmi'
