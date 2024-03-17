/*
function gml_execute_line(_code) {
	if(!string_length(_code)) return;
	__mExecute_code(_code);
}
	
function gml_execute_code(_code) {
	if(!string_length(_code)) return;
	
	var _tmp_size = string_count("\n", _code);
	var _code_list = string_split(_code, "\n", true);
	
	for(var i = 0; i < array_length(_code_list); i ++) {
		__mExecute_code(_code);
	}
	
}
*/