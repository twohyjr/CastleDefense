import MetalKit

class Renderer: NSObject{
    let renderPipelineState: MTLRenderPipelineState!
    let commandQueue: MTLCommandQueue!
    
    init(device: MTLDevice){
        super.init()
        
    }
    
    
}

extension Renderer: MTKViewDelegate{
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {  }
    
    func draw(in view: MTKView) {
        
    }
    
}
