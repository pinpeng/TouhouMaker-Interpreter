/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();


var _arr = array_create(5);

_arr[0] = 
mwidget_create_settingItem(widget_thmk_setting_item, 640, 480, -16, -224 + 96 * 0,
"global", "language", $000000, FONT.SYMIDDLE);

_arr[1] = 
mwidget_create_settingItem(widget_thmk_setting_item, 640, 480, -16, -224 + 96 * 1,
"video", "full_screen", $000000, FONT.SYMIDDLE);

_arr[2] = 
mwidget_create_settingItem(widget_thmk_setting_item, 640, 480, -16, -224 + 96 * 2,
"video", "bloom", $000000, FONT.SYMIDDLE);

_arr[3] = 
mwidget_create_settingItem(widget_thmk_setting_item, 640, 480, -16, -224 + 96 * 3,
"video", "effect", $000000, FONT.SYMIDDLE);

_arr[4] = 
mwidget_create_settingItem(widget_thmk_setting_item, 640, 480, -16, -224 + 96 * 4,
"audio", "volume_main", $000000, FONT.SYMIDDLE);

for(var i = 0; i < 5; i ++) {
	_arr[i].setSize(300, 28, 300, 28);
}

addWidget(_arr[0], [-1, 1, -1, -1]);
addWidget(_arr[1], [0, 2, -1, -1]);
addWidget(_arr[2], [1, 3, -1, -1]);
addWidget(_arr[3], [2, 4, -1, -1]);
addWidget(_arr[4], [3, 6, -1, -1]);

var tmp;

tmp = mwidget_create_button(widget_thmk_menu_button, 640, 480, -160, 256, word("exit", "accept"),
fa_center, fa_middle, $000000, FONT.SYMIDDLE,
[SprUI_thmk_widget_button, 0, SprUI_thmk_widget_button, 1]);
connect(tmp, "pressed", id, "accept");
tmp.setSize(160, 48, 160, 48);
addWidget(tmp, [4, -1, 6, 6]);


tmp = mwidget_create_button(widget_thmk_menu_button, 640, 480, 160, 256, word("exit", "cancel"),
fa_center, fa_middle, $000000, FONT.SYMIDDLE,
[SprUI_thmk_widget_button, 0, SprUI_thmk_widget_button, 1]);
connect(tmp, "pressed", id, "cancel");
tmp.setSize(160, 48, 160, 48);
addWidget(tmp, [4, -1, 5, 5]);

accept = function() {
	for(var i = 0; i < ds_list_size(_widget_list) - 2; i ++) {
		var _item = _widget_list[|i][0];
		setting_set(_item.setting_group, _item.setting_item, _item.item.val);
	}
	__mSetting_apply();
	__mSetting_save();
	close();
}

cancel = function() {
	close();
}

function _draw_background() {
	draw_set_alpha(0.5 * ui_alpha);
	draw_rectangle_color(-1, -1, VGUI_WIDTH + 1, VGUI_HEIGHT + 1,
	$000000, $000000, $000000, $000000, 0);
	draw_set_alpha(1);
	texft_on;
	draw_sprite_stretched_ext(SprUI_thmk_window_setting, 0, 640 - 360, 480 - 320, 720, 640, -1, ui_alpha);
	texft_off;
}