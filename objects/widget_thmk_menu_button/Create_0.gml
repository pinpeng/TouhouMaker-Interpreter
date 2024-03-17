/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

function _step_active(_father, _selected) {
	select = _selected;
	if(!_selected) return;
	if(input_is_kb()) {
		if(_selected) {
			if(/*(input_ms_rect_vgui(
			x - left, y - top,
			x + right, y + bottom) &&
			ms_lp) || */input_kb_pressed(INPUT.FUNC0)) {
				press(_father);
			}
		}
	}
	if(input_is_gp()) {
		if(_selected && input_gp_pressed(INPUT.FUNC0)) {
			press(_father);
		}
	}
}

function _draw_active(_father, _alpha) {
	texft_on;
	draw_sprite_stretched_ext(sprite[select], sindex[select], x - left, y - top,
	(right + left), (bottom + top), $ffffff, _alpha);
	texft_off;
	if(select) draw_set($ffffff, _alpha);
	else draw_set($ff8000, _alpha);
	text_set(halign, valign);
	text_set_font(font);
	draw_text(x, y, text);
	draw_set();
}

function _draw_deactive(_father, _alpha) {
	texft_on;
	draw_sprite_stretched_ext(sprite[select], sindex[select], x - left, y - top,
	(right - left), (bottom - top), -1, _alpha / 2);
	texft_off;
	if(select) draw_set($ffffff, _alpha / 2);
	else draw_set($ff8000, _alpha / 2);
	text_set(halign, valign);
	text_set_font(font);
	draw_text(x, y, text);
	draw_set();
}



