import MetalKit

class Node{
    public var position: float3 = float3(0)
    public var rotation: float3 = float3(0)
    public var scale: float3 = float3(0.5)
    
    var children: [Node] = []
    
    func addChild(child: Node){
        children.append(child)
    }
    
    func render(renderCommandEncoder: MTLRenderCommandEncoder){
        for child in children{
            child.render(renderCommandEncoder: renderCommandEncoder)
        }
        
    }
}
