
	enum Token {
		TYPE = 0,
		VALUE = 1
	}

	enum TokenType {
		REAL,
		STRING,
		VARIABLE,
		FUNCTION,
		MATH,
		BOOLEAN,
		LPAREN,
		RPAREN,
		LBRACE,
		RBRACE,
		SPECIAL,
		ENDL,
		EOF,
		ARGSEP,
		KEYWORD,
		BREAK,
		CONTINUE,
		LABEL,
		LBL, //Hidden label
		JMP, //Hidden GOTO
		DOT,
		ASSET,
		VAR
	}


///@function token_create(type, value)
///@arg type
///@arg value
function token_create(_type, _value) {

	var token = [_type, _value];
	return token;

}
