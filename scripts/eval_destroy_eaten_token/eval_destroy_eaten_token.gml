///@function eval_destroy_eaten_token()
function eval_destroy_eaten_token() {
	array_delete(__execute_string_tokens, __execute_string_position - 1, 1);
	__execute_string_position --;


}
