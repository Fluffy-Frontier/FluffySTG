// родной файл - modular_nova/modules/modular_weapons/code/company_and_or_faction_based/carwo_defense_systems/ammo/rifle.dm

/obj/projectile/bullet/c40sol
	damage = 35

/obj/projectile/bullet/c40sol/fragmentation
	damage = 15
	stamina = 30

/obj/projectile/bullet/c40sol/pierce
	damage = 25

/obj/projectile/bullet/c40sol/incendiary
	damage = 25
// strilka лежит в другом файле но все еще винтовочный патрон, объединяем. родной файл - modular_nova/modules/modular_weapons/code/modular_projectiles/rifle_calibers.dm
/obj/projectile/bullet/strilka310/rubber
	stamina = 55

/obj/projectile/bullet/strilka310/ap
	damage = 50

/obj/projectile/bullet/strilka310
	damage = 60

//еще один винтовочный - modular_nova/modules/modular_weapons/code/company_and_or_faction_based/szot_dynamica/ammo/rifle.dm
/obj/projectile/bullet/p60strela
	damage = 70
