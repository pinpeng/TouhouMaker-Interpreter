
#region // text

function __thmk_read_text() {
	var str = "";
	if(__THMK_DEBUG) str = __THMK_DEBUG_PATH + "/";
	var fin = file_text_open_read(str + "text.json");
	if(fin == -1) return 1;
	
	var _json = "";
	while(!file_text_eof(fin)) _json += file_text_readln(fin);
	__THMK_DATABASE.text = json_parse(_json);
	
	file_text_close(fin);
	return 0;
}

#endregion

#region // image

function __thmk_read_image_index() {
	var fin = file_text_open_read(temp_directory + "image/index");
	if(fin == -1) return 1;
	
	var _num = file_text_read_real(fin);
	file_text_readln(fin);
	
	__THMK_DATABASE.map_image = ds_map_create();
	__THMK_DATABASE.arr_image = array_create(_num);
	
	for(var i = 0; i < _num; i ++) {
		var _name = file_text_read_string(fin);
		file_text_readln(fin);
		var _id = file_text_read_real(fin);
		file_text_readln(fin);
		__THMK_DATABASE.map_image[? _name] = _id;
		__THMK_DATABASE.arr_image[_id] = [0, Spr_thmk_default_image, 0, 0];
		
		var _state = file_text_read_real(fin);
		file_text_readln(fin);
		__THMK_DATABASE.arr_image[_id][0] = _state;
		if(_state == 2) {
			_state = file_text_read_real(fin);
			file_text_readln(fin);
			__THMK_DATABASE.arr_image[_id][2] = _state;
			_state = file_text_read_real(fin);
			file_text_readln(fin);
			__THMK_DATABASE.arr_image[_id][3] = _state;
		}
	}
	
	file_text_close(fin);
	return 0;
}

function __thmk_read_image(_id) {
	switch(__THMK_DATABASE.arr_image[_id][0]) {
		case 1:
		if(!file_exists(temp_directory + "image/" + string(_id) + ".png")) return 1;
		__THMK_DATABASE.arr_image[_id][1] = 
		sprite_add_ext(temp_directory + "image/" + string(_id) + ".png", 1, 0, 0, true);
		break;
		
		case 2:
		if(!file_exists(temp_directory + "image/" + string(_id) + ".png")) return 1;
		__THMK_DATABASE.arr_image[_id][1] = 
		sprite_add_ext(temp_directory + "image/" + string(_id) + ".png",
		__THMK_DATABASE.arr_image[_id][2], 0, 0, true);
		sprite_set_speed(__THMK_DATABASE.arr_image[_id][1], 1000 / __THMK_DATABASE.arr_image[_id][3],
		spritespeed_framespersecond);
		//sprite_add(temp_directory + "image/" + string(_id) + arr_surfix[2], 1, 0, 0, 0, 0);
		break;
		
		default: break;
	}
	return 0;
}

#endregion

#region // audio

function __thmk_read_audio_index() {
	var fin = file_text_open_read(temp_directory + "audio/index");
	if(fin == -1) return 1;
	
	var _num = file_text_read_real(fin);
	file_text_readln(fin);
	
	__THMK_DATABASE.map_audio = ds_map_create();
	__THMK_DATABASE.arr_audio = array_create(_num);
	
	for(var i = 0; i < _num; i ++) {
		var _name = file_text_read_string(fin);
		file_text_readln(fin);
		var _id = file_text_read_real(fin);
		file_text_readln(fin);
		__THMK_DATABASE.map_audio[? _name] = _id;
		__THMK_DATABASE.arr_audio[_id] = [0, noone];
		
		var _state = file_text_read_real(fin);
		file_text_readln(fin);
		__THMK_DATABASE.arr_audio[_id][0] = _state;
	}
	
	file_text_close(fin);
	return 0;
}

function __thmk_read_audio(_id) {
	static arr_surfix = ["", ".ogg"];
	switch(__THMK_DATABASE.arr_audio[_id][0]) {
		case 1:
		if(!file_exists(temp_directory + "audio/" + string(_id) + arr_surfix[1])) return 1;
		__THMK_DATABASE.arr_audio[_id][1] = 
		audio_create_stream(temp_directory + "audio/" + string(_id) + arr_surfix[1]);
		break;
		
		default: break;
	}
	return 0;
}

#endregion

#region // effect

function __thmk_read_effect_index() {
	var fin = file_text_open_read(temp_directory + "effect/index");
	if(fin == -1) return 1;
	
	var _num = file_text_read_real(fin);
	file_text_readln(fin);
	
	__THMK_DATABASE.map_effect = ds_map_create();
	__THMK_DATABASE.arr_effect = array_create(_num);
	
	for(var i = 0; i < _num; i ++) {
		var _name = file_text_read_string(fin);
		file_text_readln(fin);
		var _id = file_text_read_real(fin);
		file_text_readln(fin);
		__THMK_DATABASE.map_effect[? _name] = _id;
		__THMK_DATABASE.arr_effect[_id] = [0, noone];
	}
	
	file_text_close(fin);
	return 0;
}

function __thmk_read_effect(_id) {
	return 0;
}

#endregion

#region // bullet

function __thmk_read_bullet_index() {
	var fin = file_text_open_read(temp_directory + "bullet/index");
	if(fin == -1) return 1;
	
	var _num = file_text_read_real(fin);
	file_text_readln(fin);
	
	__THMK_DATABASE.map_bullet = ds_map_create();
	__THMK_DATABASE.arr_bullet = array_create(_num);
	
	for(var i = 0; i < _num; i ++) {
		var _name = file_text_read_string(fin);
		file_text_readln(fin);
		var _id = file_text_read_real(fin);
		file_text_readln(fin);
		__THMK_DATABASE.map_bullet[? _name] = _id;
		__THMK_DATABASE.arr_bullet[_id] = [Spr_thmk_default_bullet, noone];
		
		var _image = file_text_read_real(fin);
		file_text_readln(fin);
		if(_image != -1) {
			var _tmp = __THMK_DATABASE.arr_image[_image];
			if(_tmp[0] != -1) __THMK_DATABASE.arr_bullet[_id][0] = _tmp[1];
		}
	}
	
	file_text_close(fin);
	return 0;
}

function __thmk_read_bullet(_id) {
	var fin = file_text_open_read(temp_directory + "bullet/" + string(_id));
	if(fin == -1) return 1;
	
	var _json = "";
	while(!file_text_eof(fin)) _json += file_text_readln(fin);
	__THMK_DATABASE.arr_bullet[_id][1] = json_parse(_json);
	
	for(var i = 0; i < __THMK_DATABASE.arr_bullet[_id][1].stage; i ++) {
		var _stage = __THMK_DATABASE.arr_bullet[_id][1].stageList[i];
		
		_stage.init = __thmk_execute_create_code(_stage.init);
		_stage.step = __thmk_execute_create_code(_stage.step);
		for(var j = 0; j < _stage.event; j ++) {
			_stage.eventList[j].condition = __thmk_execute_create_code(_stage.eventList[j].condition);
			_stage.eventList[j].code = __thmk_execute_create_code(_stage.eventList[j].code);
		}
		
		__THMK_DATABASE.arr_bullet[_id][1].stageList[i] = _stage;
	}
	
	file_text_close(fin);
	return 0;
}

#endregion

#region // hero

function __thmk_read_hero_index() {
	var fin = file_text_open_read(temp_directory + "character/index0");
	if(fin == -1) return 1;
	
	var _num = file_text_read_real(fin);
	file_text_readln(fin);
	
	__THMK_DATABASE.map_hero = ds_map_create();
	__THMK_DATABASE.arr_hero = array_create(_num);
	
	for(var i = 0; i < _num; i ++) {
		var _name = file_text_read_real(fin);
		file_text_readln(fin);
		var _id = file_text_read_real(fin);
		file_text_readln(fin);
		__THMK_DATABASE.map_hero[? __THMK_DATABASE.text.textList[_name][0]] = _id;
		__THMK_DATABASE.arr_hero[_id] = [array_create(6, Spr_thmk_default_hero_r), noone];
		
		for(var j = 0; j < 6; j ++) {
			var _image = file_text_read_real(fin);
			file_text_readln(fin);
			if(_image != -1) {
				var _tmp = __THMK_DATABASE.arr_image[_image];
				if(_tmp[0] != -1) __THMK_DATABASE.arr_hero[_id][0][j] = _tmp[1];
			}
		}
	}
	
	file_text_close(fin);
	return 0;
}


function __thmk_read_hero(_id) {
	return 0;
}

#endregion

#region // enemy

function __thmk_read_enemy_index() {
	var fin = file_text_open_read(temp_directory + "character/index1");
	if(fin == -1) return 1;
	
	var _num = file_text_read_real(fin);
	file_text_readln(fin);
	
	__THMK_DATABASE.map_enemy = ds_map_create();
	__THMK_DATABASE.arr_enemy = array_create(_num);
	
	for(var i = 0; i < _num; i ++) {
		var _name = file_text_read_string(fin);
		file_text_readln(fin);
		var _id = file_text_read_real(fin);
		file_text_readln(fin);
		__THMK_DATABASE.map_enemy[? _name] = _id;
		__THMK_DATABASE.arr_enemy[_id] = [Spr_thmk_default_enemy, noone];
		
		var _image = file_text_read_real(fin);
		file_text_readln(fin);
		if(_image != -1) {
			var _tmp = __THMK_DATABASE.arr_image[_image];
			if(_tmp[0] != -1) __THMK_DATABASE.arr_enemy[_id][0] = _tmp[1];
		}
	}
	
	file_text_close(fin);
	return 0;
}


function __thmk_read_enemy(_id) {
	var fin = file_text_open_read(temp_directory + "character/enemy" + string(_id));
	if(fin == -1) return 1;
	
	var _json = "";
	while(!file_text_eof(fin)) _json += file_text_readln(fin);
	__THMK_DATABASE.arr_enemy[_id][1] = json_parse(_json);
	
	
	for(var i = 0; i < __THMK_DATABASE.arr_enemy[_id][1].stage; i ++) {
		var _stage = __THMK_DATABASE.arr_enemy[_id][1].stageList[i];
		
		_stage.init = __thmk_execute_create_code(_stage.init);
		_stage.step = __thmk_execute_create_code(_stage.step);
		for(var j = 0; j < _stage.event; j ++) {
			_stage.eventList[j].condition = __thmk_execute_create_code(_stage.eventList[j].condition);
			_stage.eventList[j].code = __thmk_execute_create_code(_stage.eventList[j].code);
		}
		
		__THMK_DATABASE.arr_enemy[_id][1].stageList[i] = _stage;
	}
	
	
	file_text_close(fin);
	return 0;
}

#endregion

#region // boss

function __thmk_read_boss_index() {
	var fin = file_text_open_read(temp_directory + "character/index2");
	if(fin == -1) return 1;
	
	var _num = file_text_read_real(fin);
	file_text_readln(fin);
	
	__THMK_DATABASE.map_boss = ds_map_create();
	__THMK_DATABASE.arr_boss = array_create(_num);
	
	for(var i = 0; i < _num; i ++) {
		var _name = file_text_read_real(fin);
		file_text_readln(fin);
		var _id = file_text_read_real(fin);
		file_text_readln(fin);
		__THMK_DATABASE.map_boss[? __THMK_DATABASE.text.textList[_name][0]] = _id;
		__THMK_DATABASE.arr_boss[_id] = [array_create(3, Spr_thmk_default_boss), noone];
		
		for(var j = 0; j < 3; j ++) {
			var _image = file_text_read_real(fin);
			file_text_readln(fin);
			if(_image != -1) {
				var _tmp = __THMK_DATABASE.arr_image[_image];
				if(_tmp[0] != -1) __THMK_DATABASE.arr_boss[_id][0][j] = _tmp[1];
			}
		}
	}
	
	file_text_close(fin);
	return 0;
}


function __thmk_read_boss(_id) {
	return 0;
}

#endregion

#region // main

function __thmk_read_main_index() {
	
	var fin;
	
	fin = file_text_open_read(temp_directory + "main/index0");
	if(fin == -1) return 1;
	
	var _num = [0, 0];
	_num[0] = file_text_read_real(fin);
	file_text_readln(fin);
	_num[1] = file_text_read_real(fin);
	file_text_readln(fin);
	
	__THMK_DATABASE.num_stage = [_num[0], _num[1]];
	
	__THMK_DATABASE.map_stage = ds_map_create();
	__THMK_DATABASE.arr_stage = [
	array_create(_num[0]),
	array_create(_num[1])];
	
	var _tmp_arr = [
	array_create(_num[0]),
	array_create(_num[1])];
	
	for(var k = 0; k < 2; k ++) {
		for(var i = 0; i < _num[k]; i ++) {
			var _name = file_text_read_string(fin);
			file_text_readln(fin);
			//var _id = file_text_read_real(fin);
			//file_text_readln(fin);
			__THMK_DATABASE.map_stage[? _name] = [k, i];
			__THMK_DATABASE.arr_stage[k][i] = [0, undefined];
			
			var _len = file_text_read_real(fin);
			file_text_readln(fin);
			__THMK_DATABASE.arr_stage[k][i][0] = _len;
			var _size = file_text_read_real(fin);
			file_text_readln(fin);
			__THMK_DATABASE.arr_stage[k][i][1] = array_create(_size);
			for(var j = 0; j < _size; j ++) {
				var _event = file_text_read_real(fin);
				file_text_readln(fin);
				__THMK_DATABASE.arr_stage[k][i][1][j] = _event;
			}
		}
	}
	
	file_text_close(fin);
	
	fin = file_text_open_read(temp_directory + "main/index1");
	if(fin == -1) return 1;
	
	var _num_event = file_text_read_real(fin);
	file_text_readln(fin);
	
	__THMK_DATABASE.arr_event = array_create(_num_event);
	
	for(var k = 0; k < 2; k ++) {
		for(var i = 0; i < _num[k]; i ++) {
			var _size = array_length(__THMK_DATABASE.arr_stage[k][i][1]);
			for(var j = 0; j < _size; j ++) {
				var _id = file_text_read_real(fin);
				file_text_readln(fin);
				__THMK_DATABASE.arr_event[_id] = [0, 0, undefined];
				
				var _time = file_text_read_real(fin);
				file_text_readln(fin);
				__THMK_DATABASE.arr_event[_id][0] = _time;
				var _type = file_text_read_real(fin);
				file_text_readln(fin);
				__THMK_DATABASE.arr_event[_id][1] = _type;
			}
		}
	}
	return 0;
}


function __thmk_read_main_event(_id) {
	var fin = file_text_open_read(temp_directory + "main/" + string(_id));
	if(fin == -1) return 1;
	
	var _json = "";
	while(!file_text_eof(fin)) _json += file_text_readln(fin);
	__THMK_DATABASE.arr_event[_id][2] = json_parse(_json);
	
	switch(__THMK_DATABASE.arr_event[_id][1]) {
		case THMK_EVENT_TYPE.CREATE_ENEMY:
		case THMK_EVENT_TYPE.CREATE_ENEMY_TIME: {
			var _struct = __THMK_DATABASE.arr_event[_id][2];
			_struct.code = __thmk_execute_create_code(_struct.code);
			__THMK_DATABASE.arr_event[_id][2] = _struct;
		} break;
		
		case THMK_EVENT_TYPE.BOSS_BULLET:
		case THMK_EVENT_TYPE.BOSS_SPELL_CARD: {
			var _struct = __THMK_DATABASE.arr_event[_id][2];
			_struct.condition_code = __thmk_execute_create_code(_struct.condition_code);
			for(var i = 0; i < _struct.size; i ++) {
				var _thread = _struct.threadList[i];
				_thread.init = __thmk_execute_create_code(_thread.init);
				_thread.step = __thmk_execute_create_code(_thread.step);
				for(var j = 0; j < _thread.size; j ++) {
					var _bullet = _thread.bulletList[j];
					_bullet.num = __thmk_execute_create_code(_bullet.num);
					_bullet.timer_end = __thmk_execute_create_code(_bullet.timer_end);
					_bullet.wait_timer_end = __thmk_execute_create_code(_bullet.wait_timer_end);
					_bullet.code = __thmk_execute_create_code(_bullet.code);
					_bullet.x0 = __thmk_execute_create_code(_bullet.x0);
					_bullet.y0 = __thmk_execute_create_code(_bullet.y0);
					_bullet.spd = __thmk_execute_create_code(_bullet.spd);
					switch(_bullet.type) {
						case 0:
						_bullet.dir = __thmk_execute_create_code(_bullet.dir);
						_bullet.step = __thmk_execute_create_code(_bullet.step);
						break;
						case 1:
						_bullet.dir = __thmk_execute_create_code(_bullet.dir);
						_bullet.radius = __thmk_execute_create_code(_bullet.radius);
						break;
						case 2:
						_bullet.dir = __thmk_execute_create_code(_bullet.dir);
						_bullet.radius = __thmk_execute_create_code(_bullet.radius);
						_bullet.angle = __thmk_execute_create_code(_bullet.angle);
						break;
						case 3:
						_bullet.x1 = __thmk_execute_create_code(_bullet.x1);
						_bullet.y1 = __thmk_execute_create_code(_bullet.y1);
						break;
						case 4:
						_bullet.radius = __thmk_execute_create_code(_bullet.radius);
						break;
						default:
						_bullet.create = __thmk_execute_create_code(_bullet.create);
						break;
					}
					_thread.bulletList[j] = _bullet;
				}
				_struct.threadList[i] = _thread;
			}
			__THMK_DATABASE.arr_event[_id][2] = _struct;
		} break;
		
		case THMK_EVENT_TYPE.GOTO:
		case THMK_EVENT_TYPE.STAGE_CHANGE:
			var _struct = __THMK_DATABASE.arr_event[_id][2];
			_struct.condition = __thmk_execute_create_code(_struct.condition);
		
		default:
		break;
	}
	
	
	file_text_close(fin);
	return 0;
}

#endregion









