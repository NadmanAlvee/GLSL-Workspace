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

varying vec3 vPosition;
varying vec3 vNormal;
flat varying vec2 vUv; // hard edge

void main(){


  // gl_FragColor = vec4(vPosition.xy, 1, 1);
  gl_FragColor = vec4(vUv.xxx, 1);
}
