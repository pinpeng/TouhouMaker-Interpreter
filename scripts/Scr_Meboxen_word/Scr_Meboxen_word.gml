
__mWord_init();
function __mWord_init() {
	if(!file_exists("mword.json")) {
		show_message("Cannot find \"mword.json\"")
		game_end();
	}
	globalvar __MBN_MWORD_DB;
	var fin = file_text_open_read("mword.json");
	var json = "";
	while(!file_text_eof(fin)) json += file_text_readln(fin);
	file_text_close(fin);
	__MBN_MWORD_DB = json_parse(json);
	
}

function word(_group, _name) {
	var tmp_group = variable_struct_get(__MBN_MWORD_DB, _group);
	if(!is_struct(tmp_group)) return "<undefined>";
	var tmp_item = variable_struct_get(tmp_group, _name);
	if(!is_array(tmp_item)) return "<undefined>";
	return __MBN_MWORD_DB[$ _group][$ _name][Lan];
}
