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
    float4 materialColor;
};

vertex VertexOut basic_vertex_shader(const    VertexIn        vIn            [[ stage_in ]],
                                     constant ModelConstants &modelConstants [[ buffer(1) ]],
                                     uint     vertexID                       [[ vertex_id ]])
{
    VertexOut vOut;
    vOut.position = float4(vIn.position, 1);
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


