
depth = -12900;

window_set_min_width(1280);
window_set_min_height(720);
_timer_fullscreen = 0;

_consolo = false;
_consolo_id = noone;

globalvar UI_WIDTH, UI_HEIGHT, UI_SCALE,
BASE_RESOLUTION_RATIO_WIDTH,
BASE_RESOLUTION_RATIO_HEIGHT;

BASE_RESOLUTION_RATIO_WIDTH  = 1280;
BASE_RESOLUTION_RATIO_HEIGHT = 720;

UI_WIDTH = window_get_width();
UI_HEIGHT = window_get_height();
UI_SCALE = min(UI_WIDTH / BASE_RESOLUTION_RATIO_WIDTH, UI_HEIGHT / BASE_RESOLUTION_RATIO_HEIGHT);

__mTimer_init();

__mText_init();

__mDebug_init();

__mInput_init();

__mDraw_init();

__mFont_init();

__mAudio_init();

__mSetting_read();
__mSetting_apply();
	
audio_master_gain(setting_get("audio", "volume_main") / 100);
if(setting_get("video", "full_screen_go")) window_set_fullscreen(1);



