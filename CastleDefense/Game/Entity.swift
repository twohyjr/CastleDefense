import MetalKit

class Entity: Node{
    
    private var modelConstants = ModelConstants()
    public var vertices: [Vertex] = []
    public var solid: Bool = false
    
    public var materialColor: float4 = float4(1)

    private var modelMatrix: matrix_float4x4{
        var modelMatrix = matrix_identity_float4x4
        
        //Update the entities position in model space
        modelMatrix.translate(direction: position)
        
        //Rotation
        modelMatrix.rotate(angle: rotation.x, axis: float3(1, 0, 0))
        modelMatrix.rotate(angle: rotation.y, axis: float3(0, 1, 0))
        modelMatrix.rotate(angle: rotation.z, axis: float3(0, 0, 1))
        
        //Update the size of this entities scale
        modelMatrix.scale(axis: scale)
        
        return modelMatrix
    }
    
    init(device: MTLDevice){
        super.init()
        buildVertices()
        buildBuffers(device: device)
    }
    
    func buildVertices(){ }
    
    func buildBuffers(device: MTLDevice){ }
    
    func updateModelConstants(renderCommandEncoder: MTLRenderCommandEncoder){
        self.modelConstants.modelMatrix = self.modelMatrix
        self.modelConstants.materialColor = self.materialColor
        
        renderCommandEncoder.setVertexBytes(&modelConstants, length: MemoryLayout<ModelConstants>.stride, index: 1)
    }
    
}
