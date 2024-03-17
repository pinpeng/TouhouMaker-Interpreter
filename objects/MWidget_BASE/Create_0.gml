/// @description Insert description here
// You can write your code in this editor

__mTrigger_init();

state = MWIDGET_STATE.ACTIVE_PRE;

pos_x = 0;
pos_y = 0;
xoffset = 0;
yoffset = 0;
	
left = 32;
top = 16;
right = 32;
bottom = 16;


setActive = function() {
	state = MWIDGET_STATE.ACTIVE_PRE;
}

setDeactive = function() {
	state = MWIDGET_STATE.DEACTIVE;
}

setPosition = function(_x, _y, _xoffset, _yoffset) {
	pos_x = _x;
	pos_y = _y;
	xoffset = _xoffset;
	yoffset = _yoffset;
}
	
setSize = function(_left, _top, _right, _bottom) {
	left = _left;
	top = _top;
	right = _right;
	bottom = _bottom;
}

function _step_active(_father, _selected) {}

function _step_deactive(_father, _selected) {}

function _draw_active(_father, _alpha) {
	draw_set();
	draw_rectangle(
	x - left * UI_SCALE,
	y - top * UI_SCALE,
	x + right * UI_SCALE,
	y + bottom * UI_SCALE, 0);
	draw_set();
}

function _draw_deactive(_father, _alpha) {
	draw_set(, 0.5);
	draw_rectangle(
	x - left * UI_SCALE,
	y - top * UI_SCALE,
	x + right * UI_SCALE,
	y + bottom * UI_SCALE, 0);
	draw_set();
}

function __step(_father, _selected) {
	switch(state) {
		case MWIDGET_STATE.ACTIVE_PRE:
		state = MWIDGET_STATE.ACTIVE;
		break;
		
		case MWIDGET_STATE.ACTIVE:
		_step_active(_father, _selected);
		break;
		
		case MWIDGET_STATE.DEACTIVE:
		default:
		_step_deactive(_father, _selected);
		break;
	}
}

function __draw(_father, _alpha) {
	switch(state) {
		case MWIDGET_STATE.ACTIVE_PRE:
		case MWIDGET_STATE.ACTIVE:
		_draw_active(_father, _alpha);
		break;
		
		case MWIDGET_STATE.DEACTIVE:
		default:
		_draw_deactive(_father, _alpha);
		break;
	}
}


