// Store the player's current position
var spawn_x = other.x;
var spawn_y = other.y;

// Store movement direction
var move_direction = other.image_xscale; 

// Destroy the vulnerable player
instance_destroy(other);

// Create the nightmare player at the same position
var new_player = instance_create_depth(spawn_x, spawn_y, 0, obj_nightmare_player);

// Maintain movement direction (so the player doesn’t flip)
new_player.image_xscale = move_direction;

// Optional: Play a transformation effect
//audio_play_sound(snd_transform, 1, false);

// Destroy the armor pickup
instance_destroy();
