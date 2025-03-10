//Draw player first
draw_sprite(sprite_index, image_index, x, y);

//Draw armor if equipped
if (armor_enabled) {
	draw_sprite(obj_armor_anim, image_index, x, y)
}