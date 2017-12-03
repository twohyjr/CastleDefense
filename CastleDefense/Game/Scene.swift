import MetalKit

class Scene: Node{
    
    var circle: Circle!
    
    init(device: MTLDevice){
        super.init()
        addChild(child: Circle(device: device, radius: 1.0, circleVertexCount: 140, color: float4(1)))
        addChild(child: Circle(device: device, radius: 0.5, circleVertexCount: 4, color: float4(1,0,1,1)))
    }
    
    override func render(renderCommandEncoder: MTLRenderCommandEncoder){
        super.render(renderCommandEncoder: renderCommandEncoder)
    }
    
}
