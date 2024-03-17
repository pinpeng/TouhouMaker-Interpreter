///@function token_eat(type, ?discard)
///@arg type
///@arg discard
function eval_eat_token(_type, _discard = false) {
	var token = eval_get_current_token();
	if(token_get_type(token) == _type){
		if(_discard){
			array_delete(__execute_string_tokens, __execute_string_position, 1);
		} else {
			__execute_string_position ++;
		}
		return token_get_value(token);
	}
	//eval_error("Invalid token!");

}
