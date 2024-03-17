/// @description Insert description here
// You can write your code in this editor

draw_background();
for(var i = 0; i < ds_list_size(_widget_list); i ++) {
	_widget_list[|i][0].__draw(id, image_alpha);
}
draw_foreground();
