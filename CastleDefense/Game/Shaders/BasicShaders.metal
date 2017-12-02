#include <metal_stdlib>
using namespace metal;

struct VertexIn{
    float3 position [[ attribute(0) ]];
    float4 color [[ attribute(1) ]];
};

struct VertexOut{
    float4 position [[ position ]];
    float4 color;
};

vertex VertexOut basic_vertex_shader(const VertexIn vIn [[ stage_in ]],
                                  uint vertexID [[ vertex_id ]]){
    VertexOut vOut;
    vOut.position = float4(vIn.position, 1);
    vOut.color = float4(vIn.color);
    return vOut;
}

fragment half4 basic_fragment_shader(const VertexOut vIn [[ stage_in ]]){
    float4 color = vIn.color;
    
    return half4(color.r, color.g, color.b, color.a);
}
