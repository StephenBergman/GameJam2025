if (pause = true)
{
	////Detect mouse hover
	//for (var i =0; i < array_length(pauseOption); i++) {
	//	var option_x = display_get_gui_width() * 0.5;
	//	var option_y = display_get_gui_height() * 0.5 + (i * 30);
		
	//	//Dynamically detect size of hitbox
	//	var textW = string_width(pauseOption[i]) * 0.5;
	//	var textH = string_height(pauseOption[i]) * 0.5;
		
	//	if (point_in_rectangle(mouse_x, mouse_y, option_x - textW - 100 , option_y - textH - 100, option_x + textW + 100, option_y + textH + 100))
	//	pauseOptionSelected = i; //Highlight hovered option
		
	//	//Mouse click selection
	//	if (mouse_check_button_pressed(mb_left)) {
	//		executeMenuSelection();
	//	}
	//}

	
	if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))) {
		pauseOptionSelected -= 1;
		if (pauseOptionSelected < 0) pauseOptionSelected = array_length(pauseOption) - 1; //Wrapping from top
	}
	
	if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("D"))) {
		pauseOptionSelected += 1;
		if (pauseOptionSelected >= array_length(pauseOption)) pauseOptionSelected = 0 //wrapping from bottom
	}
	
if (keyboard_check_pressed(vk_enter)) {
	executeMenuSelection();
}
}