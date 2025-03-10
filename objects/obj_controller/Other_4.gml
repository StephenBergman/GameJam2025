if (room == rm_unhappy_1) {
    show_debug_message("Nightmare room started! Spawning vulnerable player...");

    // Find the first instance of obj_spawnpoint
    var spawn = instance_find(obj_spawnpoint, 0);

    // If a spawnpoint exists, use its position
    if (spawn != noone) {
        instance_create_depth(spawn.x, spawn.y, 0, obj_vulnerable_player);
    } else {
        // If no spawnpoint exists, use default coordinates
        instance_create_depth(200, 300, 0, obj_vulnerable_player);
        show_debug_message("Warning: No spawnpoint found! Using default position.");
    }
}
