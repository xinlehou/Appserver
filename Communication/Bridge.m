//
//  Bridge.m
//  AppServer
//
//  Created by 侯新乐 on 2017/7/18.
//  Copyright © 2017年 侯新乐. All rights reserved.
//

#import "Bridge.h"
#import "AppServer-Swift.h"


static CFDataRef ServerCallback(CFMessagePortRef local, SInt32 msgid, CFDataRef data, void *info) {
    CFMessagePortReceive *recived = (__bridge CFMessagePortReceive *)info;
    NSData *responseData = [recived handleMessage:(__bridge NSData *)(data)];
    if (responseData != NULL) {
        CFDataRef cfdata = CFDataCreate(nil, responseData.bytes, responseData.length);
        return cfdata;
    }
    else {
        return NULL;
    }
}

CFMessagePortCallBack GetRecivedCallback() {
    return ServerCallback;
}

void *GetRecivedCallbackInfo(CFMessagePortReceive *recive) {
    return (__bridge void *)recive;
}
