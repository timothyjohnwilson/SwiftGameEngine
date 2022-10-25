import simd


protocol Camera {
    var cameraType: CameraTypes { get }
    var position: simd_float3 {get set}
    func update(deltaTime: Float)
}

extension Camera {
    var viewMatrix: simd_float4x4 {
        var viewMatrix = matrix_identity_float4x4
        
        viewMatrix.translate(direction: -position)
        
        return viewMatrix
    }
    
    func update() { }
}
