// Check if the player has died
if (player_died) {
    show_debug_message("Changing rooms!"); // Debugging
    player_died = false; // Reset the variable
    alarm[0] = 10; // Delay the room change slightly
}
// Ensure the camera exists before using it
if (view_camera[0] == noone) {
    show_debug_message("Camera lost! Recreating...");
    view_camera[0] = camera_create_view(0, 0, 1280, 720, 0, noone, -1, -1, 640, 360);
    view_enabled = true;
}

// Detect which player exists in the current room
var target_player = noone;

if (instance_exists(obj_player)) {
    target_player = obj_player;
} else if (instance_exists(obj_player_dark)) {
    target_player = obj_player_dark;
}

// Only update the camera if the correct player exists
if (target_player != noone) {
    var cam_x = target_player.x - (camera_get_view_width(view_camera[0]) / 2);
    var cam_y = target_player.y - (camera_get_view_height(view_camera[0]) / 2);
    
    // Prevent the camera from going too low
    cam_y = max(cam_y, 0);

    // Move the camera to follow the correct player
    camera_set_view_x(view_camera[0], cam_x);
    camera_set_view_y(view_camera[0], cam_y);

    show_debug_message("Camera following: " + string(target_player) + " at X: " + string(cam_x) + " Y: " + string(cam_y));
} else {
    show_debug_message("No player object found in the current room!");
}



// Delay camera update by a few frames
alarm[0] = 5;
