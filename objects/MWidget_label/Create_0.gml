/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

text = "Label";
halign = fa_center;
valign = fa_middle;
color = $ffffff;
font = FONT.WH12PX;

function _draw_active(_father, _alpha) {
	draw_set(color, _alpha);
	text_set(halign, valign);
	text_set_font(font);
	text_draw_scale(x, y, text, UI_SCALE, UI_SCALE);
	draw_set();
}

function _draw_deactive(_father, _alpha) {
	draw_set(color, _alpha / 2);
	text_set(halign, valign);
	text_set_font(font);
	text_draw_scale(x, y, text, UI_SCALE, UI_SCALE);
	draw_set();
}

