//
//  ViewController.m
//  47-DrawView
//
//  Created by XFB on 2020/10/22.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "ViewController.h"

#import "ORRingChartView.h"
#import "RunDrawView.h"
#import "OfflineDrawView.h"
#import "UnusualDrawView.h"
#import "AwaitOrderDrawView.h"

#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
// 2.获取RGB颜色 + 透明度
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
// 3.获取RGB颜色
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

@interface ViewController () <ORRingChartViewDatasource>

@property (nonatomic, strong) ORRingChartView *ringChartView;
@property (nonatomic, strong) NSArray *datasource;
// 颜色数组 按照顺序排列
@property (nonatomic, strong) NSArray *graidentColors;

// 运行
@property (nonatomic, strong) RunDrawView *drawView1;
// 离线
@property (nonatomic, strong) OfflineDrawView *drawView2;
// 异常
@property (nonatomic, strong) UnusualDrawView *drawView3;
// 待命
@property (nonatomic, strong) AwaitOrderDrawView *drawView4;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGB(7, 19, 39);
    CGFloat viewW = ScreenWidth/2-45;
    
    // iOS画线 Ring
    self.ringChartView = [[ORRingChartView alloc] initWithFrame:CGRectMake(ScreenWidth/2-60, 200, 120, 120)];
    self.ringChartView.dataSource = self;
    self.ringChartView.style = ORRingChartStyleRing;
    self.ringChartView.backgroundColor = RGB(8, 17, 42);
    // 开始角度
    self.ringChartView.config.startAngle = M_PI * 2 / 3;
    // 圆环宽度
    self.ringChartView.config.ringWidth = 10;
    // 动画时间
    self.ringChartView.config.animateDuration = 1;
    // 白色围绕线宽度
    self.ringChartView.config.ringLineWidth = 1;
    self.ringChartView.config.minInfoInset = -30;
    self.ringChartView.config.infoLineMargin = 0;
    // 折线宽度
    self.ringChartView.config.infoLineWidth = 0;
    self.ringChartView.config.clockwise = YES;
    [self.view addSubview:self.ringChartView];

    self.drawView1 = [[RunDrawView alloc] initWithFrame:CGRectMake(0, 150, viewW, 60)];
    [self.view addSubview:self.drawView1];
    
    self.drawView2 = [[OfflineDrawView alloc] initWithFrame:CGRectMake(ScreenWidth-viewW, 150, viewW, 60)];
    [self.view addSubview:self.drawView2];
    
    self.drawView3 = [[UnusualDrawView alloc] initWithFrame:CGRectMake(0, 310, viewW, 60)];
    [self.view addSubview:self.drawView3];
    
    self.self.drawView4 = [[AwaitOrderDrawView alloc] initWithFrame:CGRectMake(ScreenWidth-viewW, 310, viewW, 60)];
    [self.view addSubview:self.drawView4];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSInteger number1 = arc4random()%200;
    NSInteger number2 = arc4random()%200;
    NSInteger number3 = arc4random()%200;
    NSInteger number4 = arc4random()%200;

    // 环形图数据
    _datasource = @[@(number1), @(number2), @(number3), @(number4)];
    _graidentColors = @[
        @[RGB(81, 150, 247)],
        @[[UIColor whiteColor]],
        @[RGB(230, 92, 87)],
        @[RGB(246, 186, 90)]
    ];
    [self.ringChartView reloadData];
    
    // 给四个View赋值数据
    self.drawView1.numberString = [NSString stringWithFormat:@"%d", number1];
    self.drawView2.numberString = [NSString stringWithFormat:@"%d", number2];
    self.drawView3.numberString = [NSString stringWithFormat:@"%d", number3];
    self.drawView4.numberString = [NSString stringWithFormat:@"%d", number4];
}

- (NSInteger)numberOfRingsOfChartView:(ORRingChartView *)chartView {
    return _datasource.count;
}

- (CGFloat)chartView:(ORRingChartView *)chartView valueAtRingIndex:(NSInteger)index {
    return [_datasource[index] floatValue];
}

- (NSArray<UIColor *> *)chartView:(ORRingChartView *)chartView graidentColorsAtRingIndex:(NSInteger)index {
    return _graidentColors[index];
}

- (UIView *)chartView:(ORRingChartView *)chartView viewForRingInfoAtRingIndex:(NSInteger)index {
    return [UIView new];
}

@end
