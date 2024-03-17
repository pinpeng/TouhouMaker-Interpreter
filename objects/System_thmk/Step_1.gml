
UI_WIDTH = window_get_width();
UI_HEIGHT = window_get_height();
UI_SCALE = min(UI_WIDTH / BASE_RESOLUTION_RATIO_WIDTH, UI_HEIGHT / BASE_RESOLUTION_RATIO_HEIGHT);
_timer_fullscreen = max(0, _timer_fullscreen - 1);

if(display_get_gui_width() != UI_WIDTH || display_get_gui_height() != UI_HEIGHT) {
	display_set_gui_size(UI_WIDTH, UI_HEIGHT);
	display_set_gui_maximise(1, 1, 0, 0);
}


__mDebug_step();

__mTimer_update();

__mInput_update_begin();

if(font_get_size(Font_small) != 12) {
	font_delete(Font_small);
	font_delete(Font_middle);
	font_delete(Font_large);
	Font_small	= font_add("jcyt500W.ttf", 12, 0, 0, 32, 65535);
	Font_middle	= font_add("jcyt500W.ttf", 24, 0, 0, 32, 65535);
	Font_large	= font_add("jcyt500W.ttf", 36, 0, 0, 32, 65535);
}

if(!_consolo) {
	if(keyboard_check_pressed(vk_f1)) {
		_consolo = true;
		__MBN_INPUT_ENABLE = false;
		if(!instance_exists(_consolo_id))
		_consolo_id = mwidget_create_lineEdit(Cmd_systemConsolo, 0, 1, 32 * UI_SCALE, -96 * UI_SCALE,
		"", "Type GML code here...");
	}
} else {
	if(!instance_exists(_consolo_id))
	_consolo_id = mwidget_create_lineEdit(Cmd_systemConsolo, 0, 1, 32 * UI_SCALE, -96 * UI_SCALE,
	"", "Type GML code here...");
	_consolo_id.setSize(0, 32 * UI_SCALE, UI_WIDTH - 64 * UI_SCALE, 0);
	_consolo_id.setPosition(0, 1, 32 * UI_SCALE, -96 * UI_SCALE);
	if(keyboard_check_pressed(vk_f1)) {
		if(instance_exists(_consolo_id)) instance_destroy(_consolo_id);
		_consolo_id = noone;
		_consolo = false;
		__MBN_INPUT_ENABLE = true;
	}
}

if((base_timer_360 mod 60) == 0) {
	var _tmp_size = string_count("\n", __execute_print_string);
	if(_tmp_size > 80) {
		var _arr = string_split(__execute_print_string, "\n", true);
		__execute_print_string = "";
		for(var i = array_length(_arr) - 75; i < array_length(_arr); i ++) {
			__execute_print_string += "\n" + _arr[i];
		}
	}
}

