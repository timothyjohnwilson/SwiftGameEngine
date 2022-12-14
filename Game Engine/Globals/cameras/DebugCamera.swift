import simd

class DebugCamera: Camera {
    
    override var projectionMatrix: matrix_float4x4 {
        return matrix_float4x4.perspective(degreesFov: 45, aspectRatio: Renderer.AspectRatio, near: 0.1, far: 1000)
    }
    
    init() {
        super.init(cameraType: .Debug)
    }
    
    override func doUpdate() {
        if(Keyboard.IsKeyPressed(.leftArrow)){
            self.moveX(-GameTime.DeltaTime)
        }
           
        if(Keyboard.IsKeyPressed(.rightArrow)){
            self.moveX(GameTime.DeltaTime)
        }
           
        if(Keyboard.IsKeyPressed(.upArrow)){
            self.moveY(GameTime.DeltaTime)
        }
           
        if(Keyboard.IsKeyPressed(.downArrow)){
            self.moveY(-GameTime.DeltaTime)
        }
    }
}
