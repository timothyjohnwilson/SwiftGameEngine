
class Library<T,K> {
    init() {
        fillLibrary()
    }
    
    func fillLibrary() {
        //override with defaults
    }
    
    subscript(_ type: T)->K? {
        return nil
    }
}
