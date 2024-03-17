/// @description Insert description here
// You can write your code in this editor

if(_consolo) {
	draw_black_gui(0.5);
	draw_set(-1, 1);
	text_set(fa_left, fa_bottom);
	text_set_font(FONT.SYSMALL);
	draw_text(36 * UI_SCALE, UI_HEIGHT - 136 * UI_SCALE, __execute_print_string);
}
if(!__THMK_DEBUG) {
	if(setting_get("global", "debug"))
		__mDebug_draw();
}











