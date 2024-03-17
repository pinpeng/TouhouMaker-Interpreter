//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 uv2Size;

void main()
{
	vec4 v4color = texture2D( gm_BaseTexture, v_vTexcoord) * 0.2;/*
	v4color += texture2D( gm_BaseTexture, v_vTexcoord + vec2( uv2Size.x, uv2Size.y)) * 0.2;
	v4color += texture2D( gm_BaseTexture, v_vTexcoord + vec2(-uv2Size.x, uv2Size.y)) * 0.2;
	v4color += texture2D( gm_BaseTexture, v_vTexcoord + vec2( uv2Size.x,-uv2Size.y)) * 0.2;
	v4color += texture2D( gm_BaseTexture, v_vTexcoord + vec2(-uv2Size.x,-uv2Size.y)) * 0.2;*/
	v4color += texture2D( gm_BaseTexture, v_vTexcoord + vec2( uv2Size.x, 0.0)) * 0.2;
	v4color += texture2D( gm_BaseTexture, v_vTexcoord + vec2(-uv2Size.x, 0.0)) * 0.2;
	v4color += texture2D( gm_BaseTexture, v_vTexcoord + vec2( 0.0, uv2Size.y)) * 0.2;
	v4color += texture2D( gm_BaseTexture, v_vTexcoord + vec2( 0.0,-uv2Size.y)) * 0.2;
    gl_FragColor = v_vColour * v4color;
}
