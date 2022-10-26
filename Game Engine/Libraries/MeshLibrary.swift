import MetalKit

enum MeshTypes {
    case Triangle_Custom
    case Quad_Custom
    case Cube_Custom
}
class MeshLibrary {
    private static var meshes: [MeshTypes:Mesh] = [:]
    
    public static func Initialize() {
        createDefaultMeshes()
    }
    
    private static func createDefaultMeshes() {
        meshes.updateValue(Triangle_CustomMesh(), forKey: .Triangle_Custom)
        meshes.updateValue(Quad_CustomMesh(), forKey: .Quad_Custom)
        meshes.updateValue(Cube_CustomMesh(), forKey: .Cube_Custom)
    }
    
    public static func Mesh(_ meshType: MeshTypes)->Mesh{
        return meshes[meshType]!
    }
}

protocol Mesh {
    var vertexBuffer: MTLBuffer! { get }
    var vertexCount: Int! { get }
    func setInstanceCount(_ count: Int)
    func drawPrimitives(_ renderCommandEncoder: MTLRenderCommandEncoder)
}

class CustomMesh: Mesh {
    var verticies: [Vertex]!
    var vertexBuffer: MTLBuffer!
    var instanceCount:Int = 1
    var vertexCount: Int! {
        return verticies.count
    }
    
    init() {
        createVerticies()
        createBuffers()
    }
    func createVerticies() { }
    
    func createBuffers() {
        vertexBuffer = Engine.Device.makeBuffer(bytes: verticies, length: Vertex.stride(verticies.count) * verticies.count, options: [])
    }
    
    func setInstanceCount(_ count: Int) {
        self.instanceCount = count
    }
    
    func drawPrimitives(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
//
//        renderCommandEncoder.drawPrimitives(type: .triangle,
//                                            vertexStart: 0,
//                                            vertexCount: vertexCount)
        renderCommandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertexCount, instanceCount: instanceCount)
    }
}

class Triangle_CustomMesh: CustomMesh {
    override func createVerticies() {
        verticies = [
            Vertex(position: simd_float3( 0, 1, 0), color: simd_float4(1,0,0,1)),
            Vertex(position: simd_float3(-1,-1, 0), color: simd_float4(0,1,0,1)),
            Vertex(position: simd_float3( 1,-1, 0), color: simd_float4(0,0,1,1)),
        ]
    }
    
}

class Quad_CustomMesh: CustomMesh {
    override func createVerticies() {
        verticies = [
            Vertex(position: simd_float3( 1, 1, 0), color: simd_float4(1,0,0,1)),
            Vertex(position: simd_float3(-1, 1, 0), color: simd_float4(0,1,0,1)),
            Vertex(position: simd_float3(-1,-1, 0), color: simd_float4(0,0,1,1)),
            
            Vertex(position: simd_float3( 1, 1, 0), color: simd_float4(1,0,0,1)),
            Vertex(position: simd_float3(-1,-1, 0), color: simd_float4(0,0,1,1)),
            Vertex(position: simd_float3( 1,-1, 0), color: simd_float4(1,0,1,1)),
        ]
    }
    
}

class Cube_CustomMesh: CustomMesh {
    override func createVerticies() {
        verticies = [
            //Left
            Vertex(position: simd_float3(-1.0,-1.0,-1.0), color: simd_float4(1.0, 0.5, 0.0, 1.0)),
            Vertex(position: simd_float3(-1.0,-1.0, 1.0), color: simd_float4(0.0, 1.0, 0.5, 1.0)),
            Vertex(position: simd_float3(-1.0, 1.0, 1.0), color: simd_float4(0.0, 0.5, 1.0, 1.0)),
            Vertex(position: simd_float3(-1.0,-1.0,-1.0), color: simd_float4(1.0, 1.0, 0.0, 1.0)),
            Vertex(position: simd_float3(-1.0, 1.0, 1.0), color: simd_float4(0.0, 1.0, 1.0, 1.0)),
            Vertex(position: simd_float3(-1.0, 1.0,-1.0), color: simd_float4(1.0, 0.0, 1.0, 1.0)),
            
            //RIGHT
            Vertex(position: simd_float3( 1.0, 1.0, 1.0), color: simd_float4(1.0, 0.0, 0.5, 1.0)),
            Vertex(position: simd_float3( 1.0,-1.0,-1.0), color: simd_float4(0.0, 1.0, 0.0, 1.0)),
            Vertex(position: simd_float3( 1.0, 1.0,-1.0), color: simd_float4(0.0, 0.5, 1.0, 1.0)),
            Vertex(position: simd_float3( 1.0,-1.0,-1.0), color: simd_float4(1.0, 1.0, 0.0, 1.0)),
            Vertex(position: simd_float3( 1.0, 1.0, 1.0), color: simd_float4(0.0, 1.0, 1.0, 1.0)),
            Vertex(position: simd_float3( 1.0,-1.0, 1.0), color: simd_float4(1.0, 0.5, 1.0, 1.0)),
            
            //TOP
            Vertex(position: simd_float3( 1.0, 1.0, 1.0), color: simd_float4(1.0, 0.0, 0.0, 1.0)),
            Vertex(position: simd_float3( 1.0, 1.0,-1.0), color: simd_float4(0.0, 1.0, 0.0, 1.0)),
            Vertex(position: simd_float3(-1.0, 1.0,-1.0), color: simd_float4(0.0, 0.0, 1.0, 1.0)),
            Vertex(position: simd_float3( 1.0, 1.0, 1.0), color: simd_float4(1.0, 1.0, 0.0, 1.0)),
            Vertex(position: simd_float3(-1.0, 1.0,-1.0), color: simd_float4(0.5, 1.0, 1.0, 1.0)),
            Vertex(position: simd_float3(-1.0, 1.0, 1.0), color: simd_float4(1.0, 0.0, 1.0, 1.0)),
            
            //BOTTOM
            Vertex(position: simd_float3( 1.0,-1.0, 1.0), color: simd_float4(1.0, 0.5, 0.0, 1.0)),
            Vertex(position: simd_float3(-1.0,-1.0,-1.0), color: simd_float4(0.5, 1.0, 0.0, 1.0)),
            Vertex(position: simd_float3( 1.0,-1.0,-1.0), color: simd_float4(0.0, 0.0, 1.0, 1.0)),
            Vertex(position: simd_float3( 1.0,-1.0, 1.0), color: simd_float4(1.0, 1.0, 0.5, 1.0)),
            Vertex(position: simd_float3(-1.0,-1.0, 1.0), color: simd_float4(0.0, 1.0, 1.0, 1.0)),
            Vertex(position: simd_float3(-1.0,-1.0,-1.0), color: simd_float4(1.0, 0.5, 1.0, 1.0)),
            
            //BACK
            Vertex(position: simd_float3( 1.0, 1.0,-1.0), color: simd_float4(1.0, 0.5, 0.0, 1.0)),
            Vertex(position: simd_float3(-1.0,-1.0,-1.0), color: simd_float4(0.5, 1.0, 0.0, 1.0)),
            Vertex(position: simd_float3(-1.0, 1.0,-1.0), color: simd_float4(0.0, 0.0, 1.0, 1.0)),
            Vertex(position: simd_float3( 1.0, 1.0,-1.0), color: simd_float4(1.0, 1.0, 0.0, 1.0)),
            Vertex(position: simd_float3( 1.0,-1.0,-1.0), color: simd_float4(0.0, 1.0, 1.0, 1.0)),
            Vertex(position: simd_float3(-1.0,-1.0,-1.0), color: simd_float4(1.0, 0.5, 1.0, 1.0)),
            
            //FRONT
            Vertex(position: simd_float3(-1.0, 1.0, 1.0), color: simd_float4(1.0, 0.5, 0.0, 1.0)),
            Vertex(position: simd_float3(-1.0,-1.0, 1.0), color: simd_float4(0.0, 1.0, 0.0, 1.0)),
            Vertex(position: simd_float3( 1.0,-1.0, 1.0), color: simd_float4(0.5, 0.0, 1.0, 1.0)),
            Vertex(position: simd_float3( 1.0, 1.0, 1.0), color: simd_float4(1.0, 1.0, 0.5, 1.0)),
            Vertex(position: simd_float3(-1.0, 1.0, 1.0), color: simd_float4(0.0, 1.0, 1.0, 1.0)),
            Vertex(position: simd_float3( 1.0,-1.0, 1.0), color: simd_float4(1.0, 0.0, 1.0, 1.0))
        ]
    }
}

