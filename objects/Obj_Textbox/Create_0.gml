global.clipboard = "";

draw = {
	su : noone,				// surface
	re : false,				// refresh surface
	dc : 30,				// display cursor
	ft : noone,				// font
	co : c_black,			// font color
	sx : 32,				// x start
	sy : 32,				// y start
	dw : 160,				// draw width
	dh : 64,				// draw height
	ox : 0,					// x offset
	oy : 0,					// y offset
	ry : 0,					// y resive
	lh : 22,				// line height
	sw : 4,					// scrollbar width
	sh : 0,					// scrollbar height
	dy : 0,					// scrollbar y
	my : 0					// mouse y
}

curt = {
	fo : false,				// focus
	vi : false,				// view
	mu : true,				// multiline
	li : [""],				// lines
	ls : 1,					// length
	ph : "",				// placeholder
	cl : 0,					// current line
	cu : 0,					// cursor
	sl : -1,				// select line
	se : -1,				// select
	ml : 80,				// max length
	hr : [],				// historic records
	rl : 64,				// records upper limit
	cr : -1,				// records cursor
	nw : false,				// nowrap
	aw : true,				// adaptive width
	lb : [true],			// width breakpoints
	br : 0
}

keys = {
	ho : vk_home,			// home
	ed : vk_end,			// end
	bs : vk_backspace,		// backspace
	de : vk_delete,			// delete
	ct : vk_control,		// control
	na : ord("A"),			// A
	nx : ord("X"),			// X
	nc : ord("C"),			// C
	nv : ord("V"),			// V
	nz : ord("Z"),			// Z
	ny : ord("Y"),			// Y
	le : vk_left,			// left
	ri : vk_right,			// right
	up : vk_up,				// up
	dw : vk_down,			// down
	ml : mb_left,			// mouse left
	en : vk_enter,			// enter
	sh : vk_shift,			// shift
	es : vk_escape			// escape
}

keyboard_string = "";