// special thank to scribble team

globalvar 
__MBN_TEXT_FORMAT_NORMAL,
__MBN_TEXT_FORMAT_STEP,
__MBN_TEXT_FORMAT_WAVE;

enum TEXT_FORMAT {
	NORMAL,
	STEP,
	WAVE
}

enum FONT {
	WH9PX,
	WH12PX,
	SY24PX,
	SY36PX,
	SYSMALL,
	SYMIDDLE,
	SYLARGE
}


// [] -> <> 
// <label>text</lable>
// see __scribble_config_behaviours

/*

Formatting tag						Behaviour

[/page]								Manual page break
[<name of font>]					Set font
[/font] [/f]						Reset font
[nbsp]								Inserts a non-breaking space. Actual non-breaking space characters are natively supported but [nbsp] may be more convenient in some situations
[zwsp]								Inserts a zero-width space. Actual zero-width space characters are natively supported but [zwsp] may be more convenient in some situations
[region,<name>]						Creates a region of text that can be detected later. Useful for tooltips and hyperlinks
[/region]							Ends a region

Colour and Alpha	
[<name of colour>]					Set colour. Colour names are defined in __scribble_config_colours()
[#<hex code>]						Set colour via a hexcode (format controlled by SCRIBBLE_BGR_COLOR_HEX_CODES)
[d#<decimal>]						Set colour via a decimal integer, using GameMaker’s BGR format
[/color] [/c]						Reset colour
[alpha,<value>]						Sets the alpha blending value for the following text. A value from 0 to 1 should be used, with 0 being invisible and 1 being fully visible
[/alpha]							Resets the alpha value to 1, fully visible

Sprites, Surfaces, Sounds	

[<name of sprite>]					Insert an animated sprite starting on image 0 and animating using SCRIBBLE_DEFAULT_SPRITE_SPEED
[<name of sprite>,<image>]			Insert a static sprite using the specified image index
[<name of sprite>,<image>,<speed>]	Insert animated sprite using the specified image index and animation speed
[surface,<surfaceID>]				Insert surface with the associated index
[<name of sound>]					Insert sound playback event. Sounds will only be played when using Scribble’s typewriter feature

Alignment	

[fa_left]							Horizontally align this line of text to the left of the .draw() coordinate
[fa_center] [fa_centre]				Horizontally align this line of text centrally at the .draw() coordinate
[fa_right]							Horizontally align this line of text to the right of the .draw() coordinate
[fa_top]							Vertically align all text to the top of the .draw() coordinate
[fa_middle]							Vertically align all text to the middle of the .draw() coordinate
[fa_bottom]							Vertically align all text to the bottom of the .draw() coordinate
[pin_left]							Horizontally align this line of text to the left of the entire textbox
[pin_center] [pin_centre]			Horizontally align this line of text centrally versus the entire textbox
[pin_right]							Horizontally align this line of text to the right of the entire textbox
[l2r]								Provides a hint at the direction of text. Useful at the start of strings or adjacent to punctuation to fix minor issues in text layout
[r2l]								Provides a hint at the direction of text. Useful at the start of strings or adjacent to punctuation to fix minor issues in text layout

Typewriter Control					The following commands only affect the typewriter when text is fading in'

[<event name>,<arg0>,<arg1>...]		Trigger an event with the specified arguments (see scribble_typist_add_event()
[delay,<milliseconds>]				Delay the typewriter by the given number of milliseconds. If no time value is given then the delay with defaults to SCRIBBLE_DEFAULT_DELAY_DURATION
[pause]								Pause the typewriter. The typewriter can be unpaused by calling .unpause()
[sync,<seconds>]					Timecode to wait for in sound playback. See .sync_to_sound()
[speed,<factor>]					Sets the speed of the typewriter by multiplying the value set by .in() by <factor>. A value of 2.0 will be twice as fast etc.
[/speed]							Resets the speed of the typewriter to the value set by .in()
[typistSound,...]					Sets the sound of the typewriter by replicating the behaviour of the .sound() typist
[typistSoundPerChar,...]			Sets the sound of the typewriter by replicating the behaviour of the .sound_per_char()
Transformation	
[scale,<factor>]					Set text (and in-line sprite) scale
[scaleStack,<factor>]				Multiply the scale of text (and in-line sprite) by factor
[/scale] [/s]						Reset scale to x1
[slant] [/slant]					Set/unset italic emulation. The size of the x offset is controlled by SCRIBBLE_SLANT_AMOUNT
Effects	
[wave] [/wave]						Set/unset text to wave up and down. Modified by scribble_anim_wave()
[shake] [/shake]					Set/unset text to shake. Modified by scribble_anim_shake()
[wobble] [/wobble]					Set/unset text to wobble by rotating back and forth. Modified by scribble_anim_wobble()
[pulse] [/pulse]					Set/unset text to shrink and grow rhythmically. Modified by scribble_anim_pulse()
[wheel] [/wheel]					Set/unset text to circulate around their origin. Modified by scribble_anim_wheel()
[jitter] [/jitter]					Set/unset text to scale erratically. Modified by scribble_anim_jitter()
[blink] [/blink]					Set/unset text to flash on and off. Modified by scribble_anim_blink()
[rainbow] [/rainbow]				Set/unset rainbow colour cycling. Modified by scribble_anim_rainbow()
[cycle,<hue1>,<hue2>,<hue3>,<hue4>]	Set a custom HSV colour cycle using the specified hues. Up to four hues may be specified. Saturation and value are controlled using scribble_anim_cycle()
[/cycle]							Unset colour cycling>

*/

function text_set_font(_font) {
	switch(_font) {
		case FONT.WH9PX:		draw_set_font(Font_WenHei9px); break;
		case FONT.WH12PX:		draw_set_font(Font_WenHei12px); break;
		case FONT.SY24PX:		draw_set_font(Font_WenHei24px); break;
		case FONT.SY36PX:		draw_set_font(Font_WenHei36px); break;
		case FONT.SYSMALL:		draw_set_font(Font_small); break;
		case FONT.SYMIDDLE:		draw_set_font(Font_middle); break;
		case FONT.SYLARGE:		draw_set_font(Font_large); break;
		default: draw_set_font(Font_WenHei9px); break;
	}
}

function __mText_init() {
	scribble_font_set_default("Font_default");
	scribble_font_force_bilinear_filtering("Font_default", false);
	/*scribble_font_force_bilinear_filtering("Font_WenHei12px", false);
	scribble_font_force_bilinear_filtering("Font_WenHei24px", true);
	scribble_font_force_bilinear_filtering("Font_WenHei36px", true);*/
	
	__MBN_TEXT_FORMAT_NORMAL = scribble_typist();
	
	__MBN_TEXT_FORMAT_STEP = scribble_typist();
	__MBN_TEXT_FORMAT_STEP.in(0.1, 60);
	__MBN_TEXT_FORMAT_STEP.ease(SCRIBBLE_EASE.LINEAR, 0, 0, 1, 1, 0, 0.1)
	
	__MBN_TEXT_FORMAT_WAVE = scribble_typist();
	__MBN_TEXT_FORMAT_WAVE.in(0.1, 60);
	__MBN_TEXT_FORMAT_WAVE.ease(SCRIBBLE_EASE.ELASTIC, 0, -25, 1, 1, 0, 0.1)
	
}

function text_draw(_x, _y, _string, _charNum = undefined, _format = TEXT_FORMAT.NORMAL) {
	
    var _font = draw_get_font();
    if(is_numeric(_font) && (_font >= 0) && font_exists(_font)) {
        _font = font_get_name(_font);
        if(!scribble_font_exists(_font)) __scribble_error("Font \"", _font, "\" does not exist in Scribble\n(Fonts added with font_add() are not supported)");
    } else return;
	
    var _element = scribble(_string)
	.align(draw_get_halign(), draw_get_valign())
	.starting_format(_font, c_white)
	.blend(draw_get_color(), draw_get_alpha());
	if(_charNum != undefined) _element.reveal(_charNum);
	
	switch(_format) {
		case TEXT_FORMAT.STEP:
	    _element.draw(_x, _y, __MBN_TEXT_FORMAT_STEP); break;
		
		case TEXT_FORMAT.WAVE:
	    _element.draw(_x, _y, __MBN_TEXT_FORMAT_WAVE); break;
		
		default:
	    _element.draw(_x, _y); break;
	}
	
	return _element;
}

function text_draw_scale(_x, _y, _string, _xscale, _yscale,
_charNum = undefined, _format = TEXT_FORMAT.NORMAL) {
	
    var _font = draw_get_font();
    if(is_numeric(_font) && (_font >= 0) && font_exists(_font)) {
        _font = font_get_name(_font);
        if(!scribble_font_exists(_font)) __scribble_error("Font \"", _font, "\" does not exist in Scribble\n(Fonts added with font_add() are not supported)");
    } else return;
	
    var _element = scribble(_string)
	.align(draw_get_halign(), draw_get_valign())
	.starting_format(_font, c_white)
	.blend(draw_get_color(), draw_get_alpha())
	.transform(_xscale, _yscale);
	if(_charNum != undefined) _element.reveal(_charNum);
	
	switch(_format) {
		case TEXT_FORMAT.STEP:
	    _element.draw(_x, _y, __MBN_TEXT_FORMAT_STEP); break;
		
		case TEXT_FORMAT.WAVE:
	    _element.draw(_x, _y, __MBN_TEXT_FORMAT_WAVE); break;
		
		default:
	    _element.draw(_x, _y); break;
	}
	
	return _element;
}

function text_length(_string) {
	return scribble(_string).get_glyph_count();
}

