if (pause) 
{ 
	draw_set_color(c_black);
	draw_set_alpha(0.75);
	draw_rectangle(0,0, resW, resH, false);
	draw_set_alpha(1.0);
	draw_set_color(c_white);
	draw_set_valign(fa_middle);
	draw_set_halign(fa_center);
	
	draw_text(display_get_gui_width() * 0.5 , display_get_gui_height() *0.5, "Game Paused");
	for (var i = 0; i < array_length(pauseOption); i++) {
		//Set default color
		draw_set_color(c_white);
		
		//Highlight selected option
		if (i == pauseOptionSelected) { 
			draw_set_color(c_red);
		}
		
		//Draw menu text
		draw_text(display_get_gui_width() * 0.5, (display_get_gui_height() * 0.6) + (i * 30), pauseOption[i]);
	}
}