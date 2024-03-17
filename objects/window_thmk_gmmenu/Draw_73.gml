/// @description Insert description here
// You can write your code in this editor


INGAME_SURFACE = surface_check(INGAME_SURFACE, INGAME_WIDTH, INGAME_HEIGHT);

surface_set_target(INGAME_SURFACE);

_draw_background();
for(var i = 0; i < ds_list_size(_widget_list); i ++) {
	_widget_list[|i][0].__draw(id, ui_alpha);
}
_draw_foreground();

surface_reset_target();













