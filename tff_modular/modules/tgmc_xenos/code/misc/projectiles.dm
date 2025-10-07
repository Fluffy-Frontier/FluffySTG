/// TGMC_XENOS (old nova sector xenos)

/obj/projectile/neurotoxin/tgmc
	name = "neurotoxin spit"
	icon_state = "neurotoxin"
	damage = 40
	paralyze = 0
	damage_type = STAMINA
	armor_flag = BIO

/obj/projectile/neurotoxin/tgmc/queen
	damage = 80

/obj/projectile/neurotoxin/tgmc/spitter_spread //Slightly nerfed because its a shotgun spread of these
	name = "neurotoxin spit"
	icon_state = "neurotoxin"
	damage = 30


/obj/projectile/neurotoxin/tgmc/acid
	name = "acid spit"
	icon_state = "toxin"
	damage = 25
	paralyze = 0
	damage_type = BURN
	armor_flag = ACID

/obj/projectile/neurotoxin/tgmc/acid/queen
	damage = 40

/obj/projectile/neurotoxin/tgmc/acid/spitter_spread
	name = "acid spit"
	icon_state = "toxin"
	damage = 20
	damage_type = BURN
