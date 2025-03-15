draw_self();

//Draw equipped weapon
if(global.player.equipment.Weapon != noone) {
	var weapon = global.player.equipment.Weapon;
	
	x = obj_player.x;
	y = obj_player.y;
	
	//flip weapon if player sprite is facing left
	var flip = (image_xscale < 0) ? -1 : 1;
	
	draw_sprite_ext(
	weapon.Sprite,		   // weapon sprite
	0,					   // subimage
	x + -2 + flip,		   // x pos
	y + -2 ,			   // y pos
	flip,				   // flip horizontally
	1,					   // Scale y
	0,				       // rotation
	c_white,			   // Color
	1.0					   // Transparency
	);
}