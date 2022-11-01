import MetalKit

enum MeshTypes {
    case Triangle_Custom
    case Quad_Custom
    case Cube_Custom
}
class MeshLibrary: Library<MeshTypes, Mesh> {
    private var _library: [MeshTypes:Mesh] = [:]
    
    override func fillLibrary() {
        _library.updateValue(Triangle_CustomMesh(), forKey: .Triangle_Custom)
        _library.updateValue(Quad_CustomMesh(), forKey: .Quad_Custom)
        _library.updateValue(Cube_CustomMesh(), forKey: .Cube_Custom)
    }
    
    override subscript(_ type: MeshTypes) -> Mesh? {
        return _library[type]!
    }
}

protocol Mesh {
    var vertexCount: Int! { get }
    func setInstanceCount(_ count: Int)
    func drawPrimitives(_ renderCommandEncoder: MTLRenderCommandEncoder)
}

class CustomMesh: Mesh {
    private var _verticies: [Vertex] = []
    private var _vertexBuffer: MTLBuffer!
    private var _instanceCount: Int = 1
    
    var vertexCount: Int! {
        return _verticies.count
    }
    
    init() {
        createVerticies()
        createBuffers()
    }
    func createVerticies() { }
    
    func createBuffers() {
        _vertexBuffer = Engine.Device.makeBuffer(bytes: _verticies,
                                                 length: Vertex.stride(vertexCount),
                                                 options: [])
    }
    
    func addVertex(position: simd_float3, color: simd_float4 = simd_float4(1,0,1,1), textureCoordinate: simd_float2 = simd_float2(0,0)) {
        _verticies.append(Vertex(position: position, color: color, textureCoordinate: textureCoordinate))
    }
    
    func setInstanceCount(_ count: Int) {
        self._instanceCount = count
    }
    
    func drawPrimitives(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setVertexBuffer(_vertexBuffer, offset: 0, index: 0)
        
        renderCommandEncoder.drawPrimitives(type: .triangle,
                                            vertexStart: 0,
                                            vertexCount: vertexCount,
                                            instanceCount: _instanceCount)
    }
}

class Triangle_CustomMesh: CustomMesh {
    override func createVerticies() {
        
            addVertex(position: simd_float3( 0, 1, 0), color: simd_float4(1,0,0,1))
            addVertex(position: simd_float3(-1,-1, 0), color: simd_float4(0,1,0,1))
            addVertex(position: simd_float3( 1,-1, 0), color: simd_float4(0,0,1,1))
        
    }
    
}

class Quad_CustomMesh: CustomMesh {
    override func createVerticies() {
        
        addVertex(position: simd_float3( 1, 1, 0), color: simd_float4(1,0,0,1), textureCoordinate: simd_float2(1,0))
        addVertex(position: simd_float3(-1, 1, 0), color: simd_float4(0,1,0,1), textureCoordinate: simd_float2(0,0))
        addVertex(position: simd_float3(-1,-1, 0), color: simd_float4(0,0,1,1), textureCoordinate: simd_float2(0,1))
            
            addVertex(position: simd_float3( 1, 1, 0), color: simd_float4(1,0,0,1), textureCoordinate: simd_float2(1,0))
            addVertex(position: simd_float3(-1,-1, 0), color: simd_float4(0,0,1,1), textureCoordinate: simd_float2(0,1))
            addVertex(position: simd_float3( 1,-1, 0), color: simd_float4(1,0,1,1), textureCoordinate: simd_float2(1,1))
    
    }
    
}

class Cube_CustomMesh: CustomMesh {
    override func createVerticies() {
            //Left
           addVertex(position: simd_float3(-1.0,-1.0,-1.0), color: simd_float4(1.0, 0.5, 0.0, 1.0))
           addVertex(position: simd_float3(-1.0,-1.0, 1.0), color: simd_float4(0.0, 1.0, 0.5, 1.0))
           addVertex(position: simd_float3(-1.0, 1.0, 1.0), color: simd_float4(0.0, 0.5, 1.0, 1.0))
           addVertex(position: simd_float3(-1.0,-1.0,-1.0), color: simd_float4(1.0, 1.0, 0.0, 1.0))
           addVertex(position: simd_float3(-1.0, 1.0, 1.0), color: simd_float4(0.0, 1.0, 1.0, 1.0))
           addVertex(position: simd_float3(-1.0, 1.0,-1.0), color: simd_float4(1.0, 0.0, 1.0, 1.0))
            
            //RIGHT
           addVertex(position: simd_float3( 1.0, 1.0, 1.0), color: simd_float4(1.0, 0.0, 0.5, 1.0))
           addVertex(position: simd_float3( 1.0,-1.0,-1.0), color: simd_float4(0.0, 1.0, 0.0, 1.0))
           addVertex(position: simd_float3( 1.0, 1.0,-1.0), color: simd_float4(0.0, 0.5, 1.0, 1.0))
           addVertex(position: simd_float3( 1.0,-1.0,-1.0), color: simd_float4(1.0, 1.0, 0.0, 1.0))
           addVertex(position: simd_float3( 1.0, 1.0, 1.0), color: simd_float4(0.0, 1.0, 1.0, 1.0))
           addVertex(position: simd_float3( 1.0,-1.0, 1.0), color: simd_float4(1.0, 0.5, 1.0, 1.0))
            
            //TOP
           addVertex(position: simd_float3( 1.0, 1.0, 1.0), color: simd_float4(1.0, 0.0, 0.0, 1.0))
           addVertex(position: simd_float3( 1.0, 1.0,-1.0), color: simd_float4(0.0, 1.0, 0.0, 1.0))
           addVertex(position: simd_float3(-1.0, 1.0,-1.0), color: simd_float4(0.0, 0.0, 1.0, 1.0))
           addVertex(position: simd_float3( 1.0, 1.0, 1.0), color: simd_float4(1.0, 1.0, 0.0, 1.0))
           addVertex(position: simd_float3(-1.0, 1.0,-1.0), color: simd_float4(0.5, 1.0, 1.0, 1.0))
           addVertex(position: simd_float3(-1.0, 1.0, 1.0), color: simd_float4(1.0, 0.0, 1.0, 1.0))
            
            //BOTTOM
           addVertex(position: simd_float3( 1.0,-1.0, 1.0), color: simd_float4(1.0, 0.5, 0.0, 1.0))
           addVertex(position: simd_float3(-1.0,-1.0,-1.0), color: simd_float4(0.5, 1.0, 0.0, 1.0))
           addVertex(position: simd_float3( 1.0,-1.0,-1.0), color: simd_float4(0.0, 0.0, 1.0, 1.0))
           addVertex(position: simd_float3( 1.0,-1.0, 1.0), color: simd_float4(1.0, 1.0, 0.5, 1.0))
           addVertex(position: simd_float3(-1.0,-1.0, 1.0), color: simd_float4(0.0, 1.0, 1.0, 1.0))
           addVertex(position: simd_float3(-1.0,-1.0,-1.0), color: simd_float4(1.0, 0.5, 1.0, 1.0))
            
            //BACK
           addVertex(position: simd_float3( 1.0, 1.0,-1.0), color: simd_float4(1.0, 0.5, 0.0, 1.0))
           addVertex(position: simd_float3(-1.0,-1.0,-1.0), color: simd_float4(0.5, 1.0, 0.0, 1.0))
           addVertex(position: simd_float3(-1.0, 1.0,-1.0), color: simd_float4(0.0, 0.0, 1.0, 1.0))
           addVertex(position: simd_float3( 1.0, 1.0,-1.0), color: simd_float4(1.0, 1.0, 0.0, 1.0))
           addVertex(position: simd_float3( 1.0,-1.0,-1.0), color: simd_float4(0.0, 1.0, 1.0, 1.0))
           addVertex(position: simd_float3(-1.0,-1.0,-1.0), color: simd_float4(1.0, 0.5, 1.0, 1.0))
            
            //FRONT
           addVertex(position: simd_float3(-1.0, 1.0, 1.0), color: simd_float4(1.0, 0.5, 0.0, 1.0))
           addVertex(position: simd_float3(-1.0,-1.0, 1.0), color: simd_float4(0.0, 1.0, 0.0, 1.0))
           addVertex(position: simd_float3( 1.0,-1.0, 1.0), color: simd_float4(0.5, 0.0, 1.0, 1.0))
           addVertex(position: simd_float3( 1.0, 1.0, 1.0), color: simd_float4(1.0, 1.0, 0.5, 1.0))
           addVertex(position: simd_float3(-1.0, 1.0, 1.0), color: simd_float4(0.0, 1.0, 1.0, 1.0))
           addVertex(position: simd_float3( 1.0,-1.0, 1.0), color: simd_float4(1.0, 0.0, 1.0, 1.0))
    }
}

