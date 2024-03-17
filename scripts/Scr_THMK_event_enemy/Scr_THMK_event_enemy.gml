
function __thmk_create_enemy(_enemy, _x, _y, _dir, _spd) {
	var ret = instance_create_depth(_x, _y, 0, Obj_thmk_enemy);
	ret.dir = _dir;
	ret.spd = _spd;
	
	ret.sprite_index = _enemy[0];
	
	var _data = __thmk_enemy_get_data(_enemy);
	
	ret.hp = _data.hp;
	ret.range = _data.range;
	ret.collision = _data.collision;
	
	var _stage_size = _data.stage;
	ret.stages = array_create(_stage_size);
	
	for(var i = 0; i < _stage_size; i ++) {
		ret.stages[i] = _data.stageList[i];
	}
	
	ret._init();
	return ret;
}

