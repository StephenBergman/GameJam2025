function player_die() {
    // Ensure global.game_state exists
    if (!variable_global_exists("game_state")) {
        global.game_state = "alive"; // Default state
        show_debug_message("WARNING: global.game_state was missing! Resetting to 'alive'.");
    }

    // Prevent multiple activations
    if (global.game_state == "dead") {
        return; // Exit function if already dead
    }
    global.game_state = "dead"; // Set death state

    show_debug_message("Player has died! Triggering death screen...");

    // Stop movement
    vspeed = 0;
    hspeed = 0;
    speed = 0;

    // Create the death screen if it doesn't exist
    if (!instance_exists(obj_death_screen)) {
        instance_create_depth(0, 0, -1000, obj_death_screen);
        show_debug_message("Death screen created.");
    }

    // Set the respawn timer (2 seconds)
    if (alarm[0] <= 0) {
        alarm[0] = room_speed * 2;
        show_debug_message("Alarm[0] set for " + string(alarm[0]) + " frames.");
    } else {
        show_debug_message("WARNING: alarm[0] was already running!");
    }

    // Play death sound
    //audio_play_sound(snd_death, 1, false);
}

