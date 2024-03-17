/// @description Insert description here
// You can write your code in this editor

var spd = 1;

if(input_kb(INPUT.UP))		y -= spd;
if(input_kb(INPUT.DOWN))	y += spd;
if(input_kb(INPUT.LEFT))	x -= spd;
if(input_kb(INPUT.RIGHT))	x += spd;

ingame_view_set(x, y);

