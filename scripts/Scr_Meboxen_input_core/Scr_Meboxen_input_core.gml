
globalvar
__MBN_INPUT_ENABLE,

__MBN_INPUT_LIST_BUTTON_GAMEPAD,
__MBN_INPUT_LIST_BUTTON_GAMEPAD_DEFAULT,
__MBN_INPUT_LIST_BUTTON_KEYBOARD,
__MBN_INPUT_LIST_BUTTON_KEYBOARD_DEFAULT;

__MBN_INPUT_ENABLE = true;

globalvar
mouse_xprevious,
mouse_yprevious,
mouse_x_gui,
mouse_y_gui,
mouse_xprevious_gui,
mouse_yprevious_gui,

mouse_x_vgui,
mouse_y_vgui,
mouse_xprevious_vgui,
mouse_yprevious_vgui;

globalvar
__MBN_INPUT_TYPE; // 0 = keyboard, 1 = gamepad

enum INPUT {
	UP,
	DOWN,
	LEFT,
	RIGHT,
	
	FUNC0, // gamepad A
	FUNC1, // gamepad B
	FUNC2, // gamepad X
	FUNC3, // gamepad Y
	
	FUNC4, // gamepad start (+)
	FUNC5, // gamepad select(-)
 	FUNC6, // gamepad L
	FUNC7, // gamepad R
	
	FUNC8,
	FUNC9,
	FUNC10,
	FUNC11,
}

enum INPUT_TYPE {
	KEYBOARD,
	GAMEPAD
}

function __mInput_init() {
	switch(os_type) {
		case os_windows:
		__MBN_INPUT_TYPE = 0;
		break;
		
		default:
		__MBN_INPUT_TYPE = 1;
		break;
	}
	
	mouse_xprevious = mouse_x;
	mouse_yprevious = mouse_y;
	
	mouse_x_gui = device_mouse_x_to_gui(0);
	mouse_y_gui = device_mouse_y_to_gui(0);
	mouse_xprevious_gui = mouse_x_gui;
	mouse_yprevious_gui = mouse_y_gui;
	
	var _tmp_scale = min(UI_WIDTH / VGUI_WIDTH, UI_HEIGHT / VGUI_HEIGHT);
	mouse_x_vgui = clamp((mouse_x_gui - UI_WIDTH / 2) / _tmp_scale + VGUI_WIDTH / 2, 0, VGUI_WIDTH);
	mouse_y_vgui = clamp((mouse_y_gui - UI_HEIGHT / 2) / _tmp_scale + VGUI_HEIGHT / 2, 0, VGUI_HEIGHT);
	mouse_xprevious_vgui = mouse_x_vgui;
	mouse_yprevious_vgui = mouse_y_vgui;
	
	input_reset_button_list();
}

function input_reset_button_list() {
	for(var i = 0; i < 20; i ++) {
		__MBN_INPUT_LIST_BUTTON_KEYBOARD[i] = __MBN_INPUT_LIST_BUTTON_KEYBOARD_DEFAULT[i];
		__MBN_INPUT_LIST_BUTTON_GAMEPAD[i] = __MBN_INPUT_LIST_BUTTON_GAMEPAD_DEFAULT[i];
	}
}

function input_reset_button_keyboard(_key) {
	__MBN_INPUT_LIST_BUTTON_KEYBOARD[_key] = __MBN_INPUT_LIST_BUTTON_KEYBOARD_DEFAULT[_key];
}

function input_reset_button_gamepad(_key) {
	__MBN_INPUT_LIST_BUTTON_GAMEPAD[_key] = __MBN_INPUT_LIST_BUTTON_GAMEPAD_DEFAULT[_key];
}



