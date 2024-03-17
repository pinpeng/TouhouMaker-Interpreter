/// @description Insert description here
// You can write your code in this editor

depth = -12900;

_timer_fullscreen = 0;

_consolo = false;
_consolo_id = noone;

globalvar UI_WIDTH, UI_HEIGHT, UI_SCALE,
BASE_RESOLUTION_RATIO_WIDTH,
BASE_RESOLUTION_RATIO_HEIGHT;

BASE_RESOLUTION_RATIO_WIDTH  = 1280;
BASE_RESOLUTION_RATIO_HEIGHT = 960;

window_set_size(1280, 960);

UI_WIDTH = window_get_width();
UI_HEIGHT = window_get_height();
UI_SCALE = min(UI_WIDTH / BASE_RESOLUTION_RATIO_WIDTH, UI_HEIGHT / BASE_RESOLUTION_RATIO_HEIGHT);

if(file_exists("debug.txt")) {
	__THMK_DEBUG = 1;
	window_set_min_width(75);
	window_set_min_height(90);
	window_set_size(750, 900);
	var fin = file_text_open_read("debug.txt");
	__THMK_DEBUG_PATH = file_text_readln(fin);
	__THMK_DEBUG_PATH = string_copy(__THMK_DEBUG_PATH, 1, string_length(__THMK_DEBUG_PATH) - 1);
	for(var i = 0; i < 4; i ++) {
		__THMK_DEBUG_INIT[i] = file_text_read_real(fin);
		file_text_readln(fin);
	}
	file_text_close(fin);
} else {
	__THMK_DEBUG = 0;
	__mSetting_read();
	window_set_min_width(640);
	window_set_min_height(480);
	window_set_size(1280, 960);
	window_set_caption("THMK RUNNER");
	audio_master_gain(setting_get("audio", "volume_main") / 100);
	if(setting_get("video", "full_screen")) window_set_fullscreen(1);
}


__mTimer_init();

//__mText_init();

__mDebug_init();

__mInput_init();

__mDraw_init();

Font_small	= font_add("jcyt500W.ttf", 12, 0, 0, 32, 65535);
Font_middle	= font_add("jcyt500W.ttf", 24, 0, 0, 32, 65535);
Font_large	= font_add("jcyt500W.ttf", 36, 0, 0, 32, 65535);

__mAudio_init();



