function PlayerState_Combo()
{
    // Ensure animation plays
    image_speed = 1;

    // Play different animations for each combo step
    if (combo_step == 0)
    {
        sprite_index = sWarrior_slash1;
    }
    else if (combo_step == 1)
    {
        sprite_index = sWarrior_slash2;
    }
    else if (combo_step == 2)
    {
        sprite_index = sWarrior_stab;
    }

    // Play slash sound (once per attack)
    if (image_index == 0)
    {
        audio_play_sound(sdSlash, 1, false);
    }

    // Create the hitbox for each attack
    if (image_index == 1) // Adjust frame timing as needed
    {
        var sword_x = x + lengthdir_x(32, image_angle);
        var sword_y = y + lengthdir_y(32, image_angle);
        instance_create_layer(sword_x, sword_y, "Instances", oSwordHitbox);
    }

    // Prevent movement during attack
    hspeed = 0;
    vspeed = 0;

    // Check for combo input
    if (keyboard_check_pressed(control_attack) && combo_step < 2 && combo_timer > 0)
    {
        combo_step++; // Move to the next attack
        combo_timer = combo_window; // Reset combo window
        return; // Prevent resetting state immediately
    }

    // When attack animation is done
    if (image_index >= image_number - 1)
    {
        if (combo_step < 2 && combo_timer > 0)
        {
            // Wait to see if another attack happens
            combo_timer--;
        }
        else
        {
            // Reset combo and return to free movement
            combo_step = 0;
            state = PLAYERSTATE.FREE;
        }
    }
}
