
enum AUDIO_STATE {
	ACTIVE,
	PAUSE,
	DISABLE
}

#macro __MBN_AUDIO_CHANNAL_SIZE 4

globalvar __MBN_AUDIO_BGM_LIST, __MBN_AUDIO_BGM_STATE;

globalvar __MBN_AUDIO_BGM_CHANGE_DELAY;
__MBN_AUDIO_BGM_CHANGE_DELAY = 60;

function __mAudio_init() {
	__MBN_AUDIO_BGM_LIST = array_create(__MBN_AUDIO_CHANNAL_SIZE);
	__MBN_AUDIO_BGM_STATE = array_create(__MBN_AUDIO_CHANNAL_SIZE);
	var tmp = setting_get("audio", "volume_bgm") / 100;
	for(var i = 0; i < __MBN_AUDIO_CHANNAL_SIZE; i ++) {
		__MBN_AUDIO_BGM_LIST[i] = ds_list_create();
		__MBN_AUDIO_BGM_STATE[i] = [tmp, AUDIO_STATE.ACTIVE];
	}
}

function __mAudio_step() {
	
	var _gain = setting_get("audio", "volume_bgm") / 100;
	
	for(var i = 0; i < __MBN_AUDIO_CHANNAL_SIZE; i ++) {
		var _state = __MBN_AUDIO_BGM_STATE[i][1];
		var _tmp_size = ds_list_size(__MBN_AUDIO_BGM_LIST[i]);
		if(!_tmp_size) continue;
		
		switch(_state) {
			case AUDIO_STATE.ACTIVE:
			if(_tmp_size >= 2) {
				var _tmp0 = __MBN_AUDIO_BGM_LIST[i][|0];
				var _tmp1 = __MBN_AUDIO_BGM_LIST[i][|1];
				
				if(_tmp0[2] == -4 || !audio_exists(_tmp0[2])) {
					__MBN_AUDIO_BGM_LIST[i][|0][2] = audio_play_sound(_tmp0[0], 10, 1, 0);
				}
				if(audio_is_paused(__MBN_AUDIO_BGM_LIST[i][|0][2])) {
					audio_resume_sound(__MBN_AUDIO_BGM_LIST[i][|0][2]);
				}
				if(_tmp1[2] == -4 || !audio_exists(_tmp1[2])) {
					__MBN_AUDIO_BGM_LIST[i][|1][2] = audio_play_sound(_tmp1[0], 10, 1, 0);
				}
				if(audio_is_paused(__MBN_AUDIO_BGM_LIST[i][|1][2])) {
					audio_resume_sound(__MBN_AUDIO_BGM_LIST[i][|1][2]);
				}
				
				__MBN_AUDIO_BGM_LIST[i][|0][1] = max(_tmp0[1] - 1, 0);
				__MBN_AUDIO_BGM_LIST[i][|1][1] = min(_tmp1[1] + 1, __MBN_AUDIO_BGM_CHANGE_DELAY);
				
				audio_sound_gain(__MBN_AUDIO_BGM_LIST[i][|0][2],
				__MBN_AUDIO_BGM_LIST[i][|0][1] / __MBN_AUDIO_BGM_CHANGE_DELAY * _gain, 0);
				audio_sound_gain(__MBN_AUDIO_BGM_LIST[i][|1][2],
				__MBN_AUDIO_BGM_LIST[i][|1][1] / __MBN_AUDIO_BGM_CHANGE_DELAY * _gain, 0);
				
				if(__MBN_AUDIO_BGM_LIST[i][|0][1] <= 0) {
					audio_stop_sound(__MBN_AUDIO_BGM_LIST[i][|0][2]);
					ds_list_delete(__MBN_AUDIO_BGM_LIST[i], 0);
				}
				
			} else {
				var _tmp = __MBN_AUDIO_BGM_LIST[i][|0];
				
				if(_tmp[2] == -4 || !audio_exists(_tmp[2])) {
					__MBN_AUDIO_BGM_LIST[i][|0][2] = audio_play_sound(_tmp[0], 10, 1, 0);
				}
				if(audio_is_paused(__MBN_AUDIO_BGM_LIST[i][|0][2])) {
					audio_resume_sound(__MBN_AUDIO_BGM_LIST[i][|0][2]);
				}
				
				__MBN_AUDIO_BGM_LIST[i][|0][1] = min(_tmp[1] + 1, __MBN_AUDIO_BGM_CHANGE_DELAY);
				audio_sound_gain(__MBN_AUDIO_BGM_LIST[i][|0][2],
				__MBN_AUDIO_BGM_LIST[i][|0][1] / __MBN_AUDIO_BGM_CHANGE_DELAY * _gain, 0);
			}
			break;
			
			case AUDIO_STATE.PAUSE:
			for(var j = 0; j < _tmp_size; j ++) {
				var _tmp = __MBN_AUDIO_BGM_LIST[i][|j];
				if(_tmp[2] == -4 || !audio_exists(_tmp[2])) continue;
				if(!audio_is_paused(_tmp[2])) audio_pause_sound(_tmp[2]);
			}
			break;
			
			case AUDIO_STATE.DISABLE:
			default:
			while(ds_list_size(__MBN_AUDIO_BGM_LIST[i])) {
				var _tmp = __MBN_AUDIO_BGM_LIST[i][|0];
				if(_tmp[2] != -4 && audio_exists(_tmp[2])) audio_stop_sound(_tmp[2]);
				ds_list_delete(__MBN_AUDIO_BGM_LIST[i], 0);
			}
			break;
		}
		
	} // for end
}


