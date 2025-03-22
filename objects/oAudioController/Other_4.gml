
//Global Game SoundTrack
if(!audio_is_playing(global.game_soundtrack))
{
	global.game_soundtrack = audio_play_sound(sdGame_Track1, 1 ,true);
}


// Cave water droplet ambient
if (room == rTutorial_CaveStart)
{
	if(audio_is_playing(global.ambient_sound))
	{
		audio_stop_sound(global.ambient_sound);
	}
	
	global.ambient_sound = audio_play_sound(sdWater_droplets, 1, true);
}

// Forest birds ambient
if (room == rTutorial_Forest)
{
	if(audio_is_playing(global.ambient_sound))
	{
		audio_stop_sound(global.ambient_sound);
	}
	
	global.ambient_sound = audio_play_sound(sdForest_birds, 1, true);
}

// Field Wind ambient
if (room == rTutorial_toTown)
{
	if(audio_is_playing(global.ambient_sound))
	{
		audio_stop_sound(global.ambient_sound);
	}
	
	global.ambient_sound = audio_play_sound(sdWind, 1, true);
}