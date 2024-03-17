
enum THMK_BOSS_STATE {
	IDLE,
	RUNNING,
	EXIT
}

function __thmk_create_boss(_boss, _hp) {
	var ret = instance_create_depth(-375 - 90, -250 - 90, 0, Obj_thmk_boss);
	ret.hp = _hp;
	ret.hp_max = _hp;
	
	var _img = [Spr_thmk_default_boss, Spr_thmk_default_boss, Spr_thmk_default_boss];
	for(var i = 0; i < 3; i ++) {
		_img[i] = _boss[0][i];
	}
	ret.image = _img;
	ret.sprite_index = _img[0];
	//var _data = __thmk_boss_get_data(_boss);
	
	ret._init();
	return ret;
}

function __thmk_set_boss_bullet(_data) {
	_thmk_stage.boss.inited = 0;
	_thmk_stage.boss.state = THMK_BOSS_STATE.RUNNING;
	_thmk_stage.boss.data = _data;
	
	if(_data.timeType == 0) {
		_thmk_stage.go = false;
		__THMK_TIMER ++;
	}
	
	_thmk_stage.boss.timeType = _data.timeType;
	_thmk_stage.boss.timer_end = _data.time;
	_thmk_stage.boss.condition = _data.condition;
	_thmk_stage.boss.condition_code = _data.condition_code;
	
	_thmk_stage.boss.threads = array_create(_data.size);
	for(var i = 0; i < _data.size; i ++) {
		var tmp = _data.threadList[i];
		_thmk_stage.boss.threads[i] = { val0 : 0, val1 : 0, val2 : 0, val3 : 0,
			id : _thmk_stage.boss,
			inited : false,
			init: tmp.init,
			step: tmp.step,
			type1 : tmp.type1,
			timer1 : 0,
			timer1_end : tmp.type1Time,
			type2 : tmp.type2,
			timer2 : 0,
			timer2_end : tmp.type2Time,
			bulletList : tmp.bulletList,
		};
	}
	
}
