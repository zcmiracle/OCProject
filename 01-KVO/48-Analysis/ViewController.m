//
//  ViewController.m
//  48-Analysis
//
//  Created by XFB on 2020/10/22.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "ViewController.h"
#import "ManpowerAnalysisHeaderView.h"
#import "ManpowerOverviewHeaderView.h"
#import "EnergyAnalysisHeaderView.h"


#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
// 2.获取RGB颜色 + 透明度
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
// 3.获取RGB颜色
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ManpowerAnalysisHeaderView *headerView = [ManpowerAnalysisHeaderView analysisHeaderView];
    headerView.frame = CGRectMake(0, 100, ScreenWidth, 75);
    [self.view addSubview:headerView];
    
    ManpowerOverviewHeaderView *headerView1 = [ManpowerOverviewHeaderView headerView];
    headerView1.frame = CGRectMake(0, 200, ScreenWidth-120, 100);
    [self.view addSubview:headerView1];
    
    EnergyAnalysisHeaderView *headerView2 = [EnergyAnalysisHeaderView energyAnalysisHeaderView];
    headerView2.frame = CGRectMake(0, 360, ScreenWidth, 50);
    [self.view addSubview:headerView2];
}


@end
