/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

VGUI_WIDTH = 1280;
VGUI_HEIGHT = 960;

mwindow_create(window_thmk_menu);

function _ingame_draw_begin() {
	VGUI_SURFACE = surface_check(VGUI_SURFACE, VGUI_WIDTH, VGUI_HEIGHT);
	surface_clear(VGUI_SURFACE, $000000, 1);
	
}

function _ingame_draw_gui_begin() {
	
	draw_clear(0);
	VGUI_SURFACE = surface_check(VGUI_SURFACE, VGUI_WIDTH, VGUI_HEIGHT);
	
	draw_set();
	
/*	surface_set_target(VGUI_SURFACE);
	draw_sprite(SprUI_debug_mouse, 0, mouse_x_vgui, mouse_y_vgui);
	surface_reset_target()*/
	
	texft_on
	bm_set
	
	var _tmp_scale = min(UI_WIDTH / VGUI_WIDTH, UI_HEIGHT / VGUI_HEIGHT);
	//shader_set(Shd_BoxBlur);
	//	shader_set_uniform_f(uniform_BoxBlur_radius, 0.75 / UI_WIDTH, 0.75 / UI_HEIGHT);
		draw_surface_ext(VGUI_SURFACE,
		UI_WIDTH / 2 - VGUI_WIDTH / 2 * _tmp_scale,
		UI_HEIGHT / 2 - VGUI_HEIGHT / 2 * _tmp_scale,
		_tmp_scale, _tmp_scale, 0, -1, 1);
	//shader_reset();
	
	texft_off
	bm_reset
}

