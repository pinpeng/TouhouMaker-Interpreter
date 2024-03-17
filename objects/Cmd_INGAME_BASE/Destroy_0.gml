/// @description Insert description here
// You can write your code in this editor

if(surface_exists(INGAME_SURFACE)) surface_free(INGAME_SURFACE);
if(surface_exists(VGUI_SURFACE)) surface_free(VGUI_SURFACE);

__mTrigger_destroy();
