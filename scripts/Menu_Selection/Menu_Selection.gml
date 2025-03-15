function executeMenuSelection(){
	
	if (keyboard_check_pressed(vk_enter)) {
		switch (pauseOptionSelected) {
			case 0: //continue
			
			pause = false;
			instance_activate_all();
			if (surface_exists(pauseSurf)) surface_free(pauseSurf);
			if (buffer_exists(pauseSurfBuffer)) buffer_delete(pauseSurfBuffer);
		
			break;
			
			case 1: //options
			show_message("Please implement options menu");
			break;
			
			case 2: //Save and Quit
			show_message("please implement saving");
			break;
			
			case 3: //Save and Quit to desktop
			show_message("please implement save and quit");
			break;
		}
	}
}
