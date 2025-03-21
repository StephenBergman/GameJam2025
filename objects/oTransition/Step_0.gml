if(transitioning)
{
	transition_alpha += 0.1; // fade out
	if(transition_alpha >= 1)
	{
		room_goto(target_room);
	}
}
else if (transition_alpha > 0)
{
	transition_alpha -= 0.1; // fade in
}