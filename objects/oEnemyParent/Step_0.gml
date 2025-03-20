//show_debug_message("checking: step event is running!");

if (ai != undefined) {
    //show_debug_message("ai exists in step event");
    ai.step();
    //show_debug_message("ai step running - current state: " + string(ai.state));
} else {
    //show_debug_message("error: ai is undefined in step event!");
}

// tile collision detection using bounding box
var is_grounded = tile_meeting(x, bbox_bottom + 1);
var detected_tile = tilemap_get_at_pixel(tilemap, x, bbox_bottom + 1);

// apply gravity when not grounded
if (!is_grounded) {
    vspeed += 0.3; // apply gravity
} else {
    vspeed = 0; // stop falling
}

// apply movement before collisions
x += hspeed;
y += vspeed;

// prevent sinking into the floor
if (tile_meeting(x, bbox_bottom + 1)) {
    vspeed = 0;
}

// object collision (slopes)
if (on_slope || vspeed >= 0) { 
    handle_slope_movement();
}

//// debugging output
//show_debug_message(
//    "enemy state: " + string(ai.state) +
//    " | x: " + string(x) + " | y: " + string(y) +
//    " | vspeed: " + string(vspeed) +
//    " | grounded: " + string(is_grounded) +
//    " | detected tile: " + string(detected_tile) +
//    " | bbox_bottom: " + string(bbox_bottom)
//);

// tile collision function
function tile_meeting(x_pos, y_pos) {
    x_pos = floor(x_pos); // ensure integer values
    y_pos = floor(y_pos);

    var tile = tilemap_get_at_pixel(tilemap, x_pos, y_pos);

    if (tile > 0) {
        //show_debug_message("collision detected at: (" + string(x_pos) + ", " + string(y_pos) + ") with tile: " + string(tile));
        return true;
    } else {
        //show_debug_message("no collision at: (" + string(x_pos) + ", " + string(y_pos) + ")");
        return false;
    }
}


