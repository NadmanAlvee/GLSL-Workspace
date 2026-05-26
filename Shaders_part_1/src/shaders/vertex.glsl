// attribute vec3 position;
// attribute vec3 normal;
// attribute vec2 uv;

// uniform mat4 modelViewMatrix;
// // projectionMatrix -> projects our object onto the screen (aspect ratio & perspective)
// uniform mat4 projectionMatrix;


// // Model View Matrix
// // modelMatrix -> position, scale, rotation of our model
// uniform mat4 modelMatrix;
// // viewMatrix -> position and orientation of our camera
// uniform mat4 viewMatrix;

// void main() {
//   // Transform -> position, scale, rotation

//   // M V P matricies - reverse order
// 	gl_Position = projectionMatrix * modelMatrix * viewMatrix * vec4( position, 1.0 );
// }

// # Normals are the orientation of an object, in vec3
uniform float uTime;

varying vec3 vPosition;
varying vec3 vNormal;
flat varying vec2 vUv;

void main() {
  vPosition = position;
  vNormal = normal;
  vUv = uv;

  vec4 modelViewPosition = modelViewMatrix * vec4( position, 1.0 );
  vec4 projectedPosition = projectionMatrix * modelViewPosition; 
	gl_Position = projectedPosition;
}