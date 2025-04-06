GLOBAL_VAR_INIT(obfs_x, rand(-500, 500))
GLOBAL_VAR_INIT(obfs_y, rand(-500, 500))

//Offuscate x for coord system
#define obfuscate_x(x) ((x) + GLOB.obfs_x)

//Offuscate y for coord system
#define obfuscate_y(y) ((y) + GLOB.obfs_y)

//Deoffuscate x for coord system
#define deobfuscate_x(x) ((x) - GLOB.obfs_x)

//Deoffuscate y for coord system
#define deobfuscate_y(y) ((y) - GLOB.obfs_y)
