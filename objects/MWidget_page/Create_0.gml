/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

page_id = -1;

_widget_index = 0;
_widget_list = ds_list_create();

focus_on = noone;

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

addWidget = function(_widget, _next = [-1, -1, -1, -1]) {
	ds_list_add(_widget_list, [_widget, _next]);
}

setPage = function(_page_id) {
	if(page_id == _page_id) {
		setActive();
	} else {
		setDeactive();
	}
}

function _step_active(_father, _selected) {
	if(focus_on == noone) {
		var flag = false;
		
		for(var i = 0; i < ds_list_size(_widget_list); i ++) {
			var tmp = _widget_list[|i][0];
			if(input_is_kb() && !flag) {
				if(input_ms_rect_gui(
				tmp.x - tmp.left * UI_SCALE, tmp.y - tmp.top * UI_SCALE,
				tmp.x + tmp.right * UI_SCALE, tmp.y + tmp.bottom * UI_SCALE)) {
					_widget_index = i;
					flag = true;
				}
			}
			tmp.__step(id, _widget_index == i);
		}
		if(!flag) {
			var tmp;
			tmp = _widget_list[|_widget_index][1][0];
			if(tmp != -1 &&
			(input_kb_pressed(INPUT.UP)	  || input_gp_pressed(INPUT.UP)))	 _widget_index = tmp;
			tmp = _widget_list[|_widget_index][1][1];
			if(tmp != -1 &&
			(input_kb_pressed(INPUT.DOWN) || input_gp_pressed(INPUT.DOWN)))  _widget_index = tmp;
			tmp = _widget_list[|_widget_index][1][2];
			if(tmp != -1 &&
			(input_kb_pressed(INPUT.LEFT) || input_gp_pressed(INPUT.LEFT)))  _widget_index = tmp;
			tmp = _widget_list[|_widget_index][1][3];
			if(tmp != -1 &&
			(input_kb_pressed(INPUT.RIGHT)|| input_gp_pressed(INPUT.RIGHT))) _widget_index = tmp;
		}
	} else {
		for(var i = 0; i < ds_list_size(_widget_list); i ++) {
			var tmp = _widget_list[|i][0];
			if(focus_on == i) {
				tmp.__step(id, true);
			} else {
				tmp.__step(id, false);
			}
		}
	}
	
}

function _draw_active(_father, _alpha) {
	for(var i = 0; i < ds_list_size(_widget_list); i ++) {
		_widget_list[|i][0].__draw(id, _alpha);
	}
}

function _draw_deactive(_father, _alpha) { }

