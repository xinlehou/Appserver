//
//  LaunchAgentsTool.swift
//  HYPiano
//
//  Created by 侯新乐 on 2017/7/20.
//  Copyright © 2017年 yanbin. All rights reserved.
//

import Cocoa

let macbookPwd = "p" // 电脑密码 可以自己弹窗要求用户输入密码

class LaunchAgentsTool: NSObject {

    static let plistName = "com.xinle.Appserver.LaunchAgents.plist"
    static let executableFileName = "AppServerLaunchdAgents"
    static let launchAgentsPath = "/Library/LaunchAgents"
    static let sharePath = "/Users/Shared"

    /// plist bundle地址
    static var launchAgentsPlistBundlePath: String {
        return (Bundle.main.resourcePath ?? "").appending("/\(plistName)")
    }
    /// 可执行文件 bundle地址
    static var executableFileBundlePath: String {
        return Bundle.main.bundlePath.appending("/Contents/SharedSupport/\(executableFileName)")
    }

    /// 检查开机启动项
    static func checkPowerboot() {
        if !FileManager.default.fileExists(atPath: launchAgentsPath.appending("/\(plistName)")) { // 不存在
            let process = Process()
            process.launchPath = "/bin/bash"
            process.arguments = ["-c", "echo \(macbookPwd) | sudo -S cp \(launchAgentsPlistBundlePath) \(launchAgentsPath)"]
            process.launch()
            
//          如果开机启动 没起作用 则打开注释
//            let process1 = Process()
//            process1.launchPath = "/bin/bash"
//            process1.arguments = ["-c", "echo \(macbookPwd) | sudo -S launchctl load \(launchAgentsPath.appending("/\(plistName)"))"]
//            process1.launch()
            
        }
        if !FileManager.default.fileExists(atPath: sharePath.appending("/\(executableFileName)")) { // 不存在
            let process = Process()
            process.launchPath = "/bin/bash"
            process.arguments = ["-c", "echo \(macbookPwd) | sudo -S cp \(executableFileBundlePath) \(sharePath)"]
            process.launch()
        }
        
        
    }

}
