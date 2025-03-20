function Interact_rooms()
{
    var interact = keyboard_check_pressed(control_interact) || keyboard_check_pressed(control_interact_alt);
    
    if (interact) 
    {
        var _door = instance_place(x, y, oRoomDoor);
        
        if (_door != noone && _door.target_room != noone) 
        {
            room_goto(_door.target_room);
        }
    }

}