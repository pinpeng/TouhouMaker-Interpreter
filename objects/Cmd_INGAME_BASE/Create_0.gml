/// @description Insert description here
// You can write your code in this editor

__mTrigger_init();

depth = -10000;

__ingame_view_init();

function _ingame_draw_begin() {
	
	INGAME_SURFACE = surface_check(INGAME_SURFACE, INGAME_WIDTH, INGAME_HEIGHT);
	surface_clear(INGAME_SURFACE, $000000, 1);
	
	VGUI_SURFACE = surface_check(VGUI_SURFACE, VGUI_WIDTH, VGUI_HEIGHT);
	surface_clear(VGUI_SURFACE, $000000, 0);
	
}

function _ingame_draw_gui_begin() {
	
	draw_clear(0);
	
	INGAME_SURFACE = surface_check(INGAME_SURFACE, INGAME_WIDTH, INGAME_HEIGHT);
	ingame_draw_ingame_to_game(INGAME_SURFACE, true, 0);
	
	VGUI_SURFACE = surface_check(VGUI_SURFACE, VGUI_WIDTH, VGUI_HEIGHT);
	ingame_draw_vgui_to_game(VGUI_SURFACE, true);
	
}
