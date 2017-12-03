import MetalKit

class Circle: Node{
    
    var vertices: [Vertex] = []
    var vertexBuffer: MTLBuffer!
    var radius: Float!
    
    init(device: MTLDevice, radius: Float, color: float4){
        super.init()
        self.radius = radius
        buildVertices(color: color)
        buildBuffers(device: device)
    }
    
    func buildVertices(color: float4){
        let number = 140
        let twopi: Float = 2 * Float.pi
        
        for i in 0...number{
            vertices.append(Vertex(position: float3(radius*cos(Float(i) * twopi / Float(number)), radius*sin(Float(i) * twopi / Float(number)), 0), color: color))
            vertices.append(Vertex(position: float3(0,0, 0), color: color))
        }
    }
    
    func buildBuffers(device: MTLDevice){
        vertexBuffer = device.makeBuffer(bytes: vertices, length: MemoryLayout<Vertex>.stride * vertices.count, options: [])
    }
    
    override func render(renderCommandEncoder: MTLRenderCommandEncoder){
        renderCommandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder.drawPrimitives(type: .triangleStrip, vertexStart: 0, vertexCount: vertices.count)
    }
}
