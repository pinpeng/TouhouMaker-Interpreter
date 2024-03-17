
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float ufScanlineValue;
uniform float ufHeight;

void main()
{
	vec4 v4Color = texture2D( gm_BaseTexture, v_vTexcoord );
	v4Color.rgb *= vec3(mix(1.0, cos(v_vTexcoord.y * ufHeight) * 0.5 + 0.5, ufScanlineValue));
    gl_FragColor = v_vColour * v4Color;
}
