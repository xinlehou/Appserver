//
//  main.swift
//  AppServerLaunchdAgents
//
//  Created by 侯新乐 on 2017/7/22.
//  Copyright © 2017年 xinle. All rights reserved.
//

import Foundation


let path = "/Applications/TextEdit.app" // 可替换为MainApp路径 
let task = Process()
task.launchPath = "/usr/bin/open"
task.arguments = [path]
task.launch()
