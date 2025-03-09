//Declare speed variable
speed = 0;
var accel = 2; //How fast player speeds up
var max_speed = 200// Max speed
friction = 0.02 // How fast player slows down

//Gravity and jump variables
gravity = 0; // Gravity strength
var jump_strength = -10; //Jump power (negative is up)
var max_fall_speed = 10; //Fall speed (positive is down)

//Applying gravity


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