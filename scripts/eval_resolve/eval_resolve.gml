///@function eval_resolve()
function eval_resolve() {
	var _factor = eval_factor();
	if(_factor[0]) return [1];
	
	var val = eval_boolean(_factor[1]);
	if(val[0]) return [1];
	
	
	if(is_real(val[1])) {
		var val2 = eval_addsub(val[1]);
		if(val2[0]) return [1];
		return [0, val2[1]];
	}
	else if(is_string(val[1])){
		var val2 = eval_concatenate(val[1]);
		if(val2[0]) return [1];
		return [0, val2[1]];
	} else {
		return [0, val[1]];
	}

}
