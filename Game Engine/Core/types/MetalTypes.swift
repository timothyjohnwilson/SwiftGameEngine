import simd

protocol sizeable { }

extension sizeable{
    static var size: Int {
        return MemoryLayout<Self>.size
    }
    
    static var stride: Int {
        return MemoryLayout<Self>.stride
    }
    
    static func size(_ count: Int)->Int {
        return MemoryLayout<Self>.size * count
    }
    
    static func stride(_ count: Int)->Int{
        return MemoryLayout<Self>.stride * count
    }
}

extension simd_float2: sizeable {}
extension simd_float3: sizeable {}
extension simd_float4: sizeable {}
extension Float: sizeable {}

struct Vertex: sizeable {
    var position: simd_float3
    var color: simd_float4
    var textureCoordinate: simd_float2
    
}

struct ModelConstants: sizeable {
    var modelMatrix = matrix_identity_float4x4
}


struct SceneConstants: sizeable {
    var totalGameTime: Float = 0
    var viewMatrix = matrix_identity_float4x4
    var projectionMatrix = matrix_identity_float4x4
}

struct Material: sizeable {
    var color = simd_float4(0.8, 0.8, 0.8, 1.0)
    var useMaterialColor: Bool = false
    var useTexture: Bool = false
}
