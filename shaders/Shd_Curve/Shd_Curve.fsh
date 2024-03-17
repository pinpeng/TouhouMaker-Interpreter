
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float ufOffset;

void main()
{
	vec2 v2Coord = v_vTexcoord;
	float fXEdge = abs(0.5 - v_vTexcoord.x) * ufOffset;
	float fYEdge = abs(0.5 - v_vTexcoord.y) * ufOffset;
	
	v2Coord.x = mix(v2Coord.x, 0.5, fXEdge * fYEdge * fYEdge);
	v2Coord.y = mix(v2Coord.y, 0.5, fYEdge * fXEdge * fXEdge);
	
	float fOverRange =
	max(0.0, abs(v2Coord.x - 0.5) - 0.5) * 256.0 +
	max(0.0, abs(v2Coord.y - 0.5) - 0.5) * 256.0;
	
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v2Coord );
	gl_FragColor.a *= 1.0 - clamp(fOverRange, 0.0, 1.0);
}