

function mwidget_create_lineEdit(_lineEdit = MWidget_lineEdit, _x, _y, _xoffset = 0, _yoffset = 0,
_text = "",
_text_background = "Input something...",
_color = $000000,
_color_background = $ffffff,
_font = FONT.WH12PX) {
	var ret = mwidget_create(_lineEdit, _x, _y, _xoffset, _yoffset);
	
	ret.setSize(128, 16, 128, 16);
	
	ret.text	= _text;
	ret.text_background = _text_background;
	ret.text_index = string_length(_text);
	ret.color_background = _color_background;
	ret.color	= _color;
	ret.font	= _font;
	
	return ret;
}
