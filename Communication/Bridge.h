//
//  Bridge.h
//  AppServer
//
//  Created by 侯新乐 on 2017/7/18.
//  Copyright © 2017年 侯新乐. All rights reserved.
//

#import <Foundation/Foundation.h>



@class CFMessagePortReceive;

/// Return the callback function to be passed to CFMessagePortCreateLocal()
extern CFMessagePortCallBack GetRecivedCallback();

/// Return the value to be used as the `info` field in CFMessagePortContext
extern void *GetRecivedCallbackInfo(CFMessagePortReceive *recive);

