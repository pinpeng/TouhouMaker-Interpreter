

enum THMK_STATE {
	PRE,
	PLAYING,
	PLAYING_PRE,
	DIE,
	PAUSE,
	END
}

globalvar 
__THMK_DATABASE,
__THMK_BULLET_BUFFER,
__THMK_DEBUG,
__THMK_DEBUG_PATH,
__THMK_DEBUG_INIT,

__THMK_HERO_HURT,
__THMK_HERO_HP,
__THMK_HERO_MP;

__THMK_BULLET_BUFFER = ds_list_create();
__THMK_DEBUG = 1;
__THMK_DEBUG_PATH = "";
__THMK_DEBUG_INIT = [0, 0, 0, 0];

__THMK_HERO_HURT = 0;

globalvar 
__THMK_STATE,
__THMK_GROUP, // 0 for normal, 1 for ex
__THMK_STAGE,
__THMK_TIMER;

function __thmk_init() {

	if(directory_exists(temp_directory + "audio/"))			directory_destroy(temp_directory + "audio/");
	if(directory_exists(temp_directory + "bullet/"))		directory_destroy(temp_directory + "bullet/");
	if(directory_exists(temp_directory + "character/"))		directory_destroy(temp_directory + "character/");
	if(directory_exists(temp_directory + "effect/"))		directory_destroy(temp_directory + "effect/");
	if(directory_exists(temp_directory + "image/"))			directory_destroy(temp_directory + "image/");
	if(directory_exists(temp_directory + "main/"))			directory_destroy(temp_directory + "main/");
	
	__THMK_DATABASE = { inited : 1, code : ds_map_create(), code_num : 0 };
}

function __thmk_unzip_all() {
	var str = "";
	if(__THMK_DEBUG) str = __THMK_DEBUG_PATH + "/";
	if(!file_exists(str + "audio.thmk")) return 1;
	if(!zip_unzip(str + "audio.thmk", temp_directory + "audio/")) return 1;
	
	if(!file_exists(str + "bullet.thmk")) return 1;
	if(!zip_unzip(str + "bullet.thmk", temp_directory + "bullet/")) return 1;
	
	if(!file_exists(str + "character.thmk")) return 1;
	if(!zip_unzip(str + "character.thmk", temp_directory + "character/")) return 1;
	
	if(!file_exists(str + "effect.thmk")) return 1;
	if(!zip_unzip(str + "effect.thmk", temp_directory + "effect/")) return 1;
	
	if(!file_exists(str + "image.thmk")) return 1;
	if(!zip_unzip(str + "image.thmk", temp_directory + "image/")) return 1;
	
	if(!file_exists(str + "main.thmk")) return 1;
	if(!zip_unzip(str + "main.thmk", temp_directory + "main/")) return 1;
	
	return 0;
}

function __thmk_read_all() {
	
	if(__thmk_unzip_all()) {
		show_message("THMK: Cannot unzip files.");
		game_end();
		return;
	}
	
	if(__thmk_read_text()) {
		show_message("Cannot read text files.");
		game_end();
		return;
	}
	
	if(__thmk_read_image_index()) {
		show_message("Cannot read image index.");
		game_end();
		return;
	}
	for(var i = 0; i < array_length(__THMK_DATABASE.arr_image); i ++) {
		if(__thmk_read_image(i)) {
			show_message("Cannot read image files.");
			game_end();
			return;
		}
	}
	
	if(__thmk_read_audio_index()) {
		show_message("Cannot read audio index.");
		game_end();
		return;
	}
	for(var i = 0; i < array_length(__THMK_DATABASE.arr_audio); i ++) {
		if(__thmk_read_audio(i)) {
			show_message("Cannot read audio files.");
			game_end();
			return;
		}
	}
	
	if(__thmk_read_effect_index()) {
		show_message("Cannot read effect index.");
		game_end();
		return;
	}
	for(var i = 0; i < array_length(__THMK_DATABASE.arr_effect); i ++) {
		if(__thmk_read_effect(i)) {
			show_message("Cannot read effect files.");
			game_end();
		}
	}
	
	if(__thmk_read_bullet_index()) {
		show_message("Cannot read bullet index.");
		game_end();
		return;
	}
	for(var i = 0; i < array_length(__THMK_DATABASE.arr_bullet); i ++) {
		if(__thmk_read_bullet(i)) {
			show_message("Cannot read bullet files.");
			game_end();
			return;
		}
	}
	
	if(__thmk_read_hero_index()) {
		show_message("Cannot read hero index.");
		game_end();
		return;
	}
	for(var i = 0; i < array_length(__THMK_DATABASE.arr_hero); i ++) {
		if(__thmk_read_hero(i)) {
			show_message("Cannot read hero files.");
			game_end();
			return;
		}
	}
	
	if(__thmk_read_enemy_index()) {
		show_message("Cannot read enemy index.");
		game_end();
		return;
	}
	for(var i = 0; i < array_length(__THMK_DATABASE.arr_enemy); i ++) {
		if(__thmk_read_enemy(i)) {
			show_message("Cannot read enemy files.");
			game_end();
			return;
		}
	}
	
	if(__thmk_read_boss_index()) {
		show_message("Cannot read boss index.");
		game_end();
		return;
	}
	for(var i = 0; i < array_length(__THMK_DATABASE.arr_boss); i ++) {
		if(__thmk_read_boss(i)) {
			show_message("Cannot read boss files.");
			game_end();
			return;
		}
	}
	
	if(__thmk_read_main_index()) {
		show_message("Cannot read stage index.");
		game_end();
		return;
	}
	for(var i = 0; i < array_length(__THMK_DATABASE.arr_event); i ++) {
		if(__thmk_read_main_event(i)) {
			show_message("Cannot read event files.");
			game_end();
			return;
		}
	}
	
}
 