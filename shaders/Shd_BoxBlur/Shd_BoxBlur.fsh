//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 uv2BlurRadius;

void main()
{
	vec4 v4Color = texture2D( gm_BaseTexture, v_vTexcoord)								* 0.36;
	v4Color += texture2D( gm_BaseTexture, v_vTexcoord + vec2( uv2BlurRadius.x, 0.0))	* 0.16;
	v4Color += texture2D( gm_BaseTexture, v_vTexcoord + vec2(-uv2BlurRadius.x, 0.0))	* 0.16;
	v4Color += texture2D( gm_BaseTexture, v_vTexcoord + vec2(0.0,  uv2BlurRadius.y))	* 0.16;
	v4Color += texture2D( gm_BaseTexture, v_vTexcoord + vec2(0.0, -uv2BlurRadius.y))	* 0.16;
    gl_FragColor = v_vColour * v4Color;
}
