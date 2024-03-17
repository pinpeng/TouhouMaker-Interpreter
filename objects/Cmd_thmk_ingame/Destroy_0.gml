/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

ds_list_destroy(_thmk_stage.events_list);
delete _thmk_stage;

for(var i = 0; i < ds_list_size(_thmk_hero_bullet); i ++) delete _thmk_hero_bullet[|i];
for(var i = 0; i < ds_list_size(_thmk_enemy_bullet); i ++) delete _thmk_enemy_bullet[|i];
for(var i = 0; i < ds_list_size(_thmk_effect); i ++) delete _thmk_effect[|i];

ds_list_destroy(_thmk_hero_bullet);
ds_list_destroy(_thmk_enemy_bullet);
ds_list_destroy(_thmk_effect);

if(surface_exists(surf_bloom0)) surface_free(surf_bloom0);
if(surface_exists(surf_bloom1)) surface_free(surf_bloom1);



