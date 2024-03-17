
globalvar
__execute_string_tokens,
__execute_string_position,
__execute_string_variables,
__execute_string_generatedJumps,
__execute_string_scope,
__execute_string_label,
__execute_string_creator,
__execute_print_string,
__execute_print_string_lite;

__execute_print_string = @"Press [F1] to close consolo window. Type help() to get help, cls() to clean message.";
__execute_string_tokens = -1;

__execute_string_variables = ds_map_create();
	
__execute_string_generatedJumps = ds_stack_create();
__execute_string_scope = ds_stack_create();

__execute_print_string_lite = false;

function code_create(_string) {
	return interp_create(_string);
}

function code_to_string(_code) {
	var ret = "length: " + string(array_length(_code)) + "\n";
	for(var i = 0; i < array_length(_code); i ++) {
		ret += string(_code[i]) + " , ";
	}
	return ret;
}

function execute_string_init(_id = id) {
	__execute_string_position = 0;
	__execute_string_label = 0;
	__execute_string_creator = _id;
	ds_map_clear(__execute_string_variables);
	ds_stack_clear(__execute_string_generatedJumps);
	ds_stack_clear(__execute_string_scope);
}

function execute_code(_code, _id = id) {
	__execute_print_string_lite = true;
	__execute_string_tokens = _code;
	execute_string_init(_id);
	eval_expr();
}

function execute_string(_string, _id = id) {
	__execute_print_string_lite = !setting_get("global", "debug");
	__execute_string_tokens = code_create(_string);
	execute_string_init(_id)
	eval_expr();
}

