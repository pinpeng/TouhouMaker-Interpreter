/// @description Insert description here
// You can write your code in this editor

if(__THMK_STATE != THMK_STATE.PLAYING) exit;

for(var i = 0; i < ds_list_size(_thmk_enemy_bullet); i ++) {
	var tmp = _thmk_enemy_bullet[|i];
	if(tmp.stage <= 0) {
		tmp.stage = 1;
		tmp.inited = false;
	} else if(tmp.stage <= tmp.data.stage) {
		var _stage = tmp.data.stageList[tmp.stage - 1];
		var _tmp_stage = tmp.stage;
		if(!tmp.inited) {
			tmp.inited = true;
			tmp.timer = 0;
			tmp.timer_end = _stage.time - 1;
			__thmk_execute_code(_stage.init, tmp);
		}
		
		__thmk_execute_code(_stage.step, tmp);
		for(var j = 0; j < _stage.event; j ++) {
			if(__thmk_execute_resolve(_stage.eventList[j].condition, tmp))
			__thmk_execute_resolve(_stage.eventList[j].code, tmp);
		}
		tmp.timer ++;
		if(_stage.type && _tmp_stage == tmp.stage) {
			if(tmp.timer >= tmp.timer_end + 1) {
				tmp.stage ++;
				tmp.inited = false;
			}
		}
	}
	if(tmp._step()) {
		delete _thmk_enemy_bullet[|i];
		ds_list_delete(_thmk_enemy_bullet, i);
		i --;
		continue;
	}
	
}









