

function mwidget_create(_widget, _x, _y, _xoffset = 0, _yoffset = 0) {
	var ret = instance_create_depth(0, 0, depth - 1, _widget);
	ret.pos_x = _x;
	ret.pos_y = _y;
	ret.xoffset = _xoffset;
	ret.yoffset = _yoffset;
	return ret;
}

function mwidget_create_label(_widget_label = MWidget_label, _x, _y, _xoffset = 0, _yoffset = 0,
_text = "Label",
_halign = fa_center,
_valign = fa_middle,
_color = $ffffff,
_font = FONT.WH12PX) {
	var ret = mwidget_create(_widget_label, _x, _y, _xoffset, _yoffset);
	ret.text	= _text;
	ret.halign	= _halign;
	ret.valign	= _valign;
	ret.color	= _color;
	ret.font	= _font;
	return ret;
}

function mwidget_create_button(_widget_button = MWidget_button, _x, _y, _xoffset = 0, _yoffset = 0,
_text = "Label",
_halign = fa_center,
_valign = fa_middle,
_color = $ffffff,
_font = FONT.WH12PX,
_sprite = [SprUI_mwindow_widget_button, 0, SprUI_mwindow_widget_button, 1]) {
	var ret = mwidget_create(_widget_button, _x, _y, _xoffset, _yoffset);
	ret.text	= _text;
	ret.halign	= _halign;
	ret.valign	= _valign;
	ret.color	= _color;
	ret.font	= _font;
	ret.sprite[0] = _sprite[0];
	ret.sindex[0] = _sprite[1];
	ret.sprite[1] = _sprite[2];
	ret.sindex[1] = _sprite[3];
	ret.setSize(48, 24, 48, 24);
	return ret;
	
}

function mwidget_create_page(_widget_page = MWidget_page,_x, _y, _xoffset = 0, _yoffset = 0, _page_id = -1) {
	var ret = mwidget_create(_widget_page, _x, _y, _xoffset, _yoffset);
	ret.page_id = _page_id;
	return ret;
}

