uniform float uTime;

varying vec3 vPosition;
varying vec3 vNormal;
varying vec2 vUv;
varying float vDisplacement;

// // unpredictable value from a coordinate
// float random(vec2 st) {
//     return fract(sin(dot(st, vec2(127.1, 311.7))) * 43758.5453);
// }

// vec2 hash(vec2 p) {
//   p = vec2(dot(p, vec2(127.1, 311.7)), dot(p, vec2(269.5, 183.3)));
//   return -1.0 + 2.0 * fract(sin(p) * 43758.5453123);
// }

// // smooth interpolation between random values
// float noise(vec2 p) {
//   vec2 i = floor(p);
//   vec2 f = fract(p);
//   vec2 u = f * f * (3.0 - 2.0 * f);

//   return mix(
//     mix(dot(hash(i + vec2(0.0, 0.0)), f - vec2(0.0, 0.0)),
//       dot(hash(i + vec2(1.0, 0.0)), f - vec2(1.0, 0.0)), u.x),
//     mix(dot(hash(i + vec2(0.0, 1.0)), f - vec2(0.0, 1.0)),
//       dot(hash(i + vec2(1.0, 1.0)), f - vec2(1.0, 1.0)), u.x), u.y);
// }

// // layering noise at different scales
// float fbm(vec2 st) {
//   float value = 0.0;
//   float amplitude = 0.5;
  
//   for(int i = 0; i < 4; i++) {
//     value += amplitude * noise(st);
//     st *= 2.0;        // double frequency each octave
//     amplitude *= 0.5; // halve amplitude each octave
//   }
  
//   return value;
// }

void main() {
  gl_FragColor = vec4(vec3(vUv.x), 1.0); // 1. horizontal gray gradient

  // gl_FragColor = vec4(step(0.5, mix(1.0, 0.0, vUv.y)), 0.0, step(0.5, mix(0.0, 1.0, vUv.y)), 1.0); // 2. different color on the top half vs the bottom half

  // float t = vUv.y;
  // vec3 red = vec3(1.0, 0.0, 0.0);
  // vec3 blue = vec3(0.0, 0.0, 1.0);

  // gl_FragColor = vec4(mix(red, blue, t), 1.0);// 3. different colors of smooth gradient

  // remapping position.y from -1 to 1 to 0 to 1
  // vec3 position = vPosition;
  // position.y += 1.0;
  // position.y = position.y / 2.0;

  // gl_FragColor = vec4(vec3(position.y), 1.0); // 4. different shades on different heights

  // float t = vPosition.y * 0.5 + 0.5;
  // gl_FragColor = vec4(vec2(t), 1.0, 1.0); // 5. height coloring

  // float t = vPosition.y * 0.5 + 0.5 + sin(uTime);
  // gl_FragColor = vec4(vec2(t), 1.0, 1.0); // 6. animated height coloring

  // float t = sin(vUv.x * 10.0 + uTime) * 0.5 + 0.5;
  // gl_FragColor = vec4(vec3(t), 1.0); // 7. clean stripes using sin function

  // float x = sin(vUv.x * 15.0) * 0.5 + 0.5; // x 0 -> 15
  // float y = sin(vUv.y * 15.0) * 0.5 + 0.5; // y 0 -> 15
  // gl_FragColor = vec4(vec3(x * y), 1.0); // 8. grid

  // float t = random(vUv);
  // gl_FragColor = vec4(vec3(t), 1.0); // 9. White noise

  // float t = noise(vec2(vUv.x * 3.0 + uTime * 1.3, vUv.y * 3.0));
  // gl_FragColor = vec4(vec3(t), 1.0); // 10. value noise

  vec3 deepBlue = vec3(5.0/255.0, 1.0/255.0, 74.0/255.0);
  vec3 lightCyan = vec3(204.0/255.0, 255.0/255.0, 255.0/255.0);

  // float t = fbm(vNormal * 3.0 + uTime * 0.3);
  // gl_FragColor = vec4(vec3(mix(deepBlue, lightCyan, t)), 1.0); // 12. Ocean water

  float t = vDisplacement * 1.3 + 0.45;
  gl_FragColor = vec4(mix(lightCyan, deepBlue, t), 1.0);

}
