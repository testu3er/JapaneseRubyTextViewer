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
    
    @IBAction func inputTextEditingChanged(_ textField: UITextField)
    {
        // TODO テキストが空の場合は、ひらがな変換ボタンを押せないようにする
    }
    
    @IBAction func buttonTapped(_ sender : Any)
    {
        // TODO ひらがな変換処理を行う
    }
    
}

