import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet var retButton :UIButton!
    @IBOutlet var resultTextView :UITextView!
    @IBOutlet var clipCopyButton :UIButton!
    
    let hiraganaSingleton :HiraganaSingleton = HiraganaSingleton.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Texiviewに枠を付ける
        // 枠のカラー
        resultTextView.layer.borderColor = UIColor.black.cgColor
        // 枠の幅
        resultTextView.layer.borderWidth = 1.0
        
        resultTextView.text = hiraganaSingleton.result
    }
    
    @IBAction func retButtonTapped(_ sender : Any)
    {
        // TODO ひらがな変換画面へ遷移
    }
    
    @IBAction func pasteBoardButtonTapped(_ sender : Any)
    {
        UIPasteboard.general.string = resultTextView.text
    }

}
