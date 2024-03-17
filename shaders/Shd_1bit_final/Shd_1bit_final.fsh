
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 uv2Size;
uniform float ufThreshold;
uniform sampler2D usBloomTexture;

void main()
{
	vec4 v4Color = texture2D( gm_BaseTexture, v_vTexcoord );
	float fBrightness = v4Color.r * 0.299 + v4Color.g * 0.587 + v4Color.b * 0.114;
	v4Color.rgb = vec3(fBrightness);
	v4Color.r *= 0.625;
	v4Color.g *= 1.0;
	v4Color.b *= 0.625;
	float fXOffset = cos((v_vTexcoord.x * uv2Size.x + 1.6 / uv2Size.x) * 2.0 * 3.1416);
	float fYOffset = cos((v_vTexcoord.y * uv2Size.y + 1.2 / uv2Size.y) * 2.0 * 3.1416);
	fXOffset *= max(0.0, min((fXOffset - ufThreshold) * 64.0, 1.0));
	fYOffset *= max(0.0, min((fYOffset - ufThreshold) * 64.0, 1.0));

	v4Color.rgb = mix(v4Color.rgb, vec3(0.625, 1.0, 0.625),
	max(0.0, max(fXOffset, fYOffset)));
	v4Color.rgb = v4Color.rgb - texture2D( usBloomTexture, v_vTexcoord ).rgb * vec3(0.75, 1.0, 0.75);
    gl_FragColor = v_vColour * v4Color;
}
