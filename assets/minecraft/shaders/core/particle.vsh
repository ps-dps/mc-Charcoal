#version 150

#moj_import <fog.glsl>

in vec3 Position;
in vec2 UV0;
in vec4 Color;
in ivec2 UV2;

uniform sampler2D Sampler2;
uniform sampler2D Sampler0; // https://github.com/ps-dps/mc-Charcoal

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform int FogShape;

out float vertexDistance;
out vec2 texCoord0;
out vec4 vertexColor;

const ivec2[4] CORNERS = ivec2[4](ivec2(1, 1), ivec2(1, 0), ivec2(0, 0), ivec2(0, 1)); // https://github.com/ps-dps/mc-Charcoal

void main() {
    // vanilla code
    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);

    vertexDistance = fog_distance(Position, FogShape);
    texCoord0 = UV0;
    vertexColor = Color * texelFetch(Sampler2, UV2 / 16, 0);

    // https://github.com/ps-dps/mc-Charcoal
    ivec2 atlasSize = textureSize(Sampler0, 0);
    ivec2 topleftUV = ivec2(UV0 * atlasSize + vec2(0.5)) - (CORNERS[gl_VertexID%4] * 128);
    ivec4 topleft = ivec4(texelFetch(Sampler0, topleftUV, 0) * 255 + vec4(0.5));

    if (topleft == ivec4(23, 255, 33, 255)) {
        ivec2 offset = ivec2(0, 0);

        ivec4 iColor = ivec4(Color * 255. + vec4(0.5));
        if (
            iColor.gb == ivec2(91, 38) &&
            iColor.a >= 249 &&
            iColor.a <= 254
            ) {
            vertexColor = vec4(1);

            int offsetVar = int((iColor.r / 255.) * 100 + 0.5);
            offset = ivec2(offsetVar / 10, offsetVar % 10);
        }

        ivec2 newIUV = topleftUV + ivec2(8) + ((CORNERS[gl_VertexID%4] + offset) * 8);
        texCoord0 = newIUV / vec2(atlasSize);
    }
    //////////////////////////////////////////
}
