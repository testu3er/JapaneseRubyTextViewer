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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
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
        // TODO ひらがな変換処理を行う
    }
    
}

