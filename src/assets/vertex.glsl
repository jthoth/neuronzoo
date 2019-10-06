attribute vec3 position;

uniform mat4 worldViewProjection;
uniform float time;



varying float controlled_time;

void main() {
  gl_Position = worldViewProjection * vec4(position, 1.0);
  controlled_time = ((time / 1000.0) + 1.0);
}
