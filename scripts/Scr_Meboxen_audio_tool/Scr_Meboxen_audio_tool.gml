

function se_play(_se, _gain = 1, _pitch = 1) {
	return audio_play_sound(_se, 10, 0, setting_get("audio", "volume_se") / 100 * _gain, 0, _pitch);
}

function voice_play(_voice) {
	return audio_play_sound(_voice, 10, 0, setting_get("audio", "volume_voice") / 100);
}

function bgm_set_delay(_delay = 60) {
	__MBN_AUDIO_BGM_CHANGE_DELAY = _delay;
}

function bgm_get_delay() {
	return __MBN_AUDIO_BGM_CHANGE_DELAY;
}

function bgm_set_gain(_channel, _gain = 1) {
	__MBN_AUDIO_BGM_STATE[_channel][0] = _gain;
}

function bgm_set_gain_all(_gain = 1) {
	for(var i = 0; i < __MBN_AUDIO_CHANNAL_SIZE; i ++) {
		__MBN_AUDIO_BGM_STATE[i][0] = _gain;
	}
}

function bgm_get_gain(_channel = 0) {
	return __MBN_AUDIO_BGM_STATE[_channel][0];
}

function bgm_get_state(_channel = 0) {
	return __MBN_AUDIO_BGM_STATE[_channel][1];
}

function bgm_get_time(_channel = 0) {
	if(__MBN_AUDIO_BGM_STATE[_channel][1] = AUDIO_STATE.DISABLE) return 0;
	var _tmp_size = ds_list_size(__MBN_AUDIO_BGM_LIST[_channel]);
	
	if(_tmp_size == 0) {
		return 0;
	} else if(_tmp_size == 1) {
		var _tmp = __MBN_AUDIO_BGM_LIST[_channel][|0];
		if(_tmp[2] != -4 && audio_exists(_tmp[2]) && audio_is_playing(_tmp[2])) {
			 return audio_sound_get_track_position(_tmp[2]);
		}
	} else {
		var _tmp = __MBN_AUDIO_BGM_LIST[_channel][|1];
		if(_tmp[2] != -4 && audio_exists(_tmp[2]) && audio_is_playing(_tmp[2])) {
			 return audio_sound_get_track_position(_tmp[2]);
		} else {
			_tmp = __MBN_AUDIO_BGM_LIST[_channel][|0];
			if(_tmp[2] != -4 && audio_exists(_tmp[2]) && audio_is_playing(_tmp[2])) {
				return audio_sound_get_track_position(_tmp[2]);
			}
		}
	}
	return 0;
}

function bgm_play(_bgm, _channel = 0) {
	if(__MBN_AUDIO_BGM_STATE[_channel][1] = AUDIO_STATE.DISABLE) return;
	__MBN_AUDIO_BGM_STATE[_channel][1] = AUDIO_STATE.ACTIVE;
	var _tmp_size = ds_list_size(__MBN_AUDIO_BGM_LIST[_channel]);
	
	if(_tmp_size == 0) {
		ds_list_add(__MBN_AUDIO_BGM_LIST[_channel], [_bgm, 0, -4]);
	} else if(_tmp_size == 1) {
		if(__MBN_AUDIO_BGM_LIST[_channel][|0][0] != _bgm) {
			ds_list_add(__MBN_AUDIO_BGM_LIST[_channel], [_bgm, 0, -4]);
		}
	} else if(_tmp_size >= 2) {
		if(__MBN_AUDIO_BGM_LIST[_channel][|0][0] == _bgm) {
			var _tmp = __MBN_AUDIO_BGM_LIST[_channel][|0];
			__MBN_AUDIO_BGM_LIST[_channel][|0] = __MBN_AUDIO_BGM_LIST[_channel][|1];
			__MBN_AUDIO_BGM_LIST[_channel][|1] = _tmp;
			while(ds_list_size(__MBN_AUDIO_BGM_LIST[_channel]) > 2) {
				ds_list_delete(__MBN_AUDIO_BGM_LIST[_channel], 2);
			}
		} else if(__MBN_AUDIO_BGM_LIST[_channel][|1][0] == _bgm) {
			while(ds_list_size(__MBN_AUDIO_BGM_LIST[_channel]) > 2) {
				ds_list_delete(__MBN_AUDIO_BGM_LIST[_channel], 2);
			}
		} else {
			if(_tmp_size == 2) {
				ds_list_add(__MBN_AUDIO_BGM_LIST[_channel], [_bgm, 0, -4]);
			} else {
				var _flag = false;
				var i;
				for(i = 2; i < _tmp_size; i ++) {
					if(__MBN_AUDIO_BGM_LIST[_channel][|i][0] == _bgm) { _flag = true; break; }
				}
				if(_flag) {
					repeat(i - 2) {
						ds_list_delete(__MBN_AUDIO_BGM_LIST[_channel], 2);
					}
					while(ds_list_size(__MBN_AUDIO_BGM_LIST[_channel]) > 3) {
						ds_list_delete(__MBN_AUDIO_BGM_LIST[_channel], 3);
					}
				} else {
					ds_list_add(__MBN_AUDIO_BGM_LIST[_channel], [_bgm, 0, -4]);
				}
			}
		}
	} // _tmp_size >= 2
}

function bgm_pause(_channel = 0) {
	__MBN_AUDIO_BGM_STATE[_channel][1] = AUDIO_STATE.PAUSE;
}

function bgm_pause_all() {
	for(var i = 0; i < 4; i ++) {
		__MBN_AUDIO_BGM_STATE[i][1] = AUDIO_STATE.PAUSE;
	}
}

function bgm_resume(_channel = 0) {
	__MBN_AUDIO_BGM_STATE[_channel][1] = AUDIO_STATE.ACTIVE;
}

function bgm_resume_all() {
	for(var i = 0; i < __MBN_AUDIO_CHANNAL_SIZE; i ++) {
		__MBN_AUDIO_BGM_STATE[i][1] = AUDIO_STATE.ACTIVE;
	}
}

function bgm_stop(_channel = 0) {
	while(ds_list_size(__MBN_AUDIO_BGM_LIST[_channel])) {
		var _tmp = __MBN_AUDIO_BGM_LIST[_channel][|0];
		if(_tmp[2] != -4 && audio_exists(_tmp[2])) audio_stop_sound(_tmp[2]);
		ds_list_delete(__MBN_AUDIO_BGM_LIST[_channel], 0);
	}
}

function bgm_stop_all() {
	for(var i = 0; i < __MBN_AUDIO_CHANNAL_SIZE; i ++) {
		while(ds_list_size(__MBN_AUDIO_BGM_LIST[i])) {
			var _tmp = __MBN_AUDIO_BGM_LIST[i][|0];
			if(_tmp[2] != -4 && audio_exists(_tmp[2])) audio_stop_sound(_tmp[2]);
			ds_list_delete(__MBN_AUDIO_BGM_LIST[i], 0);
		}
	}
}

function bgm_disable(_channel = 0) {
	__MBN_AUDIO_BGM_STATE[_channel][1] = AUDIO_STATE.DISABLE;
}

function bgm_disable_all() {
	for(var i = 0; i < __MBN_AUDIO_CHANNAL_SIZE; i ++) {
		__MBN_AUDIO_BGM_STATE[i][1] = AUDIO_STATE.DISABLE;
	}
}


