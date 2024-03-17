/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

press = function(_father) {}

select = false;

setting_group = "";
setting_item = "";

item = noone;

check_timer = 0;

function _step_active(_father, _selected) {
	
	select = _selected;
	if(!_selected) return;
	
	if(item.num == 0) {
		if(ms_l) {
			if(input_ms_rect_gui(
			x + right * 0.1 * UI_SCALE - 12 * UI_SCALE, y - top * UI_SCALE,
			x + right * 0.1 * UI_SCALE + 12 * UI_SCALE, y + bottom * UI_SCALE)) {
				check_timer ++;
				if(check_timer == 1 || check_timer >= 12) {
					if(check_timer >= 12) check_timer = 10;
					item.val = clamp(item.val - 1, 0, 100);
				}
			} else if(input_ms_rect_gui(
			x + right * 0.9 * UI_SCALE - 12 * UI_SCALE, y - top * UI_SCALE,
			x + right * 0.9 * UI_SCALE + 12 * UI_SCALE, y + bottom * UI_SCALE)) {
				check_timer ++;
				if(check_timer == 1 || check_timer >= 12) {
					if(check_timer >= 12) check_timer = 10;
					item.val = clamp(item.val + 1, 0, 100);
				}
			} else check_timer = 0;
		} else {
			if(input_kb(INPUT.LEFT)) {
				check_timer ++;
				if(check_timer == 1 || check_timer >= 12) {
					if(check_timer >= 12) check_timer = 10;
					item.val = clamp(item.val - 1, 0, 100);
				}
			} else if(input_kb(INPUT.RIGHT)) {
				check_timer ++;
				if(check_timer == 1 || check_timer >= 12) {
					if(check_timer >= 12) check_timer = 10;
					item.val = clamp(item.val + 1, 0, 100);
				}
			} else check_timer = 0;
		}
	} else if(item.num == 1) {
		if(ms_lp) {
			if(input_ms_rect_gui(
			x + right * 0.1 * UI_SCALE - 12 * UI_SCALE, y - top * UI_SCALE,
			x + right * 0.1 * UI_SCALE + 12 * UI_SCALE, y + bottom * UI_SCALE) ||
			input_ms_rect_gui(
			x + right * 0.9 * UI_SCALE - 12 * UI_SCALE, y - top * UI_SCALE,
			x + right * 0.9 * UI_SCALE + 12 * UI_SCALE, y + bottom * UI_SCALE)) {
				item.val = !item.val;
			}
		} else {
			if(input_kb_pressed(INPUT.LEFT) || input_kb_pressed(INPUT.RIGHT) ||
			input_kb_pressed(INPUT.FUNC0)) {
				item.val = !item.val;
			}
		}
	} else {
		if(ms_lp) {
			if(input_ms_rect_gui(
			x + right * 0.1 * UI_SCALE - 12 * UI_SCALE, y - top * UI_SCALE,
			x + right * 0.1 * UI_SCALE + 12 * UI_SCALE, y + bottom * UI_SCALE)) {
				item.val = (item.val - 1 + item.num) mod item.num;
			}
			if(input_ms_rect_gui(
			x + right * 0.9 * UI_SCALE - 12 * UI_SCALE, y - top * UI_SCALE,
			x + right * 0.9 * UI_SCALE + 12 * UI_SCALE, y + bottom * UI_SCALE)) {
				item.val = (item.val + 1 + item.num) mod item.num;
			}
		} else {
			if(input_kb_pressed(INPUT.LEFT)) {
				item.val = (item.val - 1 + item.num) mod item.num;
			}
			if(input_kb_pressed(INPUT.RIGHT)) {
				item.val = (item.val + 1 + item.num) mod item.num;
			}
		}
	}
	
	
	if(input_is_kb()) {
		if(_selected) {
			if((input_ms_rect_gui(
			x - left * UI_SCALE, y - top * UI_SCALE,
			x + right * UI_SCALE, y + bottom * UI_SCALE) &&
			ms_lp) || input_kb_pressed(INPUT.FUNC0)) {
				press(_father);
				emit("pressed");
			}
		}
	} else if(input_is_gp()) {
		if(_selected && input_gp_pressed(INPUT.FUNC0)) {
			press(_father);
			emit("pressed");
		}
	}
}

function _draw_active(_father, _alpha) {
	
	draw_set(color, _alpha);
	text_set(fa_left, fa_middle);
	text_set_font(font);
	text_draw_scale(x - left * UI_SCALE + 4, y, text, UI_SCALE, UI_SCALE);
	
	text_set(fa_center, fa_middle);
	
	if(item.num == 0) {
		text_draw_scale(x + right * 0.5 * UI_SCALE, y,
		string(setting_get(setting_group, setting_item)) + "%", UI_SCALE, UI_SCALE);
		
		draw_triangle(
		x + right * 0.1 * UI_SCALE - 12 * UI_SCALE, y,
		x + right * 0.1 * UI_SCALE, y + 8 * UI_SCALE,
		x + right * 0.1 * UI_SCALE, y - 8 * UI_SCALE, 0);
		draw_triangle(
		x + right * 0.9 * UI_SCALE + 12 * UI_SCALE, y,
		x + right * 0.9 * UI_SCALE, y + 8 * UI_SCALE,
		x + right * 0.9 * UI_SCALE, y - 8 * UI_SCALE, 0);
		
	} else if(item.num == 1) {
			
		text_draw_scale(x + right * 0.5 * UI_SCALE, y,
		string(setting_get(setting_group, setting_item))? "Yes": "No", UI_SCALE, UI_SCALE);
		
		draw_triangle(
		x + right * 0.1 * UI_SCALE - 12 * UI_SCALE, y,
		x + right * 0.1 * UI_SCALE, y + 8 * UI_SCALE,
		x + right * 0.1 * UI_SCALE, y - 8 * UI_SCALE, 0);
		draw_triangle(
		x + right * 0.9 * UI_SCALE + 12 * UI_SCALE, y,
		x + right * 0.9 * UI_SCALE, y + 8 * UI_SCALE,
		x + right * 0.9 * UI_SCALE, y - 8 * UI_SCALE, 0);
			
	} else {
		
		text_draw_scale(x + right * 0.5 * UI_SCALE, y,
		word("__msetting", setting_group + "_" + setting_item + "_" + 
		string(setting_get(setting_group, setting_item))), UI_SCALE, UI_SCALE);
		
		draw_triangle(
		x + right * 0.1 * UI_SCALE - 12 * UI_SCALE, y,
		x + right * 0.1 * UI_SCALE, y + 8 * UI_SCALE,
		x + right * 0.1 * UI_SCALE, y - 8 * UI_SCALE, 0);
		draw_triangle(
		x + right * 0.9 * UI_SCALE + 12 * UI_SCALE, y,
		x + right * 0.9 * UI_SCALE, y + 8 * UI_SCALE,
		x + right * 0.9 * UI_SCALE, y - 8 * UI_SCALE, 0);
	}
	
	draw_set_alpha(_alpha);
	if(select) draw_set_color($ff0000);
	else draw_set_color($3f3f3f);
	draw_rectangle(
	x - left * UI_SCALE - 1, y - top * UI_SCALE - 1,
	x + right * UI_SCALE, y + bottom * UI_SCALE, true);
	draw_rectangle(
	x - left * UI_SCALE - 2, y - top * UI_SCALE - 2,
	x + right * UI_SCALE + 1, y + bottom * UI_SCALE + 1, true);
	draw_set();
	
}

function _draw_deactive(_father, _alpha) {
	
	draw_set_alpha(_alpha);
	if(select) draw_set_color($ff0000);
	else draw_set_color($3f3f3f);
	draw_rectangle(
	x - left * UI_SCALE - 1, y - top * UI_SCALE - 1,
	x + right * UI_SCALE, y + bottom * UI_SCALE, true);
	draw_rectangle(
	x - left * UI_SCALE - 2, y - top * UI_SCALE - 2,
	x + right * UI_SCALE + 1, y + bottom * UI_SCALE + 1, true);
	draw_set(color, _alpha / 2);
	text_set(halign, valign);
	text_set_font(font);
	text_draw_scale(x - left * UI_SCALE + 4, y, text, UI_SCALE, UI_SCALE);
	draw_set();
}

