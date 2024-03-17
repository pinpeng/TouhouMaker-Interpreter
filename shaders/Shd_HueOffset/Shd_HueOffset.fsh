
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float ufOffset;
uniform float ufMiddle;
uniform vec3 uv3BrightColor;

void main()
{
	vec4 v4Color = texture2D( gm_BaseTexture, v_vTexcoord );
	float fBrightness = v4Color.r * 0.299 + v4Color.g * 0.587 + v4Color.b * 0.114;
	v4Color.rgb = mix(v4Color.rgb, uv3BrightColor, (fBrightness - ufMiddle) * ufOffset);
    gl_FragColor = v_vColour * v4Color;
}
