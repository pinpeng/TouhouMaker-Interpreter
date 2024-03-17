
function __thmk_bullet(_bullet, _x, _y, _dir, _spd) constructor {
	x = _x;
	y = _y;
	dir = _dir;
	spd = _spd;
	
	sprite_index = __thmk_bullet_get_sprite(_bullet);
	image_index = 0;
	
	image_angle = dir;
	image_alpha = 1;
	image_blend = $ffffff;
	
	data = __thmk_bullet_get_data(_bullet);
	
	stage = 1;
	inited = false;
	
	del_on_later = false;
	
	function _step() {
		if(del_on_later) return 1;
		
		x += spd * cos(dir / 180 * pi);
		y -= spd * sin(dir / 180 * pi);
		
		if(data.range == 0) {
			if(abs(x) > 435 || abs(y - 200) > 510) return 1;
		} else if(data.range == 1) {
			if(abs(x) >= 750 || abs(y - 200) > 900) return 1;
		}
		image_index += sprite_get_speed(sprite_index) / 60;
		image_angle = dir;
		return 0;
	}
	
	function _draw() {
		var _width = sprite_get_width(sprite_index);
		var _height = sprite_get_height(sprite_index);
		var _dir = (point_direction(0, 0, _width, _height) + image_angle) / 180 * pi;
		var _dis = sqrt(_width * _width + _height * _height) / 2;
		
		draw_sprite_ext(sprite_index, image_index,
		x - _dis * cos(_dir) + 435,
		y + _dis * sin(_dir) + 280,
		1, 1, image_angle, image_blend, image_alpha);
	}
}

function __thmk_hero_bullet(_x, _y, _dir, _spd) constructor {
	hp = 1;
	x = _x;
	y = _y;
	dir = _dir;
	spd = _spd;
	
	sprite_index = Spr_thmk_default_hero_bullet;
	image_index = 0;
	
	image_angle = dir;
	image_alpha = 1;
	image_blend = $ffffff;
	
	del_on_later = false;
	
	stage = 0;
	
	function _step() {
		if(del_on_later) return 1;
		
		if(stage == 0) {
			spd = Lerp(spd, 0, 0.12);
			if(spd <= 4) {
				stage ++;
			}
		} else if(stage == 1) {
			if(instance_exists(Obj_thmk_boss) && Obj_thmk_boss.state == THMK_BOSS_STATE.RUNNING) {
				var vec2 = Vec2_add(Dir_to_Vec2([dir, spd]),
				[(Obj_thmk_boss.x - x) / 200, (Obj_thmk_boss.y - y) / 200]);
				var tmp_dir = Vec2_to_Dir(vec2);
				dir = tmp_dir[0];
				spd = min(spd + 0.2, tmp_dir[1]);
			} else if(instance_exists(Obj_thmk_enemy)) {
				var tmp = instance_nearest(x, y, Obj_thmk_enemy);
				var vec2 = Vec2_add(Dir_to_Vec2([dir, spd]),
				[(tmp.x - x) / 100, (tmp.y - y) / 100]);
				var tmp_dir = Vec2_to_Dir(vec2);
				dir = tmp_dir[0];
				spd = min(spd + 0.2, tmp_dir[1]);
			} else {
				spd += 0.2;
			}		
		}
		
		x += spd * cos(dir / 180 * pi);
		y -= spd * sin(dir / 180 * pi);
		
		
		if(abs(x) > 435 || abs(y - 200) > 510) return 1;
		image_index += sprite_get_speed(sprite_index) / 60;
		image_angle = dir;
		return 0;
	}
	
	function _draw() {
		var _width = sprite_get_width(sprite_index);
		var _height = sprite_get_height(sprite_index);
		var _dir = (point_direction(0, 0, _width, _height) + image_angle) / 180 * pi;
		var _dis = sqrt(_width * _width + _height * _height) / 2;
		
		draw_sprite_ext(sprite_index, image_index,
		x - _dis * cos(_dir) + 435,
		y + _dis * sin(_dir) + 280,
		1, 1, image_angle, image_blend, image_alpha);
	}
}

function __thmk_hero_skill(_x, _y, _dir, _spd) constructor {
	hp = 100;
	x = _x;
	y = _y;
	dir = _dir;
	spd = _spd;
	
	sprite_index = Spr_thmk_default_hero_skill;
	image_index = 0;
	
	image_angle = 0;
	image_alpha = 1;
	image_blend = $ffffff;
	
	del_on_later = false;
	
	stage = 0;
	stage_timer = 0;
	
	function _step() {
		if(del_on_later) return 1;
		
		stage_timer ++;
		if(stage == 0) {
			dir += 4;
			if(stage_timer >= 80) {
				stage = 1;
			}
		} else {
			dir += 1;
			spd += 0.1;
		}
		
		x += spd * cos(dir / 180 * pi);
		y -= spd * sin(dir / 180 * pi);
		
		if(stage_timer mod 8 == 0) {
			ds_list_add(Cmd_thmk_ingame._thmk_effect,
			{ sprite_index : Spr_thmk_default_skill_ef,
			x : x, y : y, dir : 0, spd : 0,
			angle : 0, angle_spd : 0,
			timer : 8, timer_max : 10 });
		}
		
		for(var i = 0; i < ds_list_size(Cmd_thmk_ingame._thmk_enemy_bullet); i ++) {
			var tmp = Cmd_thmk_ingame._thmk_enemy_bullet[|i];
			if(point_distance(x, y, tmp.x, tmp.y) < 64) {
				ds_list_add(Cmd_thmk_ingame._thmk_effect,
				{ sprite_index : Spr_thmk_default_skill_ef,
				x : tmp.x, y : tmp.y, dir : random(360), spd : random_range(2, 6),
				angle : random(360), angle_spd : random_range(6, 24),
				timer : 4, timer_max : 4 });
				delete Cmd_thmk_ingame._thmk_enemy_bullet[|i];
				ds_list_delete(Cmd_thmk_ingame._thmk_enemy_bullet, i);
				i --;
			}
			
		}
		if(abs(x) > 735 || abs(y - 200) > 810) return 1;
		image_index += sprite_get_speed(sprite_index) / 60;
		image_angle += 12;
		return 0;
	}
	
	function _draw() {
		var _width = sprite_get_width(sprite_index);
		var _height = sprite_get_height(sprite_index);
		var _dir = (point_direction(0, 0, _width, _height) + image_angle) / 180 * pi;
		var _dis = sqrt(_width * _width + _height * _height) / 2;
		
		draw_sprite_ext(sprite_index, image_index,
		x - _dis * cos(_dir) + 435,
		y + _dis * sin(_dir) + 280,
		1, 1, image_angle, image_blend, image_alpha);
	}
}

