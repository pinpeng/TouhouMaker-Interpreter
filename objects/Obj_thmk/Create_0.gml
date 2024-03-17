/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

del_on_later = false;

function _draw_ingame() {
	if(surface_exists(INGAME_SURFACE) && sprite_exists(sprite_index)) {
		bm_set;
		texft_on;
		surface_set_target(INGAME_SURFACE);
			draw_sprite_ext(sprite_index, image_index,
			x - sprite_width / 2 + 435,
			y - sprite_height / 2 + 280,
			image_xscale, image_yscale, image_angle, image_blend, image_alpha);
		surface_reset_target();
		bm_reset;
		texft_off;
	}
}


