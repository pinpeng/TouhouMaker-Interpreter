///@function interp_discard_whitespace(interp)
///@arg interp
function interp_discard_whitespace(_interp) {
	while(is_whitespace(interp_get_current_char(_interp))){
		interp_advance(_interp);
	}


}
