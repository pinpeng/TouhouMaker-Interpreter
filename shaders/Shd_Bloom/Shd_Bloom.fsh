//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float ufMinValue;
uniform float ufAlpha;

void main()
{
    vec4 v4Color = texture2D( gm_BaseTexture, v_vTexcoord );
	float fBright = (v4Color.r * 0.299 + v4Color.g * 0.587 + v4Color.b * 0.114 - ufMinValue) / (1.0 - ufMinValue);
	gl_FragColor = v_vColour * vec4(v4Color.rgb * vec3(max(fBright * ufAlpha, 0.0)), v4Color.a);

}
