import Foundation

class HiraganaSingleton: NSObject {
    var data = HiraganaData(original: "", result: "")
    
    static let sharedInstance: HiraganaSingleton = HiraganaSingleton()
    private override init() {}
    
    // ひらがな変換前の文字列
    var original:String {
        get {
            return data.original
        }
        set {
            data.original = newValue
        }
    }
    
    // ひらがな変換後の文字列
    var result:String {
        get {
            return data.result
        }
        set {
            data.result = newValue
        }
    }
    
}
