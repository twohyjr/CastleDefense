import MetalKit

class Renderer: NSObject{
    var renderPipelineState: MTLRenderPipelineState!
    var commandQueue: MTLCommandQueue!
    
    var depthStencilState: MTLDepthStencilState!
    
    var scene: Scene!

    var vertexDescriptor: MTLVertexDescriptor{
        let vertexDescriptor = MTLVertexDescriptor()
        
        //Position
        vertexDescriptor.attributes[0].format = .float3
        vertexDescriptor.attributes[0].bufferIndex = 0
        vertexDescriptor.attributes[0].offset = 0
    
        vertexDescriptor.layouts[0].stride = MemoryLayout<Vertex>.stride
        
        return vertexDescriptor
    }
    
    init(device: MTLDevice){
        super.init()
        
        commandQueue = device.makeCommandQueue()
        buildRenderPipelineState(device: device)
        buildDepthStencilState(device: device)
        scene = Scene(device: device)
    }
    

    
    func buildRenderPipelineState(device: MTLDevice){
        let library = device.makeDefaultLibrary()
        let vertexFunction = library?.makeFunction(name: "basic_vertex_shader")
        let fragmentFunction = library?.makeFunction(name: "basic_fragment_shader")
        
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.vertexFunction = vertexFunction
        renderPipelineDescriptor.fragmentFunction = fragmentFunction
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        renderPipelineDescriptor.depthAttachmentPixelFormat = .depth32Float
        
        renderPipelineDescriptor.vertexDescriptor = vertexDescriptor
        
        do{
            renderPipelineState = try device.makeRenderPipelineState(descriptor: renderPipelineDescriptor)
        }catch let error as NSError{
            print("Error creating renderpipeline state: \(error)")
        }
    }
    
    private func buildDepthStencilState(device: MTLDevice){
        let depthStencilDescriptor = MTLDepthStencilDescriptor()
        depthStencilDescriptor.label = "Base Depth Stencil Descriptor"
        depthStencilDescriptor.isDepthWriteEnabled = true
        depthStencilDescriptor.depthCompareFunction = .less
        depthStencilState = device.makeDepthStencilState(descriptor: depthStencilDescriptor)
    }
    
    private func updateViewPreferences(view: MTKView){
        view.clearColor = Preferences.clearColor
    }
    
    func updateTrackingArea(view: MTKView){
        let area = NSTrackingArea(rect: view.bounds, options: [NSTrackingArea.Options.activeAlways, NSTrackingArea.Options.mouseMoved, NSTrackingArea.Options.enabledDuringMouseDrag], owner: view, userInfo: nil)
        view.addTrackingArea(area)
    }
    
}

extension Renderer: MTKViewDelegate{
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {  }
    
    func draw(in view: MTKView) {
        guard let renderPassDescriptor = view.currentRenderPassDescriptor, let currentDrawable = view.currentDrawable else { return }
        
        let commandBuffer = commandQueue.makeCommandBuffer()

        let renderCommandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        renderCommandEncoder?.setDepthStencilState(depthStencilState)
        renderCommandEncoder?.setRenderPipelineState(renderPipelineState)
        
        //View Updates
        updateViewPreferences(view: view)
        
        let deltaTime = 1/Float(view.preferredFramesPerSecond)
        scene.render(renderCommandEncoder: renderCommandEncoder!, deltaTime: deltaTime)
        
        renderCommandEncoder?.endEncoding()
        commandBuffer?.present(currentDrawable)
        commandBuffer?.commit()
    }
    
}
