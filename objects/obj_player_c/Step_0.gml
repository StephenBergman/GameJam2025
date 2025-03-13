/// @description Control Player

// ======= DIAGNOSTIC CHECKS =======
var is_grounded = place_meeting(x, y + 3, [obj_ground, tilemap]);
var is_colliding_x = place_meeting(x + 1, y, [obj_ground, tilemap]) || place_meeting(x - 1, y, [obj_ground, tilemap]);
var is_colliding_y = place_meeting(x, y, [obj_ground, tilemap]);
var is_inside_tilemap = place_meeting(x, y, tilemap);
var is_inside_ground = place_meeting(x, y, obj_ground);

show_debug_message("=== DIAGNOSTIC INFO ===");
show_debug_message("Is Grounded: " + string(is_grounded));
show_debug_message("Is Colliding X: " + string(is_colliding_x));
show_debug_message("Is Colliding Y: " + string(is_colliding_y));
show_debug_message("Is Inside Tilemap: " + string(is_inside_tilemap));
show_debug_message("Is Inside Ground: " + string(is_inside_ground));
show_debug_message("Current X: " + string(x) + ", Y: " + string(y));
show_debug_message("Sprite Origin: " + string(sprite_get_xoffset(sprite_index)) + ", " + string(sprite_get_yoffset(sprite_index)));
show_debug_message("Current Sprite: " + sprite_get_name(sprite_index));
show_debug_message("Collision Mask: " + sprite_get_name(mask_index == -1 ? sprite_index : mask_index));
// ======= END DIAGNOSTIC =======

// ======= CORE MOVEMENT APPROACH =======
// Get input
move_input_total = 0;
if keyboard_check(control_left) || keyboard_check(control_left_alt) { move_input_total -= 1; }
if keyboard_check(control_right) || keyboard_check(control_right_alt) { move_input_total += 1; }

// Jump input buffer
if keyboard_check_pressed(control_jump) || keyboard_check_pressed(control_jump_alt)
{
   jump_buffer_count = 0;
}

// Check / increment jump buffer
if jump_buffer_count < jump_buffer
{
   jump_buffer_count++;
}

// Calculate horizontal speed change
if (move_input_total != 0) {
    // Player is providing input - accelerate
    if (is_grounded) {
        hspeed += move_input_total * accel_rate_ground;
    } else {
        hspeed += move_input_total * accel_rate_air;
    }
} else {
    // Apply braking when no input
    if (is_grounded) {
        hspeed *= (1 - brake_rate_ground);
    } else {
        hspeed *= (1 - brake_rate_air);
    }
}

// Stop completely if very slow
if (abs(hspeed) < 0.1) hspeed = 0;

// Limit speed
hspeed = clamp(hspeed, -move_rate, move_rate);

// Apply gravity if in air
if (!is_grounded) {
    vspeed += gravity_rate;
    if (vspeed > gravity_vspeed) vspeed = gravity_vspeed;
} else {
    // Reset vertical speed when on ground
    vspeed = 0;
}

// Handle jumping
if (jump_buffer_count < jump_buffer && is_grounded) {
    vspeed = -jump_rate;
    jump_buffer_count = jump_buffer;
}

// ===== DIRECT MOVEMENT APPROACH =====
// Try to move horizontally
x += hspeed;
// Check for collision
if (place_meeting(x, y, [obj_ground, tilemap])) {
    // Move back
    x -= hspeed;
    // Try to move pixel by pixel
    var i = 0;
    var max_steps = abs(hspeed);
    var dir = sign(hspeed);
    while (i < max_steps && !place_meeting(x + dir, y, [obj_ground, tilemap])) {
        x += dir;
        i++;
    }
    hspeed = 0;
}

// Try to move vertically
y += vspeed;
// Check for collision
if (place_meeting(x, y, [obj_ground, tilemap])) {
    // Move back
    y -= vspeed;
    // Try to move pixel by pixel
    var i = 0;
    var max_steps = abs(vspeed);
    var dir = sign(vspeed);
    while (i < max_steps && !place_meeting(x, y + dir, [obj_ground, tilemap])) {
        y += dir;
        i++;
    }
    vspeed = 0;
}

// Sprites
if (vspeed < 0) { 
    sprite_index = spr_player_jump;
} 
else if (abs(hspeed) > 0.1) { 
    sprite_index = spr_player_run_right;
    image_xscale = sign(hspeed);
    if (image_xscale == 0) image_xscale = 1;  // Default to facing right if speed is exactly 0
} 
else { 
    sprite_index = spr_player; 
}

// Regular debug info
show_debug_message("HInput: " + string(move_input_total));
show_debug_message("Jump Buffer Count: " + string(jump_buffer_count));
show_debug_message("HSpeed: " + string(hspeed));
show_debug_message("VSpeed: " + string(vspeed));