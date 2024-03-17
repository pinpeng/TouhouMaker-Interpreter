
enum THMK_EVENT_TYPE {
	SET_BACKGROUND,
	SET_BGM,
	PLAY_SE,
	PLAY_EFFECT,
	CREATE_ENEMY,
	CREATE_ENEMY_TIME,
	PLAY_STORY,
	PLAY_STORY_TIME,
	BOSS_START,
	BOSS_END,
	BOSS_BULLET,
	BOSS_SPELL_CARD,
	CLS,
	GOTO,
	STAGE_CHANGE,
	POINT,
	
}

enum THMK_EVENT_LIST_TYPE {
	CREATE_ENEMY_LIST
}

function __thmk_execute_event(_event) {
	var _data = __thmk_event_get_data(_event);
	if(!_data.enable) return undefined;
	
	//show_debug_message(_event)
	
	var _res;
	switch(__thmk_event_get_type(_event)) {
		
		case THMK_EVENT_TYPE.SET_BACKGROUND: {
		for(var i = 0; i < 4; i ++) {
			var tmp = _thmk_stage.background[i];
			var _res = __thmk_get_image_id(_data.backgroundList[i].id);
			if(_res == -1 || !_res[0]) {
				tmp.id = -1;
				continue;
			}
			tmp.id = _res[1];
			tmp.x = 0;
			tmp.y = 0;
			tmp.dir = _data.backgroundList[i].direction;
			tmp.spd = _data.backgroundList[i].speed;
			tmp.Repeat = _data.backgroundList[i][$ "repeat"];
			tmp.slope = _data.backgroundList[i].slope;
			tmp.ind = 0;
			_thmk_stage.background[i] = tmp;
		}
		_thmk_stage.background_fog[0] = _data.fog_alpha;
		_thmk_stage.background_fog[1] = make_color_rgb(_data.fog_r, _data.fog_g, _data.fog_b); 
		} break;
		
		case THMK_EVENT_TYPE.SET_BGM:
		if(_data.id == -1) {
			bgm_stop_all();
			return undefined;
		}
		_res = __thmk_get_audio_id(_data.id);
		if(_res == -1) return undefined;
		if(!_res[0]) return undefined;
		if(audio_exists(_res[1])) bgm_play(_res[1]);
		break;
		
		case THMK_EVENT_TYPE.PLAY_SE:
		_res = __thmk_get_audio_id(_data.id);
		if(_res == -1) return undefined;
		if(!_res[0]) return undefined;
		if(audio_exists(_res[1])) se_play(_res[1], _data.volume / 100, _data.pitch / 100);
		break;
		
		case THMK_EVENT_TYPE.PLAY_EFFECT: break;
		
		case THMK_EVENT_TYPE.CREATE_ENEMY: {
		_res = __thmk_get_enemy_id(_data.id);
		if(_res == -1) return undefined;
		if(_data.type == 0) {
			for(var i = 0; i < _data.number; i ++) {
				var tmp = __thmk_create_enemy(_res,
				_data.x0 + i * _data.step * cos(_data.dir / 180 * pi),
				_data.y0 - i * _data.step * sin(_data.dir / 180 * pi),
				_data.dir, _data.spd);
				with(tmp) __thmk_execute_code(_data.code, tmp);
			}
		} else if(_data.type == 1) {
			var _angle = 360 / _data.number;
			for(var i = 0; i < _data.number; i ++) {
				var tmp = __thmk_create_enemy(_res,
				_data.x0 + _data.radius * cos((_data.dir + i * _angle) / 180 * pi),
				_data.y0 - _data.radius * sin((_data.dir + i * _angle) / 180 * pi),
				_data.dir + i * _angle, _data.spd);
				with(tmp) __thmk_execute_code(_data.code, tmp);
			}
		} else if(_data.type == 2) {
			var _num = _data.number;
			for(var i = 0; i < _data.number; i ++) {
				var tmp = __thmk_create_enemy(_res,
				_data.x0 + _data.radius * cos((_data.dir + (i - _num / 2 + 0.5) * _data.angle) / 180 * pi),
				_data.y0 - _data.radius * sin((_data.dir + (i - _num / 2 + 0.5) * _data.angle) / 180 * pi),
				_data.dir + (i - _num / 2 + 0.5) * _data.angle, _data.spd);
				with(tmp) __thmk_execute_code(_data.code, tmp);
			}
		}
		
		} break;
		
		case THMK_EVENT_TYPE.CREATE_ENEMY_TIME:
		_res = __thmk_get_enemy_id(_data.id);
		if(_res == -1) return undefined;
		if(_data.type == 0) {
			var tmp = __thmk_create_enemy(_res, _data.x0, _data.y0, _data.dir, _data.spd);
			with(tmp) __thmk_execute_code(_data.code, tmp);
		} else if(_data.type == 1) {
			var _angle = 360 / _data.number;
			var tmp = __thmk_create_enemy(_res,
			_data.x0 + _data.radius * cos(_data.dir / 180 * pi),
			_data.y0 - _data.radius * sin(_data.dir / 180 * pi),
			_data.dir, _data.spd);
			with(tmp) __thmk_execute_code(_data.code, tmp);
		} else if(_data.type == 2) {
			var _num = _data.number;
			var tmp = __thmk_create_enemy(_res,
			_data.x0 + _data.radius * cos((_data.dir + (-_num / 2 + 0.5) * _data.angle) / 180 * pi),
			_data.y0 - _data.radius * sin((_data.dir + (-_num / 2 + 0.5) * _data.angle) / 180 * pi),
			_data.dir + (-_num / 2 + 0.5) * _data.angle, _data.spd);
			with(tmp) __thmk_execute_code(_data.code, tmp);
		}
		if(_data.number <= 1) return undefined;
		var ret = [0, THMK_EVENT_LIST_TYPE.CREATE_ENEMY_LIST, _event[2]];
		ret[2].num = 1;
		ret[2].timer = 1;
		ret[2].timer_max = _event[2].time;
		return ret;
		
		case THMK_EVENT_TYPE.PLAY_STORY:
		case THMK_EVENT_TYPE.PLAY_STORY_TIME: {
		if(_thmk_stage.story) break;
		
		if(__thmk_event_get_type(_event) == THMK_EVENT_TYPE.PLAY_STORY_TIME) {
			_thmk_stage.story = 2;
		} else {
			_thmk_stage.story = 1;
			_thmk_stage.go = false;
			__THMK_TIMER ++;
		}
		
		_thmk_stage.story_list = _data.dialogList;
		for(var i = 0; i < array_length(_thmk_stage.story_list); i ++) {
			var tmp = _thmk_stage.story_list[i];
			tmp.Text = __thmk_get_text(tmp.text);
			tmp.image0index = 0;
			tmp.image1index = 0;
			if(__thmk_event_get_type(_event) == THMK_EVENT_TYPE.PLAY_STORY_TIME) {
				tmp.timer_max = tmp.time;
				tmp.timer = 0;
			}
			if(tmp.state0) {
				tmp.Image0 = __thmk_get_image_id(tmp.image0);
				if(tmp.Image0[0]) tmp.Image0 = tmp.Image0[1];
				else tmp.state0 = 0;
			}
			if(tmp.state1) {
				tmp.Image1 = __thmk_get_image_id(tmp.image1);
				if(tmp.Image1[0]) tmp.Image1 = tmp.Image1[1];
				else tmp.state1 = 0;
			}
			_thmk_stage.story_list[i] = tmp;
		}
		_thmk_stage.story_index = 0;
		} break;
		
		case THMK_EVENT_TYPE.BOSS_START:
		if(instance_exists(_thmk_stage.boss)) return undefined;
		if(_data.boss == -1) return undefined;
		_thmk_stage.boss = __thmk_create_boss(__thmk_get_boss_id(_data.boss), _data.hp);
		break;
		
		case THMK_EVENT_TYPE.BOSS_END:
		if(!instance_exists(_thmk_stage.boss)) return undefined;
		_thmk_stage.boss.state = THMK_BOSS_STATE.EXIT;
		_thmk_stage.boss = noone;
		_thmk_stage.go = 1;
		break;
		
		case THMK_EVENT_TYPE.BOSS_BULLET:
		case THMK_EVENT_TYPE.BOSS_SPELL_CARD:
		if(!instance_exists(_thmk_stage.boss)) return undefined;
		__thmk_set_boss_bullet(_data);
//		if(__thmk_event_get_type(_event) == THMK_EVENT_TYPE.BOSS_SPELL_CARD) 
		break;
		
		case THMK_EVENT_TYPE.CLS:
		for(var i = 0; i < ds_list_size(_thmk_enemy_bullet); i ++) delete _thmk_enemy_bullet[|i];
		ds_list_clear(_thmk_enemy_bullet);
		with(Obj_thmk_enemy) instance_destroy();
		break;
		
		case THMK_EVENT_TYPE.GOTO:
		if(__thmk_execute_resolve(_data.condition)) {
			__THMK_TIMER = _data.t1 * 60 + _data.t2;
		}
		break;
		
		case THMK_EVENT_TYPE.STAGE_CHANGE:
		if(__thmk_execute_resolve(_data.condition)) {
			if(_data.next == 0) {
				__THMK_STAGE ++;
			} else if(_data.next == 1) {
				__THMK_STAGE --;
			} else if(_data.next == 2) {
				game_end();
			}
		}
		break;
		
		case THMK_EVENT_TYPE.POINT: break;
		
		default: break;
	}
	return undefined;
}

function __thmk_execute_event_list(_event) {
	var _data = __thmk_event_get_data(_event);
	
	switch(__thmk_event_get_type(_event)) {
		
		case THMK_EVENT_LIST_TYPE.CREATE_ENEMY_LIST: {
		_data.timer ++;
		if(_data.timer < _data.timer_max) return -1;
		_data.timer = 0;
		_res = __thmk_get_enemy_id(_data.id);
		if(_data.type == 0) {
			var tmp = __thmk_create_enemy(_res,
			_data.x0 + _data.num * _data.step * cos(_data.dir / 180 * pi),
			_data.y0 - _data.num * _data.step * sin(_data.dir / 180 * pi),
			_data.dir, _data.spd);
			with(tmp) __thmk_execute_code(_data.code, tmp);
		} else if(_data.type == 1) {
			var _angle = 360 / _data.number;
			var tmp = __thmk_create_enemy(_res,
			_data.x0 + _data.radius * cos((_data.dir + _data.num * _angle) / 180 * pi),
			_data.y0 - _data.radius * sin((_data.dir + _data.num * _angle) / 180 * pi),
			_data.dir + _data.num * _angle, _data.spd);
			with(tmp) __thmk_execute_code(_data.code, tmp);
		} else if(_data.type == 2) {
			var _num = _data.number;
			var tmp = __thmk_create_enemy(_res,
			_data.x0 + _data.radius * cos((_data.dir + (_data.num - _num / 2 + 0.5) * _data.angle) / 180 * pi),
			_data.y0 - _data.radius * sin((_data.dir + (_data.num - _num / 2 + 0.5) * _data.angle) / 180 * pi),
			_data.dir + (_data.num - _num / 2 + 0.5) * _data.angle, _data.spd);
			with(tmp) __thmk_execute_code(_data.code, tmp);
		}
		_data.num ++;
		if(_data.num >= _data.number) return undefined;
		} return -1;
		
		default: break;
	}
	return undefined;
}

