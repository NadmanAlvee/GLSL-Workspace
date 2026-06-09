uniform float uTime;

varying vec3 vPosition;
varying vec3 vNormal;
varying vec2 vUv;

void main() {
  // gl_FragColor = vec4(vec3(vUv.x), 1.0); // 1. horizontal gray gradient

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

  float t = sin(vUv.x * 10.0 + uTime) * 0.5 + 0.5;
  gl_FragColor = vec4(vec3(t), 1.0); // 7. clean stripes using sin function

  // float x = sin(vUv.x * 15.0) * 0.5 + 0.5; // x 0 -> 15
  // float y = sin(vUv.y * 15.0) * 0.5 + 0.5; // y 0 -> 15
  // gl_FragColor = vec4(vec3(x * y), 1.0); // 8. grid

}
