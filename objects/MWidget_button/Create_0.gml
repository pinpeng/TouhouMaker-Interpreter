/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

sprite[0]  = SprUI_mwindow_widget_button;
sindex[0]  = 0;
sprite[1] = SprUI_mwindow_widget_button;
sindex[1]  = 1;

press = function(_father) {
	emit("pressed");
}

select = false;

function _step_active(_father, _selected) {
	select = _selected;
	if(!_selected) return;
	if(input_is_kb()) {
		if(_selected) {
			if((input_ms_rect_gui(
			x - left * UI_SCALE, y - top * UI_SCALE,
			x + right * UI_SCALE, y + bottom * UI_SCALE) &&
			ms_lp) || input_kb_pressed(INPUT.FUNC0)) {
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
	draw_sprite_stretched_ext(sprite[select], sindex[select], x - left * UI_SCALE, y - top * UI_SCALE,
	(right + left) * UI_SCALE, (bottom + top) * UI_SCALE, $ffffff, _alpha);
	draw_set(color, _alpha);
	text_set(halign, valign);
	text_set_font(font);
	text_draw_scale(x, y, text, UI_SCALE, UI_SCALE);
	draw_set();
}

function _draw_deactive(_father, _alpha) {
	draw_sprite_stretched_ext(sprite[select], sindex[select], x - left * UI_SCALE, y - top * UI_SCALE,
	(right - left) * UI_SCALE, (bottom - top) * UI_SCALE, -1, _alpha / 2);
	draw_set(color, _alpha / 2);
	text_set(halign, valign);
	text_set_font(font);
	text_draw_scale(x, y, text, UI_SCALE, UI_SCALE);
	draw_set();
}

