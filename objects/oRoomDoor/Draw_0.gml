//draw_self();

if (show_popup)
{
    var popup_y = y - sprite_height + 16; // Adjust height above the object
    draw_sprite(sE_button, 0, x - 16, popup_y);
	draw_sprite(sY_button, 0, x + 16, popup_y);
}