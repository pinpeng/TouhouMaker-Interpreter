
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float ufGrayValue;
uniform float ufScanlineValue;
uniform vec2 uv2Size;

void main()
{
	vec4 v4Color = texture2D( gm_BaseTexture, v_vTexcoord );
	float fBrightness = v4Color.r * 0.299 + v4Color.g * 0.587 + v4Color.b * 0.114;
	v4Color.rgb = mix(v4Color.rgb, vec3(fBrightness), ufGrayValue);
	v4Color.r *= 1.0 - 0.0625 * ufGrayValue;
	v4Color.b *= 1.0 - 0.0625 * ufGrayValue;
	float fXOffset = cos(v_vTexcoord.x * uv2Size.x);
	float fYOffset = cos(v_vTexcoord.y * uv2Size.y);
	fXOffset *= fXOffset * fXOffset * fXOffset;;
	fXOffset *= fXOffset * ufScanlineValue;
	fYOffset *= fYOffset * fYOffset * fYOffset;
	fYOffset *= fYOffset * ufScanlineValue;

	v4Color.rgb = mix(v4Color.rgb, vec3(1.0 - 0.0625 * ufGrayValue, 1.0, 1.0 - 0.0625 * ufGrayValue),
	max(0.0, max(fXOffset, fYOffset) - 0.5));
    gl_FragColor = v_vColour * v4Color;
}
