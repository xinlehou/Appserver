//
//  CFMessagePortSend.swift
//  AppServer
//
//  Created by 侯新乐 on 2017/7/18.
//  Copyright © 2017年 侯新乐. All rights reserved.
//

import Cocoa


enum CFMessageSendError : Error{
    case unablePort // 端口错误 or 没有 监听者
    case other      // 其他错误
}

/// 发送消息
func cfMessageSend(port: String, data: Data) throws {
    if let serverPort = CFMessagePortCreateRemote(nil, port as CFString) {
        let data = CFDataCreate(nil, data.cf_toPointer(),CFIndex(data.count))
        let sendResult = CFMessagePortSendRequest(serverPort,
                                                  1,
                                                  data,
                                                  0,
                                                  10,
                                                  nil,
                                                  nil);
        
        if sendResult == Int32(kCFMessagePortSuccess) {
            print("Client: success!")
        }
        else {
            print("Client error: \(sendResult)")
            throw CFMessageSendError.other
        }
    }
    else {
        print("Client: Unable to open server port")
        throw CFMessageSendError.unablePort
    }

}

extension Dictionary {
    /// 字典转JSON
    func cf_toJSONString() -> String? {
        let data = try? JSONSerialization.data(withJSONObject: self, options: [])
        let str = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
        return str as String?
    }
}

extension Data {
    func cf_toPointer() -> UnsafePointer<UInt8>? {
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: self.count)
        let stream = OutputStream(toBuffer: buffer, capacity: self.count)
        stream.open()
        self.withUnsafeBytes({ (p: UnsafePointer<UInt8>) -> Void in
            stream.write(p, maxLength: self.count)
        })
        stream.close()
        return UnsafePointer<UInt8>(buffer)
    }
}

extension String {
    func cf_toPointer() -> UnsafePointer<UInt8>? {
        guard let data = self.data(using: String.Encoding.utf8) else { return nil }
        return data.cf_toPointer()
    }
    
    func cf_toData() -> Data? {
         return self.data(using: String.Encoding.utf8)
    }
}
