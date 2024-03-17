// Debug function for Meboxen Library

globalvar __MBN_DEBUG_FONT, __MBN_DEBUG_TIMER;
	
globalvar __MBN_DEBUG_FPS_RT, __MBN_DEBUG_FPS_RT_ARR;
globalvar __MBN_DEBUG_FPS_RL, __MBN_DEBUG_FPS_RL_ARR;

function __mDebug_init() {
	
	__MBN_DEBUG_TIMER = 0;
	__MBN_DEBUG_FONT = font_add_sprite_ext(SprFont_Meboxen_debug,
	"0123456789" + 
	"AaBbCcDdEeFfGgHhIiJjKkLlMmNn" +
	"OoPpQqRrSsTtUuVvWwXxYyZz" +
	",.!?/:+-*()%", 1, 2);
		
	__MBN_DEBUG_FPS_RT_ARR = array_create(64, 0);
	__MBN_DEBUG_FPS_RL_ARR = array_create(64, 0);
	
	__MBN_DEBUG_FPS_RT = 0;
	__MBN_DEBUG_FPS_RL = 0;
	
}

function __mDebug_step() {
	__MBN_DEBUG_TIMER ++;
	if(__MBN_DEBUG_TIMER > 3) {
		__MBN_DEBUG_TIMER = 0;
		__MBN_DEBUG_FPS_RT = 0;
		__MBN_DEBUG_FPS_RL = 0;
		for(var i = 63; i > 0; i --) {
			__MBN_DEBUG_FPS_RT_ARR[i] = __MBN_DEBUG_FPS_RT_ARR[i - 1];
			__MBN_DEBUG_FPS_RL_ARR[i] = __MBN_DEBUG_FPS_RL_ARR[i - 1];
			__MBN_DEBUG_FPS_RT += __MBN_DEBUG_FPS_RT_ARR[i];
			__MBN_DEBUG_FPS_RL += __MBN_DEBUG_FPS_RL_ARR[i];
		}
		__MBN_DEBUG_FPS_RT_ARR[0] = fps;
		__MBN_DEBUG_FPS_RL_ARR[0] = fps_real;
		__MBN_DEBUG_FPS_RT = (__MBN_DEBUG_FPS_RT + fps) / 64;
		__MBN_DEBUG_FPS_RL = (__MBN_DEBUG_FPS_RL + fps_real) / 64;
	}
}

function __mDebug_draw(_x = 0, _y = 0, _alpha = 0.5) {
	
	draw_set_alpha(_alpha);
	draw_rectangle_color(_x, _y, _x + 248, _y + 160, 0, 0, 0, 0, 0);
	
	draw_set_font(__MBN_DEBUG_FONT);
	text_set(fa_left, fa_top);
	draw_set(-1, 1);
	draw_text(_x + 14,  _y + 5,		"BuildDate " + string(date_datetime_string(GM_build_date)));
	draw_text(_x + 14,  _y + 20,	"InstanceNum " + string(instance_count));
	draw_text(_x + 14,  _y + 35,	"FpsRealTime " + string(fps));
	draw_text(_x + 150, _y + 35,	"/  " + string(fps_real));
	draw_text(_x + 14,  _y + 50,	"FpsAverange " + string(__MBN_DEBUG_FPS_RT));
	draw_text(_x + 150, _y + 50,	"/  " + string(__MBN_DEBUG_FPS_RL));
	
	draw_line(_x + 20, _y + 85,  _x + 212,  _y + 85);
	draw_line(_x + 20, _y + 115, _x + 212, _y + 115);
	draw_line(_x + 20, _y + 145, _x + 212, _y + 145);
	
	draw_set_halign(fa_center);
	var tmp_avg = max(4, ceil(__MBN_DEBUG_FPS_RL * 1.2 / 100)) * 100;
	
	draw_set_color($00cc00);
	draw_text(_x + 230, _y + 80, tmp_avg);
	draw_text(_x + 230, _y + 110, tmp_avg / 2);
	draw_text(_x + 230, _y + 140, 0);
	for(var i = 0; i < 62; i ++) {
		draw_line(_x + 210 - i * 3, _y + 145 - __MBN_DEBUG_FPS_RL_ARR[i] / tmp_avg * 60,
		_x + 207 - i * 3, _y + 145 - __MBN_DEBUG_FPS_RL_ARR[i + 1] / tmp_avg * 60);
	}
	
	draw_set_color($ff2222);
	draw_line(_x + 30, _y + 145 - __MBN_DEBUG_FPS_RL / tmp_avg * 60,
	_x + 210, _y + 145 - __MBN_DEBUG_FPS_RL / tmp_avg * 60)
	
	draw_set_color($0000ff);
	draw_line(_x + 30, _y + 146 - __MBN_DEBUG_FPS_RT,
	_x + 210, _y + 146 - __MBN_DEBUG_FPS_RT)
	
	draw_set_color($00ffff);
	draw_text(_x + 11, _y + 80, 60);
	draw_text(_x + 11, _y + 110, 30);
	draw_text(_x + 11, _y + 140, 0);
	for(var i = 0; i < 62; i ++) {
		draw_line(_x + 210 - i * 3, _y + 145 - __MBN_DEBUG_FPS_RT_ARR[i],
		_x + 207 - i * 3, _y + 145 - __MBN_DEBUG_FPS_RT_ARR[i + 1]);
	}
	
	text_set();
	draw_set();
}
