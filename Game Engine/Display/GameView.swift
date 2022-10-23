import MetalKit

class GameView: MTKView {
    
    var verticies: [Vertex]!
    var vertexBuffer: MTLBuffer!
    
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        self.device = MTLCreateSystemDefaultDevice()
        
        Engine.Ignite(device: device!)
        
        self.clearColor = Preferences.ClearColor
        
        self.colorPixelFormat = Preferences.MainPixelFormat // most common for applications
        
        createVerticies()
        createBuffers()
    }
    
    func createVerticies() {
        verticies = [
            Vertex(position: SIMD3<Float>( 0, 1, 0), color: SIMD4<Float>(1,0,0,1)),
            Vertex(position: SIMD3<Float>(-1,-1, 0), color: SIMD4<Float>(0,1,0,1)),
            Vertex(position: SIMD3<Float>( 1,-1, 0), color: SIMD4<Float>(0,0,1,1)),
        ]
    }
    
    func createBuffers() {
        vertexBuffer = Engine.Device.makeBuffer(bytes: verticies, length: Vertex.stride(verticies.count) * verticies.count, options: [])
    }
    
    override func draw(_ dirtyRect: NSRect) {
        guard let drawable = self.currentDrawable, let renderPassDescriptor = self.currentRenderPassDescriptor else { return }
        
        let commandBuffer = Engine.CommandQueue.makeCommandBuffer()
        let renderCommandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        renderCommandEncoder?.setRenderPipelineState(RenderPipelineStateLibrary.PipelineState(.Basic))
        
        renderCommandEncoder?.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder?.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: verticies.count)
        
        renderCommandEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
}
