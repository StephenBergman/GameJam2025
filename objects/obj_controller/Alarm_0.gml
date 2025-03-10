//Remove death screen before changing rooms
if (instance_exists(obj_death_screen)) {
	instance_destroy(obj_death_screen);
}

// Debugging: Check if obj_player exists
if (instance_exists(obj_player)) {
    show_debug_message("Player Exists Before Destroying!");
    instance_destroy(obj_player);
    show_debug_message("Player Object Destroyed!");
} else {
    show_debug_message("WARNING: obj_player does not exist before room transition!");
}

// Wait before switching rooms
if (alarm[1] <= 0) {
    alarm[1] = room_speed / 4;
    show_debug_message("Alarm[1] set for " + string(alarm[1]) + " frames.");
}