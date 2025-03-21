if (transition_alpha > 0)
{
	draw_set_alpha(transition_alpha);
	draw_rectange(0 , 0, room_width, room_height, false);
	draw_set_alpha(1);
}