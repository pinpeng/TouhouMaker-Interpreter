///@function eval_jmp(label)
function eval_jmp(argument0) {
	var arg = argument0;
	if(arg[1]) ds_stack_pop(__execute_string_generatedJumps);
	var checkToken = token_create(TokenType.LBL, arg[0]);
	
	var i, _size = array_length(__execute_string_tokens);
	for(i = 0; i < _size; i++){
		if(token_equals(__execute_string_tokens[i], checkToken)){
			__execute_string_tokens = i;
			break;
		}
	}
	
	if(i == _size) {
		eval_error("Could not find JMP command!");
		return;
	}
	
	eval_eat_token(TokenType.LBL);

}
