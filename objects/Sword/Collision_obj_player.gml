if (global.player.equipment.Weapon == noone) {
	show_debug_message("Collision detected between Player and Weapon Pickup!");
    show_debug_message("Picking up: " + global.Weapon.Sword.Name);
    global.player.equipItem(global.Weapon.Sword); // Equip the sword
    show_debug_message("Equipped: " + global.player.equipment.Weapon.Name);
} else {
 show_debug_message("ERROR: global.Weapon.Sword is noone!");
}

// Destroy the pickup object
instance_destroy();