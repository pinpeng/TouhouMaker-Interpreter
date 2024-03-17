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
	if(_step_active()) __mwindow_step_active();
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

