/// @description Init Vars

enum PLAYERSTATE
{
	FREE,
	ATTACK
}

state = PLAYERSTATE.FREE;
hitByAttack = ds_list_create();

// Player Vars
move_rate = 2;
jump_rate = 4;
jump_buffer_count = 0;
jump_buffer = 10;
jump_ledge_buffer = 5;
jump_count = 0;
jump_max = 1;
jump_held = false;
accel_rate_ground = 1;
accel_rate_air = 0.1;
brake_rate_ground = 0.9;
brake_rate_air = 0.2;
gravity_vspeed = 3;
gravity_rate_base = 0.3;
gravity_rate_peak = 0.15;
gravity_rate_fast = 0.5;


// Controls
control_left = ord("A");
control_right = ord("D");
control_jump = vk_space;
control_attack = mb_left;
control_interact =  ord("E");
// Alternate Controls
control_left_alt = vk_left;
control_right_alt = vk_right;
control_jump_alt = vk_up;
control_interact_alt = vk_enter;


//Sprite var
sprite_bbox_left = sprite_get_bbox_left(sprite_index) - sprite_get_xoffset(sprite_index);
sprite_bbox_right = sprite_get_bbox_right(sprite_index) - sprite_get_xoffset(sprite_index);
sprite_bbox_bottom = sprite_get_bbox_bottom(sprite_index) - sprite_get_yoffset(sprite_index);
sprite_bbox_top = sprite_get_bbox_top(sprite_index) - sprite_get_yoffset(sprite_index);

//Tile var
var collision_layer = layer_get_id("collision_map"); // Get the ID of the tilemap layer
tilemap = layer_tilemap_get_id(collision_layer); // Get the tilemap ID of the layer

//Separate variables for slope collision
slope_max_angle = 45;  // Maximum angle (in degrees) player can climb
on_slope = false;      // Flag to track if player is on a slope
slope_object = noone;  // Reference to current slope object
slope_buffer = 0;

//Debug Mode
player_debug_mode = false;

