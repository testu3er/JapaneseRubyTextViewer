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

    // テキストの入力が空の場合は、変換ボタンを押せないようにする
    func checkExecButtonPermissionForTextLength(textLength: Int)
    {
        execButton.isEnabled = (textLength > 0) ? true : false
    }

    @IBAction func inputTextEditingChanged(_ textField: UITextField)
    {
        let resultText: String = textField.text!
        checkExecButtonPermissionForTextLength(textLength: resultText.utf8.count)
    }
    
    // 変換するボタンを押した時の処理
    @IBAction func buttonTapped(_ sender : Any)
    {
        let _post = "app_id="+AppID+"&sentence="+inputTextField.text!+"&output_type="+OutputType;
        urlRequestController.postRequest(HiraganaServiceUrl, post: _post)
    }
    
    // ひらがな変換を行った後のサーバーからのレスポンスが正常だった場合
    func urlRequestCompleteCallBack(response:Dictionary<String, Any>)
    {
        // 結果画面へ遷移
        let storyboard: UIStoryboard = self.storyboard!
        let resultView = storyboard.instantiateViewController(withIdentifier: "ResultView") as! ResultViewController
        resultView.hiraganaSingleton.result = response["converted"] as! String
        resultView.hiraganaSingleton.original = self.inputTextField.text!
        resultView.modalTransitionStyle = .flipHorizontal
        DispatchQueue.main.async {
            self.present(resultView, animated: true, completion: nil)
        }
    }
    
    // ひらがな変換を行った後のサーバーからのレスポンスがエラーだった場合
    func urlRequestErrorCallBack(response:Dictionary<String, Any>)
    {
        let errorCode: String = response["code"] as! String
        alert.showAlert("エラーコード:" + errorCode, alertMessage: response["message"] as! String, viewController: self)
    }
    
    // テキスト以外の場所をタップしたら、仮想キーボードを消す
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

