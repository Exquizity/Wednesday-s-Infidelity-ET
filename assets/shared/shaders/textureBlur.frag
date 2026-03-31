#pragma header

uniform float BLUR_INTENSITY;
uniform float BLUR_SPEED;
uniform float POSITION_EFFECT;
uniform float SAMPLE_COUNT;
uniform float SAMPLE_OFFSET;

uniform float iTime;

void main()
{
    vec2 uv = openfl_TextureCoordv;
    float positionFactor = abs(uv.x - POSITION_EFFECT);
    float lod = max(0.001, BLUR_INTENSITY * positionFactor);

    float samples = clamp(SAMPLE_COUNT, 1.0, 20.0);
    float offsetScale = clamp(SAMPLE_OFFSET, 0.001, 0.1);

    vec4 colorSum = vec4(0.0);
    float weightSum = 0.0;

    float halfSamples = floor(samples * 0.5);

    for (float i = -halfSamples; i <= halfSamples; i++) {
        for (float j = -halfSamples; j <= halfSamples; j++) {
            vec2 offset = vec2(i, j) * lod * offsetScale;
            vec2 sampleUV = uv + offset;

            if (all(greaterThanEqual(sampleUV, vec2(0.0))) && all(lessThanEqual(sampleUV, vec2(1.0)))) {
                float weight = exp(-dot(offset, offset) / (2.0 * lod * lod + 0.0001));
                colorSum += flixel_texture2D(bitmap, sampleUV) * weight;
                weightSum += weight;
            }
        }
    }

    gl_FragColor = (weightSum > 0.0) ? colorSum / weightSum : flixel_texture2D(bitmap, uv);
}