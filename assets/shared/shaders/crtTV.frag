#pragma header
vec2 uv = openfl_TextureCoordv.xy;
vec2 fragCoord = openfl_TextureCoordv * openfl_TextureSize;
vec2 iResolution = openfl_TextureSize;
uniform float iTime;
#define iChannel0 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor
#define mainImage main
// Controls for customization
uniform float RGB_SHIFT_R; // Red channel shift
uniform float RGB_SHIFT_G; // Green channel shift
uniform float RGB_SHIFT_B; // Blue channel shift
uniform float NOISE_SCALE; // Scale of the noise effect
uniform float NOISE_INTENSITY; // How visible the noise is
uniform float REFRESH_FLICKER; // Speed of random brightness flickering
float random(vec2 uv) {
return fract(sin(dot(uv, vec2(15.5151, 42.2561))) * 12341.14122 * (1.0 + sin(iTime * REFRESH_FLICKER) * 0.1));
}
float noise(vec2 uv) {
vec2 i = floor(uv);
vec2 f = fract(uv);
float a = random(i);
float b = random(i + vec2(0.3, 0.0));
float c = random(i + vec2(0.0, 0.3));
float d = random(i + vec2(0.3));
vec2 u = smoothstep(0.0, 0.5, f);
return mix(a, b, u.x) + (c - a) * u.y * (1.0 - u.x) + (d - b) * u.x * u.y;
}
void mainImage() {
vec2 uv = fragCoord / iResolution.xy;
vec4 col;
col.r = texture(iChannel0, uv + vec2(0.0, RGB_SHIFT_R)).r;
col.g = texture(iChannel0, uv + vec2(0.0, RGB_SHIFT_G)).g;
col.b = texture(iChannel0, uv + vec2(0.0, -RGB_SHIFT_B)).b;
col.a = texture(iChannel0, uv).a;
fragColor = mix(col, vec4(noise(uv * NOISE_SCALE)), NOISE_INTENSITY);
}