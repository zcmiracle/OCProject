//
//  LockViewController.m
//  36-线程组
//
//  Created by XFB on 2020/4/7.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "LockViewController.h"
#import "SemaphoreLock.h"

@interface LockViewController ()
{
    SemaphoreLock *_semaphoreLock;
}
@end

@implementation LockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"NSLock";
    
    _semaphoreLock = [SemaphoreLock new];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [_semaphoreLock signalLock];
}

@end
