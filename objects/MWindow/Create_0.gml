/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

ui_alpha = 0;

function _draw_background() {
	draw_black_gui(0.5 * ui_alpha);
}

function _step_active() {
	ui_alpha = Lerp(ui_alpha, 1, 0.16);
	return 1;
}

function _step_destroy() {
	ui_alpha = Lerp(ui_alpha, 0, 0.16);
	if(ui_alpha <= 0) return 1;
	return 0;
}

