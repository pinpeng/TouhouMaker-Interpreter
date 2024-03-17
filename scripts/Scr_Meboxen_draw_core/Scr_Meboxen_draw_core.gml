// Draw function for Meboxen Library

globalvar VFORM_PT, VFORM_PCT, VFORM_PC;

globalvar
uniform_SpriteColor_color,
uniform_SpriteColor_mix;

globalvar
uniform_Gray_value;

globalvar
uniform_HueOffset_offset,
uniform_HueOffset_middle,
uniform_HueOffset_bright_color;
	
globalvar
uniform_Scanline_value,
uniform_Scanline_height;

globalvar
uniform_LCD3X_offset,
uniform_LCD3X_scanline,
uniform_LCD3X_size;

globalvar
uniform_Curve_Offset;

globalvar
uniform_Mosaic_size;
	
globalvar
uniform_LCD_gray,
uniform_LCD_scanline,
uniform_LCD_size;

globalvar
uniform_WaveWarp_value,
uniform_WaveWarp_offset,
uniform_WaveWarp_height;

globalvar
uniform_NoiseWarp_scale,
uniform_NoiseWarp_strength,
uniform_NoiseWarp_offset,
uniform_NoiseWarp_size,
uniform_NoiseWarp_noise_tex,
uniform_NoiseWarp_noise_size;

globalvar
uniform_BoxBlur_radius;

globalvar
uniform_GaussianBlurHorizontal_radius,
uniform_GaussianBlurVertical_radius;

globalvar
uniform_DualBlur_size;

globalvar
uniform_Bloom_value,
uniform_Bloom_alpha;

function __mDraw_init() {
	
	vertex_format_begin();
	vertex_format_add_position();
	vertex_format_add_texcoord();
	VFORM_PT = vertex_format_end();
	
	vertex_format_begin();
	vertex_format_add_position();
	vertex_format_add_color();
	vertex_format_add_texcoord();
	VFORM_PCT = vertex_format_end();
	
	vertex_format_begin();
	vertex_format_add_position();
	vertex_format_add_color();
	VFORM_PC = vertex_format_end();

	uniform_SpriteColor_color = // vec4
	shader_get_uniform(Shd_SpriteColor, "uv4Color");
	uniform_SpriteColor_mix = // 0.0 - 1.0
	shader_get_uniform(Shd_SpriteColor, "ufMix");

	uniform_Gray_value = // 0.0 - 1.0
	shader_get_uniform(Shd_Gray, "ufGrayValue");
	
	uniform_HueOffset_offset = // 0.0 - 0.5
	shader_get_uniform(Shd_HueOffset, "ufOffset");
	uniform_HueOffset_middle = // 0.2 - 0.8
	shader_get_uniform(Shd_HueOffset, "ufMiddle");
	uniform_HueOffset_bright_color = // vec3
	shader_get_uniform(Shd_HueOffset, "uv3BrightColor");
	
	
	uniform_Scanline_value = // 0.0 - 1.0
	shader_get_uniform(Shd_Scanline, "ufScanlineValue");
	uniform_Scanline_height = // * pi / 2
	shader_get_uniform(Shd_Scanline, "ufHeight");
	
	
	uniform_LCD3X_offset = // 0.0 - 1.0
	shader_get_uniform(Shd_LCD3X, "ufOffset");
	uniform_LCD3X_scanline = // 0.0 - 1.0
	shader_get_uniform(Shd_LCD3X, "ufScanlineValue");
	uniform_LCD3X_size = // vec2
	shader_get_uniform(Shd_LCD3X, "uv2Size");
	
	uniform_Curve_Offset = // -1.0 - 1.0
	shader_get_uniform(Shd_Curve, "ufOffset");
	
	uniform_Mosaic_size = // vec2
	shader_get_uniform(Shd_Mosaic, "uv2Size");
	
	uniform_LCD_gray = // 0.0 - 1.0
	shader_get_uniform(Shd_LCD, "ufGrayValue");
	uniform_LCD_scanline = // 0.0 - 1.0
	shader_get_uniform(Shd_LCD, "ufScanlineValue");
	uniform_LCD_size = // vec2
	shader_get_uniform(Shd_LCD, "uv2Size");
	
	uniform_WaveWarp_value = // 0.0 - 1.0
	shader_get_uniform(Shd_WaveWarp, "ufValue");
	uniform_WaveWarp_offset = // * pi / 2
	shader_get_uniform(Shd_WaveWarp, "ufOffset");
	uniform_WaveWarp_height = // * pi / 2
	shader_get_uniform(Shd_WaveWarp, "ufHeight");
	
	uniform_NoiseWarp_scale = // float
	shader_get_uniform(Shd_NoiseWarp, "ufScale");
	uniform_NoiseWarp_strength = // float
	shader_get_uniform(Shd_NoiseWarp, "ufStrength");
	uniform_NoiseWarp_offset = // vec2
	shader_get_uniform(Shd_NoiseWarp, "uv2Offset");
	uniform_NoiseWarp_size = // vec2 * 2
	shader_get_uniform(Shd_NoiseWarp, "uv2Size");
	uniform_NoiseWarp_noise_size = // noise texture size
	shader_get_uniform(Shd_NoiseWarp, "uv2NoiseSize");
	uniform_NoiseWarp_noise_tex = // noise texture
	shader_get_sampler_index(Shd_NoiseWarp, "usNoiseTex");
	
	uniform_BoxBlur_radius =
	shader_get_uniform(Shd_BoxBlur, "uv2BlurRadius");
	
	uniform_GaussianBlurHorizontal_radius = // 0.0 - 4.0
	shader_get_uniform(Shd_GaussianBlurHorizontal, "ufBlurRadius");
	uniform_GaussianBlurVertical_radius = // 0.0 - 4.0
	shader_get_uniform(Shd_GaussianBlurVertical, "ufBlurRadius");
	
	uniform_DualBlur_size =
	shader_get_uniform(Shd_DualBlur, "uv2Size");
	
	uniform_Bloom_value =
	shader_get_uniform(Shd_Bloom, "ufMinValue");
	uniform_Bloom_alpha =
	shader_get_uniform(Shd_Bloom, "ufAlpha");
	

}