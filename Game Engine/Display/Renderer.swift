import MetalKit

class Renderer: NSObject {
    public static var ScreenSize: simd_float2 = simd_float2(0,0)
    public static var AspectRatio: Float {
        return ScreenSize.x / ScreenSize.y
    }
    
    init(_ mtkView: MTKView) {
        super.init()
        updateScreenSize(view: mtkView)
    }
}

extension Renderer: MTKViewDelegate {
    
    public func updateScreenSize(view: MTKView) {
        Renderer.ScreenSize = simd_float2(Float(view.bounds.width), Float(view.bounds.height))
    }
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        updateScreenSize(view: view)
    }
    
    func draw(in view: MTKView) {
        guard let drawable = view.currentDrawable, let renderPassDescriptor = view.currentRenderPassDescriptor else { return }
        
        let commandBuffer = Engine.CommandQueue.makeCommandBuffer()
        commandBuffer?.label = "My Command Buffer"
        
        let renderCommandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        renderCommandEncoder?.label = "First Render Command Encoder"
        
        SceneManager.TickScene(renderCommandEncoder: renderCommandEncoder!, deltaTime:  1 / Float(view.preferredFramesPerSecond))
        
        renderCommandEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
    

    
    
}
