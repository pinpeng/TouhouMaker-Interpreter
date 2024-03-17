
function eval_line_asset_index(_res) {
	eval_eat_token(TokenType.DOT);
	var _type = instance_exists(_res);
	var ret = [0, "", undefined];
	
	var varname2;
	if(token_get_type(eval_get_current_token()) == TokenType.VARIABLE) {
		varname2 = eval_eat_token(TokenType.VARIABLE);
	/*} else if(token_get_type(eval_get_current_token()) == TokenType.FUNCTION) {
		var funcname = eval_eat_token(TokenType.FUNCTION);
		var _type = instance_exists(_res);
		if(instance_exists(_res)) {
			return [false, "(" + string(_res) + ")." + funcname + "()", eval_function_resolve(funcname)];
		} else {
			return [false, "(struct)." + funcname + "()", eval_function_resolve(funcname)];
		}*/
	} else {
		eval_error("Invalid line operation!");
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
			ret[1] = "(" + string(_res) + ")." + varname2;
		} else {
			if(!variable_struct_get(_res, varname2)) {
				eval_error("Struct(" + string(_res) + ") has no variable named \"" + varname2 + "\"!");
				return [true];
			}
			_res2 = variable_struct_get(_res, varname2);
			ret[1] = "(struct)." + varname2;
		}
		
		if(!instance_exists(_res2) && !is_struct(_res2)) {
			eval_error("Instance or struct not exists!");
			return [true];
		}
		
		var _tmp = eval_line_asset_index(_res2);
		if(_tmp[0]) return [true];
		else return [false, ret[1] + _tmp[1], _tmp[2]];
	}
	
	var _resolve, _self_value;
	if(_type) _self_value = variable_instance_get(_res, varname2);
	else _self_value = variable_struct_get(_res, varname2);
	
	switch(eval_eat_token(TokenType.SPECIAL)) {
		case "=":
			_resolve = eval_resolve();
			if(_resolve[0]) return [1];
			if(_type) variable_instance_set(_res, varname2, _resolve[1]);
			else variable_struct_set(_res, varname2, _resolve[1]);
			break;
		case "++":
			if(_self_value == undefined) { eval_error("\"" + varname2 + "\" is undefined!") return [1]; }
			if(_type) variable_instance_set(_res, varname2, _self_value + 1);
			else variable_struct_set(_res, varname2, _self_value + 1);
			break;
		case "--":
			if(_self_value == undefined) { eval_error("\"" + varname2 + "\" is undefined!") return [1]; }
			if(_type) variable_instance_set(_res, varname2, _self_value + 1);
			else variable_struct_set(_res, varname2, _self_value + 1);
			break;
		case "+=":
			_resolve = eval_resolve();
			if(_resolve[0]) return [1];
			if(_resolve[1] == undefined) { eval_error("Return undefined!") return [true]; }
			if(_self_value == undefined) { eval_error("\"" + varname2 + "\" is undefined!") return [true]; }
			if(_type) variable_instance_set(_res, varname2, _self_value + _resolve[1]);
			else variable_struct_set(_res, varname2, _self_value + _resolve[1]);
			break;
		case "-=":
			_resolve = eval_resolve();
			if(_resolve[0]) return [1];
			if(_resolve[1] == undefined) { eval_error("Return undefined!") return [true]; }
			if(_self_value == undefined) { eval_error("\"" + varname2 + "\" is undefined!") return [true]; }
			if(_type) variable_instance_set(_res, varname2, _self_value - _resolve[1]);
			else variable_struct_set(_res, varname2, _self_value - _resolve[1]);
			break;
		case "*=":
			_resolve = eval_resolve();
			if(_resolve[0]) return [1];
			if(_resolve[1] == undefined) { eval_error("Return undefined!") return [true]; }
			if(_self_value == undefined) { eval_error("\"" + varname2 + "\" is undefined!") return [true]; }
			if(_type) variable_instance_set(_res, varname2, _self_value * _resolve[1]);
			else variable_struct_set(_res, varname2, _self_value * _resolve[1]);
			break;
		case "/=":
			_resolve = eval_resolve();
			if(_resolve[0]) return [1];
			if(_resolve[1] == undefined) { eval_error("Return undefined!") return [true]; }
			if(_self_value == undefined) { eval_error("\"" + varname2 + "\" is undefined!") return [true]; }
			if(_type) variable_instance_set(_res, varname2, _self_value / _resolve[1]);
			else variable_struct_set(_res, varname2, _self_value / _resolve[1]);
			break;
	}
	
	if(_type) {
		if(!variable_instance_exists(_res, varname2)) {
			eval_error("Warning! \"" + varname2 + "\" is not exists!");
			return [2];
		}
		ret[1] = "(" + string(_res) + ")." + varname2;
		ret[2] = variable_instance_get(_res, varname2);
	} else {
		if(!variable_struct_exists(_res, varname2)) {
			eval_error("Warning! \"" + varname2 + "\" is not exists!");
			return [2];
		}
		ret[1] = "(struct)." + varname2;
		ret[2] = variable_struct_get(_res, varname2);
	}
	
	
	return ret;		
}

function eval_line() {
	
	var token, res, arg;
	switch(token_get_type(eval_get_current_token())){
		case TokenType.ENDL:
			break;
			
		case TokenType.LBRACE:
			ds_stack_push(__execute_string_scope, ds_stack_size(__execute_string_scope));
			eval_eat_token(TokenType.LBRACE);
			return 0;
			
		case TokenType.RBRACE:
			if(ds_stack_empty(__execute_string_scope)){
				eval_error("Unexpected }!");
				return 1;
			}
			ds_stack_pop(__execute_string_scope);
			eval_eat_token(TokenType.RBRACE);
			return 0;
		
		case TokenType.LPAREN:
			eval_error("Unecessary ( used as a statment!");
			return 1;
		
		case TokenType.RPAREN:
			eval_error("Unexpected )!");
			return 1;
		
		case TokenType.LABEL:
			eval_eat_token(TokenType.LABEL);
			break;
		
		case TokenType.LBL:
			eval_eat_token(TokenType.LBL);
			return 0;

		case TokenType.JMP:
			eval_jmp(eval_eat_token(TokenType.JMP));
			return 0;
		
		case TokenType.BREAK:
			if(ds_stack_empty(__execute_string_generatedJumps)){
				eval_error("No context to break from!");
				return 1;
			}
			arg = ds_stack_pop(__execute_string_generatedJumps);
			eval_jmp([arg[1], true]);
			return 0;
		
		case TokenType.CONTINUE:
			if(ds_stack_empty(__execute_string_generatedJumps)){
				eval_error("No context to continue from!");
				return 1;
			}
			arg = ds_stack_top(__execute_string_generatedJumps);
			eval_jmp([arg[0], false]);
			return 0;
		
		case TokenType.STRING:
			res = eval_eat_token(TokenType.STRING);
			res = eval_concatenate(res);
			if(res[0]) return 1;
			if(!__execute_print_string_lite) {
				__execute_print_string += "\n\"" + res[1] + "\"";
			}
			break;
		
		case TokenType.REAL:
			res = eval_eat_token(TokenType.REAL);
			/*if(
			token_get_type(eval_get_current_token()) != TokenType.EOF ||
			token_get_type(eval_get_current_token()) != TokenType.ENDL) {
				eval_error("Invalid line operation!");
				return 1;
			}*/
			__execute_print_string += "\nreal = " + string(res);
			break;
			
		case TokenType.ASSET:
			res = eval_eat_token(TokenType.ASSET);
			if(token_get_type(eval_get_current_token()) == TokenType.DOT) {
				if(!instance_exists(res) && !is_struct(res)) { eval_error("Instance or struct not exists!"); return 1; }
			
				var _tmp = eval_line_asset_index(res);
				if(_tmp[0]) {
					return _tmp[0];
				} else if(!__execute_print_string_lite) {
					if(is_string(_tmp[2]))
					__execute_print_string += "\nvariable \"" + _tmp[1] + "\" = \"" + _tmp[2] + "\"";
					else
					__execute_print_string += "\nvariable \"" + _tmp[1] + "\" = " + string(_tmp[2]);
				}
			} else {
				if(!__execute_print_string_lite) {
					__execute_print_string += "\nasset = " + string(res);
				}
			}
			break;
		
		case TokenType.VARIABLE:
			var varname = eval_eat_token(TokenType.VARIABLE);
			
			if(token_get_type(eval_get_current_token()) == TokenType.DOT) {
				if(!eval_variable_exist(varname)) { eval_error("\"" + varname + "\" is not exists!") return 1; }
				
				res = eval_get_variable(varname);
				if(!instance_exists(res) && !is_struct(res)) { eval_error("Instance or struct not exists!"); return 1; }
			
				var _tmp = eval_line_asset_index(res);
				if(_tmp[0]) {		
					return _tmp[0];
				} else if(!__execute_print_string_lite) {
					if(is_string(_tmp[2]))
					__execute_print_string += "\nvariable \"" + varname + _tmp[1] + "\" = \"" + _tmp[2] + "\"";
					else
					__execute_print_string += "\nvariable \"" + varname + _tmp[1] + "\" = " + string(_tmp[2]);
				}
			} else { // not dot
				var _resolve, _self_value = eval_get_variable(varname);
				switch(eval_eat_token(TokenType.SPECIAL)) {
					case "=":
						_resolve = eval_resolve();
						if(_resolve[0]) return 1;
						eval_set_variable(varname, _resolve[1]);
					break;
					case "++":
						if(_self_value == undefined) { eval_error("\"" + varname + "\" is undefined!") return 1; }
						eval_set_variable(varname, _self_value + 1);
						break;
					case "--":
						if(_self_value == undefined) { eval_error("\"" + varname + "\" is undefined!") return 1; }
						eval_set_variable(varname, _self_value - 1);
						break;
					case "+=":
						_resolve = eval_resolve();
						if(_resolve[0]) return 1;
						if(_resolve[1] == undefined) { eval_error("Return undefined!") return 1; }
						if(_self_value == undefined) { eval_error("\"" + varname + "\" is undefined!") return 1; }
						eval_set_variable(varname, eval_get_variable(varname) + _resolve[1]);
						break;
					case "-=":
						_resolve = eval_resolve();
						if(_resolve[0]) return 1;
						if(_resolve[1] == undefined) { eval_error("Return undefined!") return 1; }
						if(_self_value == undefined) { eval_error("\"" + varname + "\" is undefined!") return 1; }
						eval_set_variable(varname, _self_value - _resolve[1]);
						break;
					case "*=":
						_resolve = eval_resolve();
						if(_resolve[0]) return 1;
						if(_resolve[1] == undefined) { eval_error("Return undefined!") return 1; }
						if(_self_value == undefined) { eval_error("\"" + varname + "\" is undefined!") return 1; }
						eval_set_variable(varname, _self_value * _resolve[1]);
						break;
					case "/=":
						_resolve = eval_resolve();
						if(_resolve[0]) return 1;
						if(_resolve[1] == undefined) { eval_error("Return undefined!") return 1; }
						if(_self_value == undefined) { eval_error("\"" + varname + "\" is undefined!") return 1; }
						eval_set_variable(varname, _self_value / _resolve[1]);
						break;
				}
				if(!eval_variable_exist(varname)) {
					eval_error("Warning! \"" + varname + "\" is not exists!");
					return 0;
				}
				if(!__execute_print_string_lite) {
					_self_value = eval_get_variable(varname);
					if(is_string(_self_value))
					__execute_print_string += "\nvariable \"" + varname + "\" = \"" + _self_value + "\"";
					else
					__execute_print_string += "\nvariable \"" + varname + "\" = " + string(_self_value);
				}
			}
			break;
		
		case TokenType.VAR:
			eval_eat_token(TokenType.VAR);
			if(token_get_type(eval_get_current_token()) != TokenType.VARIABLE) {
				eval_error("Invalid line operation!");
				return 1;
			}
			var varname = eval_eat_token(TokenType.VARIABLE);
			if(token_get_value(eval_get_current_token()) != "=") {
				eval_set_variable_local(varname, undefined);
			} else {
				eval_eat_token(TokenType.SPECIAL);
				var _resolve = eval_resolve();
				if(_resolve[0]) return 1;
				eval_set_variable_local(varname, _resolve[1]);
			}
			if(!__execute_print_string_lite) {
				__execute_print_string += "\nvariable \"" + varname + "\" = " + string(__execute_string_variables[? varname]);
			}
			break;
		
		case TokenType.FUNCTION:
			var funcname = eval_eat_token(TokenType.FUNCTION);
			var _resolve = eval_function_resolve(funcname);
			if(_resolve[0]) return 1;
			break;
		
		case TokenType.KEYWORD:
			switch(eval_eat_token(TokenType.KEYWORD)){
				case "if":
					var _resolve = eval_resolve();
					if(_resolve[0]) return [1];
					if(!_resolve[1]) {
						if(token_get_type(eval_get_current_token()) != TokenType.LBRACE) {
							
							eval_error("Missing { after if!");
							return 1;
							/*for(var i = __execute_string_position; i < array_length(__execute_string_tokens); i ++) {
								if(token_equals(__execute_string_tokens[i], [TokenType.KEYWORD, "else"])) {
									__execute_string_position = i;
									eval_eat_token(TokenType.KEYWORD);
									return 0;
								}
								if(
								__execute_string_tokens[i][Token.TYPE] == TokenType.ENDL ||
								__execute_string_tokens[i][Token.TYPE] == TokenType.EOF) {
									__execute_string_position = id;
									return 0;
								}
							}
							eval_error("Invalid line operation!");
							return 1;*/
						}
						eval_skip_line();
						var else_token = token_create(TokenType.KEYWORD, "else");
						if(token_equals(eval_get_current_token(),else_token)) {
							eval_eat_token(TokenType.KEYWORD);
						}
					} else {
						if(token_get_type(eval_get_current_token()) != TokenType.LBRACE) {
							eval_error("Missing { after if!");
							return 1;
						}
					}
					return 0;
				case "else":
					if(token_get_type(eval_get_current_token()) != TokenType.LBRACE) {
						eval_error("Missing { after else!");
						return 1;
					}
					eval_skip_line();
					return 0;
				case "bif":
					var _resolve = eval_resolve();
					if(_resolve[0]) return [1];
					if(_resolve[1])
						eval_skip_line();
					return 0;
				case "while":
					eval_error("Keyword \"while\" is not supported in the current version.");
					return 1;
					eval_destroy_eaten_token();
					var currPos = __execute_string_position;
					var start = eval_create_jump_label();
					var finish = eval_create_jump_label();
					ds_stack_push(__execute_string_generatedJumps, [start,finish]);
					eval_insert_token(token_create(TokenType.LBL,start));
					eval_insert_token(token_create(TokenType.KEYWORD, "bif"));
					eval_skip_clause();
					eval_insert_token(token_create(TokenType.JMP, [finish, true]));
					eval_skip_line();
					eval_insert_token(token_create(TokenType.JMP, [start, false]));
					eval_insert_token(token_create(TokenType.LBL, finish));
					__execute_string_position = currPos;
					return 0;
				case "for":
					eval_error("Keyword \"for\" is not supported in the current version.");
					return 1;
					//Destroy "for" keyword
					eval_destroy_eaten_token();
				
					//Eat and destroy opening (
					eval_eat_token(TokenType.LPAREN,true);
				
					//Setup for jumps
					var currPos = __execute_string_position;
					var start = eval_create_jump_label();
					var finish = eval_create_jump_label();
					var body = eval_create_jump_label();
					var endline = eval_create_jump_label();
					ds_stack_push(__execute_string_generatedJumps, [endline,finish]);
				
					//Skip first condition
					eval_skip_line();
				
					//Insert starting jump and second conditional check
					eval_insert_token(token_create(TokenType.LBL,start));
					eval_insert_token(token_create(TokenType.KEYWORD, "bif"));
					eval_skip_line();
				
					//Eat semicolon after second condition
					eval_destroy_eaten_token();
				
					//Jump to finish when complete, else jump to the body
					eval_insert_token(token_create(TokenType.JMP,[finish,true]));
					eval_insert_token(token_create(TokenType.JMP,[body,false]));
				
					//Endline
					eval_insert_token(token_create(TokenType.LBL,endline));
					eval_skip_line(TokenType.RPAREN);
					eval_destroy_eaten_token();
					eval_insert_token(token_create(TokenType.ENDL,";"));
					eval_insert_token(token_create(TokenType.JMP,[start,false]));
				
					eval_insert_token(token_create(TokenType.LBL,body));
					eval_skip_line();
					eval_insert_token(token_create(TokenType.JMP,[endline,false]));
				
					eval_insert_token(token_create(TokenType.LBL,finish));
					__execute_string_position = currPos;
					return 0;
			}
			break;
		
		default:
			eval_error("Invalid line operation!");
			return 1;
	}

	eval_eat_token(TokenType.ENDL);

	return 0;
}
