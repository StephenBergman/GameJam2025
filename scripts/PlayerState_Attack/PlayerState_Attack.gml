function PlayerState_Attack()
{
	// Set attack animation
    sprite_index = sWarrior_slash1;
	image_speed = 1; // Ensure animation plays
    //if (image_index == 0) show_debug_message("Attack animation started");
	
if (PLAYERSTATE.ATTACK)
{
	var sword_x = x + lengthdir_x(32, image_angle); // Position sword in front of player
    var sword_y = y + lengthdir_y(32, image_angle);
    
    instance_create_layer(sword_x, sword_y, "Instances", oSwordHitbox);
}
    // Prevent movement during attack
    hspeed = 0;
    vspeed = 0;
    // Attack hit detection (Optional)
    //var hitbox = instance_place(x + (image_xscale * 10), y, oEnemy);
    //if (hitbox) 
	//{
    //    with (hitbox) instance_destroy(); // Destroy enemy on hit
    //}

    //Return to free movement when animation is done
    if (image_index >= image_number - 1) 
	{
        state = PLAYERSTATE.FREE;
    }
}