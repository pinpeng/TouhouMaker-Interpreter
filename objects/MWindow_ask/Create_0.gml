/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

accept = function() {
	emit("accepted");
}

cancel = function() {
	emit("canceled");
}

function _draw_background() {
	draw_black_gui(0.5 * ui_alpha);
	draw_sprite_ext(SprUI_mwindow_window_ask, 0, UI_WIDTH / 2, UI_HEIGHT / 2,
	UI_SCALE, UI_SCALE, 0, -1, ui_alpha);
}


