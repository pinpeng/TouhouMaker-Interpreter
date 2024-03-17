

function __ingame_view_init() {

	INGAME_CAMERA_X = 0;
	INGAME_CAMERA_Y = 0;
	INGAME_CAMERA_X_TARGET = 0;
	INGAME_CAMERA_Y_TARGET = 0;
	INGAME_CAMERA_X_LEFT = 0;
	INGAME_CAMERA_Y_TOP = 0;
}

function ingame_view_set(_x_target, _y_target) {
	INGAME_CAMERA_X_TARGET = _x_target;
	INGAME_CAMERA_Y_TARGET = _y_target;
}

function __ingame_view_update(_width_deadzone = 0, _height_deadzone = 0) {
	
	INGAME_CAMERA_X_TARGET = clamp(INGAME_CAMERA_X_TARGET,
	_width_deadzone, room_width - _width_deadzone);
	INGAME_CAMERA_Y_TARGET = clamp(INGAME_CAMERA_Y_TARGET,
	_height_deadzone, room_height - _height_deadzone);

	INGAME_CAMERA_X = INGAME_CAMERA_X_TARGET;
	INGAME_CAMERA_Y = INGAME_CAMERA_Y_TARGET;
	
	INGAME_CAMERA_X_LEFT = INGAME_CAMERA_X - INGAME_WIDTH  / 2;
	INGAME_CAMERA_Y_TOP  = INGAME_CAMERA_Y - INGAME_HEIGHT / 2;

	INGAME_CAMERA_SHAKE[1] = Lerp(INGAME_CAMERA_SHAKE[1], 0, 0.1, 0.25);
}

function ingame_draw_ingame_to_game(_surf, _anti_aliasing = false, _edge = 0.0) {
	var _tmp_w = surface_get_width(_surf);
	var _tmp_h = surface_get_height(_surf);
	var _tmp_scale = max(UI_WIDTH / (_tmp_w - _edge * 2), UI_HEIGHT / (_tmp_h - _edge * 2));
	
	var _tmp = ingame_camera_get_shake();
	if(!_anti_aliasing) {
		draw_surface_ext(_surf,
		UI_WIDTH / 2 - (_tmp_w / 2 + _tmp[0] - frac(INGAME_CAMERA_X_LEFT)) * _tmp_scale,
		UI_HEIGHT / 2 - (_tmp_h / 2 + _tmp[1] - frac(INGAME_CAMERA_Y_TOP)) * _tmp_scale,
		_tmp_scale, _tmp_scale, 0, -1, 1);
	} else {
		shader_set(Shd_BoxBlur);
			shader_set_uniform_f(uniform_BoxBlur_radius, 0.5 / UI_WIDTH, 0.5 / UI_HEIGHT);
			draw_surface_ext(_surf,
			UI_WIDTH / 2 + (-_tmp_w / 2 + _tmp[0] - Frac(INGAME_CAMERA_X_LEFT)) * _tmp_scale,
			UI_HEIGHT / 2 + (-_tmp_h / 2 + _tmp[1] - Frac(INGAME_CAMERA_Y_TOP)) * _tmp_scale,
			_tmp_scale, _tmp_scale, 0, -1, 1);
		shader_reset();
	}
}

function ingame_draw_vgui_to_game(_surf, _anti_aliasing = false) {
	var _tmp_w = surface_get_width(_surf);
	var _tmp_h = surface_get_height(_surf);
	var _tmp_scale = max(UI_WIDTH / _tmp_w, UI_HEIGHT / _tmp_h);
	
	var _tmp = ingame_camera_get_shake();
	
	if(!_anti_aliasing) {
		draw_surface_ext(_surf,
		UI_WIDTH / 2 - _tmp_w / 2 * _tmp_scale,
		UI_HEIGHT / 2 - _tmp_h / 2 * _tmp_scale,
		_tmp_scale, _tmp_scale, 0, -1, 1);
	} else {
		shader_set(Shd_BoxBlur);
			shader_set_uniform_f(uniform_BoxBlur_radius, 0.5 / UI_WIDTH, 0.5 / UI_HEIGHT);
			draw_surface_ext(_surf,
			UI_WIDTH / 2 - _tmp_w / 2 * _tmp_scale,
			UI_HEIGHT / 2 - _tmp_h / 2 * _tmp_scale,
			_tmp_scale, _tmp_scale, 0, -1, 1);
		shader_reset();
	}
}

function ingame_draw_surface_to_game(_surf, _xoffset = 0, _yoffset = 0, _anti_aliasing = false, _edge = 0.0) {
	var _tmp_w = surface_get_width(_surf);
	var _tmp_h = surface_get_height(_surf);
	var _tmp_scale = max(UI_WIDTH / (_tmp_w - _edge * 2), UI_HEIGHT / (_tmp_h - _edge * 2));
	var _tmp = ingame_camera_get_shake();
	
	if(!_anti_aliasing) {
		draw_surface_ext(_surf,
		UI_WIDTH / 2 - (_tmp_w / 2 + _tmp[0] + _xoffset) * _tmp_scale,
		UI_HEIGHT / 2 - (_tmp_h / 2 + _tmp[1] + _yoffset) * _tmp_scale,
		_tmp_scale, _tmp_scale, 0, -1, 1);
	} else {
		shader_set(Shd_BoxBlur);
			shader_set_uniform_f(uniform_BoxBlur_radius, 0.5 / UI_WIDTH, 0.5 / UI_HEIGHT);
			draw_surface_ext(_surf,
			UI_WIDTH / 2 - (_tmp_w / 2 + _tmp[0] + _xoffset) * _tmp_scale,
			UI_HEIGHT / 2 - (_tmp_h / 2 + _tmp[1] + _yoffset) * _tmp_scale,
			_tmp_scale, _tmp_scale, 0, -1, 1);
		shader_reset();
	}
}

