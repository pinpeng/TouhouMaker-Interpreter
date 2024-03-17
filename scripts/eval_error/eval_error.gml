///@function eval_error
///@arg type
function eval_error(argument0) {
	//show_error(argument0 + " at token position: " + string(position), false);
	if(!__execute_print_string_lite) {
		__execute_print_string += "\nexecute string: " +
		string(argument0) + " at token position: " + string(__execute_string_position);
	}
}
