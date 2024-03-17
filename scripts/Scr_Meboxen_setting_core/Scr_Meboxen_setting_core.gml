/*

__MBN_MSETTING_DB = 
{
	"groupName":
	{
		bool show
		"itemName":
		{
			bool show
			int  num (0 for value, 1 for switch, 2 or more for enmu)
			real def (default value)
			real val (value)
		}
	}
}

*/

function __mSetting_apply() {
	window_set_fullscreen(setting_get("video", "full_screen"));
	audio_master_gain(setting_get("audio", "volume_main") / 100);
}

__mSetting_init(); 
function __mSetting_init() {
	// MUST check for msetting.json and mword.json
	// provide by mbnlib2tool
	if(!file_exists("msetting.json")) {
		show_message("Cannot find \"msetting.json\"");
		game_end();
	}
	
	globalvar __MBN_MSETTING_DB;
	var fin = file_text_open_read("msetting.json");
	var json = "";
	while(!file_text_eof(fin)) json += file_text_readln(fin);
	file_text_close(fin);
	__MBN_MSETTING_DB = json_parse(json);
	
	
}

function __mSetting_read() {
	if(!file_exists(working_directory + "setting.ini")) {
		var tmp_len1 = __MBN_MSETTING_DB.__name_list; // name list for group
		
		var tmp_file = file_text_open_write(working_directory + "setting.ini");
		for(var i = 0; i < array_length(tmp_len1); i ++) {
			file_text_write_string(tmp_file, "[" + tmp_len1[i] + "]");
			file_text_writeln(tmp_file);
			var tmp_group = __MBN_MSETTING_DB[$ tmp_len1[i]];
			var tmp_len2 = tmp_group.__name_list; // name list for item
			for(var j = 0; j < array_length(tmp_len2); j ++) {
				var tmp_item = tmp_group[$ tmp_len2[j]];
				file_text_write_string(tmp_file, tmp_len2[j] + "\"" + string(tmp_item.def) + "\"")
				file_text_writeln(tmp_file);
			}
		}
		file_text_close(tmp_file);
		
		/*ini_open(working_directory + "setting.ini");
		
		for(var i = 0; i < array_length(tmp_len1); i ++) {
			var tmp_group = __MBN_MSETTING_DB[$ tmp_len1[i]];
			var tmp_len2 = tmp_group.__name_list; // name list for item
			
			for(var j = 0; j < array_length(tmp_len2); j ++) {
				var tmp_item = tmp_group[$ tmp_len2[j]];
				show_debug_message(tmp_len1[i])
				show_debug_message(tmp_len2[j])
				show_debug_message(tmp_item)
				tmp_item.val = tmp_item.def;
				ini_write_real(tmp_len1[i], tmp_len2[j], tmp_item.val);
				tmp_group[$ tmp_len2[j]] = tmp_item;
			}	
			__MBN_MSETTING_DB[$ tmp_len1[i]] = tmp_group;
			ini_close();
		}*/
	} else {
		ini_open(working_directory + "setting.ini");
		var tmp_len1 = __MBN_MSETTING_DB.__name_list; // name list for group
		
		for(var i = 0; i < array_length(tmp_len1); i ++) {
			var tmp_group = __MBN_MSETTING_DB[$ tmp_len1[i]];
			var tmp_len2 = tmp_group.__name_list; // name list for item
			
			for(var j = 0; j < array_length(tmp_len2); j ++) {
				var tmp_item = tmp_group[$ tmp_len2[j]];
				
				var tmp_val = ini_read_real(tmp_len1[i], tmp_len2[j], tmp_item.def);
				tmp_item.val = tmp_val;
				tmp_group[$ tmp_len2[j]] = tmp_item;
			}	
			__MBN_MSETTING_DB[$ tmp_len1[i]] = tmp_group;
		}
		ini_close();
	}
	
}

function __mSetting_save() {
	ini_open(working_directory + "setting.ini");
	
	var tmp_len1 = __MBN_MSETTING_DB.__name_list; // name list for group
	
	for(var i = 0; i < array_length(tmp_len1); i ++) {
		var tmp_group = __MBN_MSETTING_DB[$ tmp_len1[i]];
		var tmp_len2 = tmp_group.__name_list; // name list for item
		
		for(var j = 0; j < array_length(tmp_len2); j ++) {
			var tmp_item = tmp_group[$ tmp_len2[j]];
			
			ini_write_real(tmp_len1[i], tmp_len2[j], tmp_item.val);
		}
	}
	
	ini_close();
}