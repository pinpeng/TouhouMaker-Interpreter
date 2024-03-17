
if (keyboard_check_pressed(vk_f1)) {
	var text = textbox_return(textbox_1);
	show_message(text);
}

if (keyboard_check_pressed(vk_f2)) {
	var text = textbox_return(textbox_2);
	show_message(text);
}

if (keyboard_check_pressed(vk_f4)) {
	textbox_set_font(textbox_1, font, c_blue, 30, 5);
	textbox_set_font(textbox_2, font, c_red, 32, 3);
}

if (keyboard_check_pressed(vk_f7)) {
	textbox_set_position(textbox_2, 300, 300, false);
}

if (keyboard_check_pressed(vk_f8)) {
	textbox_set_position(textbox_2, 400, 230, false);
}

var cx = keyboard_check(vk_f10) - keyboard_check(vk_f9),
	cy = keyboard_check(vk_f12) - keyboard_check(vk_f11);
if (cx != 0 || cy != 0) {
	textbox_set_position(textbox_2, cx, cy, true);
}