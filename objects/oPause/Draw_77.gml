//Disable alpha blending
gpu_set_blendenable(false);

if (pause) //Draw frozen image to screen if paused
{
	surface_set_target(application_surface);
	if (surface_exists(pauseSurf)) draw_surface(pauseSurf, 0, 0);
	else //Restore from buffer if we lost surface
	{
		pauseSurf = surface_create(resW, resH);
		buffer_set_surface(pauseSurfBuffer, pauseSurf,0);
	}
	surface_reset_target();
}

if (keyboard_check_pressed(vk_escape))
{
	if (!pause) // pause now
	{ 
		pause = true;
		
		//deactivate everything except this instance
		instance_deactivate_all(true);
		
		//Note: need to pause sprites, tiles, backgrounds separately
		
		//Capture this game moment
		pauseSurf = surface_create(resW, resH);
		surface_set_target(pauseSurf);
		draw_surface(application_surface, 0, 0);
		surface_reset_target();
		
		//back up this surface in case lost
		if (buffer_exists(pauseSurfBuffer)) buffer_delete(pauseSurfBuffer);
		pauseSurfBuffer = buffer_create(resW * resH * 4, buffer_fixed, 1);
		buffer_get_surface(pauseSurfBuffer, pauseSurf, 0);
	}
	else //unpause now
	{
		pause = false;
		instance_activate_all();
		if (surface_exists(pauseSurf)) surface_free(pauseSurf);
		if (buffer_exists(pauseSurfBuffer)) buffer_delete(pauseSurfBuffer);
	}
}

//Re-enable alpha blend
gpu_set_blendenable(true);