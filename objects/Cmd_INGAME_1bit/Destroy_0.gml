/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

for(var i = 0; i < 9; i ++) if(surface_exists(__surf1[i])) surface_free(__surf1[i]);
for(var i = 0; i < 2; i ++) if(surface_exists(__surf2[i])) surface_free(__surf2[i]);
