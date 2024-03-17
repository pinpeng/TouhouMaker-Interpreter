var mx = mouse_x,
	my = mouse_y,
	dw = draw.dw,
	dh = draw.dh,
	sx = draw.sx,
	sy = draw.sy,
	sw = curt.mu ? draw.sw : 0,
	vi = point_in_rectangle(mx, my, sx, sy, sx + dw - sw, sy + dh);

if (vi != curt.vi) {
	window_set_cursor(vi ? cr_beam : cr_default);
	curt.vi = vi;
}

var dc = draw.dc - 1;
if (dc < -30) {
	dc = 30;
	draw.re = true;
} else if (dc == 0) {
	draw.re = true;
}

draw.dc = dc;

#region update cursor (with mouse)
	
	if (mouse_check_button_pressed(keys.ml)) {
		
		curt.fo = vi;
		curt.se = -1;
		draw.dc = vi ? 30 : 0;
		draw.re = true;
		
		if (vi) {
			keyboard_string = "";
			textbox_check_minput(keyboard_check(keys.sh));
			curt.br = 5;
		} else {
			var th = curt.ls * draw.lh;
			if (th > dh) {
				var rb = sx + dw;
				if (!point_in_rectangle(mx, my, rb - sw, sy, rb, sy + dh)) return;
				var dy = draw.dy,
					sh = draw.sh,
					ty = sy + dy;
				if (my >= ty && my <= ty + sh) {
					draw.my = mouse_y;
				} else {
					var ch = dh - sh;
					dy = my - sy;
					if (dy < sh) dy = 0;
					else if (dy > ch) dy = ch;
					draw.oy = dy / ch * (th - dh);
					draw.my = my;
					draw.re = true;
				}
			}
			return;
		}
		return;
	}
	
	if (draw.my > 0) {
		if (mouse_check_button_released(keys.ml)) draw.my = 0;
		else if (mouse_check_button(keys.ml)) {
			curt.br --;
			if (curt.br < 0) {
				var dy = draw.dy,
					ch = dh - draw.sh;
				dy = clamp(dy + my - draw.my, 0, ch);
				draw.oy = dy / ch * (curt.ls * draw.lh - dh);
				draw.my = my;
				draw.re = true;
				curt.br = 1;
			}
		}
	}

#endregion

#region update offset (with mouse)

	if (vi) {
	
		var mc = mouse_wheel_up() - mouse_wheel_down();
		if (mc != 0) {
			if (curt.mu) {
				// Update y-offset.
				var lh = draw.lh,
					oy = draw.oy - lh * mc,
					mh = curt.ls * lh - dh;
				if (mh < 0) oy = 0;
				else oy = clamp(oy, 0, mh);
				draw.oy = oy;
			} else {
				// Update x-offset.
				draw_set_font(draw.ft);
				var ox = draw.ox - draw.lh * mc,
					mw = string_width(curt.li[0]) - dw;
				if (mw < 0) ox = 0;
				else ox = clamp(ox, 0, mw);
				draw.ox = ox;
			}
			draw.re = true;
			return;
		}

	}

#endregion

if (!curt.fo) return;

#region get string
	
	var ks = keyboard_string;
	if (ks != "") {
		textbox_insert_string(ks);
		keyboard_string = "";
		return;
	}
	
#endregion
	
#region update mouse selector
	
	if (mouse_check_button(keys.ml)) {
		curt.br --;
		if (curt.br < 0) {
			textbox_check_minput(true);
			curt.br = 3;
		}
		return;
	}
	
#endregion

#region execute
	
	if (keyboard_check_pressed(keys.es) || curt.nw && keyboard_check_pressed(keys.en)) {
		var tx = lines_to_text(curt.li);
		if (curt.aw) tx = textbox_close_lines(tx, 0);
		curt.fn(tx);
		return;
	}

#endregion
	
#region break line
	
	if (keyboard_check_pressed(keys.en)) {
		curt.se = -1;
		textbox_break_line();
		return;
	}
	
#endregion
	
#region update cursor
			
	var hc = keyboard_check_pressed(keys.ri) - keyboard_check_pressed(keys.le);
	if (hc != 0) {
		curt.br = 40;
		textbox_update_cursor(hc, keyboard_check(keys.sh), false);
	}
		
	var ph = keyboard_check(keys.ri) - keyboard_check(keys.le);
	if (ph != 0) {
		curt.br --;
		if (curt.br < 0) {
			textbox_update_cursor(ph, keyboard_check(keys.sh), false);
			curt.br = 3;
		}
		return;
	}
		
	if (curt.mu) {

		var vc = keyboard_check_pressed(keys.dw) - keyboard_check_pressed(keys.up);
		if (vc != 0) {
			curt.br = 40;
			textbox_update_cursor(vc, keyboard_check(keys.sh), true);
		}
		
		var pv = keyboard_check(keys.dw) - keyboard_check(keys.up);
		if (pv != 0) {
			curt.br --;
			if (curt.br < 0) {
				textbox_update_cursor(pv, keyboard_check(keys.sh), true);
				curt.br = 3;
			}
			return;
		}
		
	}
	
#endregion

#region delete string
	
	var de = keyboard_check_pressed(keys.de);
	if (keyboard_check_pressed(keys.bs) || de) {
		curt.br = 40;
		textbox_delete_string(de);
	}
	
	var pe = keyboard_check(keys.de);
	if (keyboard_check(keys.bs) || pe) {
		curt.br --;
		if (curt.br < 0) {
			textbox_delete_string(pe);
			curt.br = 3;
		}
		return;
	}

#endregion
	
#region edit string
	
	if (keyboard_check(keys.ct)) {

		// Select all string.
		if (keyboard_check_pressed(keys.na)) {
			var ls = curt.ls - 1,
				le = string_length(curt.li[ls]);
			if (ls < 1 && le < 1) return;
			curt.sl = 0;
			curt.se = 0;
			curt.cl = ls;
			curt.cu = le;
			textbox_refresh_surface();
			return;
		}
			
		// Copy string.
		if (keyboard_check_pressed(keys.nc)) {
			textbox_copy_string();
			return;
		}
			
		// Cut string.
		if (keyboard_check_pressed(keys.nx)) {
			textbox_copy_string();
			textbox_delete_string(false);
			return;
		}

		// Paste string.
		if (keyboard_check_pressed(keys.nv)) {
			var cl = clipboard_has_text() ? clipboard_get_text() : global.clipboard;
			if (cl != "") textbox_insert_string(cl);
			return;
		}
			
		// Undo.
		if (keyboard_check_pressed(keys.nz)) {
			textbox_records_set(-1);
			return;
		}
			
		// Redo.
		if (keyboard_check_pressed(keys.ny)) {
			textbox_records_set(1);
			return;
		}
			
	}
	
#endregion
	
#region others
	
	// Go to the beginning.
	if (keyboard_check_pressed(keys.ho)) {
		if (keyboard_check(keys.sh)) {
			curt.sl = curt.cl;
			curt.se = curt.cu;
		} else curt.se = -1;
		if (keyboard_check(keys.ct)) curt.cl = 0;
		curt.cu = 0;
		textbox_refresh_surface();
		return;
	}
			
	// Go to the end.
	if (keyboard_check_pressed(keys.ed)) {
		if (keyboard_check(keys.sh)) {
			curt.sl = curt.cl;
			curt.se = curt.cu;
		} else curt.se = -1;
		if (keyboard_check(keys.ct)) curt.cl = curt.ls - 1;
		curt.cu = string_length(curt.li[curt.cl]);
		textbox_refresh_surface();
		return;
	}
	
#endregion