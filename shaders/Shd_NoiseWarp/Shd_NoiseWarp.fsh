
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float ufScale;
uniform float ufStrength;

uniform vec2 uv2Offset;
uniform vec2 uv2Size;

uniform vec2 uv2NoiseSize;
uniform sampler2D usNoiseTex;

void main()
{
	vec2 v2Coord = v_vTexcoord;
	vec4 v4Noise = texture2D( usNoiseTex, fract(v2Coord * uv2NoiseSize * ufScale + uv2Offset) );
	v2Coord += (vec2(v4Noise.r, v4Noise.g) - 0.5) * 2.0 / uv2Size * ufStrength;
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v2Coord );
}
