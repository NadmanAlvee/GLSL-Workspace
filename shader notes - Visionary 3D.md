Gpu only knows how to draw a triangle
Gpu needs 2 thing to draw a triangle
1. the positions of the vertices
2. the color of the face

vertex shaders holds the position of the vertices
*vertex shader is essentially a program that runs for every single vertex for the object
*gpu runs vertex shader in parallel for every vertices
*the vertices have no idea of other vertices positions

fragment shaders tell how to fill the triangle
*fragment shader runs for every single pixel of the triangle
*the pixels have no idea of their neighbours colors
*they dont understand values below zero when rendering colors, they get clamped to zero

javascript sends information through attributes and uniforms
attributes are vertex specific
uniforms are not vertex specific

varying is used to pass data as a variable from the vertex shader to the fragment shader

