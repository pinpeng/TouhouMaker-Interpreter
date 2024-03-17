
enum MWINDOW_STATE {
	START = 0,
	ACTIVE_PRE = 11,
	ACTIVE = 10,
	DEACTIVE = 20,
	WAITTING = 100,
	END = -100
}

enum MWIDGET_STATE {
	ACTIVE_PRE,
	ACTIVE,
	DEACTIVE
}

function mwindow_create(_window) {
	var ret = instance_create_depth(0, 0, depth - 100, _window);
	return ret;
}

function __mwindow_step_start() {
	state = MWINDOW_STATE.ACTIVE;
}

function __mwindow_step_active() {
	if(!ds_list_size(_widget_list)) return;
	
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

function __mwindow_step_deactive() { }

function __mwindow_step_waitting() { }



