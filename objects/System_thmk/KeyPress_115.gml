
if(!__THMK_DEBUG && !_timer_fullscreen) {
	window_set_fullscreen(!window_get_fullscreen());
	_timer_fullscreen = 60;
}
