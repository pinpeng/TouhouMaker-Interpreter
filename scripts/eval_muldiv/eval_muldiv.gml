///@function eval_muldiv(value)
///@arg value
function eval_muldiv(argument0) {
	var result = argument0;
	while(exist(token_get_value(eval_get_current_token()),"*","/", "%")){
		var operation = eval_eat_token(TokenType.MATH);
		var _tmp = eval_factor();
		if(_tmp[0]) return [1];
		if(is_string(_tmp[1])) return [1];
		switch(operation){
			case "*":
				result = result * _tmp[1];
				break;
			case "/":
				result = result / _tmp[1];
				break;
			case "%":
				result = result % _tmp[1];
				break;
		}
	}
	return [0, result];


}
