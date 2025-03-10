// Set the initial game state
if (!variable_global_exists("game_state")) {
    global.game_state = "alive"; // Default state
    show_debug_message("global.game_state initialized to 'alive'.");
}

show_debug_message("Room Start Event running in obj_controller!");

if (room == rm_unhappy_1) {
    show_debug_message("Entered Nightmare Room!");

    // Check if player already exists
    if (!instance_exists(obj_vulnerable_player)) {
        // Find spawnpoint dynamically
        var spawn = instance_find(obj_spawnpoint, 0);

        if (spawn != noone) {
            instance_create_depth(spawn.x, spawn.y, 0, obj_vulnerable_player);
            show_debug_message("Spawned vulnerable player at spawnpoint.");
        } else {
            instance_create_depth(200, 300, 0, obj_vulnerable_player);
            show_debug_message("Warning: No spawnpoint found! Using default spawn.");
        }
    }
}
