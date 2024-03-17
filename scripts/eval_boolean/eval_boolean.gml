///@function eval_boolean(value)
///@arg value
function eval_boolean(argument0) {
	var result = argument0;
	var boolean = false;
	while(token_get_type(eval_get_current_token()) == TokenType.BOOLEAN) {
		boolean = true;
		var operation = eval_eat_token(TokenType.BOOLEAN);
		var _tmp = eval_resolve();
		if(_tmp[0]) return [1];
		switch(operation){
			case "==":
				result = (result == _tmp[1]);
				break;
			case "<":
				result = result < _tmp[1];
				break;
			case ">":
				result = result > _tmp[1];
				break;
			case "<=":
				result = result <= _tmp[1];
				break;
			case ">=":
				result = result >= _tmp[1];
				break;
			case "&&":
				result = _tmp[1] && result;
				break;
			case "&":
				result = _tmp[1] & result;
				break;
			case "||":
				result = _tmp[1] || result;
				break;
			case "|":
				result = _tmp[1] | result;
				break;
			case "^^":
				result = _tmp[1] ^^ result;
				break;
			case "^":
				result = _tmp[1] ^ result;
				break;
		}
	}
	if(boolean) result = real(result);
	return [0, result];


}
