/// @description Insert description here
// You can write your code in this editor

switch(__THMK_STATE) {
	
	case THMK_STATE.PRE:
	bgm_stop_all();
	
	for(var i = 0; i < ds_list_size(_thmk_hero_bullet); i ++) delete _thmk_hero_bullet[|i];
	ds_list_clear(_thmk_hero_bullet);
	for(var i = 0; i < ds_list_size(_thmk_enemy_bullet); i ++) delete _thmk_enemy_bullet[|i];
	ds_list_clear(_thmk_enemy_bullet);
	for(var i = 0; i < ds_list_size(_thmk_effect); i ++) delete _thmk_effect[|i];
	ds_list_clear(_thmk_effect);
	with(Obj_thmk_enemy) instance_destroy();
	with(Obj_thmk_boss) instance_destroy();
	
	
	for(var i = 0; i < ds_list_size(_thmk_stage.events_list); i ++) delete _thmk_stage.events_list[|i];
	ds_list_clear(_thmk_stage.events_list);
	
	var _stage = __thmk_get_stage_id(__THMK_GROUP, __THMK_STAGE);
	if(_stage == undefined || _stage == -1) {
		__THMK_STATE = THMK_STATE.END;
		break;
	}
	_thmk_stage.group = __THMK_GROUP;
	_thmk_stage.stage = __THMK_STAGE;
	_thmk_stage.length = __thmk_stage_get_length(_stage);
	var _tmp_arr = __thmk_stage_get_events(_stage);
	_thmk_stage.events = array_create(array_length(_tmp_arr), -4);
	array_copy(_thmk_stage.events, 0, _tmp_arr, 0, array_length(_tmp_arr))
	
	_thmk_stage.boss = noone;
	_thmk_stage.story = false;
	_thmk_stage.story_index = 0;
	_thmk_stage.story_list = [];
	
	if(__THMK_DEBUG) {
		__THMK_TIMER = __THMK_DEBUG_INIT[2];
		__THMK_DEBUG_INIT[2] = 0;
	}
	_thmk_stage.go = true;
	
	__THMK_STATE = THMK_STATE.PLAYING;
	
	bgm_stop_all();
	break;
	
	case THMK_STATE.PLAYING_PRE:
	__THMK_STATE = THMK_STATE.PLAYING;
	break;
	
	case THMK_STATE.PLAYING: {
	if(input_kb_pressed(INPUT.FUNC3)) {
		bgm_pause_all();
		__THMK_STATE = THMK_STATE.PAUSE;
		pause_index = 0;
		break;
	}
	
	for(var i = 0; i < 4; i ++) {
		var tmp = _thmk_stage.background[i];
		if(tmp.id != -1) {
			tmp.x += tmp.spd * cos(tmp.dir / 180 * pi);
			tmp.y -= tmp.spd * sin(tmp.dir / 180 * pi);
			tmp.ind += sprite_get_speed(tmp.id) / 60;
		}
		_thmk_stage.background[i] = tmp;
	}
	
	if(_thmk_stage.story) {
		if(_thmk_stage.story_index >= array_length(_thmk_stage.story_list)) {
			_thmk_stage.story = 0;
			_thmk_stage.go = true;
		} else {
			var tmp = _thmk_stage.story_list[_thmk_stage.story_index];
			if(tmp.state0) tmp.image0index += sprite_get_speed(tmp.image0) / 60;
			if(tmp.state1) tmp.image1index += sprite_get_speed(tmp.image1) / 60;
			_thmk_stage.story_list[_thmk_stage.story_index] = tmp;
			if(_thmk_stage.story == 1) {
				if(input_kb_pressed(INPUT.FUNC0) || input_kb_pressed(INPUT.FUNC1)) {
					_thmk_stage.story_index ++;
				}
			}
			if(_thmk_stage.story == 2) {
				tmp.timer ++;
				if(tmp.timer >= tmp.timer_max) {
					tmp.timer = 0;
					_thmk_stage.story_index ++;
				}
			}
		}
	}
	
	if(!_thmk_stage.go) break;
	
	var _tmp_stage = __THMK_STAGE;
	
	for(var i = 0; i < array_length(_thmk_stage.events); i ++) {
		var _event = __thmk_get_event(_thmk_stage.events[i]);
		if(_event == -1) continue;
		if(__thmk_event_get_time(_event) == __THMK_TIMER) {
			var _tmp = __thmk_execute_event(_event);
			if(!is_undefined(_tmp)) ds_list_add(_thmk_stage.events_list, _tmp);
		}
	}
	for(var i = 0; i < ds_list_size(_thmk_stage.events_list); i ++) {
		var _tmp = __thmk_execute_event_list(_thmk_stage.events_list[|i]);
		if(is_undefined(_tmp)) {
			delete _thmk_stage.events_list[|i];
			ds_list_delete(_thmk_stage.events_list, i);
			i --;
		}
	}
	
	if(_thmk_stage.go) __THMK_TIMER ++;
	
	if(__THMK_TIMER >= _thmk_stage.length) __THMK_STAGE ++;

	if(__THMK_STAGE != _tmp_stage) {
		if(__THMK_STAGE < 0) __THMK_STAGE = 0;
		__THMK_STATE = THMK_STATE.PRE;
		__THMK_TIMER = 0;
		if(__THMK_STAGE >= array_length(__THMK_DATABASE.arr_stage[__THMK_GROUP])) {
			__THMK_STATE = THMK_STATE.END;
		}
	}
	
	
	} break;
	
	case THMK_STATE.DIE: {
		if(input_kb_pressed(INPUT.UP)) {
			pause_index --;
			if(pause_index < 0) pause_index = 2;
		}
		if(input_kb_pressed(INPUT.DOWN)) {
			pause_index ++;
			if(pause_index > 2) pause_index = 0;
		}
		if(input_kb_pressed(INPUT.FUNC0)) {
			if(pause_index == 0) {
				__THMK_STATE = THMK_STATE.PLAYING_PRE;
				__THMK_HERO_HP = 3;
				__THMK_HERO_MP = 3;
				Obj_thmk_player.x = 0;
				Obj_thmk_player.y = 400;
				bgm_resume_all();
			}
			if(pause_index == 1) {
				__THMK_STATE = THMK_STATE.PRE;
				__THMK_TIMER = 0;
				__THMK_HERO_HP = 3;
				__THMK_HERO_MP = 3;
				Obj_thmk_player.x = 0;
				Obj_thmk_player.y = 400;
				bgm_stop_all();
			}
			if(pause_index == 2) {
				bgm_stop_all();
				room_goto(Room_thmk_menu);
			}
		}
	}
	break;
	
	case THMK_STATE.PAUSE:
	if(__THMK_DEBUG) {
		if(input_kb_pressed(INPUT.FUNC3)) {
			__THMK_STATE = THMK_STATE.PLAYING_PRE;
			bgm_resume_all();
		}
		break;
	}
	if(input_kb_pressed(INPUT.UP)) {
		pause_index --;
		if(pause_index < 0) pause_index = 2;
	}
	if(input_kb_pressed(INPUT.DOWN)) {
		pause_index ++;
		if(pause_index > 2) pause_index = 0;
	}
	
	if(input_kb_pressed(INPUT.FUNC3)) {
		__THMK_STATE = THMK_STATE.PLAYING_PRE;
		bgm_resume_all();
		break;
	}
	if(input_kb_pressed(INPUT.FUNC0)) {
		if(pause_index == 0) {
			__THMK_STATE = THMK_STATE.PLAYING_PRE;
			bgm_resume_all();
		}
		if(pause_index == 1) {
			__THMK_STATE = THMK_STATE.PRE;
			__THMK_TIMER = 0;
			__THMK_HERO_HP = 3;
			__THMK_HERO_MP = 3;
			Obj_thmk_player.x = 0;
			Obj_thmk_player.y = 400;
			bgm_stop_all();
		}
		if(pause_index == 2) {
			room_goto(Room_thmk_menu);
			bgm_stop_all();
		}
	}
	break;
	
	case THMK_STATE.END:
	default:
	if(__THMK_DEBUG) game_end();
	else room_goto(Room_thmk_menu);
	break;
}










