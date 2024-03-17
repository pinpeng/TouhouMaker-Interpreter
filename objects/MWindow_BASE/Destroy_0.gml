/// @description Insert description here
// You can write your code in this editor

__mTrigger_destroy();

for(var i = 0; i < ds_list_size(_widget_list); i ++) {
	instance_destroy(_widget_list[|i][0]);
}
ds_list_destroy(_widget_list);


