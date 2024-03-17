/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

stage = noone;

timer = 0;
timer_end = 0;

inited = 0;

val0 = 0;
val1 = 0;
val2 = 0;
val3 = 0;

hp = 1;
hp_max = 1;
collision = 32;

x_target = 0;
y_target = 0;

threads = [];

state = THMK_BOSS_STATE.IDLE;

vbuff_hp = vertex_create_buffer();
vbuff_hp_edge1 = vertex_create_buffer();
vbuff_hp_edge2 = vertex_create_buffer();

image = [Spr_thmk_default_boss, Spr_thmk_default_boss, Spr_thmk_default_boss];

function go(_x, _y) {
	x_target = _x;
	y_target = _y;
}

function _init() {
	timer = 0;
	inited = 0;
	thread = 0;
	threads = [];
	state = THMK_BOSS_STATE.IDLE;
	go(0, 0);
}

function _stage_init() {
	inited = 1;
	timer = 0;
	hp = hp_max;
	for(var i = 0; i < array_length(threads); i ++) {
		var tmp = threads[i];
		tmp.timer1 = 0;
		tmp.timer2 = 0;
		tmp.inited = false;
		threads[i] = tmp;
	}
}

function _draw_vgui() {
	if(state == THMK_BOSS_STATE.RUNNING) {
		
		vertex_begin(vbuff_hp, VFORM_PT);
		vertex_begin(vbuff_hp_edge1, VFORM_PC);
		vertex_begin(vbuff_hp_edge2, VFORM_PC);
		var _angle = 2;
		var _len1 = 120;
		var _len2 = 128;
		var _x1, _x2, _x3, _x4;
		var _y1, _y2, _y3, _y4;
		var _dir1, _dir2;
		_dir1 = 90 / 180 * pi;
		_x1 = _len1 * cos(_dir1) + 435;
		_y1 =-_len1 * sin(_dir1) + 280;
		_x2 = _len2 * cos(_dir1) + 435;
		_y2 =-_len2 * sin(_dir1) + 280;
		for(var i = 0; i < 360; i += _angle) {
			_dir2 = (90 - i - _angle) / 180 * pi;
			_x3 = _len1 * cos(_dir2) + 435;
			_y3 =-_len1 * sin(_dir2) + 280;
			_x4 = _len2 * cos(_dir2) + 435;
			_y4 =-_len2 * sin(_dir2) + 280;
			if(i / 360 >= 1 - hp / hp_max) {
				draw_vertex_triangle_pt(vbuff_hp,
				_x1, _y1, 0, 0, _x2, _y2, 1, 0, _x4, _y4, 1, 1);
				draw_vertex_triangle_pt(vbuff_hp,
				_x1, _y1, 0, 0, _x3, _y3, 0, 1, _x4, _y4, 1, 1);
			}
			draw_vertex_line_pc(vbuff_hp_edge1, $0000ff, 1, _x1, _y1, _x3, _y3);
			draw_vertex_line_pc(vbuff_hp_edge2, $0000ff, 1, _x2, _y2, _x4, _y4);
			_dir1 = _dir2;
			_x1 = _x3;
			_y1 = _y3;
			_x2 = _x4;
			_y2 = _y4;
		}
		
		vertex_end(vbuff_hp);
		vertex_end(vbuff_hp_edge1);
		vertex_end(vbuff_hp_edge2);
		shader_set(Shd_DrawVertexColor);
		vertex_submit(vbuff_hp_edge1, pr_linelist, -1);
		vertex_submit(vbuff_hp_edge2, pr_linelist, -1);
		shader_reset();
		draw_vertex_submit_pt(vbuff_hp, Texture_thmk_red);
		
	}
}

