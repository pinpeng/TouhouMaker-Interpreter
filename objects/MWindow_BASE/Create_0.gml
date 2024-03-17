/// @description Insert description here
// You can write your code in this editor

__mTrigger_init();

state = MWINDOW_STATE.START;

_widget_index = 0;
_widget_list = ds_list_create();

focus_on = noone;

image_alpha = 1;

setFocus = function(_id = noone) {
	focus_on = noone;
	if(_id == noone) return;
	for(var i = 0; i < ds_list_size(_widget_list); i ++) {
		if(_widget_list[|i][0] == _id) {
			focus_on = i;
			return;
		}
	}
}

close = function() {
	state = MWINDOW_STATE.END;
	emit("closed");
}

open = function(_window) {
	if(instance_exists(_window)) instance_destroy(_window);
	var ret = instance_create_depth(0, 0, depth - 100, _window);
	connect(ret, "closed", id, "setActive");
	state = MWINDOW_STATE.WAITTING;
	wait();
	return ret;
}

wait = function() {
	state = MWINDOW_STATE.WAITTING;
	emit("waited");
}

setActive = function() {
	state = MWINDOW_STATE.ACTIVE_PRE;
}

setDeactive = function() {
	state = MWINDOW_STATE.DEACTIVE;
}

addWidget = function(_widget, _next = [-1, -1, -1, -1]) {
	ds_list_add(_widget_list, [_widget, _next]);
}

setIndex = function(_index) {
	_widget_index = _index;
	emit("indexChanged", [_index]);
}

function _step_start() { return 1; }

function _step_active() { return 1; }

function _step_deactive() { return 1; }

function _step_waiting() { return 1; }

function _step_destroy() { return 1; }

function _draw_background() { draw_black_gui(0.5); }

function _draw_foreground() { }
