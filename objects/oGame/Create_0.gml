global.Weapon = {
	Sword : new Weapon(WeaponID.sword, 10, 5, "Sword", sSword_ani)
}

// initialize spawn variables
if (!variable_global_exists("spawn_x")) global.spawn_x = -1;
if (!variable_global_exists("spawn_y")) global.spawn_y = -1;
if (!variable_global_exists("last_room")) global.last_room = -1;
