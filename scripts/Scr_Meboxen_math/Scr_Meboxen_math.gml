
globalvar
base_timer_360,
base_timer_2048,
base_timer_100;

function __mTimer_init() {
	base_timer_360 = 0;
	base_timer_2048 = 0;
	base_timer_100 = 0;
}

function __mTimer_update() {
	base_timer_360	= (base_timer_360 + 1)	mod 360;
	base_timer_2048 = (base_timer_2048 + 1) mod 2048;
	base_timer_100	= (base_timer_100 + 1)  mod 100;
}

function Frac(_val) {
	return _val - floor(_val);
}

function Lerp(_val1, _val2, _amount, _near = 0.01) {
	if(abs(_val1 - _val2) <= _near) return _val2;
	return lerp(_val1, _val2, _amount);
}

function Smooth(_val1, _val2, _amount) {
	if(_amount < 0.5) return _val1 + (_val2 - _val1) * sin(_amount * pi) / 2;
	else return _val1 + (_val2 - _val1) * (2 - sin(_amount * pi)) / 2;
}

function Vec2_to_Dir(_vec2 = [0, 0]) { // Direction vectors
	var ret = [0, 0];
	ret[0] = point_direction(0, 0, _vec2[0], _vec2[1]);
	ret[1] = point_distance(0, 0, _vec2[0], _vec2[1]);
	return ret;
}

function Dir_to_Vec2(_dir = [0, 0]) { // Coordinate vectors
	var ret = [0, 0];
	ret[0] =  _dir[1] * cos(_dir[0] / 180 * pi);
	ret[1] = -_dir[1] * sin(_dir[0] / 180 * pi);
	return ret;
}

function Vec2_add(_vec2_0, _vec2_1) {
	var ret = [0, 0];
	ret[0] = _vec2_0[0] + _vec2_1[0];
	ret[1] = _vec2_0[1] + _vec2_1[1];
	return ret;
}

function Vec2_mul(_vec2_0, _vec2_1) {
	var ret = [0, 0];
	ret[0] = _vec2_0[0] * _vec2_1[0];
	ret[1] = _vec2_0[1] * _vec2_1[1];
	return ret;
}

function Vec3_add(_vec3_0, _vec3_1) {
	var ret = [0, 0, 0];
	ret[0] = _vec3_0[0] + _vec3_1[0];
	ret[1] = _vec3_0[1] + _vec3_1[1];
	ret[2] = _vec3_0[2] + _vec3_1[2];
	return ret;
}

function Vec3_mul(_vec3_0, _vec3_1) {
	var ret = [0, 0, 0];
	ret[0] = _vec3_0[0] * _vec3_1[0];
	ret[1] = _vec3_0[1] * _vec3_1[1];
	ret[2] = _vec3_0[2] * _vec3_1[2];
	return ret;
}

