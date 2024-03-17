// Draw functions for GameMaker

#macro bm_set gpu_set_blendmode_ext_sepalpha(bm_src_alpha, bm_inv_src_alpha, bm_one, bm_one)
#macro bm_set_add gpu_set_blendmode(bm_add)
#macro bm_reset gpu_set_blendmode(bm_normal)

#macro texft_on  gpu_set_tex_filter(true)
#macro texft_off gpu_set_tex_filter(false)

function text_set(_halign = fa_center, _valign = fa_middle) {
	draw_set_halign(_halign);
	draw_set_valign(_valign);
}

function draw_set(_color = $ffffff, _alpha = 1) {
	draw_set_alpha(_alpha);
	draw_set_color(_color);
}

function draw_black_gui(_alpha = 1) {
	draw_set_alpha(_alpha);
	draw_rectangle_color(-1, -1, UI_WIDTH + 1, UI_HEIGHT + 1,
	$000000, $000000, $000000, $000000, 0);
	draw_set_alpha(1);
}

function draw_white_gui(_alpha = 1) {
	draw_set_alpha(_alpha);
	draw_rectangle_color(-1, -1, UI_WIDTH + 1, UI_HEIGHT + 1,
	$ffffff, $ffffff, $ffffff, $ffffff, 0);
	draw_set_alpha(1);
}

function draw_color_gui(_color = $000000, _alpha = 1) {
	draw_set_alpha(_alpha);
	draw_rectangle_color(-1, -1, UI_WIDTH + 1, UI_HEIGHT + 1,
	_color, _color, _color, _color, 0);
	draw_set_alpha(1);
}