
function draw_vertex_triangle_pt(_vbuff,
_x1, _y1, _u1, _v1,
_x2, _y2, _u2, _v2,
_x3, _y3, _u3, _v3) {
	vertex_position(_vbuff, _x1, _y1);
	vertex_texcoord(_vbuff, _u1, _v1);
	vertex_position(_vbuff, _x2, _y2);
	vertex_texcoord(_vbuff, _u2, _v2);
	vertex_position(_vbuff, _x3, _y3);
	vertex_texcoord(_vbuff, _u3, _v3);
}

function draw_vertex_triangle_pc(_vbuff, _col, _alpha,
_x1, _y1,
_x2, _y2,
_x3, _y3) {
	vertex_position(_vbuff, _x1, _y1);
	vertex_color(_vbuff, _col, _alpha);
	vertex_position(_vbuff, _x2, _y2);
	vertex_color(_vbuff, _col, _alpha);
	vertex_position(_vbuff, _x3, _y3);
	vertex_color(_vbuff, _col, _alpha);
}

function draw_vertex_line_pc(_vbuff, _col, _alpha,
_x1, _y1, _x2, _y2) {
	vertex_position(_vbuff, _x1, _y1);
	vertex_color(_vbuff, _col, _alpha);
	vertex_position(_vbuff, _x2, _y2);
	vertex_color(_vbuff, _col, _alpha);
}

function draw_vertex_triangle_pc_ext(_vbuff,
_x1, _y1, _c1, _a1,
_x2, _y2, _c2, _a2,
_x3, _y3, _c3, _a3) {
	vertex_position(_vbuff, _x1, _y1);
	vertex_color(_vbuff, _c1, _a1);
	vertex_position(_vbuff, _x2, _y2);
	vertex_color(_vbuff, _c2, _a2);
	vertex_position(_vbuff, _x3, _y3);
	vertex_color(_vbuff, _c3, _a3);
}

function draw_vertex_line_pc_ext(_vbuff,
_x1, _y1, _c1, _a1,
_x2, _y2, _c2, _a2) {
	vertex_position(_vbuff, _x1, _y1);
	vertex_color(_vbuff, _c1, _a1);
	vertex_position(_vbuff, _x2, _y2);
	vertex_color(_vbuff, _c2, _a2);
}

function draw_vertex_triangle_pct(_vbuff, _col, _alpha,
_x1, _y1, _u1, _v1,
_x2, _y2, _u2, _v2,
_x3, _y3, _u3, _v3) {
	vertex_position(_vbuff, _x1, _y1);
	vertex_color(_vbuff, _col, _alpha);
	vertex_texcoord(_vbuff, _u1, _v1);
	vertex_position(_vbuff, _x2, _y2);
	vertex_color(_vbuff, _col, _alpha);
	vertex_texcoord(_vbuff, _u1, _v1);
	vertex_position(_vbuff, _x3, _y3);
	vertex_color(_vbuff, _col, _alpha);
	vertex_texcoord(_vbuff, _u1, _v1);
}

function draw_vertex_submit_pc(_vbuff, _texture = Texture_black64, _image = 0) {
	shader_set(Shd_DrawVertexColor);
	vertex_submit(_vbuff, pr_trianglelist, sprite_get_texture(_texture, _image));
	shader_reset();
}

function draw_vertex_submit_pt(_vbuff, _texture = Texture_black64, _image = 0) {
	shader_set(Shd_DrawVertexTexture);
	vertex_submit(_vbuff, pr_trianglelist, sprite_get_texture(_texture, _image));
	shader_reset();
}

function draw_vertex_submit_pct(_vbuff, _texture = Texture_black64, _image = 0) {
	shader_set(Shd_Simple);
	vertex_submit(_vbuff, pr_trianglelist, sprite_get_texture(_texture, _image));
	shader_reset();
}





