/// @description Insert description here
// You can write your code in this editor

if(__THMK_STATE != THMK_STATE.PLAYING) exit;

if(del_on_later) instance_destroy();

var tmp_x = x;

x = Lerp(x, x_target, 0.12, 0.9);
y = Lerp(y, y_target, 0.12, 0.9);


if(x < tmp_x) sprite_index = image[1];
else if(x > tmp_x) sprite_index = image[2];
else sprite_index = image[0];







