import MetalKit

enum MeshTypes {
    case Triangle_Custom
    case Quad_Custom
}
class MeshLibrary {
    private static var meshes: [MeshTypes:Mesh] = [:]
    
    public static func Initialize() {
        createDefaultMeshes()
    }
    
    private static func createDefaultMeshes() {
        meshes.updateValue(Triangle_CustomMesh(), forKey: .Triangle_Custom)
        meshes.updateValue(Quad_CustomMesh(), forKey: .Quad_Custom)
    }
    
    public static func Mesh(_ meshType: MeshTypes)->Mesh{
        return meshes[meshType]!
    }
}

protocol Mesh {
    var vertexBuffer: MTLBuffer! { get }
    var vertexCount: Int! { get }
}

class CustomMesh: Mesh {
    var verticies: [Vertex]!
    var vertexBuffer: MTLBuffer!
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
            Vertex(position: simd_float3( 0.5, 0.5, 0), color: simd_float4(1,0,0,1)),
            Vertex(position: simd_float3(-0.5, 0.5, 0), color: simd_float4(0,1,0,1)),
            Vertex(position: simd_float3(-0.5,-0.5, 0), color: simd_float4(0,0,1,1)),
            
            Vertex(position: simd_float3( 0.5, 0.5, 0), color: simd_float4(1,0,0,1)),
            Vertex(position: simd_float3(-0.5,-0.5, 0), color: simd_float4(0,0,1,1)),
            Vertex(position: simd_float3( 0.5,-0.5, 0), color: simd_float4(1,0,1,1)),
        ]
    }
    
}

