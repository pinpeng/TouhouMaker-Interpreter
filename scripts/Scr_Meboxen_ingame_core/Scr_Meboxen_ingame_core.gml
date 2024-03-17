
globalvar INGAME_SURFACE;
INGAME_SURFACE = -4;

globalvar INGAME_WIDTH, INGAME_HEIGHT;
INGAME_WIDTH = 320;
INGAME_HEIGHT = 180;

globalvar VGUI_SURFACE;
VGUI_SURFACE = -4;

globalvar VGUI_WIDTH, VGUI_HEIGHT;
VGUI_WIDTH = 320;
VGUI_HEIGHT = 180;

globalvar
INGAME_CAMERA_X,
INGAME_CAMERA_Y,
INGAME_CAMERA_X_TARGET,
INGAME_CAMERA_Y_TARGET,
INGAME_CAMERA_X_LEFT,
INGAME_CAMERA_Y_TOP;

globalvar
INGAME_CAMERA_SHAKE,
INGAME_CAMERA_SHAKE_DIRECTION;

INGAME_CAMERA_SHAKE = [0, 0];// direction, length

function ingame_camera_shake(_strength, _direction = random(360)) {
	var _vec2 = Vec2_add(Dir_to_Vec2(INGAME_CAMERA_SHAKE), Dir_to_Vec2([_direction, _strength]))
	INGAME_CAMERA_SHAKE = Vec2_to_Dir(_vec2);
}

function ingame_camera_get_shake() {
	if(INGAME_CAMERA_SHAKE[1] <= 0.1) return [0, 0];
	var _tmp1 = sqrt(INGAME_CAMERA_SHAKE[1]);
	var _tmp2 = random_range(-_tmp1, _tmp1);
	var _tmp3 = random_range(-_tmp1, _tmp1) / 8;
	return Dir_to_Vec2([INGAME_CAMERA_SHAKE[0] + _tmp3, _tmp2]);
}

