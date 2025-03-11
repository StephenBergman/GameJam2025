//Remove death screen before changing rooms
 if (instance_exists(obj_death_screen)) {
 	instance_destroy(obj_death_screen);
 }
 
// Tell obj_controller that the player died
with (obj_controller) {
    player_died = true;
}

instance_deactivate_object(id); 
instance_destroy();

 //Respawn in nightmare after 1st death
show_debug_message("Changing rooms in 10 frames!"); // Debugging
alarm[1] = 10; // Wait 10 frames before switching rooms