/// @description Insert description here
// You can write your code in this editor

if(__THMK_STATE != THMK_STATE.PLAYING) exit;

if(stage >= 1 && stage <= array_length(stages)) {	
	var tmp_stage = stage;
	if(!inited) _stage_init();
	__thmk_execute_code(stages[stage - 1].step);
	
	for(var i = 0; i < stages[stage - 1].event; i ++) {
		if(__thmk_execute_resolve(stages[stage - 1].eventList[i].condition)) {
			__thmk_execute_code(stages[stage - 1].eventList[i].code);
		}
	}
	
	if(tmp_stage != stage) {
		inited = false;
		exit;
	}
	timer ++;
	if(stages[stage - 1].type == 1) {
		if(timer > timer_end) {
			stage ++;
			inited = false;
		}
	}
}









