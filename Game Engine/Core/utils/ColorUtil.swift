import simd

class ColorUtil {
    
    public static var randomColor: simd_float4  {
        return simd_float4(Float.randomZeroToOne, Float.randomZeroToOne, Float.randomZeroToOne, 1.0)
    }
}
