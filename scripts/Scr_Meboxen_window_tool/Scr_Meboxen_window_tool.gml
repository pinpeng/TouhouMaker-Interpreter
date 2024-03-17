

function mwindow_add_widget_array(_widget_array) {
	if(!is_array(_widget_array)) return;
	var tmp_size = array_length(_widget_array);
	for(var i = 0; i < tmp_size; i ++) {
		addWidget(_widget_array[i]);
	}
}

function mwindow_add_widget_array_vertical(_widget_array, _loop = true) {
	if(!is_array(_widget_array)) return;
	var tmp_size = array_length(_widget_array);
	if(_loop) {
		for(var i = 0; i < tmp_size; i ++) {
			addWidget(_widget_array[i],
			[(i - 1 + tmp_size) mod tmp_size, (i + 1 + tmp_size) mod tmp_size, -1, -1]);
		}
	} else {
		for(var i = 0; i < tmp_size; i ++) {
			addWidget(_widget_array[i],
			[max(0, i - 1), min(i + 1, tmp_size - 1), -1, -1]);
		}
	}
}

function mwindow_add_widget_array_horizon(_widget_array, _loop = true) {
	if(!is_array(_widget_array)) return;
	var tmp_size = array_length(_widget_array);
	if(_loop) {
		for(var i = 0; i < tmp_size; i ++) {
			addWidget(_widget_array[i],
			[-1, -1, (i - 1 + tmp_size) mod tmp_size, (i + 1 + tmp_size) mod tmp_size]);
		}
	} else {
		for(var i = 0; i < tmp_size; i ++) {
			addWidget(_widget_array[i],
			[-1, -1, max(0, i - 1), min(i + 1, tmp_size - 1)]);
		}
	}
}
