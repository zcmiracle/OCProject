//
//  ViewController.m
//  43-RuntimeSafeCategory
//
//  Created by XFB on 2020/5/9.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "ViewController.h"
#import "AutomaticCell.h"
#import "TemperatureView.h"
#import "FLCircleProgressView.h"
#import "HumidityView.h"


@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) UIView *viewSE;
@property (nonatomic, strong) UIView *view8;
@property (nonatomic, strong) UIView *view8Plus;


// SE 320
@property (nonatomic, strong) UIView *bgView1;
// 8 x xs 375
@property (nonatomic, strong) UIView *bgView2;
// 8plus 414
@property (nonatomic, strong) UIView *bgView3;
// XR
@property (nonatomic, strong) UIView *bgView4;
// XR
@property (nonatomic, strong) UIView *bgView5;
// XR
@property (nonatomic, strong) UIView *bgView6;

@property (nonatomic, strong) TemperatureView *gaugeView1;
@property (nonatomic, strong) HumidityView *gaugeView2;
@property (nonatomic, strong) TemperatureView *gaugeView3;
@property (nonatomic, strong) HumidityView *gaugeView4;
@property (nonatomic, strong) TemperatureView *gaugeView5;
@property (nonatomic, strong) HumidityView *gaugeView6;

@end

@implementation ViewController

- (void)test {
    // SE
     self.bgView1 = [[UIView alloc] initWithFrame:CGRectMake(5, 0, 150, 150)];
     self.bgView1.backgroundColor = [UIColor orangeColor];

     self.gaugeView1 = [[TemperatureView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
     self.gaugeView1.backgroundColor = RGB(8, 17, 42);
     [self.bgView1 addSubview:self.gaugeView1];
     
     self.bgView2 = [[UIView alloc] initWithFrame:CGRectMake(165, 0, 150, 150)];
     self.bgView2.backgroundColor = [UIColor orangeColor];

     self.gaugeView2 = [[HumidityView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
     self.gaugeView2.backgroundColor = RGB(8, 17, 42);
     [self.bgView2 addSubview:self.gaugeView2];
     
     [self.viewSE addSubview:self.bgView1];
     [self.viewSE addSubview:self.bgView2];
     [self.view addSubview:self.viewSE];
     
     // 8 + X + XS
     self.bgView3 = [[UIView alloc] initWithFrame:CGRectMake(5, 0, 180, 180)];
     self.bgView3.backgroundColor = [UIColor orangeColor];

     self.gaugeView3 = [[TemperatureView alloc] initWithFrame:CGRectMake(0, 0, 180, 180)];
     self.gaugeView3.backgroundColor = RGB(8, 17, 42);
     [self.bgView3 addSubview:self.gaugeView3];
     
     self.bgView4 = [[UIView alloc] initWithFrame:CGRectMake(190, 0, 180, 180)];
     self.bgView4.backgroundColor = [UIColor orangeColor];
    
     self.gaugeView4 = [[HumidityView alloc] initWithFrame:CGRectMake(0, 0, 180, 180)];
     self.gaugeView4.backgroundColor = RGB(8, 17, 42);
     [self.bgView4 addSubview:self.gaugeView4];
     
     [self.view8 addSubview:self.bgView3];
     [self.view8 addSubview:self.bgView4];
     [self.view addSubview:self.view8];
     
     // 8plus
     self.bgView5 = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 190, 190)];
     self.bgView5.backgroundColor = [UIColor orangeColor];

     self.gaugeView5 = [[TemperatureView alloc] initWithFrame:CGRectMake(0, 0, 190, 190)];
     self.gaugeView5.backgroundColor = RGB(8, 17, 42);
     [self.bgView5 addSubview:self.gaugeView5];
     
     self.bgView6 = [[UIView alloc] initWithFrame:CGRectMake(214, 0, 190, 190)];
     self.bgView6.backgroundColor = [UIColor orangeColor];
     
     self.gaugeView6 = [[HumidityView alloc] initWithFrame:CGRectMake(0, 0, 190, 190)];
     self.gaugeView6.backgroundColor = RGB(8, 17, 42);
     [self.bgView6 addSubview:self.gaugeView6];
     
     [self.view8Plus addSubview:self.bgView5];
     [self.view8Plus addSubview:self.bgView6];
     [self.view addSubview:self.view8Plus];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.gaugeView1 setTemperatureValue:-20 animation:YES];
        [self.gaugeView2 setHumidityValue:80 animation:YES];
        [self.gaugeView3 setTemperatureValue:15 animation:YES];
        [self.gaugeView4 setHumidityValue:28 animation:YES];
        [self.gaugeView5 setTemperatureValue:62 animation:YES];
        [self.gaugeView6 setHumidityValue:62 animation:YES];
    });
}


- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self test];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  
    [self.bgView1 removeFromSuperview];
    [self.bgView2 removeFromSuperview];
    [self.bgView3 removeFromSuperview];
    [self.bgView4 removeFromSuperview];
    [self.bgView5 removeFromSuperview];
    [self.bgView6 removeFromSuperview];

    [self.viewSE removeFromSuperview];
    [self.view8 removeFromSuperview];
    [self.view8Plus removeFromSuperview];

    
    [self.gaugeView1 removeFromSuperview];
    [self.gaugeView2 removeFromSuperview];
    [self.gaugeView3 removeFromSuperview];
    [self.gaugeView4 removeFromSuperview];
    [self.gaugeView5 removeFromSuperview];
    
    [self test];
    
//    [self.gaugeView1 setTemperatureValue1:-40 animation:YES];
//    [self.gaugeView2 setTemperatureValue1:-40 animation:YES];
//    [self.gaugeView3 setTemperatureValue1:-40 animation:YES];
//    [self.gaugeView4 setTemperatureValue1:-40 animation:YES];
//    [self.gaugeView5 setTemperatureValue1:-40 animation:YES];
//    [self.gaugeView6 setTemperatureValue1:-40 animation:YES];
    
//    [self.gaugeView1 setTemperatureValue1:0 animation:YES];
//    [self.gaugeView2 setTemperatureValue1:0 animation:YES];
//    [self.gaugeView3 setTemperatureValue1:0 animation:YES];
//    [self.gaugeView4 setTemperatureValue1:0 animation:YES];
//    [self.gaugeView5 setTemperatureValue1:0 animation:YES];
//    [self.gaugeView6 setTemperatureValue1:0 animation:YES];

//    [self.gaugeView1 setTemperatureValue1:-3 animation:YES];
//    [self.gaugeView2 setTemperatureValue1:30 animation:YES];
//    [self.gaugeView3 setTemperatureValue1:90 animation:YES];
//    [self.gaugeView4 setTemperatureValue1:2 animation:YES];
//    [self.gaugeView5 setTemperatureValue1:-12 animation:YES];
//    [self.gaugeView6 setTemperatureValue1:18 animation:YES];
}


#pragma mark --- Lazy Loading
- (UIView *)viewSE {
    if (!_viewSE) {
        _viewSE = [[UIView alloc] initWithFrame:CGRectMake(0, 40, 320, 150)];
        _viewSE.backgroundColor = [UIColor lightGrayColor];
    }
    return _viewSE;
}

- (UIView *)view8 {
    if (!_view8) {
        _view8 = [[UIView alloc] initWithFrame:CGRectMake(0, 230, 375, 180)];
        _view8.backgroundColor = [UIColor lightGrayColor];
    }
    return _view8;
}

- (UIView *)view8Plus {
    if (!_view8Plus) {
        _view8Plus = [[UIView alloc] initWithFrame:CGRectMake(0, 450, 414, 190)];
        _view8Plus.backgroundColor = [UIColor lightGrayColor];
    }
    return _view8Plus;
}




















- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.estimatedRowHeight = 100;
        _tableView.backgroundColor = [UIColor orangeColor];
        [_tableView registerNib:[UINib nibWithNibName:@"AutomaticCell" bundle:nil] forCellReuseIdentifier:@"AutomaticCell"];
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AutomaticCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AutomaticCell"];
    if (indexPath.row%2 == 0) {
        cell.typeString = @"0";
    } else {
        cell.typeString = @"1";
    }
    return cell;
}


@end
