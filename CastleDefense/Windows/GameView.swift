import MetalKit

class GameView: MTKView {

    var renderer: Renderer!
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        self.device = MTLCreateSystemDefaultDevice()
        
        self.renderer = Renderer(device: device!)
        
        self.colorPixelFormat = .bgra8Unorm
        
        self.depthStencilPixelFormat = .depth32Float
        
        renderer.updateTrackingArea(view: self)
        
        self.delegate = renderer
    }
}

extension GameView{
    override var acceptsFirstResponder: Bool { return true }

    //-------KEY EVENTS SECTION-------
    
    override func keyDown(with event: NSEvent) {
        InputHandler.setKeyPressed(key: event.keyCode, isOn: true)
    }
    
    override func keyUp(with event: NSEvent) {
        InputHandler.setKeyPressed(key: event.keyCode, isOn: false)
    }
    
    //-------END MOUSE EVENTS SECTION-------
    //-------MOUSE EVENTS SECTION-------
    
    override func mouseMoved(with event: NSEvent) {
        let x: Float = Float(event.locationInWindow.x)
        let y: Float = Float(event.locationInWindow.y)
        MouseHandler.setOverallMousePosition(position: float2(x,y))
    }
    
    override func scrollWheel(with event: NSEvent) {
        MouseHandler.scrollMouse(deltaY: Float(event.deltaY))
    }
    
    //Left Mouse Button Clicked
    override func mouseDown(with event: NSEvent) {
        MouseHandler.setMouseButtonPressed(button: event.buttonNumber, isOn: true)
    }
    
    override func mouseDragged(with event: NSEvent) {
        let overallLocation = float2(Float(event.locationInWindow.x), Float(event.locationInWindow.y))
        let deltaChange = float2(Float(event.deltaX), Float(event.deltaY))
        MouseHandler.setMousePositionChange(overallPosition: overallLocation, deltaPosition: deltaChange)
    }
    
    override func mouseUp(with event: NSEvent) {
        MouseHandler.setMouseButtonPressed(button: event.buttonNumber, isOn: false)
    }
    
    //Right Mouse Button Clicked
    override func rightMouseDown(with event: NSEvent) {
        MouseHandler.setMouseButtonPressed(button: event.buttonNumber, isOn: true)
    }
    
    override func rightMouseDragged(with event: NSEvent) {
        let overallLocation = float2(Float(event.locationInWindow.x), Float(event.locationInWindow.y))
        let deltaChange = float2(Float(event.deltaX), Float(event.deltaY))
        MouseHandler.setMousePositionChange(overallPosition: overallLocation, deltaPosition: deltaChange)
    }
    
    override func rightMouseUp(with event: NSEvent) {
        MouseHandler.setMouseButtonPressed(button: event.buttonNumber, isOn: false)
    }
    
    //Other Mouse Buttons Clicked
    override func otherMouseDown(with event: NSEvent) {
        //MouseHandler.setMouseButtonPressed(button: event.buttonNumber, isOn: true)
    }
    
    override func otherMouseDragged(with event: NSEvent){
        //MouseHandler.setMouseButtonPressed(button: event.buttonNumber, isOn: true)
    }
    
    override func otherMouseUp(with event: NSEvent) {
        //MouseHandler.setMouseButtonPressed(button: event.buttonNumber, isOn: false)
    }
    //-------END MOUSE EVENTS SECTION-------
    
}
