import MetalKit

class Node{
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
