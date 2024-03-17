///@function eval_expr(eval)
///@arg eval
function eval_expr() {
	
	var _timer = 0;
	
	while(token_get_type(__execute_string_tokens[__execute_string_position]) != TokenType.EOF) {
		
		var tmp_line = __execute_string_position;
		var ret = eval_line();
		if(ret == 1) {
			if(!__execute_print_string_lite) {
				__execute_print_string += "\nexecute string: cannot execute code.";
				show_debug_message("execute string: cannot execute code.");
				show_debug_message(__execute_string_tokens);
			}
			return 1;
		}
		if(tmp_line == __execute_string_position) {
			_timer ++;
			if(_timer >= 3) {
				eval_error("Into dead loop!");
				return 1;
			}
		} else {
			_timer = 0;
		}
		
		if(__execute_string_position >= array_length(__execute_string_tokens)) {
			eval_error("Invalid line operation!");
			return 1;
		}
	}
	
			if(!ds_stack_empty(__execute_string_scope)){
				eval_error("Warning! Missing }!");
				return 1;
			}
	return 0;
}
