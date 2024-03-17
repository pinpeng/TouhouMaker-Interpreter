/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

INGAME_WIDTH = 870;
INGAME_HEIGHT = 960;

if(__THMK_DEBUG) {
	VGUI_WIDTH = 870;
	VGUI_HEIGHT = 960;
} else {
	VGUI_WIDTH = 1280;
	VGUI_HEIGHT = 960;
}

pause_index = 0;

surf_bloom0 = -4;
surf_bloom1 = -4;

_thmk_hero_bullet = ds_list_create();
_thmk_enemy_bullet = ds_list_create();
_thmk_effect = ds_list_create();

_thmk_stage = {
	background : [{}, {}, {}, {}],
	background_fog : [0, $7f7f7f],
	
	group : 0,
	stage : 0,
	length : 0,
	events : [],
	
	events_list : ds_list_create(),
	go : 0,
	
	boss : noone,
	story : false,
	story_index : 0,
	story_list : []
};

for(var i = 0; i < 4; i ++) {
	_thmk_stage.background[i].id = -1;
	_thmk_stage.background[i].ind = 0;
	_thmk_stage.background[i].x = 0;
	_thmk_stage.background[i].y = 0;
	_thmk_stage.background[i].dir = 0;
	_thmk_stage.background[i].spd = 0;
	_thmk_stage.background[i].Repeat = 0;
	_thmk_stage.background[i].slope = 0;
}


function _ingame_draw_begin() {
	
	INGAME_SURFACE = surface_check(INGAME_SURFACE, INGAME_WIDTH, INGAME_HEIGHT);
	surface_clear(INGAME_SURFACE, $000000, 1);
	VGUI_SURFACE = surface_check(VGUI_SURFACE, VGUI_WIDTH, VGUI_HEIGHT);
	surface_clear(VGUI_SURFACE, $000000, 0);
	
	texft_on
	bm_set
	surface_set_target(INGAME_SURFACE);
		for(var i = 0; i < 4; i ++) {
			var tmp = _thmk_stage.background[i];
			if(tmp.id != -1) {
				var tmp_w = sprite_get_width(tmp.id);
				var tmp_h = sprite_get_height(tmp.id);
				var tmp_scale = max((INGAME_WIDTH - 120) / tmp_w, (INGAME_HEIGHT - 60) / tmp_h);
				tmp_w *= tmp_scale;
				tmp_h *= tmp_scale;
				if(tmp.Repeat) {
					var tmp_x = (tmp.x mod (tmp_w)) + INGAME_WIDTH / 2;
					var tmp_y = (tmp.y mod (tmp_h)) + INGAME_HEIGHT / 2;
					for(var _y = tmp_y; _y >= -tmp_h / 2 - 4; _y -= tmp_h) {
						for(var _x = tmp_x; _x >= -tmp_w / 2 - 4; _x -= tmp_w) {
							draw_sprite_ext_color(tmp.id, tmp.ind, _x - tmp_w / 2, _y - tmp_h / 2,
							tmp_scale, tmp_scale, 0, _thmk_stage.background_fog[1], 1, _thmk_stage.background_fog[0]);
						}
						for(var _x = tmp_x + tmp_w; _x <= INGAME_WIDTH + tmp_w / 2 + 4; _x += tmp_w) {
							draw_sprite_ext_color(tmp.id, tmp.ind, _x - tmp_w / 2, _y - tmp_h / 2,
							tmp_scale, tmp_scale, 0, _thmk_stage.background_fog[1], 1, _thmk_stage.background_fog[0]);
						}
					}
					for(var _y = tmp_y + tmp_h; _y <= INGAME_HEIGHT + tmp_h / 2 + 4; _y += tmp_h) {
						for(var _x = tmp_x; _x >= -tmp_w / 2 - 4; _x -= tmp_w) {
							draw_sprite_ext_color(tmp.id, tmp.ind, _x - tmp_w / 2, _y - tmp_h / 2,
							tmp_scale, tmp_scale, 0, _thmk_stage.background_fog[1], 1, _thmk_stage.background_fog[0]);
						}
						for(var _x = tmp_x + tmp_w; _x <= INGAME_WIDTH + tmp_w / 2 + 4; _x += tmp_w) {
							draw_sprite_ext_color(tmp.id, tmp.ind, _x - tmp_w / 2, _y - tmp_h / 2,
							tmp_scale, tmp_scale, 0, _thmk_stage.background_fog[1], 1, _thmk_stage.background_fog[0]);
						}
					}
				} else {
					draw_sprite_ext_color(tmp.id, tmp.ind,
					tmp.x + INGAME_WIDTH / 2 - tmp_w / 2 * tmp_scale,
					tmp.y + INGAME_HEIGHT / 2 - tmp_h / 2 * tmp_scale,
					tmp_scale, tmp_scale, 0,
					_thmk_stage.background_fog[1], 1, _thmk_stage.background_fog[0]);
				}
			}
		}
	
		for(var i = 0; i < ds_list_size(_thmk_hero_bullet); i ++) {
			_thmk_hero_bullet[|i]._draw();
		}
		if(instance_exists(Obj_thmk_player)) Obj_thmk_player._draw_ingame();
		for(var i = 0; i < ds_list_size(_thmk_enemy_bullet); i ++) {
			_thmk_enemy_bullet[|i]._draw();
		}
		for(var i = 0; i < instance_number(Obj_thmk_enemy); i ++) {
			instance_find(Obj_thmk_enemy, i)._draw_ingame();
		}
		if(instance_exists(Obj_thmk_boss)) Obj_thmk_boss._draw_ingame();
		
		
		for(var i = 0; i < ds_list_size(_thmk_effect); i ++) {
			var tmp = _thmk_effect[|i];
			
			var _width = sprite_get_width(tmp.sprite_index);
			var _height = sprite_get_height(tmp.sprite_index);
			var _dir = (point_direction(0, 0, _width, _height) + tmp.angle) / 180 * pi;
			var _dis = sqrt(_width * _width + _height * _height) / 2;
			
			draw_sprite_ext(tmp.sprite_index, 0,
			tmp.x - _dis * cos(_dir) + 435,
			tmp.y + _dis * sin(_dir) + 280,
			1, 1, tmp.angle, -1, clamp(sin(tmp.timer / tmp.timer_max) + 0.5, 0, 1));
		}
		
		
	surface_reset_target();
	texft_off
	bm_reset
}

function _ingame_draw_gui_begin() {
	
	draw_clear(0);
	INGAME_SURFACE = surface_check(INGAME_SURFACE, INGAME_WIDTH, INGAME_HEIGHT);
	VGUI_SURFACE = surface_check(VGUI_SURFACE, VGUI_WIDTH, VGUI_HEIGHT);
	
	texft_on
	bm_set
	if(__THMK_DEBUG) {
		surface_set_target(VGUI_SURFACE);
			draw_surface(INGAME_SURFACE, 0, 0);
			if(instance_exists(Obj_thmk_boss)) Obj_thmk_boss._draw_vgui();
			
			
		
		if(_thmk_stage.story && _thmk_stage.story_index < array_length(_thmk_stage.story_list)) {
			var tmp = _thmk_stage.story_list[_thmk_stage.story_index];
			if(tmp.state0) {
				var tmp_w = sprite_get_width(tmp.Image0);
				var tmp_h = sprite_get_height(tmp.Image0);
				var tmp_scale = min(360 / tmp_w, 540 / tmp_h);
				draw_sprite_ext_color(tmp.Image0, tmp.image0index,
				INGAME_WIDTH * 0.22 - tmp_w / 2 * tmp_scale, INGAME_HEIGHT * 0.7 - tmp_h / 2 * tmp_scale,
				tmp_scale, tmp_scale, 0, 0, 1, (tmp.state0 == 1)? 0.5: 0);
			}
			if(tmp.state1) {
				var tmp_w = sprite_get_width(tmp.Image1);
				var tmp_h = sprite_get_height(tmp.Image1);
				var tmp_scale = min(360 / tmp_w, 540 / tmp_h);
				draw_sprite_ext_color(tmp.Image1, tmp.image1index,
				INGAME_WIDTH * 0.78 - tmp_w / 2 * tmp_scale, INGAME_HEIGHT * 0.7 - tmp_h / 2 * tmp_scale,
				tmp_scale, tmp_scale, 0, 0, 1, (tmp.state1 == 1)? 0.5: 0);
			}
			draw_set(0, 0.5);
			draw_rectangle(
			INGAME_WIDTH * 0.1,
			INGAME_HEIGHT * 0.75,
			INGAME_WIDTH * 0.9,
			INGAME_HEIGHT * 0.95, 0);
			draw_set();
			text_set_font(FONT.SYMIDDLE);
			text_set(fa_left, fa_top);
			draw_text(INGAME_WIDTH * 0.1 + 4, INGAME_HEIGHT * 0.75 + 4, tmp.Text);
		}
			
			
			if(__THMK_STATE == THMK_STATE.PAUSE) {
				draw_set(0, 0.5);
				draw_rectangle(-1, -1, INGAME_WIDTH + 2, INGAME_HEIGHT + 2, 0);
				draw_set();
				text_set_font(FONT.SYLARGE);
				text_set(fa_center, fa_middle);
				draw_text(60 + 375, 30 + 450, word("pause", "text"));
			}
		
			draw_sprite(Spr_thmk_default_game_mask_debug, 0, 0, 0);
			draw_set(0, 0.5);
			draw_rectangle(60, 30, 160, 130, 0);
			draw_set_font(__MBN_DEBUG_FONT);
			text_set(fa_left, fa_top);
			draw_set();
			draw_text(60 + 4, 34 + 20 * 0, "Time " + string(floor(__THMK_TIMER / 60)) + ":" + string(__THMK_TIMER mod 60))
			draw_text(60 + 4, 34 + 20 * 1, string(fps) + " / " + string(fps_real));
			draw_text(60 + 4, 34 + 20 * 2, "HB " + string(ds_list_size(_thmk_hero_bullet)))
			draw_text(60 + 4, 34 + 20 * 3, "EB " + string(ds_list_size(_thmk_enemy_bullet)))
			draw_text(60 + 4, 34 + 20 * 4, "HH " + string(__THMK_HERO_HURT));
			
		surface_reset_target();
	
		draw_surface_ext(VGUI_SURFACE, -60, -30, 1, 1, 0, -1, 1);
	} else {
		if(setting_get("video", "bloom")) {
			surf_bloom0 = surface_check(surf_bloom0, INGAME_WIDTH, INGAME_HEIGHT);
			surf_bloom1 = surface_check(surf_bloom1, INGAME_WIDTH, INGAME_HEIGHT);
			shader_draw_Bloom(INGAME_SURFACE, surf_bloom0, 0.85, 0.75);
			shader_draw_GaussianBlur(surf_bloom0, surf_bloom0, surf_bloom1, INGAME_WIDTH, INGAME_HEIGHT, 1);
			shader_draw_GaussianBlur(surf_bloom0, surf_bloom0, surf_bloom1, INGAME_WIDTH, INGAME_HEIGHT, 2);
			shader_draw_GaussianBlur(surf_bloom0, surf_bloom0, surf_bloom1, INGAME_WIDTH, INGAME_HEIGHT, 1);
		}
		surface_set_target(VGUI_SURFACE);
			//var _tmp = ingame_camera_get_shake();
			draw_surface(INGAME_SURFACE, 0, 0);
			if(setting_get("video", "bloom")) {
				gpu_set_blendmode(bm_add);
				draw_surface(surf_bloom0, 0, 0);
				bm_set;
			}
			if(instance_exists(Obj_thmk_boss)) Obj_thmk_boss._draw_vgui();
			
		
		if(_thmk_stage.story && _thmk_stage.story_index < array_length(_thmk_stage.story_list)) {
			var tmp = _thmk_stage.story_list[_thmk_stage.story_index];
			if(tmp.state0) {
				var tmp_w = sprite_get_width(tmp.Image0);
				var tmp_h = sprite_get_height(tmp.Image0);
				var tmp_scale = min(360 / tmp_w, 540 / tmp_h);
				draw_sprite_ext_color(tmp.Image0, tmp.image0index,
				INGAME_WIDTH * 0.22 - tmp_w / 2 * tmp_scale, INGAME_HEIGHT * 0.7 - tmp_h / 2 * tmp_scale,
				tmp_scale, tmp_scale, 0, 0, 1, (tmp.state0 == 1)? 0.5: 0);
			}
			if(tmp.state1) {
				var tmp_w = sprite_get_width(tmp.Image1);
				var tmp_h = sprite_get_height(tmp.Image1);
				var tmp_scale = min(360 / tmp_w, 540 / tmp_h);
				draw_sprite_ext_color(tmp.Image1, tmp.image1index,
				INGAME_WIDTH * 0.78 - tmp_w / 2 * tmp_scale, INGAME_HEIGHT * 0.7 - tmp_h / 2 * tmp_scale,
				tmp_scale, tmp_scale, 0, 0, 1, (tmp.state1 == 1)? 0.5: 0);
			}
			draw_set(0, 0.5);
			draw_rectangle(
			INGAME_WIDTH * 0.1,
			INGAME_HEIGHT * 0.75,
			INGAME_WIDTH * 0.9,
			INGAME_HEIGHT * 0.95, 0);
			draw_set();
			text_set_font(FONT.SYMIDDLE);
			text_set(fa_left, fa_top);
			draw_text(INGAME_WIDTH * 0.1 + 4, INGAME_HEIGHT * 0.75 + 4, tmp.Text);
		}
		
			if(__THMK_STATE == THMK_STATE.PAUSE) {
				draw_set(0, 0.5);
				draw_rectangle(-1, -1, INGAME_WIDTH + 2, INGAME_HEIGHT + 2, 0);
				draw_set();
				text_set_font(FONT.SYLARGE);
				text_set(fa_center, fa_middle);
				draw_text(60 + 375, 30 + 250, word("pause", "text"));
				for(var i = 0; i < 3; i ++) {
					draw_sprite_stretched(SprUI_thmk_widget_button, pause_index == i,
					60 + 375 - 160, 30 + 450 + 100 * i - 48, 320, 96);
				}
				text_set_font(FONT.SYMIDDLE);
				if(pause_index == 0) draw_set_color($ffffff);
				else draw_set_color($ff8000);
				draw_text(60 + 375, 30 + 450 + 100 * 0, word("pause", "continue"));
				if(pause_index == 1) draw_set_color($ffffff);
				else draw_set_color($ff8000);
				draw_text(60 + 375, 30 + 450 + 100 * 1, word("pause", "restart"));
				if(pause_index == 2) draw_set_color($ffffff);
				else draw_set_color($ff8000);
				draw_text(60 + 375, 30 + 450 + 100 * 2, word("pause", "exit"));
			}
			
			if(__THMK_STATE == THMK_STATE.DIE) {
				draw_set(0, 0.5);
				draw_rectangle(-1, -1, INGAME_WIDTH + 2, INGAME_HEIGHT + 2, 0);
				draw_set();
				text_set_font(FONT.SYLARGE);
				text_set(fa_center, fa_middle);
				draw_text(60 + 375, 30 + 250, word("pause", "die"));
				for(var i = 0; i < 3; i ++) {
					draw_sprite_stretched(SprUI_thmk_widget_button, pause_index == i,
					60 + 375 - 160, 30 + 450 + 100 * i - 48, 320, 96);
				}
				text_set_font(FONT.SYMIDDLE);
				if(pause_index == 0) draw_set_color($ffffff);
				else draw_set_color($ff8000);
				draw_text(60 + 375, 30 + 450 + 100 * 0, word("pause", "die_start"));
				if(pause_index == 1) draw_set_color($ffffff);
				else draw_set_color($ff8000);
				draw_text(60 + 375, 30 + 450 + 100 * 1, word("pause", "restart"));
				if(pause_index == 2) draw_set_color($ffffff);
				else draw_set_color($ff8000);
				draw_text(60 + 375, 30 + 450 + 100 * 2, word("pause", "exit"));
			}
		
			draw_sprite(Spr_thmk_default_game_mask, 0, 0, 0);
			
			draw_set();
			for(var i = 0; i < 8; i ++) {
				draw_sprite_stretched(SprUI_thmk_hp, __THMK_HERO_HP > i, 954 + i * 40 - 16, 270 - 16, 32, 32);
			}
			for(var i = 0; i < 8; i ++) {
				draw_sprite_stretched(SprUI_thmk_hp, __THMK_HERO_MP > i, 954 + i * 40 - 16, 330 - 16, 32, 32);
			}
			
			draw_set_font(__MBN_DEBUG_FONT);
			text_set(fa_left, fa_bottom);
			draw_set(0, 1);
			draw_text(4 + 80 * 0, VGUI_HEIGHT - 6, "TM " + string(floor(__THMK_TIMER / 60)) + ":" + string(__THMK_TIMER mod 60))
			draw_text(4 + 80 * 1, VGUI_HEIGHT - 6, "FPS " + string(fps));
			draw_text(4 + 80 * 2, VGUI_HEIGHT - 6, "HB " + string(ds_list_size(_thmk_hero_bullet)))
			draw_text(4 + 80 * 3, VGUI_HEIGHT - 6, "EB " + string(ds_list_size(_thmk_enemy_bullet)))
			
		surface_reset_target();
	
		draw_set();
	
		var _tmp_scale = min(UI_WIDTH / VGUI_WIDTH, UI_HEIGHT / VGUI_HEIGHT);
		draw_surface_ext(VGUI_SURFACE,
		UI_WIDTH / 2 - VGUI_WIDTH / 2 * _tmp_scale,
		UI_HEIGHT / 2 - VGUI_HEIGHT / 2 * _tmp_scale,
		_tmp_scale, _tmp_scale, 0, -1, 1);
	}
	texft_off
	bm_reset
}

