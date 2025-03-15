draw_self();

//Draw equipped weapon
if(global.player.equipment.Weapon != noone) {
	var weapon = global.player.equipment.Weapon;
	
	//Adjust weapon position
	var offset_x = -9; //Align with idle hand
	var offset_y = -3; 
	
	//flip weapon if player sprite is facing left
	var flip = (image_xscale < 0) ? -1 : 1;
	
	draw_sprite_ext(
	weapon.Sprite, //weapon sprite
	0,			   // subimage
	x + (offset_x * flip), //x pos
	y + offset_y,		   // y pos
	flip,				   // flip horizontally
	1,					   //Scale y
	0,				       // rotation
	c_white,			   //Color
	1.0					   //Transparency
	);
}