import MetalKit


class SandboxScene: Scene {
    
    var debugCamera = DebugCamera()
    
    var cube = Cube()
    
    override func buildScene() {
        addCamera(debugCamera)
        debugCamera.position.z = 6
        
        addCubes()
    }
    
    func addCubes() {
        for y in -5..<5 {
            let posY = Float(y) + 0.5
            for x in -8..<8 {
                let posX = Float(x) + 0.5
                let cube = Cube()
                cube.position.y  = posY
                cube.position.x = posX
                cube.scale = simd_float3(repeating: 0.3)
                cube.setColor(ColorUtil.randomColor)
                addChild(cube)
            }
        }
    }
}
