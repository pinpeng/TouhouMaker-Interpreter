/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();


var tmp_group_list = setting_get_group_list();

for(var i = 0; i < array_length(tmp_group_list); i ++) {
	if(!setting_group_is_visible(tmp_group_list[i])) {
		array_delete(tmp_group_list, i, 1); i --;
	}
}

var _group_size = array_length(tmp_group_list);

var tmp_arr_page_button = array_create(_group_size);
var tmp_arr_page = array_create(_group_size);

for(var i = 0; i < _group_size; i ++) {
	tmp_arr_page_button[i] = mwidget_create_button(MWidget_pageButton, 0.5, 0.5,
	-256, -240 + i * 64, word("__msetting", tmp_group_list[i]), , , $000000);
	tmp_arr_page_button[i].press_id = i;
	tmp_arr_page[i] = mwidget_create_page(, 0, 0, 0, 0, i);
}

for(var i = 0; i < _group_size; i ++) {
	for(var j = 0; j < _group_size; j ++) {
		connect(tmp_arr_page_button[i], "pressed", tmp_arr_page[j], "setPage");
	}
}

for(var i = 0; i < _group_size; i ++) {
	
	var tmp_group_name = tmp_group_list[i];
	
	var tmp_item_list = setting_get_item_list(tmp_group_name);
	
	for(var j = 0; j < array_length(tmp_item_list); j ++) {
		if(!setting_item_is_visible(tmp_group_name, tmp_item_list[j])) {
			array_delete(tmp_item_list, j, 1); j --;
		}
	}
	var _list_size = array_length(tmp_item_list);
	
	var tmp_arr_item = array_create(_list_size);
	
	for(var j = 0; j < _list_size; j ++) {
		tmp_arr_item[j] = 
		mwidget_create_settingItem(, 0.5, 0.5, 0, -240 + 64 * j, tmp_group_name, tmp_item_list[j], $000000);
	}
	
	with(tmp_arr_page[i]) mwindow_add_widget_array_vertical(tmp_arr_item, 1);
	tmp_arr_page[i].setPage(0);
	addWidget(tmp_arr_page[i]);
}

mwindow_add_widget_array(tmp_arr_page_button);


var tmp;

tmp = mwidget_create_button(, 0.5, 0.5, 32, 256, "Accept",
fa_center, fa_middle, $000000);
connect(tmp, "pressed", id, "accept");
addWidget(tmp);


tmp = mwidget_create_button(, 0.5, 0.5, 160, 256, "Cancel",
fa_center, fa_middle, $000000);
connect(tmp, "pressed", id, "cancel");
addWidget(tmp);

tmp = mwidget_create_label(, 0.5, 0.5, -300, -294, "<scale,2>MWindow_setting 测试窗口</>",
fa_left, fa_middle, $000000);
addWidget(tmp);


accept = function() {
	for(var i = 0; i < ds_list_size(_widget_list) - 3; i ++) {
		var _page = _widget_list[|i][0];
		for(var j = 0; j < ds_list_size(_page._widget_list); j ++) {
			var _item = _page._widget_list[|j][0];
			setting_set(_item.setting_group, _item.setting_item, _item.item.val);
		}
	}
	__mSetting_apply();
	__mSetting_save();
	close();
}

cancel = function() {
	close();
}

function _draw_background() {
	draw_black_gui(0.5 * ui_alpha);
	draw_sprite_ext(SprUI_mwindow_window_setting, 0, UI_WIDTH / 2, UI_HEIGHT / 2,
	UI_SCALE, UI_SCALE, 0, -1, ui_alpha);
}