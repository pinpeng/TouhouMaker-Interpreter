
function input_is_kb() {
	return __MBN_INPUT_TYPE == INPUT_TYPE.KEYBOARD;
}

function input_is_gp() {
	return __MBN_INPUT_TYPE == INPUT_TYPE.GAMEPAD;
}

function input_gplv(_devive = 0) {
	if(!__MBN_INPUT_ENABLE) return 0;
	return gamepad_axis_value(_devive, gp_axislv);
}

function input_gplh(_devive = 0) {
	if(!__MBN_INPUT_ENABLE) return 0;
	return gamepad_axis_value(_devive, gp_axislh);
}

function input_gprv(_devive = 0) {
	if(!__MBN_INPUT_ENABLE) return 0;
	return gamepad_axis_value(_devive, gp_axisrv);
}

function input_gprh(_devive = 0) {
	if(!__MBN_INPUT_ENABLE) return 0;
	return gamepad_axis_value(_devive, gp_axisrh);
}

function input_gplt(_devive = 0) {
	if(!__MBN_INPUT_ENABLE) return 0;
	return gamepad_button_value(_devive, gp_shoulderlb);
}

function input_gprt(_devive = 0) {
	if(!__MBN_INPUT_ENABLE) return 0;
	return gamepad_button_value(_devive, gp_shoulderrb);
}

function input_kb(_key) {
	if(!__MBN_INPUT_ENABLE) return false;
	var _tmp = __MBN_INPUT_LIST_BUTTON_KEYBOARD[_key];
	for(var i = 0; i < array_length(_tmp); i ++) {
		if(keyboard_check(_tmp[i])) return true;
	}
	return false;
}

function input_gp(_key, _device = 0) {
	if(!__MBN_INPUT_ENABLE) return false;
	var _tmp = __MBN_INPUT_LIST_BUTTON_GAMEPAD[_key];
	for(var i = 0; i < array_length(_tmp); i ++) {
		if(gamepad_button_check(0, _tmp[i])) return true;
	}
	return false;
}

function input_kb_pressed(_key) {
	if(!__MBN_INPUT_ENABLE) return false;
	var _tmp = __MBN_INPUT_LIST_BUTTON_KEYBOARD[_key];
	for(var i = 0; i < array_length(_tmp); i ++) {
		if(keyboard_check_pressed(_tmp[i])) return true;
	}
	return false;
}

function input_gp_pressed(_key, _device = 0) {
	if(!__MBN_INPUT_ENABLE) return false;
	var _tmp = __MBN_INPUT_LIST_BUTTON_GAMEPAD[_key];
	for(var i = 0; i < array_length(_tmp); i ++) {
		if(gamepad_button_check_pressed(0, _tmp[i])) return true;
	}
	return false;
}

function input_kb_released(_key) {
	if(!__MBN_INPUT_ENABLE) return false;
	var _tmp = __MBN_INPUT_LIST_BUTTON_KEYBOARD[_key];
	for(var i = 0; i < array_length(_tmp); i ++) {
		if(keyboard_check_released(_tmp[i])) return true;
	}
	return false;
}

function input_gp_released(_key, _device = 0) {
	if(!__MBN_INPUT_ENABLE) return false;
	var _tmp = __MBN_INPUT_LIST_BUTTON_GAMEPAD[_key];
	for(var i = 0; i < array_length(_tmp); i ++) {
		if(gamepad_button_check_released(0, _tmp[i])) return true;
	}
	return false;
}

#macro ms_l input_ms(mb_left)
#macro ms_r input_ms(mb_right)
#macro ms_lp input_ms_pressed(mb_left)
#macro ms_rp input_ms_pressed(mb_right)
#macro ms_lr input_ms_released(mb_left)
#macro ms_rr input_ms_released(mb_right)

function input_ms(_key, _device = 0) {
	if(!__MBN_INPUT_ENABLE) return false;
	return device_mouse_check_button(_device, _key);
}

function input_ms_pressed(_key, _device = 0) {
	if(!__MBN_INPUT_ENABLE) return false;
	return device_mouse_check_button_pressed(_device, _key);
}

function input_ms_released(_key, _device = 0) {
	if(!__MBN_INPUT_ENABLE) return false;
	return device_mouse_check_button_released(_device, _key);
}

function input_ms_rect(_x1, _y1, _x2, _y2, _device = 0) {
	var tmp_x = device_mouse_x(_device);
	var tmp_y = device_mouse_y(_device);
	return (_x1 < tmp_x && tmp_x < _x2 && _y1 < tmp_y && tmp_y < _y2);
}

function input_ms_rect_gui(_x1, _y1, _x2, _y2, _device = 0) {
	var tmp_x = device_mouse_x_to_gui(_device);
	var tmp_y = device_mouse_y_to_gui(_device);
	return (_x1 < tmp_x && tmp_x < _x2 && _y1 < tmp_y && tmp_y < _y2);
}

function input_ms_rect_vgui(_x1, _y1, _x2, _y2, _device = 0) {
	var m_x = device_mouse_x_to_gui(_device);
	var m_y = device_mouse_y_to_gui(_device);
	var _tmp_scale = min(UI_WIDTH / VGUI_WIDTH, UI_HEIGHT / VGUI_HEIGHT);
	var tmp_x = clamp((m_x - UI_WIDTH / 2) / _tmp_scale + VGUI_WIDTH / 2, 0, VGUI_WIDTH);
	var tmp_y = clamp((m_y - UI_HEIGHT / 2) / _tmp_scale + VGUI_HEIGHT / 2, 0, VGUI_HEIGHT);
	return (_x1 < tmp_x && tmp_x < _x2 && _y1 < tmp_y && tmp_y < _y2);
}

function input_ms_circle(_x, _y, _r, _device = 0) {
	var tmp_x = device_mouse_x(_device);
	var tmp_y = device_mouse_y(_device);
	return (point_distance(tmp_x, tmp_y, _x, _y) < _r);
}

function input_ms_circle_gui(_x, _y, _r, _device = 0) {
	var tmp_x = device_mouse_x_to_gui(_device);
	var tmp_y = device_mouse_y_to_gui(_device);
	return (point_distance(tmp_x, tmp_y, _x, _y) < _r);
}

function input_ms_circle_vgui(_x, _y, _r, _device = 0) {
	var m_x = device_mouse_x_to_gui(_device);
	var m_y = device_mouse_y_to_gui(_device);
	var _tmp_scale = min(UI_WIDTH / VGUI_WIDTH, UI_HEIGHT / VGUI_HEIGHT);
	var tmp_x = clamp((m_x - UI_WIDTH / 2) / _tmp_scale + VGUI_WIDTH / 2, 0, VGUI_WIDTH);
	var tmp_y = clamp((m_y - UI_HEIGHT / 2) / _tmp_scale + VGUI_HEIGHT / 2, 0, VGUI_HEIGHT);
	return (point_distance(tmp_x, tmp_y, _x, _y) < _r);
}

