//
//  AppDelegate.swift
//  AppServer
//
//  Created by 侯新乐 on 2017/7/21.
//  Copyright © 2017年 xinle. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    var statusMenu: NSMenu!
    var recived: CFMessagePortReceive!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusMenu = NSMenu(title: "")
        let item0 = NSMenuItem(title: "启动App", action: #selector(startApp), keyEquivalent: "")
        item0.isEnabled = true
        statusMenu.insertItem(item0, at: 0)
        
        let item1 = NSMenuItem(title: "设置", action: #selector(setting), keyEquivalent: "")
        item1.isEnabled = true
        statusMenu.insertItem(item1, at: 1)
        
        let item2 = NSMenuItem(title: "退出", action: #selector(exit), keyEquivalent: "")
        item2.isEnabled = true
        statusMenu.insertItem(item2, at: 2)
        
        let icon = NSImage(named: "icon1")
        statusItem.image = icon
        statusItem.menu = statusMenu
        
        
        recived = CFMessagePortReceive(port: appserverPort, callback: { (data) -> (Data?) in
            let model = AppServerMessageModel(data: data)
            print(model.cmd)
            return nil
        })
        recived.startListenning()
        
        LaunchAgentsTool.checkPowerboot()
      
    }
    
    
    func setting() {
    }
    
    func exit() {
        NSApplication.shared().terminate(self)
    }
    
    func startApp()  {
        let path = Bundle.main.bundlePath.appending("/Contents/SharedSupport/MainApp.app")
        let task = Process()
        task.launchPath = "/usr/bin/open"
        task.arguments = [path]
        task.launch()
    }
    

}

