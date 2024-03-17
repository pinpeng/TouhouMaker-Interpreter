/// @description Insert description here
// You can write your code in this editor

if(__THMK_STATE != THMK_STATE.PLAYING) {
	image_speed = 0;
	exit;
} else image_speed = 1;


switch(state) {
	case THMK_BOSS_STATE.IDLE:
	break;
	
	case THMK_BOSS_STATE.RUNNING:
	if(!inited) _stage_init();
	for(var i = 0; i < array_length(threads); i ++) {
		var tmp = threads[i];
		if(tmp.type1) {
			tmp.timer1 ++;
			if(tmp.timer1 < tmp.timer1_end) continue;
		}
		
		tmp.x = x;
		tmp.y = y;
		if(!tmp.inited) {
			tmp.inited = 1;
			tmp.timer = 0;
			for(var j = 0; j < array_length(tmp.bulletList); j ++) {
				tmp.bulletList[j].timer = 0;
				tmp.bulletList[j].wait_timer = 100000000;
				tmp.bulletList[j].num_id = 0;
			}
			__thmk_execute_code(tmp.init, tmp);
		}
		__thmk_execute_code(tmp.step, tmp);
		
		for(var j = 0; j < array_length(tmp.bulletList); j ++) {
			var _bullet = tmp.bulletList[j];
			if(_bullet.index == -1) continue;
			var _num = __thmk_execute_resolve(_bullet.num, tmp);
			if(!is_real(_num) || _num <= 0) continue;
			var _timer_end = __thmk_execute_resolve(_bullet.timer_end, tmp);
			if(!is_real(_timer_end) || _timer_end < 0) continue;
			var _wait_timer_end = __thmk_execute_resolve(_bullet.wait_timer_end, tmp);
			
			_bullet.wait_timer ++;
			if(_bullet.wait_timer <= _wait_timer_end) continue;
			
			if(_timer_end == 0) {
				_bullet.wait_timer = 0;
				var _res = __thmk_get_bullet_id(_bullet.index);
				var _x0 = __thmk_execute_resolve(_bullet.x0, tmp);
				var _y0 = __thmk_execute_resolve(_bullet.y0, tmp);
				
				switch(_bullet.type) {
				case 0: { // line
					var _dir = __thmk_execute_resolve(_bullet.dir, tmp);
					var _spd = __thmk_execute_resolve(_bullet.spd, tmp);
					var tmp_step = __thmk_execute_resolve(_bullet.step, tmp);
					for(var k = 0; k < _num; k ++) {
						var inst = new __thmk_bullet(_res,
						_x0 + k * tmp_step * cos(_dir / 180 * pi),
						_y0 - k * tmp_step * sin(_dir / 180 * pi),
						_dir, _spd);
						with(inst) __thmk_execute_code(_bullet.code, inst);
						ds_list_add(Cmd_thmk_ingame._thmk_enemy_bullet, inst);
					}
				} break;
					
				case 1: { // circle
					var tmp_angle = 360 / _num;
					var _dir = __thmk_execute_resolve(_bullet.dir, tmp);
					var _spd = __thmk_execute_resolve(_bullet.spd, tmp);
					var _radius = __thmk_execute_resolve(_bullet.radius, tmp);
					for(var k = 0; k < _num; k ++) {
						var inst = new __thmk_bullet(_res,
						_x0 + _radius * cos((_dir + k * tmp_angle) / 180 * pi),
						_y0 - _radius * sin((_dir + k * tmp_angle) / 180 * pi),
						_dir + k * tmp_angle, _spd);
						with(inst) __thmk_execute_code(_bullet.code, inst);
						ds_list_add(Cmd_thmk_ingame._thmk_enemy_bullet, inst);
					}
				} break;
				
				case 2: { // fan
					var _dir = __thmk_execute_resolve(_bullet.dir, tmp);
					var _spd = __thmk_execute_resolve(_bullet.spd, tmp);
					var _radius = __thmk_execute_resolve(_bullet.radius, tmp);
					var _angle = __thmk_execute_resolve(_bullet.angle, tmp);
					for(var k = 0; k < _num; k ++) {
						var inst = new __thmk_bullet(_res,
						_x0 + _radius * cos((_dir + (k - _num / 2 + 0.5) * _angle) / 180 * pi),
						_y0 - _radius * sin((_dir + (k - _num / 2 + 0.5) * _angle) / 180 * pi),
						_dir + (k - _num / 2 + 0.5) * _angle, _spd);
						with(inst) __thmk_execute_code(_bullet.code, inst);
						ds_list_add(Cmd_thmk_ingame._thmk_enemy_bullet, inst);
					}
				} break;
				
				case 3: { // random rect
					var _x1 = __thmk_execute_resolve(_bullet.x1, tmp);
					var _y1 = __thmk_execute_resolve(_bullet.y1, tmp);
					var _spd = __thmk_execute_resolve(_bullet.spd, tmp);
					repeat(_num) {
						var inst = new __thmk_bullet(_res,
						random_range(_x0, _x1),
						random_range(_y0, _y1),
						random(360), _spd);
						with(inst) __thmk_execute_code(_bullet.code, inst);
						ds_list_add(Cmd_thmk_ingame._thmk_enemy_bullet, inst);
					}
				} break;
				
				case 4: { // random rect
					var _radius = __thmk_execute_resolve(_bullet.radius, tmp);
					var _spd = __thmk_execute_resolve(_bullet.spd, tmp);
					repeat(_num) {
						var _tmp_dir = random(360);
						var _tmp_dis = random(_radius);
						var inst = new __thmk_bullet(_res,
						_x0 + _tmp_dis * cos(_tmp_dir / 180 * pi),
						_y0 - _tmp_dis * sin(_tmp_dir / 180 * pi),
						_tmp_dir, _spd);
						with(inst) __thmk_execute_code(_bullet.code, inst);
						ds_list_add(Cmd_thmk_ingame._thmk_enemy_bullet, inst);
					}
				} break;
					
				default:
					__thmk_execute_code(_bullet.create, tmp);
					for(var k = 0; k < ds_list_size(__THMK_BULLET_BUFFER); k ++) {
						with(__THMK_BULLET_BUFFER[|i])
						__thmk_execute_code(_bullet.code, __THMK_BULLET_BUFFER[|k]);
					}
					ds_list_clear(__THMK_BULLET_BUFFER);
				break;
				}
				
			} else {
				if(_bullet.num_id >= _num) {
					_bullet.num_id = 0;
					_bullet.timer = 0;
					_bullet.wait_timer = 0;
					continue;
				}
				_bullet.timer ++;
				if(_bullet.timer < _timer_end) continue;
				
				var _res = __thmk_get_bullet_id(_bullet.index);
				var _x0 = __thmk_execute_resolve(_bullet.x0, tmp);
				var _y0 = __thmk_execute_resolve(_bullet.y0, tmp);
					
				switch(_bullet.type) {
					case 0: { // line
						var _dir = __thmk_execute_resolve(_bullet.dir, tmp);
						var _spd = __thmk_execute_resolve(_bullet.spd, tmp);
						var tmp_step = __thmk_execute_resolve(_bullet.step, tmp);
						var inst = new __thmk_bullet(_res,
						_x0 + _bullet.num_id * tmp_step * cos(_dir / 180 * pi),
						_y0 - _bullet.num_id * tmp_step * sin(_dir / 180 * pi),
						_dir, _spd);
						with(inst) __thmk_execute_code(_bullet.code, inst);
						ds_list_add(Cmd_thmk_ingame._thmk_enemy_bullet, inst);
					} break;
					
					case 1: { // circle
						var _dir = __thmk_execute_resolve(_bullet.dir, tmp);
						var _spd = __thmk_execute_resolve(_bullet.spd, tmp);
						var _radius = __thmk_execute_resolve(_bullet.radius, tmp);
						var tmp_angle = 360 / _num;
						var inst = new __thmk_bullet(_res,
						_x0 + _radius * cos((_dir + _bullet.num_id * tmp_angle) / 180 * pi),
						_y0 - _radius * sin((_dir + _bullet.num_id * tmp_angle) / 180 * pi),
						_dir + _bullet.num_id * tmp_angle, _spd);
						with(inst) __thmk_execute_code(_bullet.code, inst);
						ds_list_add(Cmd_thmk_ingame._thmk_enemy_bullet, inst);
					} break;
				
					case 2: { // fan
						var _dir = __thmk_execute_resolve(_bullet.dir, tmp);
						var _spd = __thmk_execute_resolve(_bullet.spd, tmp);
						var _radius = __thmk_execute_resolve(_bullet.radius, tmp);
						var _angle = __thmk_execute_resolve(_bullet.angle, tmp);
						var inst = new __thmk_bullet(_res,
						_x0 + _radius * cos((_dir + (_bullet.num_id - _num / 2 + 0.5) * _angle) / 180 * pi),
						_y0 - _radius * sin((_dir + (_bullet.num_id - _num / 2 + 0.5) * _angle) / 180 * pi),
						_dir + (_bullet.num_id - _num / 2 + 0.5) * _angle, _spd);
						with(inst) __thmk_execute_code(_bullet.code, inst);
						ds_list_add(Cmd_thmk_ingame._thmk_enemy_bullet, inst);
					} break;
				
					case 3: { // random rect
						var _x1 = __thmk_execute_resolve(_bullet.x1, tmp);
						var _y1 = __thmk_execute_resolve(_bullet.y1, tmp);
						var _spd = __thmk_execute_resolve(_bullet.spd, tmp);
						var inst = new __thmk_bullet(_res,
						random_range(_x0, _x1),
						random_range(_y0, _y1),
						random(360), _spd);
						with(inst) __thmk_execute_code(_bullet.code, inst);
						ds_list_add(Cmd_thmk_ingame._thmk_enemy_bullet, inst);
					} break;
				
					case 4: { // random rect
						var _radius = __thmk_execute_resolve(_bullet.radius, tmp);
						var _spd = __thmk_execute_resolve(_bullet.spd, tmp);
						var _tmp_dir = random(360);
						var _tmp_dis = random(_radius);
						var inst = new __thmk_bullet(_res,
						_x0 + _tmp_dis * cos(_tmp_dir / 180 * pi),
						_y0 - _tmp_dis * sin(_tmp_dir / 180 * pi),
						_tmp_dir, _spd);
						with(inst) __thmk_execute_code(_bullet.code, inst);
						ds_list_add(Cmd_thmk_ingame._thmk_enemy_bullet, inst);
					} break;
					
					default:
						__thmk_execute_code(_bullet.create, tmp);
						for(var k = 0; k < ds_list_size(__THMK_BULLET_BUFFER); k ++) {
							with(__THMK_BULLET_BUFFER[|i])
							__thmk_execute_code(_bullet.code, __THMK_BULLET_BUFFER[|k]);
						}
						ds_list_clear(__THMK_BULLET_BUFFER);
					break;
				} // switch end
				_bullet.num_id ++;
			}
			tmp.bulletList[j] = _bullet;
		}
		
		tmp.timer ++;
		
		if(tmp.type2) {
			tmp.timer2 ++;
			if(tmp.timer2 > tmp.timer2_end) {
				tmp.timer2 = 0;
				tmp.timer = 0;
				tmp.inited = 0;
			}
		}
		
		threads[i] = tmp;
	}
	
	if(ds_list_size(Cmd_thmk_ingame._thmk_hero_bullet)) {
		for(var i = 0; i < ds_list_size(Cmd_thmk_ingame._thmk_hero_bullet); i ++) {
			var tmp = Cmd_thmk_ingame._thmk_hero_bullet[|i];
			if(point_distance(x, y, tmp.x, tmp.y) < 64) {
				tmp.hp --;
				if(tmp.hp <= 0) tmp.del_on_later = true;
				hp = max(hp - 1, 0);
				ds_list_add(Cmd_thmk_ingame._thmk_effect,
				{ sprite_index : Spr_thmk_default_bullet_ef,
				x : x, y : y, dir : random(360), spd : random_range(2, 6),
				angle : random(360), angle_spd : random_range(6, 24),
				timer : 20, timer_max : 18 });
			}
		}
	}
	
	if(condition == 0) {
		if(hp <= 0) {
			state = THMK_BOSS_STATE.IDLE;
			Cmd_thmk_ingame._thmk_stage.go = 1;
			for(var i = 0; i < ds_list_size(Cmd_thmk_ingame._thmk_enemy_bullet); i ++)
			delete Cmd_thmk_ingame._thmk_enemy_bullet[|i];
			ds_list_clear(Cmd_thmk_ingame._thmk_enemy_bullet);
			with(Obj_thmk_enemy) instance_destroy();
		}
	} else if(condition == 1) {
		if(!ds_list_size(Cmd_thmk_ingame._thmk_enemy_bullet)) {
			state = THMK_BOSS_STATE.IDLE;
			Cmd_thmk_ingame._thmk_stage.go = 1;
			for(var i = 0; i < ds_list_size(Cmd_thmk_ingame._thmk_enemy_bullet); i ++)
			delete Cmd_thmk_ingame._thmk_enemy_bullet[|i];
			ds_list_clear(Cmd_thmk_ingame._thmk_enemy_bullet);
			with(Obj_thmk_enemy) instance_destroy();
		}
	} else if(condition == 2) {
		if(hp <= hp_max / 2) {
			state = THMK_BOSS_STATE.IDLE;
			Cmd_thmk_ingame._thmk_stage.go = 1;
			for(var i = 0; i < ds_list_size(Cmd_thmk_ingame._thmk_enemy_bullet); i ++)
			delete Cmd_thmk_ingame._thmk_enemy_bullet[|i];
			ds_list_clear(Cmd_thmk_ingame._thmk_enemy_bullet);
			with(Obj_thmk_enemy) instance_destroy();
		}
	} else if(__thmk_execute_resolve(condition_code, id)) {
		if(hp <= hp_max / 2) {
			state = THMK_BOSS_STATE.IDLE;
			Cmd_thmk_ingame._thmk_stage.go = 1;
			for(var i = 0; i < ds_list_size(Cmd_thmk_ingame._thmk_enemy_bullet); i ++)
			delete Cmd_thmk_ingame._thmk_enemy_bullet[|i];
			ds_list_clear(Cmd_thmk_ingame._thmk_enemy_bullet);
			with(Obj_thmk_enemy) instance_destroy();
		}
	}
	
	if(timeType) {
		timer ++;
		if(timer >= timer_end) {
			state = THMK_BOSS_STATE.IDLE;
			Cmd_thmk_ingame._thmk_stage.go = 1;
			for(var i = 0; i < ds_list_size(Cmd_thmk_ingame._thmk_enemy_bullet); i ++)
			delete Cmd_thmk_ingame._thmk_enemy_bullet[|i];
			ds_list_clear(Cmd_thmk_ingame._thmk_enemy_bullet);
			with(Obj_thmk_enemy) instance_destroy();
		}
	}
	break;
	
	case THMK_BOSS_STATE.EXIT:
	default:
	go(375 + 92, -250 - 92);
	if(x > 375 + 90 && y < -250 - 90) {
		instance_destroy();
	}
	break;
}








