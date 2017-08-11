//
//  BroadcastHandle.h
//  Broadcast
//
//  Created by 石晴露 on 2017/8/11.
//  Copyright © 2017年 Arvin.shi. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <CoreBluetooth/CoreBluetooth.h>
@interface BroadcastHandle : NSObject

void Broadcast(Byte *byte, int len);
@property (nonatomic, strong) NSData *data;
@property (nonatomic, strong) CBPeripheralManager *manager;
+ (instancetype)shareInstance;
@end
