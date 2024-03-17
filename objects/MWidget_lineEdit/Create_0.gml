/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

text = "lineEdit";
text_background = "lineEdit";
color = $000000;
color_background = $ffffff;
font = FONT.WH12PX;
text_index = 0;

_index_flash_timer = 0;
_delete_timer = 0;
_move_timer = 0;

keyboard_string = "";

surf = -4;

state = MWIDGET_STATE.DEACTIVE;

select = false;

setText = function(_text) {
	text = _text;
}

accept = function(_text) {
	emit("accepted", [_text]);
}

function _step_deactive(_father, _selected) {
	select = _selected;
	if(!_selected) return;
	
	if(input_is_kb()) {
		if(_selected) {
			if((input_ms_rect_gui(
			x - left * UI_SCALE, y - top * UI_SCALE,
			x + right * UI_SCALE, y + bottom * UI_SCALE)
			&& ms_lp) || input_kb_pressed(INPUT.FUNC0)) {
				setActive();
				_father.setFocus(id);
				keyboard_string = "";
			}
		}
	}
	if(input_is_gp()) {
		if(_selected && input_gp_pressed(INPUT.FUNC0)) {
			setActive();
			_father.setFocus(id);
			keyboard_string = "";
		}
	}
}

	
function _step_active(_father, _selected) {
	select = _selected;
	if(!_selected) {
		setDeactive();
		return;
	}
	if(input_is_kb()) {
		if((ms_lp &&
		!input_ms_rect_gui(
		x - left * UI_SCALE, y - top * UI_SCALE,
		x + right * UI_SCALE, y + bottom * UI_SCALE)) ||
		input_kb_pressed(INPUT.FUNC1)) {
			setDeactive();
			_father.setFocus();
			return;
		}
	}
	if(input_is_gp()) {
		if(input_gp_pressed(INPUT.FUNC1)) {
			setDeactive();
			_father.setFocus();
			return;
		}
	}
	
	_index_flash_timer = (_index_flash_timer + 1) mod 60;
	text_index = clamp(text_index, 0, string_length(text));

	var ks = keyboard_string;
	if (keyboard_string != "") {
		
		if(string_length(text_index) <= 0) {
			text = keyboard_string;
		} else {
			text = string_copy(text, 1, text_index) +
			keyboard_string + string_copy(text, text_index + 1, string_length(text) - text_index);
		}
		text_index += string_length(keyboard_string);
		keyboard_string = "";
		_index_flash_timer = 0;
		text_index = clamp(text_index, 0, string_length(text));
		return;
	}
	
	if (keyboard_check_pressed(vk_enter)) {
		accept(text);
		return;
	}
	
	if(keyboard_check(vk_left)) {
		_move_timer ++;
		if(_move_timer == 1 || _move_timer >= 20) {
			_index_flash_timer = 0;
			text_index = clamp(text_index - 1, 0, string_length(text));
			if(_move_timer >= 20) _move_timer = 18;
		}
	} else if(keyboard_check(vk_right)) {
		_move_timer ++;
		if(_move_timer == 1 || _move_timer >= 20) {
			_index_flash_timer = 0;
			text_index = clamp(text_index + 1, 0, string_length(text));
			if(_move_timer >= 20) _move_timer = 18;
		}
	} else {
		_move_timer = 0;
	}
	
	if(input_is_kb() && ms_lp) {
		text_set_font(font);
		var _flag = false;
		var _w0 = 2;
		var _w1 = 2;
	
		for(var i = 1; i <= string_length(text); i ++) {
			_w1 = 2 + string_width(string_copy(text, 1, i));
			if(input_ms_rect_gui(
			x + (-left + _w0) * UI_SCALE,
			y - top * UI_SCALE,
			x + (-left + (_w1 + _w0) / 2) * UI_SCALE,
			y + bottom * UI_SCALE)) {
				_index_flash_timer = 0;
				text_index = clamp(i - 1, 0, string_length(text));
				_flag = true;
				break;
			}
			if(input_ms_rect_gui(
			x + (-left + (_w1 + _w0) / 2) * UI_SCALE,
			y - top * UI_SCALE,
			x + (-left + _w1) * UI_SCALE,
			y + bottom * UI_SCALE)) {
				_index_flash_timer = 0;
				text_index = clamp(i, 0, string_length(text));
				_flag = true;
				break;
			}
			_w0 = _w1;
		}
		
		if(!_flag) {
			if(input_ms_rect_gui(
			x + (-left + _w1) * UI_SCALE,
			y - top * UI_SCALE,
			x + right * UI_SCALE,
			y + bottom * UI_SCALE)) {
				text_index = string_length(text);
				_index_flash_timer = 0;
			}
		}
	}
	
	if(keyboard_check(vk_backspace)) {
		_delete_timer ++;
		if(text_index > 0) {
			if(_delete_timer == 1 || _delete_timer >= 20) {
				text = string_delete(text, text_index, 1);
				text_index = clamp(text_index - 1, 0, string_length(text));
				_index_flash_timer = 0;
				if(_delete_timer >= 20) _delete_timer = 18;
				return;
			}
		}
	} else if(keyboard_check(vk_delete)) {
		_delete_timer ++;
		if(text_index < string_length(text)) {
			if(_delete_timer == 1 || _delete_timer >= 16) {
				text = string_delete(text, text_index + 1, 1);
				text_index = clamp(text_index, 0, string_length(text));
				_index_flash_timer = 0;
				if(_delete_timer >= 16) _delete_timer = 14;
				return;
			}
		}
	} else {
		_delete_timer = 0;
	}
	
	otherFunc();
}

function _draw_active(_father, _alpha) {

	bm_set
	
	surf = surface_check(surf, left + right, top + bottom);
		
	surface_set_target(surf);
		draw_clear_alpha(color_background, 1);
	
		text_set_font(font);
		draw_set_color(color);
		draw_set_alpha(1);
		draw_set_valign(fa_middle);
		draw_set_halign(fa_left);

		if(string_length(text) <= 0) {
			draw_set_alpha(0.5);
			draw_text(2, (top + bottom) / 2, text_background);
		} else {
			draw_set_alpha(1);
			draw_text(2, (top + bottom) / 2, text);
		}
		
		var _w = 1 + string_width(string_copy(text, 1, text_index));
		var _h = top + bottom - 8;
		
		draw_set_alpha(_index_flash_timer < 30);
		draw_line(_w, 4, _w, 4 + _h);

	surface_reset_target();

	draw_set();
	draw_surface_ext(surf, x - left * UI_SCALE, y - top * UI_SCALE, UI_SCALE, UI_SCALE, 0, -1, _alpha);
	
	if(select) draw_set_color($ff0000);
	else draw_set_color($3f3f3f);
	draw_rectangle(
	x - left * UI_SCALE - 1, y - top * UI_SCALE - 1,
	x + right * UI_SCALE, y + bottom * UI_SCALE, true);
	draw_rectangle(
	x - left * UI_SCALE - 2, y - top * UI_SCALE - 2,
	x + right * UI_SCALE + 1, y + bottom * UI_SCALE + 1, true);
	draw_set();
	bm_reset
	
}


function _draw_deactive(_father, _alpha) {

	bm_set
	
	surf = surface_check(surf, left + right, top + bottom);
		
	surface_set_target(surf);
		draw_clear_alpha(color_background, 1);
	
		text_set_font(font);
		draw_set_color(color);
		draw_set_alpha(1);
		draw_set_valign(fa_middle);
		draw_set_halign(fa_left);

		if(string_length(text) <= 0) {
			draw_set_alpha(0.5);
			draw_text(2, (top + bottom) / 2, text_background);
		} else {
			draw_set_alpha(1);
			draw_text(2, (top + bottom) / 2, text);
		}
		
		var _w = string_width(string_copy(text, 1, text_index));
		var _h = top + bottom - 8;
		
		draw_set(color_background, 0.5);
		draw_rectangle(-1, -1, left + right + 1, top + bottom + 1, 0);
		
	surface_reset_target();

	draw_set();
	draw_surface_ext(surf, x - left * UI_SCALE, y - top * UI_SCALE, UI_SCALE, UI_SCALE, 0, -1, _alpha);
	
	if(select) draw_set_color($ff0000);
	else draw_set_color($3f3f3f);
	draw_rectangle(
	x - left * UI_SCALE - 1, y - top * UI_SCALE - 1,
	x + right * UI_SCALE, y + bottom * UI_SCALE, true);
	draw_rectangle(
	x - left * UI_SCALE - 2, y - top * UI_SCALE - 2,
	x + right * UI_SCALE + 1, y + bottom * UI_SCALE + 1, true);
	draw_set();
	bm_reset
}


