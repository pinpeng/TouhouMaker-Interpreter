
// copy from Gatete Mario Engine 9
function key_ord_to_string(_key) {

	switch (_key) {
    
	    //Backspace
	    case (8): return "backspace";
    
	    //Tab
	    case (9): return "tab";
    
	    //Numpad middle
	    case (12): return "numpad middle";
    
	    //Enter
	    case (13): return "enter";
    
	    //Shift
	    case (16): return "shift";
    
	    //Control
	    case (17): return "control";

	    //Alt
	    case (18): return "alt";
    
	    //Pause
	    case (19): return "pause";
    
	    //Caps Lock
	    case (20): return "caps lock";
    
	    //Escape
	    case (27): return "escape";

	    //Space
	    case (32): return "space";
    
	    //Page Up
	    case (33): return "page up";
    
	    //Page Down
	    case (34): return "page down";
    
	    //End
	    case (35): return "end";
    
	    //Home
	    case (36): return "home";
    
	    //Left
	    case (37): return "left";
    
	    //Up
	    case (38): return "up";
    
	    //Right 
	    case (39): return "right";
    
	    //Down
	    case (40): return "down";
    
	    //Print Screen
	    case (44): return "print screen";
    
	    //Insert
	    case (45): return "insert";
    
	    //Delete
	    case (46): return "delete";

	    //Left Windows
	    case (91): return "left windows";

	    //Right Windows
	    case (92): return "right windows";
    
	    //Menu
	    case (93): return "menu";
    
	    //Numpad 0
	    case (96): return "numpad 0";

	    //Numpad 1
	    case (97): return "numpad 1";
    
	    //Numpad 2
	    case (98): return "numpad 2";
    
	    //Numpad 3
	    case (99): return "numpad 3";
    
	    //Numpad 4
	    case (100): return "numpad 4";
    
	    //Numpad 5
	    case (101): return "numpad 5";
    
	    //Numpad 6
	    case (102): return "numpad 6";

	    //Numpad 7
	    case (103): return "numpad 7";
    
	    //Numpad 8
	    case (104): return "numpad 8";
    
	    //Numpad 9
	    case (105): return "numpad 9";
    
	    //Numpad *
	    case (106): return "numpad *";

	    //Numpad +
	    case (107): return "numpad +";

	    //Numpad -
	    case (109): return "numpad -";
    
	    //Numpad .
	    case (110): return "numpad .";
   
	    //Numpad /
	    case (111): return "numpad /";
    
	    //F1
	    case (112): return "F1";
    
	    //F2
	    case (113): return "F2";
    
	    //F3
	    case (114): return "F3";
    
	    //F4
	    case (115): return "F4";
    
	    //F5
	    case (116): return "F5";
    
	    //F6
	    case (117): return "F6";
    
	    //F7
	    case (118): return "F7";
    
	    //F8
	    case (119): return "F8";
    
	    //F9
	    case (120): return "F9";
    
	    //F10
	    case (121): return "F10";
    
	    //F11
	    case (122): return "F11";
    
	    //F12
	    case (123): return "F12";

	    //Num lock
	    case (144): return "num lock";
    
	    //Scroll lock
	    case (145): return "scroll lock";

	    //Any key
	    default: return chr(_key);
	}
}

