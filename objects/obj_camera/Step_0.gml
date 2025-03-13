//Fullscreen toggle
if keyboard_check_pressed(vk_f11)
{
	window_set_fullscreen(!window_get_fullscreen());
}

//Exit if theres no Player
if !instance_exists(obj_player_c) exit;

//Get camera size
var cam_width = camera_get_view_width(view_camera[0]);
var cam_height = camera_get_view_height(view_camera[0]);

//Get camera target coords
var cam_x = obj_player_c.x - cam_width/2;
var cam_y = obj_player_c.y - cam_height/2;

//Constrain cam to room borders
cam_x = clamp(cam_x, 0, room_width - cam_width);
cam_y = clamp(cam_y, 0 ,room_height - cam_height);

//Set cam coord variables
finalCamX += (cam_x - finalCamX) * camTrailSpd;
finalCamY += (cam_y - finalCamY) * camTrailSpd;

//Set camera coords
camera_set_view_pos(view_camera[0], finalCamX, finalCamY);