function PlayerState_Free()
{
	// ======= MOVEMENT HANDLING =======
	
	//Add slope buffer to prevent collision issues
	if (slope_buffer > 0) slope_buffer--;
	
	//Check if on a slope
	check_slope_collision();
	
	move_with_collision(hspeed, vspeed);
	
	var is_grounded = tile_meeting(x, y + 1);
	var is_colliding_x = tile_meeting(x + sign(hspeed), y);
	var is_colliding_y = tile_meeting(x, y + sign(vspeed));
	var is_inside_tilemap = tile_meeting(x, y);

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
		
		//play jump sound
		audio_play_sound(sdJump, 1, false);
	
		//Increment jump count if airborne
		if(!is_grounded)
		{
			jump_count++;
		}
	}

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
			if (tile_meeting(x + dir, y) && !tile_meeting(x, y + 1))
			{
				break;
			}
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
			sprite_index = sWarrior_jump;
		}
		else
		{
			sprite_index = sWarrior_jump;			
		}
	} 
	else if (vspeed > 0  && !is_grounded) 
	{ 
	    sprite_index = sWarrior_fall; // New falling sprite when vspeed is positive
	} 
	else if (abs(hspeed) > 0.1)
	{ 
	    sprite_index = sWarrior_run;
	    image_xscale = sign(hspeed);
	    if (image_xscale == 0) image_xscale = 1;  // Default to facing right if speed is exactly 0
	} 
	else if (vspeed == 0 && hspeed == 0)
	{ 
	    sprite_index = sWarrior_idle_naked; 
	}
	
	// Footstep Sound Logic
	if (abs(hspeed) > 0.1 && is_grounded) // Only play when moving on the ground
	{
		step_timer--;
		if (step_timer <= 0) 
	{
        audio_play_sound(sdFootstep, 1, false); // Play footstep sound
        step_timer = step_interval; // Reset step timer
    }
	}
	else
	{
	    step_timer = step_interval; // Reset when stopping
	}


	// ===== END OF SPRITE MOVEMENT HANDLING =====

	// ===== POST MOVEMENT DEBUG INFO =====

	// Regular debug info
	//show_debug_message("HInput: " + string(move_input_total));
	//show_debug_message("Jump Buffer Count: " + string(jump_buffer_count));
	//show_debug_message("HSpeed: " + string(hspeed));
	//show_debug_message("VSpeed: " + string(vspeed));
	//show_debug_message("On Slope: " + string(on_slope));
}