///@function interp_create(string)
///@arg string
function interp_create(argument0) {

	enum Interp {
		POSITION = 0,
		TEXT = 1,
		CURRENT_CHAR = 2,
		CURRENT_TOKEN = 3,
		TOKENS = 4
	}
	var interp = array_create(5);
	var tokens = ds_list_create();
	interp[Interp.POSITION] = 0;
	interp[Interp.TEXT] = argument0;
	interp[Interp.CURRENT_CHAR] = "";
	interp[Interp.CURRENT_TOKEN] = -1;

	interp_advance(interp);
	do {
		ds_list_add(tokens, interp_get_next_token(interp));
	} until(token_get_type(interp_get_current_token(interp)) == TokenType.EOF);
	
	var ret = ds_list_to_array(tokens);
	ds_list_destroy(tokens);
	return ret;


}
