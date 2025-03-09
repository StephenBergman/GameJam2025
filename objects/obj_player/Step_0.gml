//Declare speed variable
var accel = 30; //How fast player speeds up
var max_speed = 200// Max speed
 // How fast player slows down

//Gravity and jump variables
gravity = 0; // Gravity strength
var jump_strength = -10; //Jump power (negative is up)
var max_fall_speed = 10; //Fall speed (positive is down)

//Applying gravity
if (!place_meeting(x, y + 1, obj_ground)) { //If not touching ground
	vspeed += gravity; //Apply gravity
	if (vspeed > max_fall_speed) vspeed = max_fall_speed; // Cap falling speed
} else {
	vspeed = 0; // stop falling when on ground
}
//Jumping
	if ((keyboard_check_pressed(vk_up) || keyboard_check_pressed(vk_space)) && place_meeting(x, y + 1, obj_ground)) {
		vspeed = jump_strength; //Jump when on ground
	}

	//Apply vertical movement
	y += vspeed;
	
	//Keep existing movement
	var accel = 0.5;
	var max_speed = 5;
	friction = 0.2
	speed = 0

//Move Right
if (keyboard_check(vk_right) || keyboard_check(ord("D"))) {
	speed += accel; //Increase speed
	if (speed > max_speed) speed = max_speed; //Cap speed
	sprite_index = spr_player_run_right; //Running sprite
	image_xscale = 1; //Face right
}

//Move left
else if 
 (keyboard_check(vk_left) || keyboard_check(ord("A"))) {
	speed -= accel; //Increase speed
	if (speed < -max_speed) speed = -max_speed; //Cap negative speed
	sprite_index = spr_player_run_right; //Set running sprite
	image_xscale = -1; //Flip sprite to face left
 }
	else {
	if (speed > 0) {
		speed -= friction;
		if (speed < 0) speed = 0; //Prevent negative speed
	} else if (speed < 0) {
		speed += friction;
		if (speed > 0) speed = 0;
	}
	
	//Idle sprite if not moving
	if (speed == 0) {
		sprite_index = spr_player
	}
}

//Apply movement
x += speed;