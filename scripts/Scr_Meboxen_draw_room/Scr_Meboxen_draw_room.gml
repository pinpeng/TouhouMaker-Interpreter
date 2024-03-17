
function room_get_tilemap(_name) {
	return layer_tilemap_get_id(layer_get_id(_name));
}

function ingame_draw_tilemap(_id,
_xoffset = -floor(INGAME_CAMERA_X_LEFT),
_yoffset = -floor(INGAME_CAMERA_Y_TOP)) {
	draw_tilemap(_id, _xoffset, _yoffset);
}

function room_get_background(_name) {
	return layer_background_get_id(layer_get_id(_name));
}

function ingame_draw_background(_id,
_xoffset = -floor(INGAME_CAMERA_X_LEFT),
_yoffset = -floor(INGAME_CAMERA_Y_TOP)) {
	var _spr = layer_background_get_sprite(_id);
	var _ind = layer_background_get_index(_id);
	var _x = layer_get_x(_id);
	var _y = layer_get_y(_id);
	draw_sprite(_spr, _ind, _x + _xoffset, _y + _yoffset);
}

