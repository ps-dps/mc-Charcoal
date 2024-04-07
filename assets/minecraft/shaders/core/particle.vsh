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

    // https://github.com/ps-dps/mc-Charcoal //
    ivec2 atlasSize = textureSize(Sampler0, 0);
    ivec2 topleftUV = ivec2(UV0 * atlasSize + vec2(0.5)) - (CORNERS[gl_VertexID%4] * 128);
    ivec4 topleft = ivec4(texelFetch(Sampler0, topleftUV, 0) * 255 + vec4(0.5));
    bool isCustomTexture = topleft == ivec4(23, 255, 33, 255);

    if (isCustomTexture) {
        ivec2 offset = ivec2(0, 0);
        ivec2 textureScale = ivec2(8);

        ivec4 iColor = ivec4(Color * 255. + vec4(0.5));
        bool isCustomTint = iColor.gb == ivec2(91, 38) && iColor.a >= 249 && iColor.a <= 254;

        if (isCustomTint) {
            vertexColor = vec4(1);

            int offsetVar = int((iColor.r / 255.) * 100 + 0.5);
            offset = ivec2(offsetVar / 10, offsetVar % 10);

            ivec2 headerUV = topleftUV + offset * ivec2(8, 9);

            vec4 textureSizeColor = texelFetch(Sampler0, headerUV + ivec2(0, 0), 0);
            if (textureSizeColor.a == 1) {
                textureScale = ivec2(textureSizeColor.rg * 255 + vec2(.5));
            }

            vec4 scaleColor = texelFetch(Sampler0, headerUV + ivec2(1, 0), 0);
            if (scaleColor.a == 1) {
                float scaleMultiplier = scaleColor.g * 2.5 - 0.15;
                vec2 scaleOffset = vec2(CORNERS[3-(gl_VertexID%4)] - vec2(.5)) * scaleMultiplier;
                vec3 viewPos = (ModelViewMat * vec4(Position, 1.0)).xyz - vec3(scaleOffset, 0);
                gl_Position = ProjMat * vec4(viewPos, 1.0);
            }
        }

        ivec2 newIUV = topleftUV + ivec2(0,1) + (CORNERS[gl_VertexID%4] * textureScale + offset * ivec2(8, 9));
        texCoord0 = newIUV / vec2(atlasSize);
    }
    /////////////////////////////////////////////
}
