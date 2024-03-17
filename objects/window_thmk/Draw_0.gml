/// @description Insert description here
// You can write your code in this editor

VGUI_SURFACE = surface_check(VGUI_SURFACE, VGUI_WIDTH, VGUI_HEIGHT);

bm_set;
surface_set_target(VGUI_SURFACE);

_draw_background();
for(var i = 0; i < ds_list_size(_widget_list); i ++) {
	_widget_list[|i][0].__draw(id, ui_alpha);
}
_draw_foreground();

surface_reset_target();
bm_reset;


















