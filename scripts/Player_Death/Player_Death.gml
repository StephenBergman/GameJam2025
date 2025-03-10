//Player death
function player_die() {
	show_debug_message("function is working!"); //Debugging
	
	vspeed = 0;
	hspeed = 0;
	
// sprite_index = spr_player_death; //Death animation

//Death screen (Sprite because I suck at art)
if (!instance_exists(obj_death_screen)) {
	instance_create_depth(0, 0, -1000, obj_death_screen);
}

//Wait 1 second before respawning
if (alarm[0] <= 0) {
alarm[0] = room_speed * 2// room speed = 1 second
}
show_debug_message("Alarm set to " + string(alarm[0]));

//Add death sound
}
