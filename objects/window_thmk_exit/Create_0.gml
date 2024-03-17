/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

var tmp = [0, 0];

tmp[0] = mwidget_create_button(widget_thmk_menu_button, 640, 480, -160, 52, word("exit", "accept"),
fa_center, fa_middle, $000000, FONT.SYMIDDLE,
[SprUI_thmk_widget_button, 0, SprUI_thmk_widget_button, 1]);
connect(tmp[0], "pressed", id, "wait");

tmp[1] = mwidget_create_button(widget_thmk_menu_button, 640, 480, 160, 52, word("exit", "cancel"),
fa_center, fa_middle, $000000, FONT.SYMIDDLE,
[SprUI_thmk_widget_button, 0, SprUI_thmk_widget_button, 1]);
connect(tmp[1], "pressed", id, "close");

for(var i = 0; i < 2; i ++) {
	tmp[i].setSize(160, 48, 160, 48);
}

mwindow_add_widget_array_horizon(tmp, 1);

function _step_waiting() {
	ui_alpha = Lerp(ui_alpha, 0, 0.16)
	if(state == MWINDOW_STATE.WAITTING && ui_alpha <= 0) {
		game_end();
	}
	return 1;
}

function _draw_foreground() {
	if(state == MWINDOW_STATE.WAITTING) {
		draw_black_gui(1 - ui_alpha);
	}
}

function _draw_background() {
	draw_set_alpha(0.5 * ui_alpha);
	draw_rectangle_color(-1, -1, VGUI_WIDTH + 1, VGUI_HEIGHT + 1,
	$000000, $000000, $000000, $000000, 0);
	draw_set_alpha(1);
	texft_on;
	draw_sprite_stretched_ext(SprUI_thmk_window_ask, 0, 640 - 360, 480 - 128, 720, 256, -1, ui_alpha);
	texft_off;
	text_set_font(FONT.SYMIDDLE);
	text_set(fa_center, fa_middle);
	draw_set($1f1f1f, ui_alpha);
	draw_text(640, 480 - 42, word("exit", "text"));
	draw_set();
}