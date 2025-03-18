

view_width = 1920/4; //
view_height = 1080/4; //

window_scale = 3;

window_set_size(view_width * window_scale, view_height * window_scale);
alarm[0] = 1;

surface_resize(application_surface, view_width * window_scale, view_height * window_scale);

finalCamX = 0;
finalCamY = 0;

camTrailSpd = 0.4;

//parallax vars
frontLayer = layer_get_id("bg_Dark_Graveyard");
middleLayer = layer_get_id("bg_DarkMountain");
backLayer = layer_get_id("bg_DarkMoon");
