// Check if player is within range
var _range = 32; // Adjust this based on how close you want the player to be

if (instance_exists(oPlayer))
{
    var _dist = point_distance(x, y, oPlayer.x, oPlayer.y);
    show_popup = (_dist < _range);
}
else
{
    show_popup = false;
}