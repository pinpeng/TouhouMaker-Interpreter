
function ds_list_to_array(_list) {
	var _i = 0, _s = ds_list_size(_list);
	var _a = array_create(_s);
	repeat (_s) {
	    _a[_i] = _list[|_i];
	    _i ++;
	}
	return _a;
}

function ds_list_to_string(_list) {
	var _i = 0, _s = ds_list_size(_list);
	var _str = "[ ";
	repeat (_s) {
	    _str[_i] += string(_list[|_i]) + ", ";
	    _i ++;
	}
	return _str = "]";
}
