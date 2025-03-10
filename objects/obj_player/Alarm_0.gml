//Remove death screen before changing rooms
 if (instance_exists(obj_death_screen)) {
 	instance_destroy(obj_death_screen);
 }
 
 instance_destroy();
 //Respawn in nightmare after 1st death
 show_debug_message("Changing rooms!") //Debugging
 room_goto(rm_unhappy)