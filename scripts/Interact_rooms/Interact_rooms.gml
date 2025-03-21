function Interact_rooms()
{
    var interact = keyboard_check_pressed(control_interact) || keyboard_check_pressed(control_interact_alt);
    
    if (interact) 
    {
        var _door = instance_place(x, y, oRoomDoor);
        
		if (_door != noone && _door.target_room != noone) 
		{
		    global.spawn_x = _door.exit_x;
		    global.spawn_y = _door.exit_y;
			transitioning = true;
		    room_goto(_door.target_room);
		}
    }

}

function Passthru_rooms()
{       
	if (other.target_room != noone) 
	{
		global.spawn_x = other.exit_x;
		global.spawn_y = other.exit_y;
		transitioning = true;
		room_goto(other.target_room);
	}
}