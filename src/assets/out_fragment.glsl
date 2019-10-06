
varying float controlled_time;
uniform float num_octaves;
uniform float neuron;

#define PI 3.141592653589793
#define TAU_MP 20.0

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

float fbm ( in vec2 uv) {
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

vec3 compute_lif(in vec3 compound){
  float x = exp(compound[0]/TAU_MP)*compound[0];
  float y = exp((compound[1] - compound[0])/TAU_MP)*compound[1];
  float z  =exp((compound[2] - compound[1])/TAU_MP)*compound[2];

  return vec3(x + y + z);
}

vec4 compute_activation_function(in vec3 compound){

  mat4 container = mat4(1.);

  container[0] = vec4(step(.5, compound), 1.);
  container[1] = vec4(1.0 / (1. + exp(-compound)), 1.);
  container[2] = vec4(tan(compound), 1.);
  container[3] = vec4(compute_lif(compound), 1.);

  return container[int(neuron) - 1];
}

void main() {

  vec2 st = gl_FragCoord.xy/120.0;

  vec3 color = vec3(0.0);
  vec2 q = vec2(0.);

  q.x = fbm( st + 0.00 * controlled_time);
  q.y = fbm( st + vec2(1.0));

  vec2 r = vec2(0.);
  r.x = fbm( st + 1.0 * q + vec2(1.7,9.2)+ 0.15 * controlled_time );
  r.y = fbm( st + 1.0 * q + vec2(8.3,2.8)+ 0.126 * controlled_time);

  float f = fbm(st + r);

  color = mix(vec3(0.101961,0.619608,0.666667),
              vec3(0.666667,0.666667,0.498039),
              clamp((pow(f, 2.0)) * 4.0, 0.0, 1.0));

  color = mix(color, vec3(0,0,0.164706), clamp(length(q),0.0,1.0));

  color = mix(color, vec3(0.666667,1,1), clamp(length(r.x),0.0,1.0));

  for (int i = 0; i < int(num_octaves); ++i) {
    color += color * (pow(f, 3.0) + .6 * pow(f, 2.0) + .5 * f); // Compound axoms sumations supose I have
    // a neuron for each pixel in the screen
  }

  gl_FragColor = compute_activation_function(color / num_octaves);

}
