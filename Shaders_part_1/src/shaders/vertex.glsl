attribute vec3 position;

uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;

uniform float uTime;

// Model View Matrix
uniform mat4 modelMatrix;
uniform mat4 viewMatrix;

void main() {
  // Transform -> position, scale, rotation

  // modelMatrix -> position, scale, rotation of our model
  // viewMatrix -> position and orientation of our camera
  // projectionMatrix -> projects our object onto the screen (aspect ratio & perspective)

  // M V P - reverse order
	gl_Position = projectionMatrix * modelMatrix * viewMatrix * vec4( position, 1.0 );
}