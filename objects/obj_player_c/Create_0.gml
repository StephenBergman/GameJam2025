/// @description Init Vars

// Player Vars
move_rate = 8;
jump_rate = 16;
jump_buffer_count = 0;
jump_buffer = 10;
jump_ledge_buffer = 10;
jump_count = 0;
jump_max = 2;
accel_rate_ground = 1;
accel_rate_air = 0.1;
brake_rate_ground = 0.9;
brake_rate_air = 0.2;
gravity_vspeed = 8;
gravity_rate = 0.5;

// Controls
control_left = ord("A");
control_right = ord("D");
control_jump = vk_space;
// Alternate Controls
control_left_alt = vk_left;
control_right_alt = vk_right;
control_jump_alt = vk_up;

//Tile var
var collision_layer = layer_get_id("collision_map"); // Get the ID of the tilemap layer
tilemap = layer_tilemap_get_id(collision_layer); // Get the tilemap ID of the layer

//Sprite var
sprite_bbox_left = sprite_get_bbox_left(sprite_index) - sprite_get_xoffset(sprite_index);
sprite_bbox_right = sprite_get_bbox_right(sprite_index) - sprite_get_xoffset(sprite_index);
sprite_bbox_bottom = sprite_get_bbox_bottom(sprite_index) - sprite_get_yoffset(sprite_index);
sprite_bbox_top = sprite_get_bbox_top(sprite_index) - sprite_get_yoffset(sprite_index);
