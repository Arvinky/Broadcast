//
//  ViewController.m
//  Broadcast
//
//  Created by 石晴露 on 2017/8/11.
//  Copyright © 2017年 Arvin.shi. All rights reserved.
//

#import "ViewController.h"
#import "BroadcastHandle.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *s;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[BroadcastHandle shareInstance] setUpdataState:^(CBManagerState state){
        if (state!=CBManagerStatePoweredOn) {
            NSURL *url = [NSURL URLWithString:@"prefs:root=General&path=Bluetooth"];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            }
        }else{
            [self sendData];
        }
    }];
}

- (void)sendData {
    Byte byte[22];
    memset(byte, 0x1f, 22);
    Broadcast(byte, 22);
    NSTimeInterval delay = 5 * 60;
    NSLog(@"begin: %.5f", [[NSDate date] timeIntervalSince1970]);
    [self performSelector:@selector(stopA) withObject:nil afterDelay:delay];
}
- (void)stopA {
    [[BroadcastHandle shareInstance].manager stopAdvertising];
    self.s.on = NO;
    NSLog(@"begin: %.5f", [[NSDate date] timeIntervalSince1970]);
}
- (IBAction)startAdvertisment:(UISwitch *)sender {
    NSLog(@"哈哈哈哈%s", __func__);
    if (sender.on) {
        if ([BroadcastHandle shareInstance].manager.state==CBManagerStatePoweredOn) {
            [self sendData];
        }else{
            return;
        }
    }else{
        [[BroadcastHandle shareInstance].manager stopAdvertising];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
