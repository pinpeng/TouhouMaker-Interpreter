///@function goto(label)
function goto(argument0) {
	var checkToken = token_create(TokenType.LABEL, argument0);
	
	var i, _size = array_length(__execute_string_tokens);
	for(i = 0; i < _size; i ++) {
		if(token_equals(__execute_string_tokens[i], checkToken)) {
			__execute_string_position = i;
			break;
		}
	}
	
	if(i == _size) {
		eval_error("Could not find label!");
		return;
	}
	
	eval_eat_token(TokenType.LABEL);

}
