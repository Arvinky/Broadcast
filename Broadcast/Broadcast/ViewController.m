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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [BroadcastHandle shareInstance];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
