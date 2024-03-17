
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 uv2Size;

void main()
{
	vec2 v2Coord = v_vTexcoord;
	v2Coord = floor(v2Coord * uv2Size) / uv2Size;
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v2Coord );
}
