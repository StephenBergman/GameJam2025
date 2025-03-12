// Debug message to confirm obj_controller is running
show_debug_message("✅ obj_controller has been created!");

// Ensure this object persists across rooms (optional)
persistent = true;

// Ensure the game state exists
if (!variable_global_exists("game_state")) {
    global.game_state = "alive"; // Default state
    show_debug_message("✅ global.game_state initialized to 'alive'.");
}

// Initialize variables
player_died = false; 
global.player_exists = false;

// Declare camera variable globally
view_camera[0] = noone;

// Delay camera setup to prevent early execution
alarm[0] = game_speed / 4; // Wait for objects to load before setting camera
