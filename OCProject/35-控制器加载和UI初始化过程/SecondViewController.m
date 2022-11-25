//
//  SecondViewController.m
//  35-控制器加载和UI初始化过程
//
//  Created by Fearless on 2020/4/5.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "SecondViewController.h"
#import "SecondView.h"
#import "NSObject+SYKVO.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (instancetype)init {
    NSLog(@"%s", __func__);
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    NSLog(@"%s", __func__);
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}


/**
 loadView里面什么都不写，那么控制器的view是nil
 MVCS loadView KVO
 控制器 和 view分开，将控制器的作用弱化
  loadView重写了，如果想要加载xib，必须得指定xib

 */
- (void)loadView {
    NSLog(@"2---loadView");
//    [super loadView];
    SecondView *view = [[SecondView alloc] init];
    self.view = view;
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"2---viewWillAppear");

    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"2---viewDidAppear");
}

// 布局代码的安全操作
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    // view的大小 尺寸
}

- (void)viewDidLoad {
    [super viewDidLoad];

    NSLog(@"2---viewDidLoad");
    [self.view addObserverSuny:self keyPath:@"pushToThreeVC" block:^(id newValue) {
        NSLog(@"处理业务");
    }];

}



@end
