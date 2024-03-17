
function setting_get_group(_group) {
	return __MBN_MSETTING_DB[$ _group];
}

function setting_get_item(_group, _item) {
	return __MBN_MSETTING_DB[$ _group][$ _item];
}

function setting_get_group_number() {
	return array_length(__MBN_MSETTING_DB.__name_list);
}

function setting_get_group_list() {
	return __MBN_MSETTING_DB.__name_list;
}

function setting_get_item_number(_group) {
	return array_length(__MBN_MSETTING_DB[$ _group].__name_list);
}

function setting_get_item_list(_group) {
	return __MBN_MSETTING_DB[$ _group].__name_list;
}

function setting_set(_group, _item, _val) {
	__MBN_MSETTING_DB[$ _group][$ _item].val = _val;
}

function setting_get_default(_group, _item) {
	return __MBN_MSETTING_DB[$ _group][$ _item].def;
}

function setting_get(_group, _item) {
	return __MBN_MSETTING_DB[$ _group][$ _item].val;
}

function setting_set_language(_language) {
	__MBN_MSETTING_DB.global.language.val = _language;
}

#macro lanSize __MBN_MSETTING_DB.global.language.num
function setting_get_language_number() {
	return __MBN_MSETTING_DB.global.language.num;
}

#macro Lan __MBN_MSETTING_DB.global.language.val
function setting_get_language() {
	return __MBN_MSETTING_DB.global.language.val;
}

function setting_group_is_visible(_group) {
	return __MBN_MSETTING_DB[$ _group].show;
}

function setting_item_is_visible(_group, _item) {
	return __MBN_MSETTING_DB[$ _group][$ _item].show;
}

function setting_reset(_group, _item) {
	__MBN_MSETTING_DB[$ _group][$ _item].val = __MBN_MSETTING_DB[$ _group][$ _item].def;
}

function setting_reset_group(_group) {
	var tmp_len2 = __MBN_MSETTING_DB[$ _group].__name_list;
	
	for(var i = 0; i < array_length(tmp_len2); i ++) {
		var _item = tmp_len2[i];
		__MBN_MSETTING_DB[$ _group][$ _item].val = __MBN_MSETTING_DB[$ _group][$ _item].def;
	}
}

function setting_reset_all() {
	var tmp_len1 = __MBN_MSETTING_DB.__name_list;
	
	for(var i = 0; i < array_length(tmp_len1); i ++) {
		var _group = tmp_len1[i];
		var tmp_len2 = __MBN_MSETTING_DB[$ _group].__name_list;
		
		for(var j = 0; j < array_length(tmp_len2); j ++) {
			var _item = tmp_len2[j];
			__MBN_MSETTING_DB[$ _group][$ _item].val = __MBN_MSETTING_DB[$ _group][$ _item].def;
		}
	}
}

