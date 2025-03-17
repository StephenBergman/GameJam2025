function PlayerState_Test()
{
	// ======= MOVEMENT HANDLING =======
	
	resolve_stuck();
	player_handle_jump();
	player_move_vertical();
	player_move_horizontal();
	player_check_tile_collision();

	//OBJECT COLLISION (SLOPES)
	// After tile movement, adjust for slopes
	if (on_slope || vspeed >= 0)
	{ // Check when falling or on slope
	    handle_slope_movement();
	}

	// ===== SPRITE MOVEMENT HANDLING =====

	// Sprites
	if (vspeed < 0) 
	{
		if(jump_count == 0)
		{
			sprite_index = sPlayer_jump;
		}
		else
		{
			sprite_index = sPlayer_jump2;
		}
	} 
	else if (vspeed > 0) 
	{ 
	    sprite_index = sPlayer_fall;  // New falling sprite when vspeed is positive
	} 
	else if (abs(hspeed) > 0.1)
	{ 
	    sprite_index = sPlayer_run;
	    image_xscale = sign(hspeed);
	    if (image_xscale == 0) image_xscale = 1;  // Default to facing right if speed is exactly 0
	} 
	else 
	{ 
	    sprite_index = sPlayer; 
	}

	// ===== END OF SPRITE MOVEMENT HANDLING =====

	// ===== POST MOVEMENT DEBUG INFO =====

	// Regular debug info
	show_debug_message("HInput: " + string(move_input_total));
	show_debug_message("Jump Buffer Count: " + string(jump_buffer_count));
	show_debug_message("HSpeed: " + string(hspeed));
	show_debug_message("VSpeed: " + string(vspeed));
	show_debug_message("On Slope: " + string(on_slope));
}

//if(keyAttack) state = PLAYERSTATE.ATTACK;