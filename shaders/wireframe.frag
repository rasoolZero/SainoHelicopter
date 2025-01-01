#version 450

layout(location = 0) in vec4 inColor;    // Interpolated color from vertex shader
layout(location = 0) out vec4 outFragColor; // Output color of the fragment

void main() {
    outFragColor = inColor; // Set the fragment color
}
