//COLLISION HANDLING

/// Function to check if a point is colliding with a tile
function tile_meeting_point(x_pos, y_pos)
{
    // Get the tile at the given position
    var tile = tilemap_get_at_pixel(tilemap, x_pos, y_pos);
    // Return true if there's a tile (non-zero tile ID)
    return tile != 0;
}


/// Function to check if the player is colliding with tiles
function tile_meeting(x_pos, y_pos)
{
	var tolerance = .01 // Number of pixels to shrink from each side
	
    // Check each corner of the player's bounding box
    var s_bbox_left = x_pos + sprite_bbox_left + tolerance;
    var s_bbox_right = x_pos + sprite_bbox_right + tolerance;
    var s_bbox_top = y_pos + sprite_bbox_top + tolerance;
    var s_bbox_bottom = y_pos + sprite_bbox_bottom + tolerance;
    
    // Check all four corners and the middle points of each edge
    return 
        tile_meeting_point(s_bbox_left, s_bbox_top) ||
        tile_meeting_point(s_bbox_right, s_bbox_top) ||
        tile_meeting_point(s_bbox_left, s_bbox_bottom) ||
        tile_meeting_point(s_bbox_right, s_bbox_bottom) ||
        tile_meeting_point(s_bbox_left, (s_bbox_top + s_bbox_bottom) / 2) ||  // Middle of left edge
        tile_meeting_point(s_bbox_right, (s_bbox_top + s_bbox_bottom) / 2) || // Middle of right edge
        tile_meeting_point((s_bbox_left + s_bbox_right) / 2, s_bbox_top) ||   // Middle of top edge
        tile_meeting_point((s_bbox_left + s_bbox_right) / 2, s_bbox_bottom);  // Middle of bottom edge
}

/// Function to check if a point is colliding with obj_wall -> children
function object_meeting_point(x_pos, y_pos)
{
    // Check if the point collides with any obj_wall instance
    var inst = instance_position(x_pos, y_pos, obj_wall);
    // Return true if there's a collision
    return inst != noone;
}


/// Function to check if the player is colliding with obj_wall -> children
function object_meeting(x_pos, y_pos)
{
	var tolerance = .01 // Number of pixels to shrink from each side
	
    // Check each corner of the player's bounding box
    var s_bbox_left = x_pos + sprite_bbox_left + tolerance;
    var s_bbox_right = x_pos + sprite_bbox_right + tolerance;
    var s_bbox_top = y_pos + sprite_bbox_top + tolerance;
    var s_bbox_bottom = y_pos + sprite_bbox_bottom + tolerance;
    
    // Check all four corners and the middle points of each edge
    return 
        object_meeting_point(s_bbox_left, s_bbox_top) ||
        object_meeting_point(s_bbox_right, s_bbox_top) ||
        object_meeting_point(s_bbox_left, s_bbox_bottom) ||
        object_meeting_point(s_bbox_right, s_bbox_bottom) ||
        object_meeting_point(s_bbox_left, (s_bbox_top + s_bbox_bottom) / 2) ||  // Middle of left edge
        object_meeting_point(s_bbox_right, (s_bbox_top + s_bbox_bottom) / 2) || // Middle of right edge
        object_meeting_point((s_bbox_left + s_bbox_right) / 2, s_bbox_top) ||   // Middle of top edge
        object_meeting_point((s_bbox_left + s_bbox_right) / 2, s_bbox_bottom);  // Middle of bottom edge
}	


// Add this function to check for slope collision
function check_slope_collision() 
{
    // Reset slope status
    on_slope = false;
    slope_object = noone;
    
    // Check for slope objects below the player
    var slope = instance_place(x, y + 1, obj_wall);
    
    if (slope != noone) 
	{
        // If we found a potential slope object
        if (object_is_ancestor(slope.object_index, obj_wall) && slope.object_index != obj_wall)
		{
            // It's a child of obj_wall (a slope)
            on_slope = true;
            slope_object = slope;
            return true;
        }
    }
    
    return false;
}

// Add this function to handle movement on slopes
function handle_slope_movement() 
{
    if (!on_slope || slope_object == noone) return;
    
    // Get slope information
    var slope_x1, slope_y1, slope_x2, slope_y2;
    
    // Determine slope points based on object's angle or type
    // For this example, we'll assume you've set the slope direction in the object
    switch(slope_object.object_index) 
	{
        case obj_slope_tr: // 45 degrees top right
            slope_x1 = slope_object.bbox_left;
            slope_y1 = slope_object.bbox_bottom;
            slope_x2 = slope_object.bbox_right;
            slope_y2 = slope_object.bbox_top;
            break;
            
        case obj_slope_tl: // 45 degrees top left
            slope_x1 = slope_object.bbox_right;
            slope_y1 = slope_object.bbox_bottom;
            slope_x2 = slope_object.bbox_left;
            slope_y2 = slope_object.bbox_top;
            break;
            
        case obj_slope_br: // 45 degrees bottom right
            slope_x1 = slope_object.bbox_left;
            slope_y1 = slope_object.bbox_bottom;
            slope_x2 = slope_object.bbox_right;
            slope_y2 = slope_object.bbox_top;
            break;
            
        case obj_slope_bl: // 45 degrees bottom left
            slope_x1 = slope_object.bbox_right;
            slope_y1 = slope_object.bbox_bottom;
            slope_x2 = slope_object.bbox_left;
            slope_y2 = slope_object.bbox_top;
            break;
            
        default:
            // Unknown slope type - treat as ground
            on_slope = false;
            return;
    }
    
    // Calculate where player should be on the slope based on x position
    var t = (x - slope_x1) / (slope_x2 - slope_x1);
    t = clamp(t, 0, 1); // Ensure t is between 0 and 1
    
    var target_y = lerp(slope_y1, slope_y2, t) - 1; // -1 to stay slightly above the slope
    
    // If player is above the slope line, adjust y position
    if (bbox_bottom > target_y) {
        y = target_y - (bbox_bottom - y);
        is_grounded = true;
        vspeed = 0;
    }
}

// Add this function to handle sliding down slopes when appropriate
function handle_slope_sliding()
{
    if (!on_slope || slope_object == noone) return;
    
    // Optional: Add sliding on steep slopes when no input
    if (move_input_total == 0) 
	{
        // Determine slope direction and steepness
        var slope_direction = 0;
        
        switch(slope_object.object_index) 
		{
            case obj_slope_tr: // Top-Right slope
                slope_direction = -1; // Slide left on up-right slope
                break;
            case obj_slope_tl: // Top-Left slope
                slope_direction = 1;  // Slide right on up-left slope
                break;
            case obj_slope_br: // Bottom-Right slope
                slope_direction = -0.5; // Slide left slower on shallow slope
                break;
            case obj_slope_bl: // Bottom-Left slope
                slope_direction = 0.5;  // Slide right slower on shallow slope
                break;
        }
        
        // Apply small slide force
        hspeed += slope_direction * 0.1;
    }
}

// Function to resolve player being stuck in tiles
function resolve_stuck()
{
    if (tile_meeting(x, y))
	{
        // Try to move in each cardinal direction to find safe space
        var directions = [[0, -1], [1, 0], [0, 1], [-1, 0]];
        var max_push = 32; // Maximum distance to push out
        
        for (var d = 0; d < array_length(directions); d++)
		{
            var dir_x = directions[d][0];
            var dir_y = directions[d][1];
            
            for (var i = 1; i <= max_push; i++)
			{
                if (!tile_meeting(x + dir_x * i, y + dir_y * i))
				{
                    // Found safe position
                    x += dir_x * i;
                    y += dir_y * i;
                    return true;
                }
            }
        }
        // If we got here, we couldn't resolve the collision
        return false;
    }
    return true; // Not stuck
}
