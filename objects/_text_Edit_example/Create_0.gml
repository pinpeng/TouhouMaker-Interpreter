font = font_add("SourceHanSansCN-Regular.otf", 14, false, false, 0, 65535);

// Single-line.
textbox_1 = textbox_create(400, 96, 480, 38, "", "Enter text", 120, true, false, font, function(s) {
	show_message(s);
});

textbox_set_font(textbox_1, font, c_black, 22, 1.5);

// Multi-line.
textbox_2 = textbox_create(400, 230, 480, 200, "", "Enter text", 4000, true, true, font, function(s) {
	show_message(s);
});

textbox_set_font(textbox_2, font, c_black, 22, 1.5);