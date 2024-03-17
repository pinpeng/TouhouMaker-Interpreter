/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

surf_ingame_final = -4;
surf_gm_bloom = -4;
surf_gm_bloom_tmp = -4;

INGAME_WIDTH  = 320 + 64;
INGAME_HEIGHT = 180 + 64;

VGUI_WIDTH  = INGAME_WIDTH - 64;
VGUI_HEIGHT = INGAME_HEIGHT - 64;

function _ingame_draw_begin() {
	
	INGAME_SURFACE = surface_check(INGAME_SURFACE, INGAME_WIDTH, INGAME_HEIGHT);
	surface_clear(INGAME_SURFACE, $000000, 1);
	
	surface_set_target(INGAME_SURFACE)
	ingame_draw_background(room_get_background("Background"));
	surface_reset_target();
	
	
	VGUI_SURFACE = surface_check(VGUI_SURFACE, VGUI_WIDTH, VGUI_HEIGHT);
	surface_clear(VGUI_SURFACE, $000000, 0);
}
function _ingame_draw_gui_begin() {
	draw_clear(0);
	INGAME_SURFACE = surface_check(INGAME_SURFACE, INGAME_WIDTH, INGAME_HEIGHT);
	VGUI_SURFACE = surface_check(VGUI_SURFACE, VGUI_WIDTH, VGUI_HEIGHT);
	
	surf_gm_bloom = surface_check(surf_gm_bloom, INGAME_WIDTH, INGAME_HEIGHT);
	surf_gm_bloom_tmp = surface_check(surf_gm_bloom_tmp, INGAME_WIDTH, INGAME_HEIGHT);
	surf_ingame_final = surface_check(surf_ingame_final, UI_WIDTH + 64 * UI_SCALE, UI_HEIGHT + 64 * UI_SCALE);
	
	shader_draw_Bloom(INGAME_SURFACE, surf_gm_bloom, 0.9, 1);
	
	shader_draw_GaussianBlur(surf_gm_bloom, surf_gm_bloom, surf_gm_bloom_tmp,
	INGAME_WIDTH, INGAME_HEIGHT, 1);
	shader_draw_GaussianBlur(surf_gm_bloom, surf_gm_bloom, surf_gm_bloom_tmp,
	INGAME_WIDTH, INGAME_HEIGHT, 2);
	shader_draw_GaussianBlur(surf_gm_bloom, surf_gm_bloom, surf_gm_bloom_tmp,
	INGAME_WIDTH, INGAME_HEIGHT, 4);
	shader_draw_GaussianBlur(surf_gm_bloom, surf_gm_bloom, surf_gm_bloom_tmp,
	INGAME_WIDTH, INGAME_HEIGHT, 2);
	shader_draw_GaussianBlur(surf_gm_bloom, surf_gm_bloom, surf_gm_bloom_tmp,
	INGAME_WIDTH, INGAME_HEIGHT, 1);
	
	surface_set_target(surf_ingame_final);
	draw_clear(0);
	ingame_draw_ingame_to_game(INGAME_SURFACE, true, 32);
	bm_set_add
	ingame_draw_ingame_to_game(surf_gm_bloom, true, 32);
	bm_reset;
	surface_reset_target();
	
	texft_on
	shader_draw_NoiseWarp_to_game(surf_ingame_final, -32 * UI_SCALE, -32 * UI_SCALE,
	UI_WIDTH, UI_HEIGHT, 8 * UI_SCALE, 0, base_timer_2048 / 256, UI_SCALE,
	Texture_cnoise512, 0);
	texft_off
	
	ingame_draw_vgui_to_game(VGUI_SURFACE);
		
}
