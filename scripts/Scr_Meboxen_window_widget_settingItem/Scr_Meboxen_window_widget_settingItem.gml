function mwidget_create_settingItem(_widget_item = MWidget_settingItem, _x, _y, _xoffset = 0, _yoffset = 0,
_group,
_item,
_color = $ffffff,
_font = FONT.WH12PX) {
	var ret = mwidget_create_label(_widget_item, _x, _y, _xoffset, _yoffset,
	word("__msetting", _group + "_" + _item),
	fa_left, fa_middle, _color, _font);
	
	ret.setSize(160, 16, 256, 16);
	
	ret.setting_group	= _group;
	ret.setting_item	= _item;
	
	var tmp = __MBN_MSETTING_DB[$ _group][$ _item];
	ret.item = {
		show : tmp.show,
		num : tmp.num,
		def : tmp.def,
		val : tmp.val
	}
	return ret;
}


