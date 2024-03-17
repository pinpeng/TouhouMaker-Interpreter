
function hero_dir() {
	return point_direction(
	__execute_string_creator.x,
	__execute_string_creator.y,
	Obj_thmk_player.x,
	Obj_thmk_player.y);
}

function enemy_dir() {
	if(instance_exists(Obj_thmk_boss)) {
		return point_direction(
		__execute_string_creator.x,
		__execute_string_creator.y,
		Obj_thmk_boss.x,
		Obj_thmk_boss.y);
	}
	var tmp = instance_nearest(__execute_string_creator.x, __execute_string_creator.y, Obj_thmk_enemy);
	if(!tmp) return __execute_string_creator.dir;
	return point_direction(
	__execute_string_creator.x,
	__execute_string_creator.y,
	tmp.x, tmp.y);
}

function bullet_create(_name, _x, _y, _dir, _spd) {
	var _res = __thmk_get_bullet_name(_name);
	if(_res == -1) return noone;
	var ret = new __thmk_bullet(_res, _x, _y, _dir, _spd);
	ds_list_add(Cmd_thmk_ingame._thmk_enemy_bullet, ret);
	ds_list_add(__THMK_BULLET_BUFFER, ret);
	return ret;
}

function effect_create() {
	return noone;
}

function destroy() {
	__execute_string_creator.del_on_later = true;
}
