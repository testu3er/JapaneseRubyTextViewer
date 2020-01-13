//
//  HiraganaSingleton.swift
//  RubyTextViewerProto
//
//  Created by mini2019 on 2020/01/12.
//  Copyright © 2020 mini2019. All rights reserved.
//

import Foundation

class HiraganaSingleton: NSObject {
    var data = HiraganaData(original: "", result: "")
    
    static let sharedInstance: HiraganaSingleton = HiraganaSingleton()
    private override init() {}
    
    var original:String {
        get {
            return data.original
        }
        set {
            data.original = newValue
        }
    }
    
    var result:String {
        get {
            return data.result
        }
        set {
            data.result = newValue
        }
    }
    
}
