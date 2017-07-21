//
//  CFMessagePortReceive.swift
//  AppServer
//
//  Created by 侯新乐 on 2017/7/18.
//  Copyright © 2017年 侯新乐. All rights reserved.
//

import Cocoa

public typealias CFMessagePortReceiveBlcok = (_ data: Data)->(Data?)


class CFMessagePortReceive: NSObject {
    
    var mMsgPortListenner: CFMessagePort!
    var port: String  {
       return _port
    }
    private var _port: String
    private var block: CFMessagePortReceiveBlcok
    
    init(port: String,callback: @escaping CFMessagePortReceiveBlcok) {
        self._port = port
        self.block = callback
        super.init()
    }
    
    private override init() {
        self._port = ""
        self.block = { data in
            return nil
        }
        super.init()
    }
  
    /// 消息接收 回调
    func handleMessage(_ data: Data) -> Data? {
        return self.block(data)
    }
    
    
    /// 开始监听
    func startListenning() {
        if (nil != mMsgPortListenner && CFMessagePortIsValid(mMsgPortListenner))
        {
            CFMessagePortInvalidate(mMsgPortListenner);
            self.mMsgPortListenner = nil
        }
        
        var context = CFMessagePortContext(
            version: 0,
            info: GetRecivedCallbackInfo(self),
            retain: nil,
            release: nil,
            copyDescription: nil)
        
        mMsgPortListenner = CFMessagePortCreateLocal(nil,
                                                     self._port as CFString,
                                                     GetRecivedCallback(),
                                                     &context,
                                                     nil)
        let source = CFMessagePortCreateRunLoopSource(nil, mMsgPortListenner, 0)
        CFRunLoopAddSource(CFRunLoopGetCurrent(), source, CFRunLoopMode.commonModes)
        
    }
    
    
    
    /// 结束监听
    func stopListenning() {
        CFMessagePortInvalidate(mMsgPortListenner);
        self.mMsgPortListenner = nil
    }
    
    
}



