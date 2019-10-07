
varying float controlled_time;
uniform float num_octaves;

#define PI 3.141592653589793
#define ZOOM 120.0

float random (in vec2 _st) {
    return fract(sin(dot(_st.xy,
                         vec2(12.9898,78.233)))*
        43758.5453123);
}

highp float noise(in vec2 uv) {
    vec2 i = floor(uv);
    vec2 f = fract(uv);
    float a = random(i);
    float b = random(i + vec2(1.0, 0.0));
    float c = random(i + vec2(0.0, 1.0));
    float d = random(i + vec2(1.0, 1.0));
    vec2 u = f * f * (3.0 - 2.0 * f);
    return mix(a, b, u.x) + (c - a)* u.y * (1.0 - u.x) + (d - b) * u.x * u.y;
}

float fractalbrownianmotion ( in vec2 uv) {
    float v = 0.0;
    float a = 0.5;
    vec2 shift = vec2(100.0);
    mat2 rot = mat2(cos(0.5), sin(0.5),-sin(0.5), cos(0.50));
    for (int i = 0; i < int(num_octaves); ++i) {
        v += a * noise(uv);
        uv = rot * uv * 2.0 + shift;
        a *= 0.5;
    }
    return v;
}



void main() {

  vec2 uv = gl_FragCoord.xy/ZOOM;

  vec3 color = vec3(0.0);

  vec2 q = vec2(0.);
  q.x = fractalbrownianmotion( uv + 0.00 * controlled_time);
  q.y = fractalbrownianmotion( uv + vec2(1.0));

  vec2 r = vec2(0.);
  r.x = fractalbrownianmotion( uv + 1.0 * q + vec2(1.7,9.2)+ 0.15 * controlled_time );
  r.y = fractalbrownianmotion( uv + 1.0 * q + vec2(8.3,2.8)+ 0.126 * controlled_time);

  float fractal = fractalbrownianmotion(uv + r);

  color = mix(vec3(0.101961,0.619608,0.666667),
              vec3(0.666667,0.666667,0.498039),
              clamp((pow(fractal, 2.0)) * 4.0, 0.0, 1.0));

  color = mix(color, vec3(0, 0, 0.164706), clamp(length(q), 0.0, 1.0));

  color = mix(color, vec3(0.666667, 1, 1), clamp(length(r), 0.0, 1.0));

  gl_FragColor = vec4((pow(fractal, 3.0) + .6 * pow(fractal, 2.0) + .5 * fractal) * color,1.);

}
