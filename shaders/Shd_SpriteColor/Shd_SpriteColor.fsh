
varying vec2 v_vTexcoord;

uniform vec4 uv4Color;
uniform float ufMix;

void main()
{
	vec4 v4Color = texture2D( gm_BaseTexture, v_vTexcoord );
    gl_FragColor = mix(v4Color, uv4Color, ufMix * v4Color.a);
}
