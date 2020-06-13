//
//  ViewController.swift
//  SwiftToolsKitDemo
//
//  Created by depler on 2020/6/12.
//  Copyright © 2020 DePeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(isPhoneNumber("19999999999") ? "是手机号" : "重新输入")
        print(Date().stk.toString(style: "YYYY-MM-dd HH:mm:ss"))
        UILabel(text: "SwiftToolsKit", textColor: .red, font: .systemFont(ofSize: 16))
        
    }


}

