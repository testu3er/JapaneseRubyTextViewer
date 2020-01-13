//
//  URLRequestController.swift
//  RubyTextViewerProto
//
//  Created by mini2019 on 2020/01/12.
//  Copyright © 2020 mini2019. All rights reserved.
//

import Foundation

class URLRequestController {
    
    var completeCallBack:(Dictionary<String, Any>)->Void
    var errorCallBack:(Dictionary<String, Any>)->Void
    
    init(completeCallBack:@escaping (Dictionary<String, Any>)->Void, errorCallBack:@escaping (Dictionary<String, Any>)->Void) {
        self.completeCallBack = completeCallBack
        self.errorCallBack = errorCallBack
    }
    
    func postRequest(_ _url: String, post: String)
    {
        let url = URL(string: _url)
        guard let requestUrl = url else { fatalError() }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        
        request.httpBody = post.data(using: String.Encoding.utf8);
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // サーバーからのレスポンスエラー
            if let error = error {
                let errorDict = ["code": "", "message": error.localizedDescription];
                self.errorCallBack(errorDict)
                return
            }
            
            if let data = data, let responseData = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(responseData)")
                let dic = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
                
                // サーバーからのレスポンスエラー
                if dic["error"] != nil {
                    let error:Dictionary = dic["error"] as! Dictionary<String, Any>
                    let message:String = error["message"] as! String
                    let errorCode:String = (error["code"] as! Int).description
                    let errorDict = ["code": errorCode, "message": message];
                    self.errorCallBack(errorDict)
                    return
                }

                // サーバーからのレスポンス成功
                print("converted: \(dic["converted"] as! String)")
                print("output_type: \(dic["output_type"] as! String)")
                print("request_id: \(dic["request_id"] as! String)")
                
                let completeDict = dic;
                self.completeCallBack(completeDict)
            }
        }
        task.resume()
    }
}
