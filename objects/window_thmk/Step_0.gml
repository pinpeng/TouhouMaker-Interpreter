/// @description Insert description here
// You can write your code in this editor

switch(state) {
	case MWINDOW_STATE.START:
	if(_step_start()) __mwindow_step_start();
	break;
	
	case MWINDOW_STATE.ACTIVE_PRE:
	state = MWINDOW_STATE.ACTIVE;
	break;
	
	case MWINDOW_STATE.ACTIVE:
	if(_step_active()) {
		if(!ds_list_size(_widget_list)) return;
	
	if(focus_on == noone) {
		var flag = false;
		for(var i = 0; i < ds_list_size(_widget_list); i ++) {
			var tmp = _widget_list[|i][0];
			/*if(input_is_kb() && !flag) {
				if(input_ms_rect_vgui(
				tmp.x - tmp.left, tmp.y - tmp.top,
				tmp.x + tmp.right, tmp.y + tmp.bottom)) {
					_widget_index = i;
					flag = true;
				}
			}*/
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
	break;
	
	case MWINDOW_STATE.DEACTIVE:
	if(_step_deactive()) __mwindow_step_deactive();
	break;
	
	case MWINDOW_STATE.WAITTING:
	if(_step_waiting()) __mwindow_step_waitting();
	break;
	
	case MWINDOW_STATE.END:
	default:
	if(_step_destroy()) instance_destroy();
	break;
}

