/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if(surface_exists(surf_ingame_final)) surface_free(surf_ingame_final);
if(surface_exists(surf_gm_bloom)) surface_free(surf_gm_bloom);
if(surface_exists(surf_gm_bloom_tmp)) surface_free(surf_gm_bloom_tmp);

