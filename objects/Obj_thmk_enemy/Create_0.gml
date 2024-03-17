/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

timer = 0;
timer_end = 0;
stage = 0;
inited = 0;
val0 = 0;
val1 = 0;
val2 = 0;
val3 = 0;

hp = 1;
range = 1;
collision = 1;

function _init() {
	inited = 0;
	stage = 1;
}

function _stage_init() {
	inited = 1;
	timer = 0;
	timer_end = stages[stage - 1].time;
	__thmk_execute_code(stages[stage - 1].init);
}



