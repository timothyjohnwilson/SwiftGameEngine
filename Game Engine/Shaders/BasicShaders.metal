
#include <metal_stdlib>
#include "Shared.metal"
using namespace metal;

//job is to put points into space
vertex RasterizerData basic_vertex_shader(const VertexIn vIn [[ stage_in ]],
                                          constant SceneConstants &sceneConstants [[ buffer(1) ]],
                                          constant ModelConstants &modelConstants [[ buffer(2) ]]) {
    
    RasterizerData rd;
    
    rd.position = sceneConstants.projectionMatrix * sceneConstants.viewMatrix * modelConstants.modelMatrix * float4(vIn.position, 1);
    rd.color = vIn.color;
    rd.textureCoordinate = vIn.textureCoordinate;
    rd.totalGameTime = sceneConstants.totalGameTime;
    
    return rd;
}

fragment half4 basic_fragment_shader(const RasterizerData rd [[ stage_in ]],
                                     constant Material &material [[ buffer(1) ]],
                                     sampler sampler2d [[ sampler(0) ]],
                                     texture2d<float> texture [[texture(0)]]) {
    
    float2 textCoord = rd.textureCoordinate;
    
    float4 color;
    
    if(material.useTexture) {
        color = texture.sample(sampler2d, textCoord);
    } else if(material.useMaterialColor) {
        color = material.color;
    } else {
         color = rd.color;
    }
    return half4(color.r, color.g, color.b, color.a);
};
