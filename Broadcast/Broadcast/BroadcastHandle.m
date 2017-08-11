//
//  BroadcastHandle.m
//  Broadcast
//
//  Created by 石晴露 on 2017/8/11.
//  Copyright © 2017年 Arvin.shi. All rights reserved.
//

#import "BroadcastHandle.h"
@interface BroadcastHandle () <CBPeripheralManagerDelegate>

@property (nonatomic, strong) NSUUID *proximityUUID;
@end
static BroadcastHandle *handle = nil;
void Broadcast(Byte *byte, int len) {
    NSData *data = [NSData dataWithBytes:byte length:len];
    [BroadcastHandle shareInstance].data = data;
    
}
@implementation BroadcastHandle

- (instancetype)init {
    if (self = [super init]) {
        _manager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil];
    }
    return self;
}
+ (instancetype)shareInstance {
    
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        handle = [[BroadcastHandle alloc] init];
    });
    return handle;
}
- (void)starAdvertise {
    NSString *beaconKey = @"kCBAdvDataAppleBeaconKey";
    NSLog(@"%@", self.data);
    if (!_data) {
        Byte byte[21] = {0,1,2,3,4,5,6,7,8,9,0xa,0xb,0xc,0xd,0xe,0xf};
        _data = [NSData dataWithBytes:byte length:21];
    }
    [self.manager startAdvertising:@{beaconKey:self.data}];
}
- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral {
    switch (peripheral.state) {
        case CBManagerStatePoweredOn:
        {
            [self starAdvertise];
            
        }
            break;
            
        default:
            break;
    }
}
- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(NSError *)error {
    NSLog(@"%s",__func__);
}
@end
