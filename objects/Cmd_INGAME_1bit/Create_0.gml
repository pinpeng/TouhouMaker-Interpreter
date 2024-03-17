/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

depth = 1000;

//window_set_cursor(cr_none);

shdhd_1bit_final_size = shader_get_uniform(Shd_1bit_final, "uv2Size");
shdhd_1bit_final_threshold = shader_get_uniform(Shd_1bit_final, "ufThreshold");
shdhd_1bit_final_bloom = shader_get_sampler_index(Shd_1bit_final, "usBloomTexture");

INGAME_WIDTH = 160;
INGAME_HEIGHT = 120;
VGUI_WIDTH = 160;
VGUI_HEIGHT = 120;

__surf1 = [-4, -4, -4, -4, -4, -4, -4, -4, -4];
__surf2 = [-4, -4];

ingame_view_set(80, 60);

function _ingame_draw_begin() {
	INGAME_SURFACE = surface_check(INGAME_SURFACE, INGAME_WIDTH, INGAME_HEIGHT);
	surface_clear(INGAME_SURFACE, $ffffff, 1);
	
	surface_set_target(INGAME_SURFACE)
	ingame_draw_background(room_get_background("Background"));
	surface_reset_target();
	
	VGUI_SURFACE = surface_check(VGUI_SURFACE, VGUI_WIDTH, VGUI_HEIGHT);
	surface_clear(VGUI_SURFACE, $ffffff, 0);
	
	for(var i = 0; i < 9; i ++) {
		__surf1[i] = surface_check(__surf1[i], INGAME_WIDTH, INGAME_HEIGHT);
	}
	for(var i = 0; i < 2; i ++) {
		__surf2[i] = surface_check(__surf2[i], INGAME_WIDTH * 4, INGAME_HEIGHT * 4);
	}
	
	
}

function _ingame_draw_gui_begin() {
	
	draw_clear(0);
	INGAME_SURFACE = surface_check(INGAME_SURFACE, INGAME_WIDTH, INGAME_HEIGHT);
	
	surface_copy(__surf1[7], 0, 0, __surf1[6]);
	surface_copy(__surf1[6], 0, 0, __surf1[5]);
	surface_copy(__surf1[5], 0, 0, __surf1[4]);
	surface_copy(__surf1[4], 0, 0, __surf1[3]);
	surface_copy(__surf1[3], 0, 0, __surf1[2]);
	surface_copy(__surf1[2], 0, 0, __surf1[1]);
	surface_copy(__surf1[1], 0, 0, __surf1[0]);
	surface_copy(__surf1[0], 0, 0, __surf1[8]);
	
	surface_set_target(__surf1[8]);
		draw_clear_alpha(0, 0);
		gpu_set_blendmode_ext_sepalpha(bm_src_alpha, bm_inv_src_alpha, bm_one, bm_one);
		draw_surface(INGAME_SURFACE, 0, 0);
		draw_surface(VGUI_SURFACE, 0, 0);
/*		draw_sprite(SprUI_debug_mouse, 0,
		floor((mouse_x_gui - UI_WIDTH / 2) / UI_SCALE / 8 + INGAME_WIDTH / 2 + 0.5),
		floor((mouse_y_gui - UI_HEIGHT / 2) / UI_SCALE / 8 + INGAME_HEIGHT / 2 + 0.5));*/
		for(var i = 0; i < 7; i ++) {
			draw_surface_ext(__surf1[0], 0, 0, 1, 1, 0, -1, 0.022 * (8 - i));
		}
		gpu_set_blendmode(bm_normal);
	surface_reset_target();
	
	gpu_set_tex_filter(1);
	surface_set_target(__surf2[0]);
		draw_clear(0);
		shader_set(Shd_1bit_bloom);
			draw_surface_ext(__surf1[8], 0, 0, 4, 4, 0, -1, 1);
		shader_reset();
	surface_reset_target();
	shader_draw_GaussianBlur(__surf2[0], __surf2[0], __surf2[1], INGAME_WIDTH * 4, INGAME_HEIGHT * 4, 1.0);
	shader_draw_GaussianBlur(__surf2[0], __surf2[0], __surf2[1], INGAME_WIDTH * 4, INGAME_HEIGHT * 4, 2.0);
	shader_draw_GaussianBlur(__surf2[0], __surf2[0], __surf2[1], INGAME_WIDTH * 4, INGAME_HEIGHT * 4, 1.0);
	gpu_set_tex_filter(0);
	
	surface_set_target(__surf2[1]);
		draw_clear($000000);
		draw_surface_ext(__surf1[8], 0, 0, 4, 4, 0, -1, 1);
	surface_reset_target();
	
	//gpu_set_tex_filter(1);
	shader_set(Shd_1bit_final);
		var scale = min(UI_WIDTH / INGAME_WIDTH / 4, UI_HEIGHT / INGAME_HEIGHT / 4);
		shader_set_uniform_f(shdhd_1bit_final_size, INGAME_WIDTH, INGAME_HEIGHT);
		shader_set_uniform_f(shdhd_1bit_final_threshold, lerp(0.83, 0.98, scale / 4));
		texture_set_stage(shdhd_1bit_final_bloom, surface_get_texture(__surf2[0]));
		draw_surface_ext(__surf2[1],
		UI_WIDTH / 2 - INGAME_WIDTH * 2 * scale,
		UI_HEIGHT / 2 - INGAME_HEIGHT * 2 * scale,
		scale, scale, 0, -1, 1);
	shader_reset();
	//gpu_set_tex_filter(0);
	
}