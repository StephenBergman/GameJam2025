if (fnt_death != -1) {
    draw_set_font(fnt_death);
}

// Get GUI width/height
var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

// Draw black background
draw_set_alpha(image_alpha);
draw_set_color(c_black);
draw_rectangle(0, 0, gui_w, gui_h, false);

// Ensure text is centered
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_red);
draw_set_alpha(1);

// Correctly center the text
draw_text(gui_w / 2, gui_h / 2, "YOU DIED");

// Reset alpha
draw_set_alpha(1);