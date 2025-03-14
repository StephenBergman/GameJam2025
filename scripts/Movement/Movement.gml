function player_handle_jump()
{
		// Jump input buffer logic
	if (jump_buffer_count < jump_buffer)
	{
	    jump_buffer_count++;
	}

	// Handle jump when buffered or pressed
	if ((jump_buffer_count < jump_buffer && is_grounded) ||
	(jump_count < jump_max && (keyboard_check_pressed(control_jump) || keyboard_check_pressed(control_jump_alt))))
	{
	    vspeed = -jump_rate;  // Apply jump force
	    jump_buffer_count = jump_buffer;  // Reset jump buffer count
	    on_slope = false;  // Ensure we're not on a slope during jump

	    // Increment jump count if airborne
	    if(!is_grounded)
	    {
	        jump_count++;
	    }
	}
}

function player_move_horizontal()
{
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

	// Limit horizontal speed
	hspeed = clamp(hspeed, -move_rate, move_rate);
}

function player_move_vertical()
{
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

	    // Cap gravity speed
	    if (vspeed > gravity_vspeed) vspeed = gravity_vspeed;
	}
	else
	{
	    // Reset vertical speed when on ground
	    vspeed = 0;
	    jump_count = 0;  // Reset jump count when grounded
	}
}

function player_check_tile_collision()
{
		// Check horizontal collision with tiles
	if (!tile_meeting(x + hspeed, y))
	{
	    // No collision, move horizontally
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

	// Check vertical collision with tiles
	if (!tile_meeting(x, y + vspeed))
	{
	    // No collision, move vertically
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
}

function player_handle_slope_movement()
{
	if (on_slope || vspeed >= 0)  // Check if the player is on a slope or falling
	{
	    // Handle movement on slope, e.g., sliding, slope-specific acceleration
	    // You may need to use collision checks to adjust position or speed here
	    // Example (basic slope sliding):
	    if (is_grounded && on_slope)
	    {
	        // Adjust speed based on slope angle
	        hspeed *= 0.5;  // Example: apply sliding friction
	    }
	}
}

function player_resolve_stuck()
{
	// Basic implementation to resolve stuck state (optional)
	if (is_inside_tilemap)
	{
	    // Attempt to move the player by one pixel in each direction
	    if (!tile_meeting(x + sign(hspeed), y))
	    {
	        x += sign(hspeed);
	    }
	    else if (!tile_meeting(x, y + sign(vspeed)))
	    {
	        y += sign(vspeed);
	    }
	    else
	    {
	        // If stuck, reset position or force movement
	        x -= sign(hspeed);
	        y -= sign(vspeed);
	    }
	}
}