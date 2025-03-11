// Remove death screen before changing rooms
if (instance_exists(obj_death_screen)) {
    instance_destroy(obj_death_screen);
}

// Ensure camera exists
if (view_camera[0] == noone) {
    show_debug_message("⚠ Camera lost! Recreating...");
    view_camera[0] = camera_create_view(0, 0, 1280, 720, 0, noone, -1, -1, 640, 360);
    view_set_camera(0, view_camera[0]); // Assign to viewport
    view_enabled = true;
    show_debug_message("✅ Camera successfully recreated.");
}

// Debugging: Check if obj_player exists before destroying
if (instance_exists(obj_player)) {
    show_debug_message("Destroying obj_player before switching rooms...");
    instance_destroy(obj_player);
    show_debug_message("Player Object Destroyed!");
}

// Wait a short time before switching rooms
show_debug_message("Setting alarm[1] for delayed room transition...");
alarm[1] = room_speed / 4; // Small delay before switching rooms


if (instance_exists(obj_player_dark)) {
    camera_set_view_x(view_camera[0], obj_player_dark.x - (camera_get_view_width(view_camera[0]) / 2));
    camera_set_view_y(view_camera[0], obj_player_dark.y - (camera_get_view_height(view_camera[0]) / 2));
}

