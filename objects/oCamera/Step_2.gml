//Fullscreen toggle
if keyboard_check_pressed(vk_f11)
{
	window_set_fullscreen(!window_get_fullscreen());
}

//Exit if theres no Player
if !instance_exists(oPlayer) exit;

//Get camera size
var cam_width = camera_get_view_width(view_camera[0]);
var cam_height = camera_get_view_height(view_camera[0]);

//Get camera target coords
var cam_x = oPlayer.x - cam_width/2;
var cam_y = oPlayer.y - cam_height/2;

//Constrain cam to room borders
cam_x = clamp(cam_x, 0, room_width - cam_width);
cam_y = clamp(cam_y, 0 ,room_height - cam_height);

//Set cam coord variables
var y_tolerance = 40;
finalCamX += (cam_x - finalCamX) * camTrailSpd;
finalCamY += (cam_y - finalCamY - y_tolerance) * camTrailSpd;

//Set camera coords
camera_set_view_pos(view_camera[0], finalCamX, finalCamY);

if (layer_exists(backLayer))
{
	layer_x(backLayer, cam_x/1.5);
	layer_x(middleLayer, cam_x/4);
	layer_x(frontLayer, cam_x/100);
}