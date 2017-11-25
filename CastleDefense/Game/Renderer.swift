import MetalKit

class Renderer: NSObject{
    var renderPipelineState: MTLRenderPipelineState!
    var commandQueue: MTLCommandQueue!
    
    init(device: MTLDevice){
        super.init()
        
        commandQueue = device.makeCommandQueue()
        buildRenderPipelineState(device: device)
    }
    
    func buildRenderPipelineState(device: MTLDevice){
        let library = device.makeDefaultLibrary()
        let vertexFunction = library?.makeFunction(name: "basic_vertex_shader")
        let fragmentFunction = library?.makeFunction(name: "basic_fragment_shader")
        
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.vertexFunction = vertexFunction
        renderPipelineDescriptor.fragmentFunction = fragmentFunction
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        
        do{
            renderPipelineState = try device.makeRenderPipelineState(descriptor: renderPipelineDescriptor)
        }catch let error as NSError{
            print("Error creating renderpipeline state: \(error)")
        }
    }
    
    private func updateViewPreferences(view: MTKView){
        view.clearColor = Preferences.clearColor
    }
}

extension Renderer: MTKViewDelegate{
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {  }
    
    func draw(in view: MTKView) {
        guard let renderPassDescriptor = view.currentRenderPassDescriptor, let currentDrawable = view.currentDrawable else { return }
        
        let commandBuffer = commandQueue.makeCommandBuffer()
        let renderCommandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        renderCommandEncoder?.setRenderPipelineState(renderPipelineState)
        
        //View Updates
        updateViewPreferences(view: view)
        
        //TODO: Draw the scene stuff here
        
        renderCommandEncoder?.endEncoding()
        commandBuffer?.present(currentDrawable)
        commandBuffer?.commit()
    }
    
}
