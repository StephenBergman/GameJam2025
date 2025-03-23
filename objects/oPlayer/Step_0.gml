

 //======= DIAGNOSTIC CHECKS =======
var is_grounded = tile_meeting(x, y + 1);
var is_colliding_x = tile_meeting(x + sign(hspeed), y);
var is_colliding_y = tile_meeting(x, y + sign(vspeed));
var is_inside_tilemap = tile_meeting(x, y);

// Check for slopes before other collision
var on_slope_last_frame = on_slope;
check_slope_collision();

// If on a slope, override the is_grounded value
if (on_slope) is_grounded = true;

if (player_debug_mode = true)
{
	show_debug_message("=== DIAGNOSTIC INFO ===");
	show_debug_message("Is Grounded: " + string(is_grounded));
	show_debug_message("Is Colliding X: " + string(is_colliding_x));
	show_debug_message("Is Colliding Y: " + string(is_colliding_y));
	show_debug_message("Is Inside Tilemap: " + string(is_inside_tilemap));

	show_debug_message("Current X: " + string(x) + ", Y: " + string(y));
	show_debug_message("Sprite Origin: " + string(sprite_get_xoffset(sprite_index)) + ", " + string(sprite_get_yoffset(sprite_index)));
	show_debug_message("Current Sprite: " + sprite_get_name(sprite_index));
	show_debug_message("Collision Mask: " + sprite_get_name(mask_index == -1 ? sprite_index : mask_index));
}


 //Prevent starting a frame stuck
if (is_inside_tilemap)
{
    resolve_stuck();
}

// Get input
move_input_total = 0;

if keyboard_check(control_left) || keyboard_check(control_left_alt) { move_input_total -= 1; }
if keyboard_check(control_right) || keyboard_check(control_right_alt) { move_input_total += 1; }

Interact_rooms();

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


if (attack_timer > 0) 
{
    attack_timer -= 1;
}

if (mouse_check_button_pressed(control_attack))
{
    state = PLAYERSTATE.ATTACK;
		//play slash sound
	audio_play_sound(sdSlash, 1, false);
	attack_timer = 10; // Cooldown before another attack can start
}

	
// Handle player states
switch (state)
{
    case PLAYERSTATE.FREE:
        PlayerState_Free();
        break;

    case PLAYERSTATE.ATTACK:
        if (image_index < image_number - 1)
		{
            PlayerState_Attack(); // Continue attack animation
        } else 
		{
            state = PLAYERSTATE.FREE; // Return to movement once attack animation is done
        }
        break;
}
