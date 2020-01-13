//
//  Alert.swift
//  RubyTextViewerProto
//
//  Created by mini2019 on 2020/01/12.
//  Copyright © 2020 mini2019. All rights reserved.
//

import Foundation
import UIKit

class Alert {
    
    var okCallBack:()->Void
    
    init(okCallBack:@escaping ()->Void) {
        self.okCallBack = okCallBack
    }
    
    func showAlert(_ alertTitle: String, alertMessage: String, viewController: UIViewController)
    {
        DispatchQueue.main.async {
            let alert: UIAlertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
            let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
                (action: UIAlertAction!) -> Void in
                do {
                    self.okCallBack()
                }
            })
            alert.addAction(defaultAction)
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
}
