import MetalKit


class GameObject {
    var verticies: [Vertex]!
    var vertexBuffer: MTLBuffer!

    init() {
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

    func render(renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setRenderPipelineState(RenderPipelineStateLibrary.PipelineState(.Basic))
        renderCommandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: verticies.count)
    }
}
