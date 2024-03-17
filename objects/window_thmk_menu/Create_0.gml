/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

menu_thmk_start = function() {
	__THMK_GROUP = 0;
	__THMK_STAGE = 0;
	__THMK_TIMER = 0;
	__THMK_STATE = THMK_STATE.PRE;
	__THMK_HERO_HP = 3;
	__THMK_HERO_MP = 3;
	room_goto(Room_thmk_game);
}

menu_thmk_ex_start = function() {
	__THMK_GROUP = 1;
	__THMK_STAGE = 0;
	__THMK_TIMER = 0;
	__THMK_STATE = THMK_STATE.PRE;
	__THMK_HERO_HP = 3;
	__THMK_HERO_MP = 3;
	room_goto(Room_thmk_game);
}

menu_thmk_setting = function() {
	open(window_thmk_setting);
}

menu_thmk_exit = function() {
	open(window_thmk_exit);
}

var tmp = array_create(4);

tmp[0] = mwidget_create_button(widget_thmk_menu_button, 
640, 400, 0, 100 * 1, word("menu", "start"), fa_center, fa_middle, 0, FONT.SYMIDDLE,
[SprUI_thmk_widget_button, 0, SprUI_thmk_widget_button, 1]);
connect(tmp[0], "pressed", id, "menu_thmk_start");

tmp[1] = mwidget_create_button(widget_thmk_menu_button, 
640, 400, 0, 100 * 2, word("menu", "ex_start"), fa_center, fa_middle, 0, FONT.SYMIDDLE,
[SprUI_thmk_widget_button, 0, SprUI_thmk_widget_button, 1]);
connect(tmp[1], "pressed", id, "menu_thmk_ex_start");

tmp[2] = mwidget_create_button(widget_thmk_menu_button, 
640, 400, 0, 100 * 3, word("menu", "setting"), fa_center, fa_middle, 0, FONT.SYMIDDLE,
[SprUI_thmk_widget_button, 0, SprUI_thmk_widget_button, 1]);
connect(tmp[2], "pressed", id, "menu_thmk_setting");

tmp[3] = mwidget_create_button(widget_thmk_menu_button, 
640, 400, 0, 100 * 4, word("menu", "exit"), fa_center, fa_middle, 0, FONT.SYMIDDLE,
[SprUI_thmk_widget_button, 0, SprUI_thmk_widget_button, 1]);
connect(tmp[3], "pressed", id, "menu_thmk_exit");

for(var i = 0; i < 4; i ++) {
	tmp[i].setSize(160, 48, 160, 48);
}

mwindow_add_widget_array_vertical(tmp, 1);

function _draw_background() {
	draw_set();
//	texft_on;
//	draw_sprite_stretched(Spr_thmk_default_image, 0, 0, 0, 1280, 960);
//	texft_off;
	draw_rectangle(-1, -1, VGUI_WIDTH + 1, VGUI_HEIGHT + 1, 0);
	draw_set($ff8000);
	draw_rectangle(6, 6, VGUI_WIDTH - 7, VGUI_HEIGHT - 7, 1);
	draw_rectangle(7, 7, VGUI_WIDTH - 8, VGUI_HEIGHT - 8, 1);
	draw_set();
	texft_on;
	draw_sprite_ext(Spr_thmk_default_game_title, 0, 640, 480 - 240,
	1.5, 1.5, 0, -1, 1);
	draw_sprite_ext(SprUI_thmk_help, 0, 60, 640,
	0.5, 0.5, 0, -1, 1);
	texft_off;
	text_set_font(FONT.SYSMALL);
	draw_set($ff8000, 1);
	text_set(fa_left, fa_bottom);
	draw_text(16, 960 - 20, "(C)2024 Meboxen Studio - THMK RUNNER V0.1.1");
	draw_set();
	draw_sprite_ext(check_here, 0, VGUI_WIDTH - 32, VGUI_HEIGHT, 4, 4, 0, -1, 1);
}
