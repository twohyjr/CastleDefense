import MetalKit

struct Vertex{
    var position: float3
}

struct ModelConstants{
    var modelMatrix: matrix_float4x4 = matrix_identity_float4x4
    var materialColor: float4 = float4(1)
}

struct SceneConstants{
    var projectionMatrix: matrix_float4x4 = matrix_identity_float4x4
    var viewMatrix: matrix_float4x4 = matrix_identity_float4x4
}
