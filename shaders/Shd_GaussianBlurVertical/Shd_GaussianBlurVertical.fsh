//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float ufBlurRadius;

void main()
{
	vec2 v2Offset = vec2(0.0, ufBlurRadius);
	vec4 v4Color = texture2D( gm_BaseTexture, v_vTexcoord)							* 0.16;
	v4Color		+= texture2D( gm_BaseTexture, v_vTexcoord + v2Offset * vec2(1.0))	* 0.15;
	v4Color		+= texture2D( gm_BaseTexture, v_vTexcoord + v2Offset * vec2(2.0))	* 0.12;
	v4Color		+= texture2D( gm_BaseTexture, v_vTexcoord + v2Offset * vec2(3.0))	* 0.09;
	v4Color		+= texture2D( gm_BaseTexture, v_vTexcoord + v2Offset * vec2(4.0))	* 0.06;
	v4Color		+= texture2D( gm_BaseTexture, v_vTexcoord + v2Offset * vec2(-1.0))	* 0.15;
	v4Color		+= texture2D( gm_BaseTexture, v_vTexcoord + v2Offset * vec2(-2.0))	* 0.12;
	v4Color		+= texture2D( gm_BaseTexture, v_vTexcoord + v2Offset * vec2(-3.0))	* 0.09;
	v4Color		+= texture2D( gm_BaseTexture, v_vTexcoord + v2Offset * vec2(-4.0))	* 0.06;
    gl_FragColor = v4Color;
}
