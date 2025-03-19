
persistent = true;

view_width = (1920/4); //
view_height = (1080/4); //

// Apply the new view size to the camera
camera_set_view_size(view_camera[0], view_width, view_height);

window_scale = 4;
zoom_factor = 1.5; // Increase to zoom out

window_set_size(view_width * window_scale, view_height * window_scale);
alarm[0] = 1;

surface_resize(application_surface, view_width * window_scale, view_height * window_scale);

finalCamX = 0;
finalCamY = 0;

camTrailSpd = 0.4;



// Reset parallax layer variables to avoid uninitialized errors
frontLayer = noone;
frontLayer2 = noone;
middleLayer = noone;
backLayer = noone;

//Light Parallax vars
frontLayer = layer_get_id("bgLightGrass");
frontLayer2 = layer_get_id("bgLightFlowers");
middleLayer = layer_get_id("bgLightCloud");
backLayer = layer_get_id("bgLightSky");
//Dark Parallax vars
darkFrontLayer = layer_get_id("bg_Dark_Graveyard");
darkMiddleLayer = layer_get_id("bg_DarkMountain");
darkBackLayer = layer_get_id("bg_DarkMoon");
