import MetalKit

class GameView: MTKView {

    var renderer: Renderer!
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        renderer = Renderer()
        
        
        
        self.delegate = renderer
    }
    
}
