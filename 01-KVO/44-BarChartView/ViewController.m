//
//  ViewController.m
//  44-BarChartView
//
//  Created by XFB on 2020/10/21.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "ViewController.h"
#import "ZFChart.h"

@interface ViewController () <ZFGenericChartDataSource, ZFBarChartDelegate>

@property (nonatomic, strong) ZFBarChart * barChart;

@end

@implementation ViewController


- (void)test {
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 300)];
    leftView.backgroundColor = ZFColor(8, 19, 44, 1);
    for (int i = 0; i < 7; i ++) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(10, 300-60-31*i, 50, 31);
//        label.backgroundColor = [UIColor redColor];

        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:12];
        [leftView addSubview:label];
        label.text = [NSString stringWithFormat:@"%d%%", i * 20];
        
        if (i == 0) {
            label.text = @"0";
        }
    }
    
    self.barChart = [[ZFBarChart alloc] initWithFrame:CGRectMake(-10, 100, SCREEN_WIDTH+10, 300)];
    self.barChart.dataSource = self;
    //    self.barChart.backgroundColor = UIColor.clearColor;
    self.barChart.delegate = self;
    
    self.barChart.topicLabel.text = @"制程OEE1分析";
    self.barChart.topicLabel.textColor = ZFWhite;
    // y轴(普通图表) 或 x轴(横向图表) 标题颜色(默认为黑色)
    self.barChart.axisLineNameColor = [UIColor whiteColor];
    // y轴(普通图表) 或 x轴(横向图表) value颜色(默认为黑色)
    self.barChart.axisLineValueColor = [UIColor clearColor];
    // y轴(普通图表) 或 x轴(横向图表) 上名称字体大小(默认为10.f)
    self.barChart.axisLineNameFont = [UIFont boldSystemFontOfSize:12];
    // y轴(普通图表) 或 x轴(横向图表) 上数值字体大小(默认为10.f)
    self.barChart.axisLineValueFont = [UIFont boldSystemFontOfSize:12];
    // 数字空白样式，不用气泡
    self.barChart.valueLabelPattern = kPopoverLabelPatternBlank;
    // 柱状图背景颜色
    self.barChart.backgroundColor = ZFColor(8, 19, 44, 1);
    // X轴颜色
    self.barChart.xAxisColor = ZFWhite;
    // Y轴颜色
    self.barChart.yAxisColor = [UIColor clearColor];
    // 显示小数点后两位
    self.barChart.numberOfDecimal = 2;
    self.barChart.isAnimated = YES;
    /**
     该属性是否重设坐标轴最小值，默认为NO(不设置，从0开始)，当设置为YES时，则有以下2种情况
     ①若同时实现代理方法中的
     - (CGFloat)axisLineMinValueInGenericChart:(ZFGenericChart *)chart
     则y轴最小值为该方法的返回值
     ②若不实现①中的方法，则y轴最小值为数据源最小值
     */
    self.barChart.isResetAxisLineMaxValue = YES;
    
    // 气泡 是否有阴影
    //     self.barChart.isShadowForValueLabel = NO;
    // Y轴数值
    //    self.barChart.valueType = kValueTypeInteger;
    // 是否显示 y轴(普通图表) 或 x轴(横向图表) 的value
    //    self.barChart.isShowAxisLineValue = NO;
    // 是否显示Y轴网格
    //    self.barChart.isShowYLineSeparate = YES;
    //    // 是否显示X周网格
    //    self.barChart.isShowXLineSeparate = YES;
    
    [self.barChart strokePath];
    
    [self.barChart addSubview:leftView];
    [self.view addSubview:self.barChart];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    [self test];
    
}

- (NSArray *)valueArrayInGenericChart:(ZFGenericChart *)chart{
    return @[@[@"53.81", @"58.49", @"0", @"52.82", @"59.34", @"54.23", @"56.18",@"53.81", @"58.49", @"52.66", @"52.82", @"59.34", @"54.23", @"56.18"],
             @[@"99.62", @"99.54", @"99.3", @"98.89", @"99.04", @"99.39", @"99.12",@"99.62", @"99.54", @"99.3", @"98.89", @"99.04", @"99.39", @"99.12"],
             @[@"90.71", @"94.66", @"85.86", @"89.34", @"90.8", @"86.4", @"74.15",@"90.71", @"94.66", @"85.86", @"89.34", @"90.8", @"86.4", @"74.15"],
             @[@"98.1", @"97.85", @"97.86", @"98.34", @"97.8", @"98.4", @"98.16",@"98.1", @"97.85", @"97.86", @"98.34", @"97.8", @"98.4", @"98.16"]];
}

- (NSArray *)nameArrayInGenericChart:(ZFGenericChart *)chart{
    return @[@"10/15", @"10/16", @"10/17", @"10/18", @"10/19", @"10/20", @"10/21",@"10/15", @"10/16", @"10/17", @"10/18", @"10/19", @"10/20", @"10/21"];
}

- (NSArray *)colorArrayInGenericChart:(ZFGenericChart *)chart{
    return @[ZFColor(71, 204, 255, 1), ZFGold, ZFColor(16, 140, 39, 1), ZFColor(71, 204, 255, 1)];
}

// 最大值
- (CGFloat)axisLineMaxValueInGenericChart:(ZFGenericChart *)chart {
    return 120;
}

- (CGFloat)axisLineMinValueInGenericChart:(ZFGenericChart *)chart {
    return 0;
}

- (NSUInteger)axisLineSectionCountInGenericChart:(ZFGenericChart *)chart {
    return 6;
}

#pragma mark - ZFBarChartDelegate
- (CGFloat)barWidthInBarChart:(ZFBarChart *)barChart {
    return 10.f;
}

- (CGFloat)paddingForGroupsInBarChart:(ZFBarChart *)barChart {
    return 30.f;
}

- (CGFloat)paddingForBarInBarChart:(ZFBarChart *)barChart {
    return 10.f;
}

- (id)valueTextColorArrayInBarChart:(ZFBarChart *)barChart {
    //    return ZFBlue;
    return @[ZFColor(71, 204, 255, 1), ZFColor(253, 203, 76, 1), ZFColor(16, 140, 39, 1),ZFColor(253, 203, 76, 1)];
}

- (NSArray<ZFGradientAttribute *> *)gradientColorArrayInBarChart:(ZFBarChart *)barChart{
    //该组第1个bar渐变色
    ZFGradientAttribute * gradientAttribute1 = [[ZFGradientAttribute alloc] init];
    gradientAttribute1.colors = @[(id)ZFColor(67, 134, 229, 1).CGColor,(id)ZFColor(99, 164, 242, 0.8).CGColor];
    gradientAttribute1.locations = @[@(0.0), @(1)];
    gradientAttribute1.startPoint = CGPointMake(0, 0.5);
    gradientAttribute1.endPoint = CGPointMake(0, 1);
    
    //该组第2个bar渐变色
    ZFGradientAttribute * gradientAttribute2 = [[ZFGradientAttribute alloc] init];
    gradientAttribute2.colors = @[(id)ZFColor(100, 208, 180, 1).CGColor, (id)ZFWhite.CGColor];
    gradientAttribute2.locations = @[@(0.2), @(0.99)];
    gradientAttribute2.startPoint = CGPointMake(0, 0);
    gradientAttribute2.endPoint = CGPointMake(0, 1);
    
    //该组第3个bar渐变色
    ZFGradientAttribute * gradientAttribute3 = [[ZFGradientAttribute alloc] init];
    gradientAttribute3.colors = @[(id)ZFColor(246, 205, 115, 1).CGColor, (id)ZFWhite.CGColor];
    gradientAttribute3.locations = @[@(0.2), @(0.99)];
    gradientAttribute3.startPoint = CGPointMake(0, 0);
    gradientAttribute3.endPoint = CGPointMake(0, 1);
    
    ZFGradientAttribute * gradientAttribute4 = [[ZFGradientAttribute alloc] init];
    gradientAttribute4.colors = @[(id)ZFColor(137, 112, 246, 1).CGColor, (id)ZFWhite.CGColor];
    gradientAttribute4.locations = @[@(0.2), @(0.99)];
    gradientAttribute4.startPoint = CGPointMake(0, 0);
    gradientAttribute4.endPoint = CGPointMake(0, 1);
    
    return [NSArray arrayWithObjects:gradientAttribute1, gradientAttribute2, gradientAttribute3, gradientAttribute4, nil];
}

- (void)barChart:(ZFBarChart *)barChart didSelectBarAtGroupIndex:(NSInteger)groupIndex barIndex:(NSInteger)barIndex bar:(ZFBar *)bar popoverLabel:(ZFPopoverLabel *)popoverLabel{
    NSLog(@"第%ld个颜色中的第%ld个",(long)groupIndex,(long)barIndex);
}

- (void)barChart:(ZFBarChart *)barChart didSelectPopoverLabelAtGroupIndex:(NSInteger)groupIndex labelIndex:(NSInteger)labelIndex popoverLabel:(ZFPopoverLabel *)popoverLabel{
    NSLog(@"第%ld组========第%ld个",(long)groupIndex,(long)labelIndex);
}

#pragma mark - 横竖屏适配(若需要同时横屏,竖屏适配，则添加以下代码，反之不需添加)
/// PS：size为控制器self.view的size，若图表不是直接添加self.view上，则修改以下的frame值
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator NS_AVAILABLE_IOS(8_0){
    
    if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight){
        self.barChart.frame = CGRectMake(0, 0, size.width, size.height - NAVIGATIONBAR_HEIGHT * 0.5);
    }else{
        self.barChart.frame = CGRectMake(0, 0, size.width, size.height + NAVIGATIONBAR_HEIGHT * 0.5);
    }
    
    [self.barChart strokePath];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
        
    if (self.barChart) {
        
        for (UIView *subView in self.barChart.subviews) {
            [subView removeFromSuperview];
        }
        
        for (CALayer *subLayer in self.barChart.layer.sublayers) {
            [subLayer removeFromSuperlayer];
        }
        
        [self.barChart removeFromSuperview];
        self.barChart = nil;
    }
    
    [self test];
}

@end
