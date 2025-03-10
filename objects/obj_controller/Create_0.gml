// Debug message to confirm obj_controller is running
show_debug_message("obj_controller has been created!");

// Ensure this object persists across rooms (optional)
persistent = true;

// Set default game state
global.game_state = "normal"; // Possible values: "normal", "dead", "transition"

// Track player existence
global.player_exists = false;
