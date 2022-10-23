import MetalKit

class GameView: MTKView {
    
    var renderer: Renderer!
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        self.device = MTLCreateSystemDefaultDevice()
        
        Engine.Ignite(device: device!)
        
        self.clearColor = Preferences.ClearColor
        
        self.colorPixelFormat = Preferences.MainPixelFormat // most common for applications
        
        self.renderer = Renderer()
        
        self.delegate = renderer
        
        // M&K Input

    }
}
