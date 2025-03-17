

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

if (mouse_check_button_pressed(mb_left))
{
    state = PLAYERSTATE.ATTACK;
}

	
switch(state)
{
	case PLAYERSTATE.FREE: PlayerState_Free();
		break;
		
	case PLAYERSTATE.ATTACK: PlayerState_Attack();
		break;
}
