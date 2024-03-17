///@function eval_factor_asset()
function eval_factor_asset(_res) {
	eval_eat_token(TokenType.DOT);
	var _type = instance_exists(_res);
	var ret = [0, undefined];
	
	if(!instance_exists(_res) && !is_struct(_res)) {
		eval_error("Instance or struct is not exists!");
		return [true];
	}
	
	var varname2;
	if(token_get_type(eval_get_current_token()) == TokenType.VARIABLE) {
		varname2 = eval_eat_token(TokenType.VARIABLE);
	} else {
		eval_error("Invalid factor!");
		return [true];
	}
	
	if(token_get_type(eval_get_current_token()) == TokenType.DOT) {
		
		var _res2;
		if(_type) {
			if(!variable_instance_exists(_res, varname2)) {
				eval_error("Instance(" + string(_res) + ") has no variable named \"" + varname2 + "\"!");
				return [true];
			}
			_res2 = variable_instance_get(_res, varname2);
		} else {
			if(!variable_struct_get(_res, varname2)) {
				eval_error("Struct(" + string(_res) + ") has no variable named \"" + varname2 + "\"!");
				return [true];
			}
			_res2 = variable_struct_get(_res, varname2);
		}
		
		if(!instance_exists(_res2) && !is_struct(_res2)) {
			eval_error("Instance or struct not exists!");
			return [true];
		}
		
		var _tmp = eval_line_asset_index(_res2);
		if(_tmp[0]) return [true];
		else return [false, _tmp[1]];
		
	}

	if(_type) {
		if(!variable_instance_exists(_res, varname2)) {
			eval_error("\"" + varname2 + "\" is undefined!");
			return [true];
		}
		ret[1] = variable_instance_get(_res, varname2);
	} else {
		if(!variable_struct_exists(_res, varname2)) {
			eval_error("\"" + varname2 + "\" is undefined!");
			return [true];
		}
		ret[1] = variable_struct_get(_res, varname2);
	}
	
	return ret;
}

///@function eval_factor()
function eval_factor() {
	var token = eval_get_current_token();
	var res;
	//REAL
	if(token_get_type(token) == TokenType.REAL) {
		return [0, eval_eat_token(TokenType.REAL)];
	} //STRING
	else if(token_get_type(token) == TokenType.STRING) {
		return [0, eval_eat_token(TokenType.STRING)];
	} //PARENTHESES
	else if(token_get_type(token) == TokenType.LPAREN) {
		eval_eat_token(TokenType.LPAREN);
		res = eval_resolve();
		if(res[0]) return [1];
		token = eval_get_current_token();
		if(token_get_type(token) != TokenType.RPAREN) {
			eval_error("Invalid factor!");
			return [1];
		}
		eval_eat_token(TokenType.RPAREN);
		return [0, res[1]];
	} // ASSET
	else if(token_get_type(token) == TokenType.ASSET) {
		res = eval_eat_token(TokenType.ASSET);
		if(token_get_value(eval_get_current_token())==".") {
			if(!instance_exists(res) && !is_struct(res)) { eval_error("Instance or struct not exists!"); return [1]; }
			var _tmp = eval_factor_asset(res);
			if(_tmp[0]) return [1];
			return [0, _tmp[1]];
		}
		return [0, res];
	} // VARIABLE
	else if(token_get_type(token) == TokenType.VARIABLE){
		var varname = eval_eat_token(TokenType.VARIABLE);
		if(!eval_variable_exist(varname)) { eval_error("\"" + varname + "\" is not exists!") return [1]; }
		
		if(token_get_value(eval_get_current_token())=="++") {
			var _self_value = eval_get_variable(varname);
			if(_self_value == undefined) { eval_error("\"" + varname + "\" is undefined!") return [1]; }
			eval_eat_token(TokenType.SPECIAL);
			eval_set_variable(varname, _self_value + 1);
		} else if(token_get_value(eval_get_current_token())=="--") {
			var _self_value = eval_get_variable(varname);
			if(_self_value == undefined) { eval_error("\"" + varname + "\" is undefined!") return [1]; }
			eval_eat_token(TokenType.SPECIAL);
			eval_set_variable(varname, eval_get_variable( varname) - 1);
		} else if(token_get_value(eval_get_current_token())==".") {
			res = eval_get_variable(varname);
			if(!instance_exists(res) && !is_struct(res)) { eval_error("Instance or struct not exists!"); return [1]; }
			var _tmp = eval_factor_asset(res);
			if(_tmp[0]) return [1];
			return [0, _tmp[1]];
		}
		return [0, eval_get_variable(varname)];
	}
	else if(token_get_type(token) == TokenType.FUNCTION) {
		var _tmp = eval_function_resolve(eval_eat_token(TokenType.FUNCTION));
		if(_tmp[0]) return [1];
		return [0, _tmp[1]];
	}
	else if(token_get_type(token) == TokenType.MATH) {
		eval_eat_token(TokenType.MATH);
		
		switch(token_get_value(token)){
			case "+":
				var _factor = eval_factor();
				if(_factor[0]) return [1];
				if(!is_real(_factor[1])) return [1];
				return [0, _factor[1]];
			case "-":
				var _factor = eval_factor();
				if(_factor[0]) return [1];
				if(!is_real(_factor[1])) return [1];
				return [0, -1*_factor[1]];
			case "!":
				var _factor = eval_factor();
				if(_factor[0]) return [1];
				if(!is_real(_factor[1])) return [1];
				return [0, real(!_factor[1])];
		}
	}
	else if(token_get_type(token) == TokenType.SPECIAL) {
		var operation = eval_eat_token(TokenType.SPECIAL);
		if(token_get_type(token) != TokenType.VARIABLE) {
			eval_error("Invalid factor!");
			return [1];
		}
		var varname = eval_eat_token(TokenType.VARIABLE);
		if(!eval_variable_exist(varname)) { eval_error("\"" + varname + "\" is not exists!") return [1]; }
		switch(operation){
			case "++":
				var _self_value = eval_get_variable(varname);
				if(_self_value == undefined) { eval_error("\"" + varname + "\" is undefined!") return [1]; }
				return [0, eval_set_variable(varname, _self_value + 1)];
			case "--":
				var _self_value = eval_get_variable(varname);
				if(_self_value == undefined) { eval_error("\"" + varname + "\" is undefined!") return [1]; }
				return [0, eval_set_variable(varname, _self_value - 1)];
		}
	}
	
	eval_error("Invalid factor!");
	return [1];
}
