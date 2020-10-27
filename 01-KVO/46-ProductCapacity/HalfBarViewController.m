//
//  HalfBarViewController.m
//  46-ProductCapacity
//
//  Created by Fearless on 2020/10/27.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "HalfBarViewController.h"
#import "CourseHeatViewHalfView.h"

@interface HalfBarViewController ()

@end

@implementation HalfBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(8, 17, 42);

    
    CourseHeatViewHalfView *halfView = [[CourseHeatViewHalfView alloc] init];
    halfView.frame = CGRectMake(0, 200, ScreenWidth/2-10, 200);
    halfView.backgroundColor = RGB(8, 17, 42);
    [self.view addSubview:halfView];
    
    NSArray *dataArray = @[
        @{ @"number" : @"318", @"type" : @"銑削B141檢驗與包裝" },
        @{ @"number" : @"258", @"type" : @"B591銑削段檢驗包裝" },
        @{ @"number" : @"244", @"type" : @"B591  安全(1)" },
        @{ @"number" : @"238", @"type" : @"B591銑削段工藝流程" },
        @{ @"number" : @"235", @"type" : @"B141銑削段安全操作流程" },
    ];
    [halfView setDataArray:dataArray];
}

@end
