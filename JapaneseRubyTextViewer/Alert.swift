import Foundation
import UIKit

class Alert {
    
    var okCallBack:()->Void
    
    init(okCallBack:@escaping ()->Void) {
        self.okCallBack = okCallBack
    }
    
    // アラートを表示します
    func showAlert(_ alertTitle: String, alertMessage: String, viewController: UIViewController)
    {
        DispatchQueue.main.async {
            let alert: UIAlertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
            let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
                (action: UIAlertAction!) -> Void in
                do {
                    // initで指定した場所にコールバックします
                    self.okCallBack()
                }
            })
            alert.addAction(defaultAction)
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
}
