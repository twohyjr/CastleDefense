import MetalKit

class Scene: Node{
    
    var sceneConstants = SceneConstants()
    var camera = Camera()
    
    init(device: MTLDevice){
        super.init()
    }
    
    private func updateModels(deltaTime: Float){ }
    
    private func updateSceneConstants(renderCommandEncoder: MTLRenderCommandEncoder){
        self.sceneConstants.projectionMatrix = camera.projectionMatrix
        self.sceneConstants.viewMatrix = camera.viewMatrix
        
        renderCommandEncoder.setVertexBytes(&sceneConstants, length: MemoryLayout<SceneConstants>.stride, index: 2)
    }
    
    func render(renderCommandEncoder: MTLRenderCommandEncoder, deltaTime: Float){
        updateSceneConstants(renderCommandEncoder: renderCommandEncoder)
        updateModels(deltaTime: deltaTime)
        super.render(renderCommandEncoder: renderCommandEncoder)
    }
    
}
