

function __thmk_execute_create_code(_code) {
	if(!is_string(_code)) return -1;
	if(!string_length(_code)) return -1;
	var tmp = code_create(string_replace_all(_code, "\\n", "\n"));
	__THMK_DATABASE.code[? __THMK_DATABASE.code_num] = tmp;
	__THMK_DATABASE.code_num ++;
	return __THMK_DATABASE.code_num - 1;
}

function __thmk_execute_resolve(_code_id, _this = id){
	if(!is_real(_code_id) || _code_id == -1) return undefined;
	__execute_print_string_lite = true;
	__execute_string_tokens = __THMK_DATABASE.code[? _code_id];
	execute_string_init(_this);
	var _resolve = eval_resolve();
	if(_resolve[0]) return undefined;
	return _resolve[1];
}

function __thmk_execute_code(_code_id, _this = id){
	if(!is_real(_code_id) || _code_id == -1) return;
	__execute_print_string_lite = true;
	__execute_string_tokens = __THMK_DATABASE.code[? _code_id];
	execute_string_init(_this);
	eval_expr();
}

