show_debug_message("Player collided with killbox!");

// Destroy the player
with (other) {
    instance_destroy();
}

// Create the death screen
instance_create_layer(x, y, "GUI", obj_death_screen);
