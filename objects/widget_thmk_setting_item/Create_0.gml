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
		
		if(0/*ms_l*/) {
			if(input_ms_rect_vgui(
			x + right * 0.5 - 144 - 24, y - top,
			x + right * 0.5 - 144 + 24, y + bottom)) {
				check_timer ++;
				if(check_timer == 1 || check_timer >= 12) {
					if(check_timer >= 12) check_timer = 10;
					item.val = clamp(item.val - 1, 0, 100);
				}
			} else if(input_ms_rect_vgui(
			x + right * 0.5 + 144 - 24, y - top,
			x + right * 0.5 + 144 + 24, y + bottom)) {
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
		if(0/*ms_lp*/) {
			if(input_ms_rect_vgui(
			x + right * 0.5 - 144 - 24, y - top,
			x + right * 0.5 - 144 + 24, y + bottom) ||
			input_ms_rect_vgui(
			x + right * 0.5 + 144 - 24, y - top,
			x + right * 0.5 + 144 + 24, y + bottom)) {
				item.val = !item.val;
			}
		} else {
			if(input_kb_pressed(INPUT.LEFT) || input_kb_pressed(INPUT.RIGHT) ||
			input_kb_pressed(INPUT.FUNC0)) {
				item.val = !item.val;
			}
		}
	} else {
		if(0/*ms_lp*/) {
			if(input_ms_rect_vgui(
			x + right * 0.5 - 144 - 24, y - top,
			x + right * 0.5 - 144 + 24, y + bottom)) {
				item.val = (item.val - 1 + item.num) mod item.num;
			}
			if(input_ms_rect_vgui(
			x + right * 0.5 + 144 - 24, y - top,
			x + right * 0.5 + 144 + 24, y + bottom)) {
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
			if(/*(input_ms_rect_vgui(
			x - left, y - top,
			x + right, y + bottom) &&
			ms_lp) || */input_kb_pressed(INPUT.FUNC0)) {
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
	
	draw_set($1f1f1f, _alpha);
	text_set(fa_left, fa_middle);
	text_set_font(font);
	draw_text(x - left + 4, y, text);
	
	text_set(fa_center, fa_middle);
	
	texft_on;
	draw_sprite_stretched_ext(SprUI_thmk_widget_chooseButton, select,
	x + right * 0.5 - 192, y - 48, 384, 96, -1, _alpha);
	texft_off;
	
	draw_set_color($ff8000);
	
	if(item.num == 0) {
		draw_text(x + right * 0.5, y,
		string(item.val) + "%");
		
	} else if(item.num == 1) {
			
		draw_text(x + right * 0.5, y,
		string(item.val)? "Yes": "No");
		
	} else {
		
		draw_text(x + right * 0.5, y,
		word("__msetting", setting_group + "_" + setting_item + "_" + 
		string(item.val)));
		
	}
	
	draw_set();
}

function _draw_deactive(_father, _alpha) {
	draw_set_alpha(_alpha);
	draw_set(color, _alpha / 2);
	text_set(halign, valign);
	text_set_font(font);
	draw_text(x - left + 4, y, text);
	draw_set();
	
	texft_on;
	draw_sprite_stretched_ext(SprUI_thmk_widget_chooseButton, select,
	x + right * 0.5 - 192, y - 48, 384, 96, -1, _alpha);
	texft_off;
	
}

