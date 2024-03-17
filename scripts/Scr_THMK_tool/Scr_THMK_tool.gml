
function __thmk_get_text(_id) {
	return __THMK_DATABASE.text.textList[_id][Lan];
}

function __thmk_get_image_name(_name) {
	var _id = __THMK_DATABASE.map_image[? _name];
	if(_id == undefined || _id == -1) return -1; 
	return __THMK_DATABASE.arr_image[_id];
}

function __thmk_get_image_id(_id) {
	if(_id == undefined || _id == -1) return -1; 
	return __THMK_DATABASE.arr_image[_id];
}

function __thmk_get_audio_name(_name) {
	var _id = __THMK_DATABASE.map_audio[? _name];
	if(_id == undefined || _id == -1) return -1; 
	return __THMK_DATABASE.arr_audio[_id];
}

function __thmk_get_audio_id(_id) {
	if(_id == undefined || _id == -1) return -1; 
	return __THMK_DATABASE.arr_audio[_id];
}

function __thmk_get_effect_name(_name) {
	var _id = __THMK_DATABASE.map_effect[? _name];
	if(_id == undefined || _id == -1) return -1; 
	return __THMK_DATABASE.arr_effect[_id];
}

function __thmk_get_effect_id(_id) {
	if(_id == undefined || _id == -1) return -1; 
	return __THMK_DATABASE.arr_effect[_id];
}

function __thmk_get_bullet_name(_name) {
	var _id = __THMK_DATABASE.map_bullet[? _name];
	if(_id == undefined || _id == -1) return -1; 
	return __THMK_DATABASE.arr_bullet[_id];
}

function __thmk_get_bullet_id(_id) {
	if(_id == undefined || _id == -1) return -1; 
	return __THMK_DATABASE.arr_bullet[_id];
}

function __thmk_bullet_get_sprite(_bullet) {
	return _bullet[0];
}

function __thmk_bullet_get_data(_bullet) {
	return _bullet[1];
}

function __thmk_get_hero_name(_name_id) {
	var _id = __THMK_DATABASE.map_hero[? __THMK_DATABASE.text.textList[_name_id][Lan]];
	if(_id == undefined || _id == -1) return -1;
	return __THMK_DATABASE.arr_hero[_id];
}

function __thmk_get_hero_id(_id) {
	if(_id == undefined || _id == -1) return -1; 
	return __THMK_DATABASE.arr_hero[_id];
}

function __thmk_hero_get_sprite(_hero, _image) {
	return _hero[0][_image];
}

function __thmk_hero_get_data(_hero) {
	return _hero[1];
}

function __thmk_get_enemy_name(_name) {
	var _id = __THMK_DATABASE.map_enemy[? _name];
	if(_id == undefined || _id == -1) return -1; 
	return __THMK_DATABASE.arr_enemy[_id];
}

function __thmk_get_enemy_id(_id) {
	if(_id == undefined || _id == -1) return -1; 
	return __THMK_DATABASE.arr_enemy[_id];
}

function __thmk_enemy_get_sprite(_enemy) {
	return _enemy[0];
}

function __thmk_enemy_get_data(_enemy) {
	return _enemy[1];
}

function __thmk_get_boss_name(_name_id) {
	var _id = __THMK_DATABASE.map_boss[? __THMK_DATABASE.text.textList[_name_id][Lan]];
	if(_id == undefined || _id == -1) return -1;
	return __THMK_DATABASE.arr_boss[_id];
}

function __thmk_get_boss_id(_id) {
	if(_id == undefined || _id == -1) return -1;
	return __THMK_DATABASE.arr_boss[_id];
}

function __thmk_boss_get_sprite(_boss, _image) {
	return _boss[0][_image];
}

function __thmk_boss_get_data(_boss) {
	return _boss[1];
}

function __thmk_get_stage_name(_name) {
	var _tmp = __THMK_DATABASE.map_stage[? _name];
	if(_tmp == undefined || _tmp == -1) return -1;
	return __THMK_DATABASE.arr_stage[_tmp[0]][_tmp[1]];
}

function __thmk_get_stage_id(_group, _id) {
	return __THMK_DATABASE.arr_stage[_group][_id];
}

function __thmk_stage_get_length(_stage) {
	return _stage[0];
}

function __thmk_stage_get_events(_stage) {
	return _stage[1];
}

function __thmk_get_event(_id) {
	if(_id == undefined || _id == -1) return -1;
	return __THMK_DATABASE.arr_event[_id];
}

function __thmk_event_get_time(_event) {
	return _event[0];
}

function __thmk_event_get_type(_event) {
	return _event[1];
}

function __thmk_event_get_data(_event) {
	return _event[2];
}
