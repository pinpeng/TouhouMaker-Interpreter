/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

menu_thmk_continue = function() {
	Cmd_thmk_ingame.state = THMK_STATE.PLAYING;
	close();
}

menu_thmk_restart = function() {
	Cmd_thmk_ingame.state = THMK_STATE.PRE;
	__THMK_TIMER = 0;
	close();
}

menu_thmk_menu = function() {
	if(__THMK_DEBUG) game_end();
	else room_goto(Room_thmk_menu);
}


var tmp = array_create(3);

tmp[0] = mwidget_create_button(widget_thmk_menu_button, 
640, 300, 0, 100 * 1, "CONTINUE", fa_center, fa_middle, 0, FONT.SYMIDDLE);
connect(tmp[0], "pressed", id, "menu_thmk_continue");

tmp[1] = mwidget_create_button(widget_thmk_menu_button, 
640, 300, 0, 100 * 2, "RESTART", fa_center, fa_middle, 0, FONT.SYMIDDLE);
connect(tmp[1], "pressed", id, "menu_thmk_restart");

tmp[2] = mwidget_create_button(widget_thmk_menu_button, 
640, 300, 0, 100 * 3, "MENU", fa_center, fa_middle, 0, FONT.SYMIDDLE);
connect(tmp[2], "pressed", id, "menu_thmk_menu");


for(var i = 0; i < 3; i ++) {
	tmp[i].setSize(256, 48, 256, 48);
}

mwindow_add_widget_array_vertical(tmp, 1);
