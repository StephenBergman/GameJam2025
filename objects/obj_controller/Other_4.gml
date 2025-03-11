if (room == rm_unhappy) {
    show_debug_message("Nightmare room started! Spawning vulnerable player...");

    // Find the first instance of obj_spawnpoint
    var spawn = instance_find(obj_spawnpoint, 0);

    // If a spawnpoint exists, use its position
    if (spawn != noone) {
        instance_create_depth(spawn.x, spawn.y, 0, obj_player_dark);
    } else {
        // If no spawnpoint exists, use default coordinates
        instance_create_depth(200, 300, 0, obj_player_dark);
        show_debug_message("Warning: No spawnpoint found! Using default position.");
    }
}

// Ensure the camera exists when entering a new room
if (view_camera[0] == noone) {
    show_debug_message("Camera lost during room change! Recreating...");
    view_camera[0] = camera_create_view(0, 0, 1280, 720, 0, noone, -1, -1, 640, 360);
    view_enabled = true;
}

// Assign the camera to the view 
view_set_camera(0, view_camera[0]);
show_debug_message("Camera reassigned to viewport after room change.");
