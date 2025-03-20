pause = false; //Sets normal state to false
pauseSurf = -1;
pauseSurfBuffer= -1;
pauseOption = ["Continue", "RESET", "Options" , "Save and Quit" , "Save and Quit to Desktop"]; //Pause menu options
pauseOptionSelected = 0 //Defaults to top option
draw_set_font(fnt_pause);

//Game Resoulution
//Be sure to change this object if this changes
 resW = display_get_width();
 resH = display_get_height();

	 