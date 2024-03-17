
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float ufOffset;
uniform float ufScanlineValue;
uniform vec2 uv2Size;

void main()
{
	vec4 v4Color = texture2D( gm_BaseTexture, v_vTexcoord );
	v4Color.rgb *= vec3(mix(1.0, cos(v_vTexcoord.y * uv2Size.y) * 0.5 + 0.5, ufScanlineValue));
	v4Color.rgb *= vec3(
	cos((v_vTexcoord.x * uv2Size.x)			    * 3.1416) * ufOffset + 1.0,
	cos((v_vTexcoord.x * uv2Size.x + 2.0 / 3.0) * 3.1416) * ufOffset + 1.0,
	cos((v_vTexcoord.x * uv2Size.x + 4.0 / 3.0) * 3.1416) * ufOffset + 1.0);
    gl_FragColor = v_vColour * v4Color;
}
