///@function eval_concatenate(value)
///@arg value
function eval_concatenate(argument0) {
	var result = argument0;
	while(token_get_value(eval_get_current_token())=="+"){
		eval_eat_token(TokenType.MATH);
		var _tmp = eval_factor();
		if(_tmp[0]) return [1];
		if(!is_string(_tmp[1])) return [1];
		result = result + _tmp[1];
	}
	return [0, result];


}
