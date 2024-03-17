/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

timer_fire = 0;
timer_fire_max = 12;

timer_skill = 0;
skill_pos = [0, 0];

x = 0;
y = 400;

function _draw_ingame() {
	if(surface_exists(INGAME_SURFACE) && sprite_exists(sprite_index)) {
		bm_set;
		texft_on;
		surface_set_target(INGAME_SURFACE);
			draw_sprite_ext(sprite_index, image_index,
			x - sprite_width / 2 + 435,
			y - sprite_height / 2 + 280,
			image_xscale, image_yscale, image_angle, image_blend, image_alpha);
			if(input_kb(INPUT.FUNC2)) {
				draw_sprite_ext(Spr_thmk_default_hero_center, 0,
				x + 435,
				y + 280,
				1, 1, 0, -1, 1);
			}
		surface_reset_target();
		bm_reset;
		texft_off;
	}
}
