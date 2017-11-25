import MetalKit

class Preferences{
    
    static var clearColor: MTLClearColor = MTLClearColor(red: 0.132552, green: 0.366699, blue: 0.410022, alpha: 1.0)
    
    public static func updateClearColor(color: NSColor){
        Preferences.clearColor = MTLClearColor(red: Double(color.redComponent), green: Double(color.greenComponent), blue: Double(color.blueComponent), alpha: Double(color.alphaComponent))
    }
}
