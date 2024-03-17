///@function eval_function_resolve(function)
///@arg function
function eval_function_resolve(_function) {
	var returnval = 0;

	eval_eat_token(TokenType.LPAREN);

	var args = ds_list_create();
	var _flag = true;
	for(var i = __execute_string_position; i < array_length(__execute_string_tokens); i ++) {
		if(__execute_string_tokens[i][Token.TYPE] == TokenType.RPAREN) {
			_flag = false;
			break;
		}
	}
	if(_flag) {
		eval_error("Invalid function operation!");
		ds_list_destroy(args);
		return [1];
	}
	while(token_get_type(eval_get_current_token()) != TokenType.RPAREN){
		var tmp = eval_resolve();
		if(tmp[0]) return [1];
	    ds_list_add(args, tmp[1]);
	    if(token_get_type(eval_get_current_token()) != TokenType.RPAREN){
	        eval_eat_token(TokenType.ARGSEP);
	    }
	}
	//	if(token_get_type(eval_get_current_token())==TokenType.ARGSEP){
	//		eval_eat_token(TokenType.ARGSEP);
	//	}
	//	ds_list_add(args, eval_resolve());
	//} until(token_get_type(eval_get_current_token())!=TokenType.ARGSEP);

	eval_eat_token(TokenType.RPAREN);
	var funcIndex = asset_get_index(_function);
	if(funcIndex == -1) returnval = function_execute_array(_function, ds_list_to_array(args));
	else {
		if(eval_is_hidden_function(funcIndex)) returnval = script_execute_args(funcIndex, args);
		else returnval = script_execute_args(funcIndex, args);
	}

	ds_list_destroy(args);
	return [0, returnval];

}
