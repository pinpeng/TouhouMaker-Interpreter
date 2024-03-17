///@function script_execute_args(script, args)
///@arg script
///@arg args
function script_execute_args(argument0, argument1) {
	var a = argument1;
	var ret = undefined;
	switch(ds_list_size(a)){
		case 0:
			ret = script_execute(argument0);
			break;
		case 1:
			ret = script_execute(argument0,a[|0]);
			break;
		case 2:
			ret = script_execute(argument0,a[|0],a[|1]);
			break;
		case 3:
			ret = script_execute(argument0,a[|0],a[|1],a[|2]);
			break;
		case 4:
			ret = script_execute(argument0,a[|0],a[|1],a[|2],a[|3]);
			break;
		case 5:
			ret = script_execute(argument0,a[|0],a[|1],a[|2],a[|3],a[|4]);
			break;
		case 6:
			ret = script_execute(argument0,a[|0],a[|1],a[|2],a[|3],a[|4],a[|5]);
			break;
		case 7:
			ret = script_execute(argument0,a[|0],a[|1],a[|2],a[|3],a[|4],a[|5],a[|6]);
			break;
		case 8:
			ret = script_execute(argument0,a[|0],a[|1],a[|2],a[|3],a[|4],a[|5],a[|6],a[|7]);
			break;
		case 9:
			ret = script_execute(argument0,a[|0],a[|1],a[|2],a[|3],a[|4],a[|5],a[|6],a[|7],a[|8]);
			break;
		case 10:
			ret = script_execute(argument0,a[|0],a[|1],a[|2],a[|3],a[|4],a[|5],a[|6],a[|7],a[|8],a[|9]);
			break;
		case 11:
			ret = script_execute(argument0,a[|0],a[|1],a[|2],a[|3],a[|4],a[|5],a[|6],a[|7],a[|8],a[|9],a[|10]);
			break;
		case 12:
			ret = script_execute(argument0,a[|0],a[|1],a[|2],a[|3],a[|4],a[|5],a[|6],a[|7],a[|8],a[|9],a[|10],a[|11]);
			break;
		case 13:
			ret = script_execute(argument0,a[|0],a[|1],a[|2],a[|3],a[|4],a[|5],a[|6],a[|7],a[|8],a[|9],a[|10],a[|11],a[|12]);
			break;
		case 14:
			ret = script_execute(argument0,a[|0],a[|1],a[|2],a[|3],a[|4],a[|5],a[|6],a[|7],a[|8],a[|9],a[|10],a[|11],a[|12],a[|13]);
			break;
		case 15:
			ret = script_execute(argument0,a[|0],a[|1],a[|2],a[|3],a[|4],a[|5],a[|6],a[|7],a[|8],a[|9],a[|10],a[|11],a[|12],a[|13],a[|14]);
			break;
		case 16:
			ret = script_execute(argument0,a[|0],a[|1],a[|2],a[|3],a[|4],a[|5],a[|6],a[|7],a[|8],a[|9],a[|10],a[|11],a[|12],a[|13],a[|14],a[|15]);
			break;
		default:
			//show_error("Argument count not supported!",true);
			__execute_print_string += "\nexecute string: " +
			"Argument count not supported!";
			break;
	}

	return ret;
}
