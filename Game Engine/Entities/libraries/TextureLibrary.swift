import MetalKit

enum TextureTypes {
    case None
    case PartyPirateParot
}

class TextureLibrary: Library<TextureTypes, MTLTexture> {
    private var library: [TextureTypes: Texture] = [:]
    
    override func fillLibrary() {
        library.updateValue(Texture("PartyPirateParot"), forKey: .PartyPirateParot)
    }
    
    override subscript(_ type: TextureTypes) -> MTLTexture? {
        return library[type]?.texture
    }
}

class Texture {
    var texture: MTLTexture!
    
    init(_ textureName: String, ext: String = "png", origin: TextureOrigin = TextureOrigin.TopLeft) {
        let textureLoader = TextureLoader(textureName: textureName, textureExtension: ext, origin: origin)
        let texture = textureLoader.loadTextureFromBundle()
        setTexture(texture)
    }
    
    func setTexture(_ texture: MTLTexture) {
        self.texture = texture
    }
}

public enum TextureOrigin {
    case TopLeft
    case BottomLeft
}

class TextureLoader {
    private var _textureName: String!
    private var _textureExtension: String!
    private var _origin: MTKTextureLoader.Origin!
    
    init(textureName: String, textureExtension: String = "png", origin: TextureOrigin = TextureOrigin.TopLeft) {
        self._textureName = textureName
        self._textureExtension = textureExtension
        self.setTextureOrigin(origin)
    }
    
    private func setTextureOrigin(_ textureOrigin: TextureOrigin) {
        switch textureOrigin {
        case .TopLeft:
            self._origin = MTKTextureLoader.Origin.topLeft
        case .BottomLeft:
            self._origin = MTKTextureLoader.Origin.bottomLeft
        }
    }
    
    public func loadTextureFromBundle()->MTLTexture {
        var result: MTLTexture!
        
        if let url = Bundle.main.url(forResource: _textureName, withExtension: self._textureExtension) {
            let textureLoader = MTKTextureLoader(device: Engine.Device)
            
            let options: [MTKTextureLoader.Option: Any] = [MTKTextureLoader.Option.origin: _origin]
            
            do {
            result = try textureLoader.newTexture(URL: url, options: options)
            result.label = _textureName
            
            } catch let error as NSError {
                print("ERROR::CREATING::TEXTURE::__\(_textureName!)__::\(error)")
            }
        } else {
            print("ERROR::CREATING::TEXTURE::__\(_textureName!) does not exist")
        }
        
        return result
    }
}
