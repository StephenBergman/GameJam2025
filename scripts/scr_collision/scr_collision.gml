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
	var tolerance = 5 // Number of pixels to shrink from each side
	
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
