/// @description Insert description here
// You can write your code in this editor

if(__THMK_STATE != THMK_STATE.PLAYING) {
	image_speed = 0;
	exit;
} else image_speed = 1;

var tmp_x = x;

var spd = 6;

if(input_kb(INPUT.FUNC2)) spd = 3;

if(input_kb(INPUT.UP))		y -= spd;
else if(input_kb(INPUT.DOWN))	y += spd;
if(input_kb(INPUT.RIGHT))	x += spd;
else if(input_kb(INPUT.LEFT))	x -= spd;

x = clamp(x, -375 + 8, 375 - 8);
y = clamp(y, -250 + 8, 650 - 8);

if(x < tmp_x) sprite_index = Spr_thmk_default_hero_lmove;
else if(x > tmp_x) sprite_index = Spr_thmk_default_hero_rmove;
else sprite_index = Spr_thmk_default_hero_idle;

if(!Cmd_thmk_ingame._thmk_stage.story) {
	timer_fire ++;
	if(input_kb(INPUT.FUNC0)) {
		if(timer_fire >= timer_fire_max) {
			
			ds_list_add(Cmd_thmk_ingame._thmk_hero_bullet, new __thmk_hero_bullet(x - 36, y, 90 + 24, 16));
			ds_list_add(Cmd_thmk_ingame._thmk_effect,
			{ sprite_index : Spr_thmk_default_bullet_ef,
			x : x - 36, y : y, dir : random(360), spd : 0, angle : random(360), angle_spd : 0,
			timer : 6, timer_max : 5 });
			
			ds_list_add(Cmd_thmk_ingame._thmk_hero_bullet, new __thmk_hero_bullet(x - 24, y - 36, 90 + 2, 16));
			ds_list_add(Cmd_thmk_ingame._thmk_effect,
			{ sprite_index : Spr_thmk_default_bullet_ef,
			x : x - 24, y : y - 36, dir : random(360), spd : 0, angle : random(360), angle_spd : 0,
			timer : 6, timer_max : 5 });
			
			ds_list_add(Cmd_thmk_ingame._thmk_hero_bullet, new __thmk_hero_bullet(x + 24, y - 36, 90 - 2, 16));
			ds_list_add(Cmd_thmk_ingame._thmk_effect,
			{ sprite_index : Spr_thmk_default_bullet_ef,
			x : x + 24, y : y - 36, dir : random(360), spd : 0, angle : random(360), angle_spd : 0,
			timer : 6, timer_max : 5 });
			
			ds_list_add(Cmd_thmk_ingame._thmk_hero_bullet, new __thmk_hero_bullet(x + 36, y, 90 - 24, 16));
			ds_list_add(Cmd_thmk_ingame._thmk_effect,
			{ sprite_index : Spr_thmk_default_bullet_ef,
			x : x + 36, y : y, dir : random(360), spd : 0, angle : random(360), angle_spd : 0,
			timer : 6, timer_max : 5 });
			
			timer_fire = 0;
		}
	}
	if(timer_skill <= 0) {
		if((__THMK_HERO_MP || __THMK_DEBUG) && input_kb_pressed(INPUT.FUNC1)) {
			__THMK_HERO_MP --;
			timer_skill = 18;
			skill_pos[0] = x;
			skill_pos[1] = y;
			for(var i = 0; i < 12; i ++) {
				ds_list_add(Cmd_thmk_ingame._thmk_hero_bullet,
				new __thmk_hero_skill(skill_pos[0], skill_pos[1], i * 30, 6));
			}
		}
	} else {
		timer_skill --;
		if(timer_skill mod 6 == 0) {
			for(var i = 0; i < 12; i ++) {
				ds_list_add(Cmd_thmk_ingame._thmk_hero_bullet,
				new __thmk_hero_skill(skill_pos[0], skill_pos[1], i * 30, 6));
			}
		}
	}
}






