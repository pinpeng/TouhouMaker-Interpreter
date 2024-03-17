/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

function _draw_ingame() {
	if(surface_exists(INGAME_SURFACE) && sprite_exists(sprite_index)) {
		bm_set;
		surface_set_target(INGAME_SURFACE);
			draw_sprite_ext(sprite_index, image_index,
			floor(x) - floor(INGAME_CAMERA_X_LEFT) - 2, floor(y) - floor(INGAME_CAMERA_Y_TOP) - 2,
			image_xscale, image_yscale, image_angle, 0, image_alpha / 2);
			draw_sprite_ext(sprite_index, image_index,
			floor(x) - floor(INGAME_CAMERA_X_LEFT), floor(y) - floor(INGAME_CAMERA_Y_TOP),
			image_xscale, image_yscale, image_angle, image_blend, image_alpha);
		surface_reset_target();
		bm_reset;
	}
}
