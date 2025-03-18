
//Fullscreen toggle
if keyboard_check_pressed(vk_f11)
{
	window_set_fullscreen(!window_get_fullscreen());
}

//Exit if theres no Player
if !instance_exists(oPlayer) exit;

// Get base camera size
var base_width = 1920 / 4;
var base_height = 1080 / 4;

// Apply zoom without affecting window size
var cam_width = base_width * zoom_factor;
var cam_height = base_height * zoom_factor;

// Set the new camera size
camera_set_view_size(view_camera[0], cam_width, cam_height);
var cam_offset = 0;
//Get camera target coords
var cam_x = oPlayer.x - cam_width/2 - cam_offset;
var cam_y = oPlayer.y - cam_height/2 - cam_offset;

//Constrain cam to room borders
cam_x = clamp(cam_x, 0, room_width - cam_width);
cam_y = clamp(cam_y, 0 ,room_height - cam_height);

//Set cam coord variables
var y_tolerance = 40;
finalCamX += (cam_x - finalCamX) * camTrailSpd;
finalCamY += (cam_y - finalCamY - y_tolerance) * camTrailSpd;

//Set camera coords
camera_set_view_pos(view_camera[0], finalCamX, finalCamY);

if (layer_exists(frontLayer))
{
	layer_x(backLayer, cam_x/1.2);
	layer_x(middleLayer, cam_x/2);
	layer_x(frontLayer, cam_x/4);
	layer_x(frontLayer2, cam_x/8);
}

if (layer_exists(darkFrontLayer))
{
	layer_x(darkBackLayer, cam_x/1.1);
	layer_x(darkMiddleLayer, cam_x/1.5);
	layer_x(darkFrontLayer, cam_x/10);
}