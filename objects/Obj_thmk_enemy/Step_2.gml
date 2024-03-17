/// @description Insert description here
// You can write your code in this editor

if(__THMK_STATE != THMK_STATE.PLAYING) exit;

x += spd * cos(dir / 180 * pi);
y -= spd * sin(dir / 180 * pi);


if(ds_list_size(Cmd_thmk_ingame._thmk_hero_bullet)) {
	for(var i = 0; i < ds_list_size(Cmd_thmk_ingame._thmk_hero_bullet); i ++) {
		var tmp = Cmd_thmk_ingame._thmk_hero_bullet[|i];
		if(point_distance(x, y, tmp.x, tmp.y) < collision + 16) {
			tmp.hp --;
			if(tmp.hp <= 0) tmp.del_on_later = true;
			hp = max(hp - 1, 0);
			ds_list_add(Cmd_thmk_ingame._thmk_effect,
			{ sprite_index : Spr_thmk_default_bullet_ef,
			x : x, y : y, dir : random(360), spd : random_range(2, 6),
			angle : random(360), angle_spd : random_range(6, 24),
			timer : 20, timer_max : 18 });
		}
	}
}

if(hp <= 0) instance_destroy();

if(range == 0) {
	if(abs(x) > 435 || abs(y - 200) > 510) instance_destroy();
} else if(range == 1) {
	if(abs(x) >= 750 || abs(y - 200) > 900) instance_destroy();
}








