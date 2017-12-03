import MetalKit

class Circle: Entity{
    
    var vertices: [Vertex] = []
    var vertexBuffer: MTLBuffer!
    var radius: Float!
    var circleVertexCount: Int!
    
    init(device: MTLDevice, radius: Float, circleVertexCount: Int, color: float4){
        super.init()
        self.radius = radius
        self.circleVertexCount = circleVertexCount
        
        modelConstants.materialColor = color
        
        buildVertices()
        buildBuffers(device: device)
    }
    
    func buildVertices(){
        for i in 0...circleVertexCount{
            vertices.append(Vertex(position: float3(radius*cos(Float(i) * Maths.twopi / Float(circleVertexCount)), radius*sin(Float(i) * Maths.twopi / Float(circleVertexCount)), 0)))
            vertices.append(Vertex(position: float3(0,0, 0)))
        }
    }
    
    func buildBuffers(device: MTLDevice){
        vertexBuffer = device.makeBuffer(bytes: vertices, length: MemoryLayout<Vertex>.stride * vertices.count, options: [])
    }
    
    override func render(renderCommandEncoder: MTLRenderCommandEncoder){
        renderCommandEncoder.setVertexBytes(&modelConstants, length: MemoryLayout<ModelConstants>.stride, index: 1)
        renderCommandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder.drawPrimitives(type: .triangleStrip, vertexStart: 0, vertexCount: vertices.count)
    }
}
