///@function eval_get_current_token()
function eval_get_current_token() {
	if(__execute_string_position >= array_length(__execute_string_tokens))
	return token_create(TokenType.EOF, undefined);
	return __execute_string_tokens[__execute_string_position];


}
