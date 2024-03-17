/// @description Insert description here
// You can write your code in this editor

__thmk_init();

if(__THMK_DEBUG) {
	__thmk_read_all();
} else {
	__thmk_read_all();
}

if(__THMK_DEBUG) {
	if(__THMK_DEBUG_INIT[0] != -123) {
		__THMK_GROUP = __THMK_DEBUG_INIT[0] - 1;
		__THMK_STAGE = __THMK_DEBUG_INIT[1];
		__THMK_TIMER = __THMK_DEBUG_INIT[2];
	} else {
		__THMK_GROUP = 0;
		__THMK_STAGE = 0;
		__THMK_TIMER = 0;
	}
	__THMK_HERO_HP = 1;
	__THMK_HERO_MP = 1;
	__THMK_STATE = THMK_STATE.PRE;
	room_goto(Room_thmk_game);

	__THMK_STATE = THMK_STATE.PRE;
} else {
	room_goto(Room_thmk_menu);

	__THMK_STATE = THMK_STATE.PRE;
}



