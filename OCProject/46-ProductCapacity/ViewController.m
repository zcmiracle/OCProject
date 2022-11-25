//
//  ViewController.m
//  46-ProductCapacity
//
//  Created by XFB on 2020/10/21.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "ViewController.h"
#import "ProductCapacityHeaderView.h"
#import "EducationTrainHeaderView.h"
#import "HalfBarViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGB(8, 17, 42);
//    self.view.backgroundColor = UIColorFromRGB(0x051328);
    self.view.backgroundColor = UIColorFromRGB(0xFFFFFF);

    // 冲压
    ProductCapacityHeaderView *headerView = [ProductCapacityHeaderView headerViewWithSubTitle1:@"良品数(冲压产出)"
                                                                                     subTitle2:@"良率(冲压产出)"];
    headerView.frame = CGRectMake(0, 50, ScreenWidth, 125);
    [self.view addSubview:headerView];

    // 电镀
    ProductCapacityHeaderView *headerView1 = [ProductCapacityHeaderView headerViewWithSubTitle1:@"良品数(电镀产出)"
                                                                                      subTitle2:@"良率(电镀产出)"];
    headerView1.frame = CGRectMake(0, 180, ScreenWidth, 125);
    [self.view addSubview:headerView1];
    
    // 成型
    ProductCapacityHeaderView *headerView2 = [ProductCapacityHeaderView headerViewWithSubTitle1:@"良品数(成型(镭雕)产出)"
                                                                                      subTitle2:@"良率(成型(镭雕)产出)"];
    headerView2.frame = CGRectMake(0, 310, ScreenWidth, 125);
    [self.view addSubview:headerView2];

    // 组装
    ProductCapacityHeaderView *headerView3 = [ProductCapacityHeaderView headerViewWithSubTitle1:@"良品数(组装产出)"
                                                                                      subTitle2:@"良率(组装产出)"];
    headerView3.frame = CGRectMake(0, 440, ScreenWidth, 125);
    [self.view addSubview:headerView3];
    
    // 教育训练
    EducationTrainHeaderView *headerView4 = [EducationTrainHeaderView headerView];
    headerView4.frame = CGRectMake(0, 570, ScreenWidth, 125);
    [self.view addSubview:headerView4];
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    HalfBarViewController *vc = [[HalfBarViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
    
}

@end
