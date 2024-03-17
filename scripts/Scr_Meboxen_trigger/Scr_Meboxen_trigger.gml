

function __mTrigger_init() {
	__mTrigger_inited = 1;
	__mTrigger_list = ds_list_create();
	__mTrigger_global_list = ds_list_create();
}

function __mTrigger_destroy() {
	emit("destroyed");
	ds_list_destroy(__mTrigger_list);
	ds_list_destroy(__mTrigger_global_list);
}

function connect(_sender, _signal_name, _receiver, _method_name) {
	if(!instance_exists(_sender) || !instance_exists(_receiver)) return;
	if(!variable_instance_exists(_sender, "__mTrigger_inited")) {
		with(_sender) __mTrigger_init();                   
	}
	with(_sender) {
		for(var i = 0; i < ds_list_size(__mTrigger_list); i ++) {
			var _tmp = __mTrigger_list[|i];
			if(!instance_exists(_tmp[1])) {
				ds_list_delete(__mTrigger_list, i);
				i --;
				continue;
			}
			if(_tmp[0] == _signal_name && _tmp[1] == _receiver && _tmp[2] == _method_name) {
				return;
			}
		}
		ds_list_add(__mTrigger_list, [_signal_name, _receiver, _method_name]);
	}
}

function disconnect(_sender, _signal_name, _receiver, _method_name) {
	if(!instance_exists(_sender) || !instance_exists(_receiver)) return;
	if(!variable_instance_exists(_sender, "__mTrigger_inited")) return;
	
	with(_sender) {
		for(var i = 0; i < ds_list_size(__mTrigger_list); i ++) {
			var _tmp = __mTrigger_list[|i];
			if(!instance_exists(_tmp[1])) {
				ds_list_delete(__mTrigger_list, i);
				i --;
				continue;
			}
			if(_tmp[0] == _signal_name && _tmp[1] == _receiver && _tmp[2] == _method_name) {
				ds_list_delete(__mTrigger_list, i);
				return;
			}
		}
	}
}

function disconnect_all(_sender = id) {
	if(!variable_instance_exists(_sender, "__mTrigger_inited")) return;
	with(_sender) ds_list_clear(__mTrigger_list);
}

function emit(_signal_name, _args = []) {
	if(!variable_instance_exists(id, "__mTrigger_inited")) return;

//show_debug_message("emit local signal!\nsender:" + string(id) + 
//", signal:" + _signal_name + ", args:" + string(_args))
	
	for(var i = 0; i < ds_list_size(__mTrigger_list); i ++) {
		var _tmp = __mTrigger_list[|i];
		
		if(_tmp[0] == _signal_name) {
			if(instance_exists(_tmp[1])) {
				var _method = variable_instance_get(_tmp[1], _tmp[2]);
				if(is_method(_method)) {
					with(_tmp[1]) method_call(_method, _args);
					
//show_debug_message("recevier:" + string(_tmp[1]) + ", method:" + _tmp[2])

				}
			} else {
				ds_list_delete(__mTrigger_list, i);
				i --;
				continue;
			}
		}
	}
	
}

function connect_global(_sender, _signal_name, _receiver, _method_name) {
	if(!instance_exists(_sender) || !object_exists(_receiver)) return;
	if(!variable_instance_exists(_sender, "__mTrigger_inited")) {
		with(_sender) __mTrigger_init();                   
	}
	with(_sender) {
		for(var i = 0; i < ds_list_size(__mTrigger_global_list); i ++) {
			var _tmp = __mTrigger_global_list[|i];
			if(_tmp[0] == _signal_name && _tmp[1] == _receiver && _tmp[2] == _method_name) {
				return;
			}
		}
		ds_list_add(__mTrigger_global_list, [_signal_name, _receiver, _method_name]);
	}
}

function disconnect_global(_sender, _signal_name, _receiver, _method_name) {
	if(!instance_exists(_sender)) return;
	if(!variable_instance_exists(_sender, "__mTrigger_inited")) return;
	
	with(_sender) {
		for(var i = 0; i < ds_list_size(__mTrigger_global_list); i ++) {
			var _tmp = __mTrigger_global_list[|i];
			if(_tmp[0] == _signal_name && _tmp[1] == _receiver && _tmp[2] == _method_name) {
				ds_list_delete(__mTrigger_global_list, i);
				return;
			}
		}
	}
}

function emit_global(_signal_name, _args = []) {
	if(!variable_instance_exists(id, "__mTrigger_inited")) return;

//show_debug_message("emit global signal!\nsender:" + string(id) + 
//", signal:" + _signal_name + ", args:" + string(_args))
	
	for(var i = 0; i < ds_list_size(__mTrigger_global_list); i ++) {
		var _tmp = __mTrigger_global_list[|i];

		if(_tmp[0] == _signal_name) {
			for(var j = 0; j < instance_number(_tmp[1]); j ++) {
				var _obj = instance_find(_tmp[1], j)
				var _method = variable_instance_get(_obj, _tmp[2]);
				if(is_method(_method)) {
					with(_obj) method_call(_method, _args);
					
//show_debug_message("recevier:" + string(_tmp[1]) + ", method:" + _tmp[2])

				}
			}
		}
	}
}