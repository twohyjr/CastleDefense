#include <metal_stdlib>
using namespace metal;

struct VertexIn{
    float3 position [[ attribute(0) ]];
};

struct VertexOut{
    float4 position [[ position ]];
    float4 color;
};

struct ModelConstants{
    float4x4 modelMatrix;
    float4 materialColor;
};

struct SceneConstants{
    float4x4 projectionMatrix;
    float4x4 viewMatrix;
};

vertex VertexOut basic_vertex_shader(const    VertexIn        vIn            [[ stage_in ]],
                                     constant ModelConstants &modelConstants [[ buffer(1) ]],
                                     constant SceneConstants &sceneConstants [[ buffer(2) ]],
                                     uint     vertexID                       [[ vertex_id ]])
{
    VertexOut vOut;
    
    float4x4 transformationMatrix = modelConstants.modelMatrix;
    float4 worldPosition = transformationMatrix * float4(vIn.position, 1.0);
    vOut.position = sceneConstants.projectionMatrix * sceneConstants.viewMatrix * worldPosition;
    
    vOut.color = modelConstants.materialColor;
    return vOut;
}

const half4 getHalf4Color(float4 color)
{
    return half4(color.r, color.g, color.b, color.a);
}

fragment half4 basic_fragment_shader(const VertexOut vIn [[ stage_in ]])
{
    float4 color = vIn.color;
    return getHalf4Color(color);
}


