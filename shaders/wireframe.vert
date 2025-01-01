#version 450

layout(location = 0) in vec3 inPosition; // Vertex position input
layout(location = 1) in vec4 inColor;    // Vertex color input

layout(location = 0) out vec4 outColor;  // Output color to fragment shader

layout(push_constant) uniform PushConstants {
    mat4 modelViewProjection; // Push constant for the transformation matrix
} pc;

void main() {
    gl_Position = pc.modelViewProjection * vec4(inPosition, 1.0); // Compute position
    outColor = inColor;                                          // Pass color to fragment shader
}
