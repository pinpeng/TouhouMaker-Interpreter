/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

var tmp = [0, 0];

tmp[0] = mwidget_create_button(, 0.5, 0.5, -108, 52, "<scale,3>Accept</>",
fa_center, fa_middle, $000000);
connect(tmp[0], "pressed", id, "wait");

tmp[1] = mwidget_create_button(, 0.5, 0.5, 108, 52, "<scale,3>Cancel</>",
fa_center, fa_middle, $000000);
connect(tmp[1], "pressed", id, "close");

mwindow_add_widget_array_vertical(tmp, 1);

tmp = mwidget_create_label(, 0.5, 0.5, 0, -42, "<scale,4>Do you want to exit?</>",
fa_center, fa_middle, $000000);
addWidget(tmp);

tmp = mwidget_create_label(, 0.5, 0.5, -300, -102, "<scale,2>MWindow_ask_exit 测试窗口</>",
fa_left, fa_middle, $000000);
addWidget(tmp);

function _step_waiting() {
	ui_alpha = Lerp(ui_alpha, 0, 0.16)
	if(state == MWINDOW_STATE.WAITTING && ui_alpha <= 0) {
		game_end();
	}
	return 1;
}

function _draw_foreground() {
	if(state == MWINDOW_STATE.WAITTING) {
		draw_black_gui(1 - ui_alpha);
	}
}
