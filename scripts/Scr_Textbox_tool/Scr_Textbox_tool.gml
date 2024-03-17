function textline_create(_x, _y, _w, _h, _text, _text_bck, _font) {
	return textbox_create(400, 96, 480, 38, "", "Enter text", 120, true, false, font, function(s) {
	show_message(s);
});
}

