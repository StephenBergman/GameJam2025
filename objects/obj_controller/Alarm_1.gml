show_debug_message("Changing rooms now!");
room_goto(rm_unhappy);

// Wait a short time before updating the camera
alarm[0] = 10; // Wait 10 frames to allow obj_player_dark to spawn
