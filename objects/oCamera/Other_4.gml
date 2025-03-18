//On room start enable viewport and make visible

view_enabled = true;
view_visible[0] = true;

// Check if the camera exists, otherwise create a new one
if (view_camera[0] == noone)
{
    view_camera[0] = camera_create_view(0, 0, view_width, view_height, 0, oPlayer, -1, -1, view_width / 2, view_height / 2);
}

// Assign the camera to the viewport
view_set_camera(0, view_camera[0]);

// Ensure the camera retains the correct zoom level
camera_set_view_size(view_camera[0], view_width, view_height);

// Reinitialize Parallax Layers
frontLayer = layer_get_id("bgLightGrass");
frontLayer2 = layer_get_id("bgLightFlowers");
middleLayer = layer_get_id("bgLightCloud");
backLayer = layer_get_id("bgLightSky");

darkFrontLayer = layer_get_id("bg_Dark_Graveyard");
darkMiddleLayer = layer_get_id("bg_DarkMountain");
darkBackLayer = layer_get_id("bg_DarkMoon");
