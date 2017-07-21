//
//  ViewController.swift
//  MainApp
//
//  Created by 侯新乐 on 2017/7/21.
//  Copyright © 2017年 xinle. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        AppServerMessageModel(cmd: "startMainApp", value: "1").sendMessage(port: appserverPort)
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

