/// @description Insert description here
// You can write your code in this editor

_draw_background();
for(var i = 0; i < ds_list_size(_widget_list); i ++) {
	_widget_list[|i][0].__draw(id, ui_alpha);
}
_draw_foreground();







