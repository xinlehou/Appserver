//
//  AppServerMessageModel.swift
//  AppServer
//
//  Created by 侯新乐 on 2017/7/18.
//  Copyright © 2017年 侯新乐. All rights reserved.
//

import Cocoa

let appserverPort = "com.xinle.appServer"

class AppServerMessageModel: NSObject {

    var cmd: String!
    var value: Any!
    
    init(cmd: String, value: Any) {
        self.cmd = cmd
        self.value = value
        super.init()
    }
    
    convenience init(data: Data) {
        
        do {
            guard let dic = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableLeaves) as? [String: Any] else {
                self.init(cmd: "", value: "")
                return
            }
            self.init(cmd: dic["cmd"] as? String ?? "", value:  dic["cmd"] ?? "")
        } catch  {
            self.init(cmd: "", value: "")
            print(error)
        }
        
    }
    
    func toData() -> Data {
        let dic = ["cmd": cmd,"value": value]
        return dic.cf_toJSONString()?.cf_toData() ?? Data()
    }
    
    func sendMessage(port: String) {
        do {
            try cfMessageSend(port: port, data: self.toData())
        } catch  {
            print(error)
        }
        
        
    }
    
}
