//vibes based bullet speed

#define BULLET_SPEED_SHOTGUN 1
#define BULLET_SPEED_HANDGUN 1.2
#define BULLET_SPEED_REVOLVER 1
#define BULLET_SPEED_PDW 1.3
#define BULLET_SPEED_RIFLE 1.1
#define BULLET_SPEED_SNIPER 1.4

//calibers
#define CALIBER_712X82MM "7.12x82mm"
#define CALIBER_22LR "22lr"
#define CALIBER_44ROUMAIN ".44 Roumain"
#define CALIBER_762X40MM "7.62x40mm"
#define CALIBER_57X39MM "5.7x39mm"
#define CALIBER_75X64MM "7.5x64mm"
#define CALIBER_A300 "a300"
#define CALIBER_8X50MM "8x50mm"
#define CALIBER_556X42MM "5.56x42mm"
#define CALIBER_308 "308"
#define CALIBER_47X33MM "47x33mm"
#define CALIBER_299 "299"
#define CALIBER_556 "556"
#define CALIBER_PELLET "pellet"
#define CALIBER_A858 "a858"
#define CALIBER_4570 "4570"

////Tile coordinates (x, y) to absolute coordinates (in number of pixels). Center of a tile is generally assumed to be (16,16), but can be offset.
#define ABS_COOR(c) (((c - 1) * 32) + 16)
#define ABS_COOR_OFFSET(c, o) (((c - 1) * 32) + o)

/proc/get_angle_with_scatter(atom/start, atom/end, scatter, x_offset = 16, y_offset = 16)
	var/end_apx
	var/end_apy
	if(isliving(end)) //Center mass.
		end_apx = ABS_COOR(end.x)
		end_apy = ABS_COOR(end.y)
	else //Exact pixel.
		end_apx = ABS_COOR_OFFSET(end.x, x_offset)
		end_apy = ABS_COOR_OFFSET(end.y, y_offset)
	scatter = ((rand(0, min(scatter, 45))) * (prob(50) ? 1 : -1)) //Up to 45 degrees deviation to either side.
	. = round((90 - ATAN2(end_apx - ABS_COOR(start.x), end_apy - ABS_COOR(start.y))), 1) + scatter
	if(. < 0)
		. += 360
	else if(. >= 360)
		. -= 360

/datum/movespeed_modifier/aiming
	multiplicative_slowdown = 0
	variable = TRUE

/datum/movespeed_modifier/gun
	multiplicative_slowdown = 1
	variable = TRUE
