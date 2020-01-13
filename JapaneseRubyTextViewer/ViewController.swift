//
//  ViewController.swift
//  RubyTextViewerProto
//
//  Created by mini2019 on 2020/01/11.
//  Copyright © 2020 mini2019. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var execButton :UIButton!
    @IBOutlet weak var inputTextField: UITextField!
    
    let hiraganaSingleton :HiraganaSingleton = HiraganaSingleton.sharedInstance
    
    var alert:Alert!
    
    let AppID: String = "180885c7f439f2826984a75c4fb9bf22972e7955cf3f9b98add65b63530cc791"
    let HiraganaServiceUrl: String = "https://labs.goo.ne.jp/api/hiragana"
    let OutputType: String = "hiragana"
    var urlRequestController:URLRequestController!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        inputTextField.text = hiraganaSingleton.original
        checkExecButtonPermissionForTextLength(textLength: hiraganaSingleton.original.utf8.count)

        alert = Alert (
            okCallBack: { ()->Void in
                self.okCallBack()
            }
        )

        urlRequestController = URLRequestController (
            completeCallBack: {
                (resonse:Dictionary<String, Any>)->Void in
                self.urlRequestCompleteCallBack(response: resonse)
            },
            errorCallBack: {
                (resonse:Dictionary<String, Any>)->Void in
                self.urlRequestErrorCallBack(response: resonse)
            }
        )
    }
    
    func okCallBack()
    {
        // 特に処理をしない
    }

    func checkExecButtonPermissionForTextLength(textLength: Int)
    {
        execButton.isEnabled = (textLength > 0) ? true : false
    }

    @IBAction func inputTextEditingChanged(_ textField: UITextField)
    {
        let resultText: String = textField.text!
        checkExecButtonPermissionForTextLength(textLength: resultText.utf8.count)
    }
    
    @IBAction func buttonTapped(_ sender : Any)
    {
        let _post = "app_id="+AppID+"&sentence="+inputTextField.text!+"&output_type="+OutputType;
        urlRequestController.postRequest(HiraganaServiceUrl, post: _post)
    }
    
    func urlRequestCompleteCallBack(response:Dictionary<String, Any>)
    {
        // TODO 結果画面へ遷移
    }
    
    func urlRequestErrorCallBack(response:Dictionary<String, Any>)
    {
        let errorCode: String = response["code"] as! String
        alert.showAlert("エラーコード:" + errorCode, alertMessage: response["message"] as! String, viewController: self)
    }
    
}

