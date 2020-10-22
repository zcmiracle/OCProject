//
//  ViewController.m
//  45-CicleProgressView
//
//  Created by XFB on 2020/10/21.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "ViewController.h"
#import "ZZCircleProgress.h"
#import "CircleProgressView.h"

// 2.获取RGB颜色 + 透明度
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
// 3.获取RGB颜色
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)

@interface ViewController ()

@property (strong, nonatomic) ZZCircleProgress *progressView;
// OEE1
@property (strong, nonatomic) CircleProgressView *circleProgressView;
// 点检完成率
@property (strong, nonatomic) CircleProgressView *circleProgressView1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.view.backgroundColor = RGB(7, 17, 43);
//
//    // 圆环背景颜色
//    UIColor *backgroundColor = RGB(18, 40, 93);
//    // 填充颜色
//    UIColor *fillColor = RGB(48, 111, 204);
//
//    self.progressView = [[ZZCircleProgress alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame)-135)/2.0, 42, 135, 135) pathBackColor:backgroundColor pathFillColor:fillColor startAngle:130 strokeWidth:10];
//    // 是否显示圆点
//    self.progressView.showPoint = NO;
//    // 减少角度 80
//    self.progressView.reduceAngle = 80;
//    self.progressView.duration = 1.0;
//    [self.view addSubview:self.progressView];
    
    
    self.circleProgressView = [[CircleProgressView alloc] initWithCircleProgressViewFrame:CGRectMake(ScreenWidth-180, 100, 180, 135) subTitle:@"OEE1"];
    [self.view addSubview:self.circleProgressView];

    self.circleProgressView1 = [[CircleProgressView alloc] initWithCircleProgressViewFrame:CGRectMake(ScreenWidth-180, 235, 180, 135) subTitle:@"点检完成率"];
    [self.view addSubview:self.circleProgressView1];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    CGFloat randomFloat = arc4random()%100+0.55;
    self.circleProgressView.progressFloat = randomFloat;

    CGFloat randomFloat2 = arc4random()%100+0.25;
    self.circleProgressView1.progressFloat = randomFloat2;

}


@end
