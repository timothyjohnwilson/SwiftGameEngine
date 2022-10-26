import MetalKit


class SandboxScene: Scene {
    
    var debugCamera = DebugCamera()
    
    var cube = Cube()
    
    var cubeCollection:CubeCollection!
    var cubeCollection2:CubeCollection!
    
    override func buildScene() {
        addCamera(debugCamera)
        debugCamera.position.z = 100
        
        addCubes()
    }
    
    func addCubes() {
        cubeCollection = CubeCollection(cubesWide: 20, cubesHigh: 20, cubesBack: 20)
        cubeCollection.position.x = -16
        
        cubeCollection2 = CubeCollection(cubesWide: 20, cubesHigh: 20, cubesBack: 20)
        cubeCollection2.position.x = 16
        addChild(cubeCollection)
        addChild(cubeCollection2)
    }
    
    override func update(deltaTime:Float) {
        cubeCollection.rotation.z += deltaTime
        cubeCollection2.rotation.z -= deltaTime
        
        super.update(deltaTime: deltaTime)
    }
    
}
