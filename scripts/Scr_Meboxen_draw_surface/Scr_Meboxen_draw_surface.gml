
function surface_check(_surf, _width, _height) {
	if(!surface_exists(_surf)) return surface_create(_width, _height);
	if(surface_get_width(_surf) != _width || surface_get_height(_surf) != _height) {
		surface_free(_surf);
		return surface_create(_width, _height);
	} else return _surf;
}

function surface_clear(_surf, _color = 0, _alpha = 1) {
	surface_set_target(_surf);
	draw_clear_alpha(_color, _alpha);
	surface_reset_target();
}

function draw_surface_center(_surf, _x, _y) {
	draw_surface(_surf,
	_x - surface_get_width(_surf) / 2,
	_y - surface_get_height(_surf) / 2);
}

function draw_surface_to_size(_surf, _x, _y, _width, _height, _anti_aliasing = false, _edge = 0.0) {
	var _tmp_w = surface_get_width(_surf);
	var _tmp_h = surface_get_height(_surf);
	var _tmp_scale = max(_width / (_tmp_w - _edge * 2), _height / (_tmp_h - _edge * 2));
	if(!_anti_aliasing) {
		draw_surface_part_ext(_surf, _edge, _edge, _tmp_w - _edge * 2, _tmp_h - _edge * 2, 
		_x - _edge * _tmp_scale,
		_y - _edge * _tmp_scale,
		_tmp_scale, _tmp_scale, -1, 1);
	} else {
		shader_set(Shd_BoxBlur);
			shader_set_uniform_f(uniform_BoxBlur_radius, 0.5 / _width, 0.5 / _height);
			draw_surface_part_ext(_surf, _edge, _edge, _tmp_w - _edge * 2, _tmp_h - _edge * 2, 
			_x - _edge * _tmp_scale,
			_y - _edge * _tmp_scale,
			_tmp_scale, _tmp_scale, -1, 1);
		shader_reset();
	}
}






