/// @description Control Player

// ======= DIAGNOSTIC CHECKS =======
var is_grounded = tile_meeting(x, y + 1);
var is_colliding_x = tile_meeting(x + sign(hspeed), y);
var is_colliding_y = tile_meeting(x, y + sign(vspeed));
var is_inside_tilemap = tile_meeting(x, y);

// Check for slopes before other collision
var on_slope_last_frame = on_slope;
check_slope_collision();

// If on a slope, override the is_grounded value
if (on_slope) is_grounded = true;

show_debug_message("=== DIAGNOSTIC INFO ===");
show_debug_message("Is Grounded: " + string(is_grounded));
show_debug_message("Is Colliding X: " + string(is_colliding_x));
show_debug_message("Is Colliding Y: " + string(is_colliding_y));
show_debug_message("Is Inside Tilemap: " + string(is_inside_tilemap));

show_debug_message("Current X: " + string(x) + ", Y: " + string(y));
show_debug_message("Sprite Origin: " + string(sprite_get_xoffset(sprite_index)) + ", " + string(sprite_get_yoffset(sprite_index)));
show_debug_message("Current Sprite: " + sprite_get_name(sprite_index));
show_debug_message("Collision Mask: " + sprite_get_name(mask_index == -1 ? sprite_index : mask_index));

// ======= MOVEMENT HANDLING =======

// Prevent starting a frame stuck
if (is_inside_tilemap)
{
    resolve_stuck();
}

// Get input
move_input_total = 0;

if keyboard_check(control_left) || keyboard_check(control_left_alt) { move_input_total -= 1; }
if keyboard_check(control_right) || keyboard_check(control_right_alt) { move_input_total += 1; }

// Jump input buffer
if keyboard_check_pressed(control_jump) || keyboard_check_pressed(control_jump_alt)
{
   jump_buffer_count = 0;
}

// Track if the jump button is held
if keyboard_check(control_jump) || keyboard_check(control_jump_alt)
{
    jump_held = true;
}
else 
{
    jump_held = false;
}

// Check / increment jump buffer
if jump_buffer_count < jump_buffer
{
   jump_buffer_count++;
}

// Calculate horizontal speed change
if (move_input_total != 0)
{
    // Player is providing input - accelerate
    if (is_grounded) 
	{
        hspeed += move_input_total * accel_rate_ground;
    }
	else 
	{
        hspeed += move_input_total * accel_rate_air;
    }
}
else 
{
    // Apply braking when no input
    if (is_grounded)
	{
        hspeed *= (1 - brake_rate_ground);
    }
	else 
	{
        hspeed *= (1 - brake_rate_air);
    }
}

// Stop completely if very slow
if (abs(hspeed) < 0.1) hspeed = 0;

// Limit speed
hspeed = clamp(hspeed, -move_rate, move_rate);

// Apply gravity if in air
if (!is_grounded) 
{
    // Apply base gravity if falling fast
    var applied_gravity = gravity_rate_base;
    
    // Reduce gravity when rising near the peak of the jump
    if (vspeed < 0 && abs(vspeed) < jump_rate * 0.5) 
    {
        applied_gravity = gravity_rate_peak;
    }

    // Apply slightly stronger gravity if the player released jump early
    if (!jump_held && vspeed < 0)
    {
        applied_gravity = gravity_rate_fast;
    }

    // Apply final gravity value
    vspeed += applied_gravity;

    // Cap gravity
    if (vspeed > gravity_vspeed) vspeed = gravity_vspeed;
}
else 
{
    // Reset vertical speed and jump count when on ground
    vspeed = 0;
	jump_count = 0;
}

// Handle jumping
if ((jump_buffer_count < jump_buffer && is_grounded) ||
(jump_count < jump_max && keyboard_check_pressed(control_jump)))
{
    vspeed = -jump_rate;
    jump_buffer_count = jump_buffer;
	on_slope = false;
	
	//Increment jump count if airborne
	if(!is_grounded)
	{
		jump_count++;
	}
}

//// Apply slope sliding when no input and on a slope
//if (is_grounded && on_slope) 
//{
//    handle_slope_sliding();
//}

// ===== END OF MOVEMENT HANDLING =====

// ===== COLLISION MOVEMENT HANDLING =====

// TILEMAP COLLISION
// Check for horizontal collision with tiles
if (!tile_meeting(x + hspeed, y))
{
    // No collision, safe to move
    x += hspeed;
}
else
{
    // Try to move pixel by pixel
    var i = 0;
    var max_steps = abs(hspeed);
    var dir = sign(hspeed);
    while (i < max_steps && !tile_meeting(x + dir, y))
    {
        x += dir;
        i++;
    }
    hspeed = 0;
}

// Check for vertical collision with tiles
if (!tile_meeting(x, y + vspeed))
{
    // No collision, safe to move vertically
    y += vspeed;
}
else
{
    // Try to move pixel by pixel
    var i = 0;
    var max_steps = abs(vspeed);
    var dir = sign(vspeed);
    while (i < max_steps && !tile_meeting(x, y + dir))
    {
        y += dir;
        i++;
    }
    vspeed = 0;
}

//OBJECT COLLISION (SLOPES)
// After tile movement, adjust for slopes
if (on_slope || vspeed >= 0)
{ // Check when falling or on slope
    handle_slope_movement();
}


// ===== END OF COLLISION MOVEMENT HANDLING =====

// ===== SPRITE MOVEMENT HANDLING =====

// Sprites
if (vspeed < 0) 
{
	if(jump_count == 0)
	{
		sprite_index = spr_player_jump;
	}
	else
	{
		sprite_index = spr_player_jump2;
	}
} 
else if (vspeed > 0) 
{ 
    sprite_index = spr_player_fall;  // New falling sprite when vspeed is positive
} 
else if (abs(hspeed) > 0.1)
{ 
    sprite_index = spr_player_run_right;
    image_xscale = sign(hspeed);
    if (image_xscale == 0) image_xscale = 1;  // Default to facing right if speed is exactly 0
} 
else 
{ 
    sprite_index = spr_player; 
}

// ===== END OF SPRITE MOVEMENT HANDLING =====

// ===== POST MOVEMENT DEBUG INFO =====

// Regular debug info
show_debug_message("HInput: " + string(move_input_total));
show_debug_message("Jump Buffer Count: " + string(jump_buffer_count));
show_debug_message("HSpeed: " + string(hspeed));
show_debug_message("VSpeed: " + string(vspeed));
show_debug_message("On Slope: " + string(on_slope));