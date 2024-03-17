
function __mInput_update_begin() {
	if(gamepad_is_connected(0)) {
		if(mouse_xprevious != mouse_x
		|| mouse_yprevious != mouse_y)
		{ __MBN_INPUT_TYPE = INPUT_TYPE.KEYBOARD; return; }
		if(mouse_xprevious_gui != mouse_x_gui
		|| mouse_yprevious_gui != mouse_y_gui)
		{ __MBN_INPUT_TYPE = INPUT_TYPE.KEYBOARD; return; }
		if(mouse_xprevious_vgui != mouse_x_vgui
		|| mouse_yprevious_vgui != mouse_y_vgui)
		{ __MBN_INPUT_TYPE = INPUT_TYPE.KEYBOARD; return; }
		if(keyboard_check(vk_anykey)) 
		{ __MBN_INPUT_TYPE = INPUT_TYPE.KEYBOARD; return; }
		if(abs(gamepad_axis_value(0, gp_axislh)) >= 0.1
		|| abs(gamepad_axis_value(0, gp_axislv)) >= 0.1
		|| abs(gamepad_axis_value(0, gp_axisrh)) >= 0.1
		|| abs(gamepad_axis_value(0, gp_axisrv)) >= 0.1)
		{ __MBN_INPUT_TYPE = INPUT_TYPE.GAMEPAD; return; }
		if(gamepad_button_check(0, gp_face1)
		|| gamepad_button_check(0, gp_face2)
		|| gamepad_button_check(0, gp_face3)
		|| gamepad_button_check(0, gp_face4))
		{ __MBN_INPUT_TYPE = INPUT_TYPE.GAMEPAD; return; }
		if(gamepad_button_check(0, gp_padu)
		|| gamepad_button_check(0, gp_padd)
		|| gamepad_button_check(0, gp_padl)	
		|| gamepad_button_check(0, gp_padr))
		{ __MBN_INPUT_TYPE = INPUT_TYPE.GAMEPAD; return; }
		if(gamepad_button_check(0, gp_shoulderl)
		|| gamepad_button_check(0, gp_shoulderr)
		|| gamepad_button_check(0, gp_shoulderlb)
		|| gamepad_button_check(0, gp_shoulderlb))
		{ __MBN_INPUT_TYPE = INPUT_TYPE.GAMEPAD; return; }
		if(gamepad_button_check(0, gp_start)
		|| gamepad_button_check(0, gp_select)
		|| gamepad_button_check(0, gp_stickl)
		|| gamepad_button_check(0, gp_stickr))
		{ __MBN_INPUT_TYPE = INPUT_TYPE.GAMEPAD; return; }
	} else __MBN_INPUT_TYPE = INPUT_TYPE.KEYBOARD;
}

function __mInput_update_end() {
	mouse_xprevious = mouse_x;
	mouse_yprevious = mouse_y;
	
	mouse_xprevious_gui = mouse_x_gui;
	mouse_yprevious_gui = mouse_y_gui;
	mouse_x_gui = device_mouse_x_to_gui(0);
	mouse_y_gui = device_mouse_y_to_gui(0);
	
	mouse_xprevious_vgui = mouse_x_vgui;
	mouse_yprevious_vgui = mouse_y_vgui;
	var _tmp_scale = min(UI_WIDTH / VGUI_WIDTH, UI_HEIGHT / VGUI_HEIGHT);
	mouse_x_vgui = clamp((mouse_x_gui - UI_WIDTH / 2) / _tmp_scale + VGUI_WIDTH / 2, 0, VGUI_WIDTH);
	mouse_y_vgui = clamp((mouse_y_gui - UI_HEIGHT / 2) / _tmp_scale + VGUI_HEIGHT / 2, 0, VGUI_HEIGHT);
}

