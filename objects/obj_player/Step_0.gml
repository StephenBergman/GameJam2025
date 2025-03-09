// Declare speed variable

var accel = 2; // How fast player speeds up
var max_speed = 8; // Max movement speed


// Gravity and jump variables
gravity = 8; // Gravity
var jump_strength = -20; // jump power
var max_fall_speed = 20; // Capped fall speed

// Applying gravity
if (!place_meeting(x, y + 2, obj_ground)) { // If not touching ground
    vspeed += gravity * 0.2; // Apply gradual gravity
    if (vspeed > max_fall_speed) vspeed = max_fall_speed; // Cap falling speed
} 
else {
    vspeed = 0; // Stop falling when on ground
}

// Jumping 
if ((keyboard_check_pressed(vk_up) || keyboard_check_pressed(vk_space)) && place_meeting(x, y + 2, obj_ground)) {
    vspeed = jump_strength; // Jump when on ground
}

// Apply vertical movement 
if (vspeed > 0) { // Falling down
    if (place_meeting(x, y + vspeed, obj_ground)) {
        move_contact_solid(270, abs(vspeed)); // Move down until touching the ground
        vspeed = 0; // Stop falling
    } else {
        y += vspeed; // Move normally if no collision
    }
} 
else if (vspeed < 0) { // Jumping
    if (place_meeting(x, y + vspeed, obj_ground)) {
        move_contact_solid(90, abs(vspeed)); // Stop at ceiling
        vspeed = 0;
    } else {
        y += vspeed;
    }
}

// Player movement (Left/Right)
if (keyboard_check(vk_right) || keyboard_check(ord("D"))) {
    hspeed += accel;  // Accelerate to the right
    if (hspeed > max_speed) hspeed = max_speed; // Cap speed
    image_xscale = 1; // Face right
} 
else if (keyboard_check(vk_left) || keyboard_check(ord("A"))) {
    hspeed -= accel;  // Accelerate to the left 
    if (hspeed < -max_speed) hspeed = -max_speed; // Cap leftward speed
    image_xscale = -1; // Flip sprite
} 



if (!keyboard_check(vk_right) && !keyboard_check(vk_left) &&
!keyboard_check(ord("D")) && !keyboard_check(ord("A"))) {
	hspeed = 0;
}


//Sprites
if (vspeed < 0 && abs(hspeed) >= 0) { // Only apply jump sprite when stationary & airborne
    sprite_index = spr_player_jump;
} 
else if (abs(speed) > 0) { // Running (no separate left sprite needed)
    sprite_index = spr_player_run_right;
} 
else { // Standing still
    sprite_index = spr_player; 
}

// Apply movement
x += hspeed;
