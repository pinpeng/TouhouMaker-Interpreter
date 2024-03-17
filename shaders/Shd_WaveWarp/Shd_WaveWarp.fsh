
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float ufValue;
uniform float ufOffset;
uniform float ufHeight;

void main()
{
	vec2 v2Coord = v_vTexcoord;
	v2Coord.x += cos(v_vTexcoord.y * ufHeight + ufOffset) * ufValue;
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v2Coord );
}
