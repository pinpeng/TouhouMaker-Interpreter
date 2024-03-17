
globalvar
Font_small,
Font_middle,
Font_large;

function __mFont_init() {

	var tmp = max(3, floor((UI_WIDTH / 640 + UI_HEIGHT / 720)));
	Font_small	= font_add("SourceHanSans.otf", tmp * 4, 0, 0, 32, 65535);
	Font_middle	= font_add("SourceHanSans.otf", tmp * 8, 0, 0, 32, 65535);
	Font_large	= font_add("SourceHanSans.otf", tmp * 12, 0, 0, 32, 65535);
}

function __mFont_update() {
	var tmp = max(3, floor((UI_WIDTH / 640 + UI_HEIGHT / 720)));
	if(font_get_size(Font_small) != tmp * 4) {
		font_delete(Font_small);
		font_delete(Font_middle);
		font_delete(Font_large);
		Font_small	= font_add("SourceHanSans.otf", tmp * 4, 0, 0, 32, 65535);
		Font_middle	= font_add("SourceHanSans.otf", tmp * 8, 0, 0, 32, 65535);
		Font_large	= font_add("SourceHanSans.otf", tmp * 12, 0, 0, 32, 65535);
	}
}


