/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

press_id = -1;

press = function(_father) {
	emit("pressed", [press_id]);
}

