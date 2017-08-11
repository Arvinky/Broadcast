//
//  BroadcastHandle.m
//  Broadcast
//
//  Created by 石晴露 on 2017/8/11.
//  Copyright © 2017年 Arvin.shi. All rights reserved.
//

#import "BroadcastHandle.h"
#import "AppDelegate.h"
@interface BroadcastHandle () <CBPeripheralManagerDelegate>

@property (nonatomic, strong) NSUUID *proximityUUID;
@end
#define UUID1 @"FFF9"
#define MaxLen (21)
void Broadcast(Byte *byte, int len) {
    Byte tempData[21];
    memset(tempData, 0, 21);
    if (len>MaxLen) {
        len = MaxLen;
    }
    memcpy(tempData, byte, len);
    NSString *beaconKey = @"kCBAdvDataAppleBeaconKey";
    Byte uuidbyte[4] = {0xff, 0xff,0xff, 0xf9};
    NSData *data = [NSData dataWithBytes:tempData length:21];
    CBUUID *uuid = [CBUUID UUIDWithData:[NSData dataWithBytes:uuidbyte length:4]];
    NSDictionary *dic =@{
                         beaconKey:data,
                         CBAdvertisementDataServiceUUIDsKey : @[uuid]
                         };
    NSLog(@"%@", dic);
    
    [[BroadcastHandle shareInstance].manager startAdvertising:dic];
    
}
@implementation BroadcastHandle

- (instancetype)init {
    if (self = [super init]) {
        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                                 @"ARRestoreIdentifier",CBCentralManagerOptionRestoreIdentifierKey, nil];
        _manager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil options:options];
    }
    return self;
}

static BroadcastHandle *handle = nil;
+ (instancetype)shareInstance {

    static dispatch_once_t token;
    dispatch_once(&token, ^{
        handle = [[BroadcastHandle alloc] init];
    });
    return handle;
}
- (void)peripheralManager:(CBPeripheralManager *)peripheral willRestoreState:(NSDictionary<NSString *,id> *)dict {

    NSLog(@"willRestoreState->%s",__func__);
}
- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral {
    if (self.UpdataState) {
        self.UpdataState(peripheral.state);
    }
}
- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(NSError *)error {
    NSLog(@"%s",__func__);
}
@end
