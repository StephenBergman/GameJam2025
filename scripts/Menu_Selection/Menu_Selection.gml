function executeMenuSelection()
{
	
	if (keyboard_check_pressed(vk_enter))
	{
		switch (pauseOptionSelected)
		{
			case 0: //continue
			
			pause = false;
			instance_activate_all();
			if (surface_exists(pauseSurf)) surface_free(pauseSurf);
			if (buffer_exists(pauseSurfBuffer)) buffer_delete(pauseSurfBuffer);
		
			break;
			
			case 1:
			pause = false;
			instance_activate_all();
			resetToInitialSpawn();
			break;
			
			case 2: //options
			show_message("Please implement options menu");
			break;
			
			case 3: //Save and Quit
			show_message("please implement saving");
			break;
			
			case 4: //Save and Quit to desktop
			show_message("please implement save and quit");
			break;
		}
	}
}

function resetToInitialSpawn()
{
    if (instance_exists(oPlayer))
	{
        with (oPlayer)
		{
			room_goto(rDev);
            x = global.initial_spawn_x;
            y = global.initial_spawn_y;
        }
    }
    
    // Optional: Reset any game states (like health, collected items, etc.)
    show_debug_message("Player reset to first spawn point");
}
