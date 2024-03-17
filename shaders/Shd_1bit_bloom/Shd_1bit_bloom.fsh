//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    vec4 v4Color = texture2D( gm_BaseTexture, v_vTexcoord );
	float fBrightness = v4Color.r * 0.299 + v4Color.g * 0.587 + v4Color.b * 0.114;
	v4Color.rgb = vec3(fBrightness);
	float fBright = 1.0 - fBrightness;
	gl_FragColor = v_vColour * vec4(v4Color.rgb * vec3(max(fBright, 0.0)), 1.0);

}
