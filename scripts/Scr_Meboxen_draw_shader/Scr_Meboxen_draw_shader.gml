// Draw function for Meboxen Library

#region Simple

function shader_draw_Simple(_surf_from, _surf_to, _full = false) {
	shader_set(Shd_Simple);
		surface_set_target(_surf_to);
		if(_full) {
			draw_surface_ext(_surf_from, 0, 0,
			surface_get_width(_surf_to) / surface_get_width(_surf_from), 
			surface_get_height(_surf_to) / surface_get_height(_surf_from), 0, -1, 1);
		} else draw_surface(_surf_from, 0, 0);
		surface_reset_target();
	shader_reset();
}

function shader_draw_Simple_to_game(_surf_from, _x, _y) {
	shader_set(Shd_Simple);
		draw_surface(_surf_from, _x, _y);
	shader_reset();
}

#endregion

#region Color

function draw_sprite_color_rgb(_sprite, _image, _x, _y, _r, _g, _b, _alpha = 1.0, _mix = 1.0) {
	shader_set(Shd_SpriteColor);
		shader_set_uniform_f(uniform_SpriteColor_color, _r, _g, _b, _alpha);
		shader_set_uniform_f(uniform_SpriteColor_mix, _mix);
		draw_sprite(_sprite, _image, _x, _y);
	shader_reset();
}

function draw_sprite_color(_sprite, _image, _x, _y, _color, _alpha = 1.0, _mix = 1.0) {
	shader_set(Shd_SpriteColor);
		shader_set_uniform_f(uniform_SpriteColor_color,
		color_get_red(_color) / 255,
		color_get_green(_color) / 255,
		color_get_blue(_color) / 255,
		_alpha);
		shader_set_uniform_f(uniform_SpriteColor_mix, _mix);
		draw_sprite(_sprite, _image, _x, _y);
	shader_reset();
}

function draw_sprite_ext_color_rgb(_sprite, _image, _x, _y, _xscale, _yscale, _rot, _r, _g, _b, _alpha = 1.0, _mix = 1.0) {
	shader_set(Shd_SpriteColor);
		shader_set_uniform_f(uniform_SpriteColor_color, _r, _g, _b, _alpha);
		shader_set_uniform_f(uniform_SpriteColor_mix, _mix);
		draw_sprite_ext(_sprite, _image, _x, _y, _xscale, _yscale, _rot, $ffffff, 1);
	shader_reset();
}

function draw_sprite_ext_color(_sprite, _image, _x, _y, _xscale, _yscale, _rot, _color, _alpha = 1.0, _mix = 1.0) {
	shader_set(Shd_SpriteColor);
		shader_set_uniform_f(uniform_SpriteColor_color,
		color_get_red(_color) / 255, color_get_green(_color) / 255, color_get_blue(_color) / 255, _alpha);
		shader_set_uniform_f(uniform_SpriteColor_mix, _mix);
		draw_sprite_ext(_sprite, _image, _x, _y, _xscale, _yscale, _rot, $ffffff, 1);
	shader_reset();
}

#endregion

#region Gray

function shader_draw_Gray(_surf_from, _surf_to, _gray = 1.0, _full = false) {
	shader_set(Shd_Gray);
		shader_set_uniform_f(uniform_Gray_value, _gray);
		surface_set_target(_surf_to);
		if(_full) {
			draw_surface_ext(_surf_from, 0, 0,
			surface_get_width(_surf_to) / surface_get_width(_surf_from), 
			surface_get_height(_surf_to) / surface_get_height(_surf_from), 0, -1, 1);
		} else draw_surface(_surf_from, 0, 0);
		surface_reset_target();
	shader_reset();
}

function shader_draw_Gray_to_game(_surf_from, _x, _y, _gray = 1.0) {
	shader_set(Shd_Gray);
		shader_set_uniform_f(uniform_Gray_value, _gray);
		draw_surface(_surf_from, _x, _y);
	shader_reset();
}

function draw_sprite_gray(_sprite, _image, _x, _y, _gray = 1.0) {
	shader_set(Shd_Gray);
		shader_set_uniform_f(uniform_Gray_value, _gray);
		draw_sprite(_sprite, _image, _x, _y);
	shader_reset();
}

function draw_sprite_ext_gray(_sprite, _image, _x, _y, _xscale, _yscale, _rot, _alpha = 1.0, _gray = 1.0) {
	shader_set(Shd_Gray);
		shader_set_uniform_f(uniform_Gray_value, _gray);
		draw_sprite_ext(_sprite, _image, _x, _y, _xscale, _yscale, _rot, $ffffff, _alpha);
	shader_reset();
}

#endregion

#region Hue Offset

function shader_draw_HueOffset_surf_to_surf(_surf_from, _surf_to, _expand = false,
_offset = 0.5, _middle = 0.5, _r = 0.875, _g = 1.0, _b = 0.125) {
	shader_set(Shd_HueOffset);
		shader_set_uniform_f(uniform_HueOffset_offset, _offset);
		shader_set_uniform_f(uniform_HueOffset_middle, _middle);
		shader_set_uniform_f(uniform_HueOffset_bright_color, _r, _g, _b);
		surface_set_target(_surf_to);
		if(_expand) {
			draw_surface_ext(_surf_from, 0, 0,
			surface_get_width(_surf_to) / surface_get_width(_surf_from), 
			surface_get_height(_surf_to) / surface_get_height(_surf_from), 0, -1, 1);
		} else draw_surface(_surf_from, 0, 0);
		surface_reset_target();
	shader_reset();
}

function shader_draw_HueOffset_surf_to_game(_surf_from, _x, _y,
_offset = 0.5, _middle = 0.5, _r = 0.875, _g = 1.0, _b = 0.125) {
	shader_set(Shd_HueOffset);
		shader_set_uniform_f(uniform_HueOffset_offset, _offset);
		shader_set_uniform_f(uniform_HueOffset_middle, _middle);
		shader_set_uniform_f(uniform_HueOffset_bright_color, _r, _g, _b);
		draw_surface(_surf_from, _x, _y);
	shader_reset();
}

function shader_draw_HueOffset_spr_to_game(_sprite, _image, _x, _y,
_offset = 0.5, _middle = 0.5, _r = 0.875, _g = 1.0, _b = 0.125) {
	shader_set(Shd_HueOffset);
		shader_set_uniform_f(uniform_HueOffset_offset, _offset);
		shader_set_uniform_f(uniform_HueOffset_middle, _middle);
		shader_set_uniform_f(uniform_HueOffset_bright_color, _r, _g, _b);
		draw_sprite(_sprite, _image, _x, _y);
	shader_reset();
}

#endregion

#region scanline

function shader_draw_Scanline_surf_to_surf(_surf_from, _surf_to, _expand = false, _height, _alpha = 1.0) {
	shader_set(Shd_Scanline);
		shader_set_uniform_f(uniform_Scanline_value, _alpha);
		shader_set_uniform_f(uniform_Scanline_height, _height * pi / 2);
		surface_set_target(_surf_to);
		if(_expand) {
			draw_surface_ext(_surf_from, 0, 0,
			surface_get_width(_surf_to) / surface_get_width(_surf_from), 
			surface_get_height(_surf_to) / surface_get_height(_surf_from), 0, -1, 1);
		} else draw_surface(_surf_from, 0, 0);
		surface_reset_target();
	shader_reset();
}
	
function shader_draw_Scanline_surf_to_game(_surf_from, _x, _y, _height, _alpha = 1.0) {
	shader_set(Shd_Scanline);
		shader_set_uniform_f(uniform_Scanline_value, _alpha);
		shader_set_uniform_f(uniform_Scanline_height, _height * pi / 2);
		draw_surface(_surf_from, _x, _y);
	shader_reset();
}

function shader_draw_Scanline_spr_to_game(_sprite, _image, _x, _y, _height, _alpha = 1.0) {
	shader_set(Shd_Scanline);
		shader_set_uniform_f(uniform_Scanline_value, _alpha);
		shader_set_uniform_f(uniform_Scanline_height, _height * pi / 2);
		draw_sprite(_sprite, _image, _x, _y);
	shader_reset();
}

#endregion

#region LCD3X

function shader_draw_LCD3X_surf_to_surf(_surf_from, _surf_to, _expand = false, _width, _height, _offset = 0.5, _scanline = 0.5) {
	shader_set(Shd_LCD3X);
		shader_set_uniform_f(uniform_LCD3X_offset, _offset);
		shader_set_uniform_f(uniform_LCD3X_scanline, _scanline);
		shader_set_uniform_f(uniform_LCD3X_size, _width / 2, _height * pi / 2);
		surface_set_target(_surf_to);
		if(_expand) {
			draw_surface_ext(_surf_from, 0, 0,
			surface_get_width(_surf_to) / surface_get_width(_surf_from), 
			surface_get_height(_surf_to) / surface_get_height(_surf_from), 0, -1, 1);
		} else draw_surface(_surf_from, 0, 0);
		surface_reset_target();
	shader_reset();
}
	
function shader_draw_LCD3X_surf_to_game(_surf_from, _x, _y, _width, _height, _offset = 0.5, _scanline = 0.5) {
	shader_set(Shd_LCD3X);
		shader_set_uniform_f(uniform_LCD3X_offset, _offset);
		shader_set_uniform_f(uniform_LCD3X_scanline, _scanline);
		shader_set_uniform_f(uniform_LCD3X_size, _width / 2, _height * pi / 2);
		draw_surface(_surf_from, _x, _y);
	shader_reset();
}

function shader_draw_LCD3X_spr_to_game(_sprite, _image, _x, _y, _width, _height, _offset = 0.5, _scanline = 0.5) {
	shader_set(Shd_LCD3X);
		shader_set_uniform_f(uniform_LCD3X_offset, _offset);
		shader_set_uniform_f(uniform_LCD3X_scanline, _scanline);
		shader_set_uniform_f(uniform_LCD3X_size, _width / 2, _height * pi / 2);
		draw_sprite(_sprite, _image, _x, _y);
	shader_reset();
}

#endregion

#region Curve

function shader_draw_Curve_surf_to_surf(_surf_from, _surf_to, _expand = false, _offset = 1.0) {
	shader_set(Shd_Curve);
		shader_set_uniform_f(uniform_Curve_Offset, -_offset);
		surface_set_target(_surf_to);
		if(_expand) {
			draw_surface_ext(_surf_from, 0, 0,
			surface_get_width(_surf_to) / surface_get_width(_surf_from), 
			surface_get_height(_surf_to) / surface_get_height(_surf_from), 0, -1, 1);
		} else draw_surface(_surf_from, 0, 0);
		surface_reset_target();
	shader_reset();
}

function shader_draw_Curve_surf_to_game(_surf_from, _x, _y, _offset = 1.0) {
	shader_set(Shd_Curve);
		shader_set_uniform_f(uniform_Curve_Offset, -_offset);
		draw_surface(_surf_from, _x, _y);
	shader_reset();
}

function shader_draw_Curve_spr_to_game(_sprite, _image, _x, _y, _offset = 1.0) {
	shader_set(Shd_Curve);
		shader_set_uniform_f(uniform_Curve_Offset, -_offset);
		draw_sprite(_sprite, _image, _x, _y);
	shader_reset();
}

#endregion

#region Mosaic

function shader_draw_Mosaic_surf_to_surf(_surf_from, _surf_to, _expand = false, _to_width, _to_height) {
	shader_set(Shd_Mosaic);
		shader_set_uniform_f(uniform_Mosaic_size, _to_width, _to_height);
		surface_set_target(_surf_to);
		if(_expand) {
			draw_surface_ext(_surf_from, 0, 0,
			surface_get_width(_surf_to) / surface_get_width(_surf_from), 
			surface_get_height(_surf_to) / surface_get_height(_surf_from), 0, -1, 1);
		} else draw_surface(_surf_from, 0, 0);
		surface_reset_target();
	shader_reset();
}

function shader_draw_Mosaic_surf_to_game(_surf_from, _x, _y, _to_width, _to_height) {
	shader_set(Shd_Mosaic);
		shader_set_uniform_f(uniform_Mosaic_size, _to_width, _to_height);
		draw_surface(_surf_from, _x, _y);
	shader_reset();
}

function shader_draw_Mosaic_spr_to_game(_sprite, _image, _x, _y, _to_width, _to_height) {
	shader_set(Shd_Mosaic);
		shader_set_uniform_f(uniform_Mosaic_size, _to_width, _to_height);
		draw_sprite(_sprite, _image, _x, _y);
	shader_reset();
}

#endregion

#region LCD

function shader_draw_LCD_surf_to_surf(_surf_from, _surf_to, _expand = false, _width, _height, _gray = 1.0, _scanline = 0.5) {
	shader_set(Shd_LCD);
		shader_set_uniform_f(uniform_LCD_gray, _gray);
		shader_set_uniform_f(uniform_LCD_scanline, _scanline);
		shader_set_uniform_f(uniform_LCD_size, _width * pi, _height * pi);
		surface_set_target(_surf_to);
		if(_expand) {
			draw_surface_ext(_surf_from, 0, 0,
			surface_get_width(_surf_to) / surface_get_width(_surf_from), 
			surface_get_height(_surf_to) / surface_get_height(_surf_from), 0, -1, 1);
		} else draw_surface(_surf_from, 0, 0);
		surface_reset_target();
	shader_reset();
}

function shader_draw_LCD_surf_to_game(_surf_from, _x, _y, _width, _height, _gray = 1.0, _scanline = 0.5) {
	shader_set(Shd_LCD);
		shader_set_uniform_f(uniform_LCD_gray, _gray);
		shader_set_uniform_f(uniform_LCD_scanline, _scanline);
		shader_set_uniform_f(uniform_LCD_size, _width * pi, _height * pi);
		draw_surface(_surf_from, _x, _y);
	shader_reset();
}

#endregion

#region Wave Warp

function shader_draw_WaveWarp(_surf_from, _surf_to, _expand = false,
_width, _height, _value = 1.0, _offset = 0.0) {
	shader_set(Shd_WaveWarp);
		shader_set_uniform_f(uniform_WaveWarp_value, _value / _width * 2.0);
		shader_set_uniform_f(uniform_WaveWarp_offset, _offset * pi * 2);
		shader_set_uniform_f(uniform_WaveWarp_height, _height * pi / 4);
		surface_set_target(_surf_to);
		if(_expand) {
			draw_surface_ext(_surf_from, 0, 0,
			surface_get_width(_surf_to) / surface_get_width(_surf_from), 
			surface_get_height(_surf_to) / surface_get_height(_surf_from), 0, -1, 1);
		} else draw_surface(_surf_from, 0, 0);
		surface_reset_target();
	shader_reset();
}

function shader_draw_WaveWarp_to_game(_surf_from, _x, _y,
_width, _height, _value = 1.0, _offset = 0.0) {
	shader_set(Shd_WaveWarp);
		shader_set_uniform_f(uniform_WaveWarp_value, _value / _width * 2.0);
		shader_set_uniform_f(uniform_WaveWarp_offset, _offset * pi * 2);
		shader_set_uniform_f(uniform_WaveWarp_height, _height * pi / 4);
		draw_surface(_surf_from, _x, _y);
	shader_reset();
}


#endregion

#region Noise Warp

function shader_draw_NoiseWarp(_surf_from, _surf_to, _expand = false,
_width, _height, _strength = 1.0, _xoffset = 0.0, _yoffset = 0.0, _tex_scale = 1.0,
_noise_tex = Texture_noise256, _image = 0) {
	var _tmp_w = sprite_get_width(_noise_tex);
	var _tmp_h = sprite_get_width(_noise_tex);
	var _tex = sprite_get_texture(_noise_tex, _image);
	shader_set(Shd_NoiseWarp);
		gpu_set_tex_repeat(1);
		shader_set_uniform_f(uniform_NoiseWarp_scale, 1.0 / _tex_scale);
		shader_set_uniform_f(uniform_NoiseWarp_strength, _strength);
		shader_set_uniform_f(uniform_NoiseWarp_offset, _xoffset, _yoffset);
		shader_set_uniform_f(uniform_NoiseWarp_size, _width, _height);
		texture_set_stage(uniform_NoiseWarp_noise_tex, _tex);
		shader_set_uniform_f(uniform_NoiseWarp_noise_size, _width / _tmp_w, _height / _tmp_h);
		surface_set_target(_surf_to);
		if(_expand) {
			draw_surface_ext(_surf_from, 0, 0,
			surface_get_width(_surf_to) / surface_get_width(_surf_from), 
			surface_get_height(_surf_to) / surface_get_height(_surf_from), 0, -1, 1);
		} else draw_surface(_surf_from, 0, 0);
		surface_reset_target();
		gpu_set_tex_repeat(0);
	shader_reset();
}

function shader_draw_NoiseWarp_to_game(_surf_from, _x, _y,
_width, _height, _strength = 1.0, _xoffset = 0.0, _yoffset = 0.0, _tex_scale = 1.0,
_noise_tex = Texture_noise256, _image = 0) {
	var _tmp_w = sprite_get_width(_noise_tex);
	var _tmp_h = sprite_get_width(_noise_tex);
	var _tex = sprite_get_texture(_noise_tex, _image);
	shader_set(Shd_NoiseWarp);
		gpu_set_tex_repeat(1);
		shader_set_uniform_f(uniform_NoiseWarp_scale, 1.0 / _tex_scale);
		shader_set_uniform_f(uniform_NoiseWarp_strength, _strength);
		shader_set_uniform_f(uniform_NoiseWarp_offset, _xoffset, _yoffset);
		shader_set_uniform_f(uniform_NoiseWarp_size, _width, _height);
		texture_set_stage(uniform_NoiseWarp_noise_tex, _tex);
		shader_set_uniform_f(uniform_NoiseWarp_noise_size, _width / _tmp_w, _height / _tmp_h);
		draw_surface(_surf_from, _x, _y);
		gpu_set_tex_repeat(0);
	shader_reset();
}


#endregion

#region Box Blur

function shader_draw_BoxBlur(_surf_from, _surf_to, _width, _height, _radius) {
	shader_set(Shd_BoxBlur);
		shader_set_uniform_f(uniform_BoxBlur_radius, _radius / _width, _radius / _height);
		surface_set_target(_surf_to);
			draw_surface(_surf_from, 0, 0);
		surface_reset_target();
	shader_reset();
}

#endregion

#region Gaussian Blur

function shader_draw_GaussianBlur(_surf_from, _surf_to, _surf_tmp, _width, _height, _radius) {
	shader_set(Shd_GaussianBlurHorizontal);
		shader_set_uniform_f(uniform_GaussianBlurHorizontal_radius, _radius / _width);
		surface_set_target(_surf_tmp);
			draw_surface(_surf_from, 0, 0);
		surface_reset_target();
	shader_reset();
	shader_set(Shd_GaussianBlurVertical);
		shader_set_uniform_f(uniform_GaussianBlurVertical_radius, _radius / _height);
		surface_set_target(_surf_to);
			draw_surface(_surf_tmp, 0, 0);
		surface_reset_target();	
	shader_reset();
}

#endregion

#region Dual Blur

function shader_draw_DualBlur(_surf_from, _surf_to, _surf_tmp1, _surf_tmp2,
_width, _height, _radius = 1.0) {
	shader_set(Shd_BoxBlur);
		shader_set_uniform_f(uniform_BoxBlur_radius, _radius / _width * 4.0, _radius / _height * 4.0);
		surface_set_target(_surf_tmp1);
			draw_surface_ext(_surf_from, 0, 0, 0.25, 0.25, 0, -1, 1);
		surface_reset_target();
		shader_set_uniform_f(uniform_BoxBlur_radius, _radius / _width * 2.0, _radius / _height * 2.0);
		surface_set_target(_surf_tmp2);
			draw_surface_ext(_surf_tmp1, 0, 0, 2, 2, 0, -1, 1);
		surface_reset_target();
		shader_set_uniform_f(uniform_BoxBlur_radius, _radius / _width * 1.0, _radius / _height * 1.0);
		surface_set_target(_surf_to);
			draw_surface_ext(_surf_tmp2, 0, 0, 2, 2, 0, -1, 1);
		surface_reset_target();	
	shader_reset();
	
	
	
/*	shader_set(Shd_DualBlur);
	
	shader_set_uniform_f(uniform_DualBlur_size,
	_radius * 4.0 / _width, _radius * 4.0 / _height);
	
	surface_set_target(_surf2);
	draw_clear_alpha(0, 0);
	draw_surface_ext(_surf0, 0, 0, 0.25, 0.25, 0, -1, 1);
	surface_reset_target();
	
	shader_set_uniform_f(uniform_DualBlur_size,
	_radius * 2.0 / _width, _radius * 2.0 / _height);
	
	surface_set_target(_surf1);
	draw_clear_alpha(0, 0);
	draw_surface_ext(_surf2, 0, 0, 2, 2, 0, -1, 1);
	surface_reset_target();
	
	shader_set_uniform_f(uniform_DualBlur_size,
	_radius * 1.0 / _width, _radius * 1.0 / _height);
	
	surface_set_target(_surf0);
	draw_clear_alpha(0, 0);
	draw_surface_ext(_surf1, 0, 0, 2, 2, 0, -1, 1);
	surface_reset_target();
	
	shader_reset();*/
}

#endregion

#region Bloom

function shader_draw_Bloom(_surf_from, _surf_to, _value, _alpha) {
	
	shader_set(Shd_Bloom);
	shader_set_uniform_f(uniform_Bloom_value, _value);
	shader_set_uniform_f(uniform_Bloom_alpha, _alpha);
	
	surface_set_target(_surf_to);
	draw_clear_alpha(0, 1);
	draw_surface(_surf_from, 0, 0);
	surface_reset_target();
	
	shader_reset();
	
}

#endregion


