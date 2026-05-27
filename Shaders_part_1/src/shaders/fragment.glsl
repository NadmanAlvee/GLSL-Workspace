// struct vec5 {
//   float x;
//   float y;
//   float z;
//   float w;
//   float q;
// };

// float sum(float a , float b) {
//   return a + b;
// }

// // # Data Types && Type Casting
// void main() {
//   // float, double, int, uint, bool
//   // vec2, vec3, vec4 -> stores float
//   // ivec3 -> stores int
//   // uvec3 -> stores uint
//   // bvec2 -> stores boolean
//   // dvec3 -> stores double

//   float greenValue = 1.0;

//   vec3 myVector = vec3(1);
//   myVector.x = 0.f; // .f means float

//   vec5 myVector2 = vec5(1.f, 0.5, 0.f, 1.f, 1.f); // 1.0 == 1.f == float(1)

//   // vec4 color = vec4(1); // equivalent to 1.0, 1.0, 1.0, 1.0
//   // vec4 color = vec4(vec2(1, 1), vec2(1, 1)); // equivalent to 1.0, 1.0, 1.0, 1.0
//   vec4 color = vec4(0.8627, 0.0784, 0.2352, sum(0.5, 0.5));
// 	gl_FragColor = color;
// }

// // # swizzle mask
// void main() {
//   vec3 color = vec3(1, 0, 1);
//   color.x = 0.0; // x y z w == r g b a
//   color.r = 0.0;
//   color.rg = vec2(1.0, 0.0);
//   color.gr = vec2(0.0, 1.0); // reversible
//   color.gbr = vec3(1.0, 0.0, 0.f); // == color.yzx

//   gl_FragColor = vec4(color.ggg, 1.0);
// }

// // # math functions
// void main(){
//   vec3 color = vec3(0, 0, 0);
//   color += vec3(1, 0.5, 0.5); // *= /=
//   color /= vec3(1, 1, 1);

//   vec2 myVector = color.xx / vec2(2, 2);

//   float newFloat = mod(color.x, 2.0);

//   // mod()
//   // abs()
//   // min()
//   // max()
//   // sin, cos, tan, atan
//   // dot, cross
//   // clamp(-0.1, 0, 1)
//   // step, smoothstep, fract, equal
//   // mix()

//   bvec3 isEqual = equal(vec3(1), vec3(1));

//   gl_FragColor = vec4(isEqual, 1);
// }

// # Attrributes & Uniforms

// precision mediump float; // only needs to be specified when using RawShaderMaterial

uniform float uTime;
uniform float uRadius;

varying vec3 vPosition;
varying vec3 vNormal;
// flat varying vec2 vUv; // hard edge, no interpolation
varying vec2 vUv; // interpolation / lerp, no hard edge

// #  useful functions
void main(){
  // x, y -> x

  // swizzle mask
  // gl_FragColor = vec4(vPosition.xy, 1, 1);

  // power function
  // gl_FragColor = vec4(vec3(pow(vUv.x, 3.f)), 1);

  // step - value >= edge ? 1 : 0;
  // gl_FragColor = vec4(vec3(step(0.5, vUv.x)), 1);

  // smooth step
  // gl_FragColor = vec4(vec3(smoothstep(0.45, 0.55, vUv.x)), 1);

  // length  length of a vector
  vec2 uv = vUv;

  // uv.x = uv.x - 1.0 / 2.0;
  // uv.y = uv.y - 1.0 / 2.0;
  // uv *= 2.0;

  // gl_FragColor = vec4(vUv, 0, 1);
  // gl_FragColor = vec4(vec3(length(vUv)), 1);

  // const float RADIUS = 0.8;
  // gl_FragColor = vec4(vec3(step(uRadius, length(uv))), 1);

  // fract() only returns the decimal part. 3.5 -> 0.5
  // gl_FragColor = vec4(vec3(fract(vUv.x * 10.f)), 1);

  // gl_FragColor = vec4(vec3(step(0.5, mod(vUv.x * 10.f, 2.0))), 1);

  // mix() lerps between min and max of the given value
  // gl_FragColor = vec4(vec3(mix(0.0, 0.5, vUv.x)), 1);

  // sunlight brightness
  vec3 dLight = normalize(vec3(0.f, 2.f, 0.f));
  vec3 normal = normalize(vNormal);
  float brightness = max(dot(normal, dLight), 0.f) * 2.0;

  vec3 vectorA = vec3(1.0);
  vec3 vectorB = vec3(0.0);
  float dotProduct = dot(vectorA, vectorB);

  gl_FragColor = vec4(vec3(dotProduct), 1);
}
