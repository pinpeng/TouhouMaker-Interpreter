
function eval_get_variable(_name) {
	
	if(variable_global_exists(_name))
	return variable_global_get(_name);
	
	if(ds_map_exists(__execute_string_variables, _name))
	return __execute_string_variables[? _name];
	
	if(is_struct(__execute_string_creator)) {
		return variable_struct_get(__execute_string_creator, _name);
	}
	return variable_instance_get(__execute_string_creator, _name);
}

function eval_set_variable(_name, _value) {
	if(variable_global_exists(_name)) {
		variable_global_set(_name, _value);
		return _value;
	}
	
	if(ds_map_exists(__execute_string_variables, _name)) {
		__execute_string_variables[? _name] = _value;
		return _value;
	}
	
	if(is_struct(__execute_string_creator)) {
		variable_struct_set(__execute_string_creator, _name, _value);
		return _value;
	} else {
		variable_instance_set(__execute_string_creator, _name, _value);
		return _value;
	}
}

function eval_set_variable_local(_name, _value) {
	__execute_string_variables[? _name] = _value;
	return _value;
}

function eval_variable_exist(_name) {
	if(variable_global_exists(_name)) return true;
	if(ds_map_exists(__execute_string_variables, _name)) return true;
	if(is_struct(__execute_string_creator)) {
		return variable_struct_exists(__execute_string_creator, _name);
	}
	return variable_instance_exists(__execute_string_creator, _name);
}
