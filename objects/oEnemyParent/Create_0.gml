// Default values for all enemies (Can be modified in create event for individual enemies)
counter = 0;
hp = 30;
flash = 0;
move_rate = 0;
hspeed = move_rate;
gravity = 0.0;
gravity_amount = 0.3


// Default state
state = EnemyState.Idle;

// Random movement
move_dir = irandom_range(0, 180); // Full range movement
moveX = lengthdir_x(move_rate, move_dir);
//moveY = lengthdir_y(move_rate, move_dir);

//Tile var
var collision_layer = layer_get_id("collision_map"); // Get the ID of the tilemap layer
tilemap = layer_tilemap_get_id(collision_layer); // Get the tilemap ID of the layer

//Slope Collision
slope_max_angle = 45;  // Maximum angle (in degrees) player can climb
on_slope = false;      // Flag to track if player is on a slope
slope_object = noone;  // Reference to current slope object

//Sprite vars
sprite_bbox_left = sprite_get_bbox_left(sprite_index) - sprite_get_xoffset(sprite_index);
sprite_bbox_right = sprite_get_bbox_right(sprite_index) - sprite_get_xoffset(sprite_index);
sprite_bbox_bottom = sprite_get_bbox_bottom(sprite_index) - sprite_get_yoffset(sprite_index);
sprite_bbox_top = sprite_get_bbox_top(sprite_index) - sprite_get_yoffset(sprite_index);

// Initialize AI 
if (!variable_instance_exists(self, "ai")) {
    ai = new EnemyAI(self);
}

// Ensure the object has a valid sprite assigned
if (sprite_index != -1) {
    sprite_bbox_left   = sprite_get_bbox_left(sprite_index) - sprite_get_xoffset(sprite_index);
    sprite_bbox_right  = sprite_get_bbox_right(sprite_index) - sprite_get_xoffset(sprite_index);
    sprite_bbox_top    = sprite_get_bbox_top(sprite_index) - sprite_get_yoffset(sprite_index);
    sprite_bbox_bottom = sprite_get_bbox_bottom(sprite_index) - sprite_get_yoffset(sprite_index);
} else {
    // Default to 0 to avoid undefined errors if no sprite is assigned
    sprite_bbox_left   = 0;
    sprite_bbox_right  = 0;
    sprite_bbox_top    = 0;
    sprite_bbox_bottom = 0;
}
show_debug_message("Tilemap ID in Enemy: " + string(tilemap));