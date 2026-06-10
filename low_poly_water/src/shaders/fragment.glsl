// fragment.glsl
uniform float uTime;

varying vec3 vPosition;
varying vec2 vUv;
varying float vDisplacement;

void main() {
  // Calculate flat face normal using derivatives
  vec3 dX = dFdx(vPosition);
  vec3 dY = dFdy(vPosition);
  vec3 flatNormal = normalize(cross(dX, dY));

  vec3 deepBlue = vec3(10.0/255.0, 5.0/255.0, 60.0/255.0);
  vec3 lightCyan = vec3(0.0/255.0, 235.0/255.0, 255.0/255.0);

  float t = vDisplacement * 1.5 + 0.5;
  vec3 color = mix(lightCyan, deepBlue, clamp(t, 0.0, 1.0));

  // Calculate View Direction for Fresnel & Light
  vec3 viewDir = normalize(cameraPosition - vPosition);

  float fresnel = 1.0 - max(dot(flatNormal, viewDir), 0.0);
  fresnel = pow(fresnel, 4.0);
  color = mix(color, vec3(0.9, 0.95, 1.0), fresnel * 0.6);

  vec3 lightDir = normalize(vec3(5.0, 10.0, 5.0));
  float lighting = max(dot(flatNormal, lightDir), 0.0);
  color += vec3(0.15) * lighting;

  gl_FragColor = vec4(color, 1.0);
}
