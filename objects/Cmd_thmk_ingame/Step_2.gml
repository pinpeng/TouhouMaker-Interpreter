/// @description Insert description here
// You can write your code in this editor

if(__THMK_STATE != THMK_STATE.PLAYING) exit;

for(var i = 0; i < ds_list_size(_thmk_hero_bullet); i ++) {
	if(_thmk_hero_bullet[|i]._step()) {
		delete _thmk_hero_bullet[|i];
		ds_list_delete(_thmk_hero_bullet, i);
		i --;
	}
}

var del_flag = !setting_get("video", "effect") || __THMK_DEBUG;

for(var i = 0; i < ds_list_size(_thmk_effect); i ++) {
	if(del_flag) {
		delete _thmk_effect[|i];
		ds_list_delete(_thmk_effect, i);
		i --;
		continue;
	}
	var tmp = _thmk_effect[|i];
	tmp.x += tmp.spd * cos(tmp.dir / 180 * pi);
	tmp.y -= tmp.spd * sin(tmp.dir / 180 * pi);
	tmp.angle += tmp.angle_spd;
	tmp.timer --;
	if(tmp.timer < 0) {
		delete _thmk_effect[|i];
		ds_list_delete(_thmk_effect, i);
		i --;
	}
}


if(instance_exists(Obj_thmk_player) && !_thmk_stage.story) {
	var _x = Obj_thmk_player.x;
	var _y = Obj_thmk_player.y;
	
	for(var i = 0; i < ds_list_size(_thmk_enemy_bullet); i ++) {
		var tmp = _thmk_enemy_bullet[|i];
		if(tmp.data.collision > 0) {
			if(point_distance(_x, _y, tmp.x, tmp.y) <= tmp.data.collision + 2) {
				__THMK_HERO_HURT ++;
				if(!__THMK_DEBUG) {
					for(var j = 0; j < ds_list_size(_thmk_enemy_bullet); j ++) delete _thmk_enemy_bullet[|j];
					ds_list_clear(_thmk_enemy_bullet);
					for(var j = 0; j < ds_list_size(_thmk_hero_bullet); j ++) delete _thmk_hero_bullet[|j];
					ds_list_clear(_thmk_hero_bullet);
					with(Obj_thmk_enemy) instance_destroy();
					
					__THMK_HERO_HP --;
					__THMK_HERO_MP = 3;
					if(__THMK_HERO_HP < 0) {
						pause_index = 0;
						__THMK_STATE = THMK_STATE.DIE;
					} else {
						Obj_thmk_player.x = 0;
						Obj_thmk_player.y = 400;
					}
				}
				break;
			}
		}
	}
	
	for(var i = 0; i < instance_number(Obj_thmk_enemy); i ++) {
		var tmp = instance_find(Obj_thmk_enemy, i);
		if(tmp.collision > 0) {
			if(point_distance(_x, _y, tmp.x, tmp.y) <= tmp.collision + 2) {
				__THMK_HERO_HURT ++;
				if(!__THMK_DEBUG) {
					for(var j = 0; j < ds_list_size(_thmk_enemy_bullet); j ++) delete _thmk_enemy_bullet[|j];
					ds_list_clear(_thmk_enemy_bullet);
					for(var j = 0; j < ds_list_size(_thmk_hero_bullet); j ++) delete _thmk_hero_bullet[|j];
					ds_list_clear(_thmk_hero_bullet);
					with(Obj_thmk_enemy) instance_destroy();
					
					__THMK_HERO_HP --;
					__THMK_HERO_MP = 3;
					if(__THMK_HERO_HP < 0) {
						pause_index = 0;
						__THMK_STATE = THMK_STATE.DIE;
					} else {
						Obj_thmk_player.x = 0;
						Obj_thmk_player.y = 400;
					}
				}
				break;
			}
		}
	}
	
	if(instance_exists(Obj_thmk_boss) && Obj_thmk_boss.state == THMK_BOSS_STATE.RUNNING) {
		if(point_distance(_x, _y, Obj_thmk_boss.x, Obj_thmk_boss.y) <= 12) {
			__THMK_HERO_HURT ++;
			if(!__THMK_DEBUG) {
					for(var j = 0; j < ds_list_size(_thmk_enemy_bullet); j ++) delete _thmk_enemy_bullet[|j];
					ds_list_clear(_thmk_enemy_bullet);
					for(var j = 0; j < ds_list_size(_thmk_hero_bullet); j ++) delete _thmk_hero_bullet[|j];
					ds_list_clear(_thmk_hero_bullet);
					with(Obj_thmk_enemy) instance_destroy();
					
				__THMK_HERO_HP --;
				__THMK_HERO_MP = 3;
				if(__THMK_HERO_HP < 0) {
					bgm_pause_all();
					pause_index = 0;
					__THMK_STATE = THMK_STATE.DIE;
				} else {
					Obj_thmk_player.x = 0;
					Obj_thmk_player.y = 400;
				}
			}
		}
	}
	
}




