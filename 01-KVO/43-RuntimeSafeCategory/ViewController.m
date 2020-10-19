//
//  ViewController.m
//  43-RuntimeSafeCategory
//
//  Created by XFB on 2020/5/9.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "ViewController.h"
#import "AutomaticCell.h"
#import "Gauge.h"
#import "FLCircleProgressView.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    
    Gauge *view = [[Gauge alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/2, 180)];
    [view setGaugeValue:26 animation:YES];
    view.backgroundColor = [UIColor colorWithRed:8/255.0 green:17/255.0 blue:42/255.0 alpha:1];
    [self.view addSubview:view];

    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2, 60, [UIScreen mainScreen].bounds.size.width/2, 200)];
    [self.view addSubview:view3];

    Gauge *view2 = [[Gauge alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/2, 180)];
    [view2 setGaugeValue:80 animation:YES];
    view2.backgroundColor = [UIColor colorWithRed:8/255.0 green:17/255.0 blue:42/255.0 alpha:1];
    [view3 addSubview:view2];
    
    UIView *view5 = [[UIView alloc] initWithFrame:CGRectMake(0, 300, [UIScreen mainScreen].bounds.size.width/2, 200)];
    [self.view addSubview:view5];

    Gauge *view4 = [[Gauge alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/2, 210)];
    [view4 setGaugeValue:62 animation:YES];
    view4.backgroundColor = [UIColor colorWithRed:8/255.0 green:17/255.0 blue:42/255.0 alpha:1];
    [view5 addSubview:view4];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [view4 setGaugeValue:90 animation:YES];
    });

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [view4 setGaugeValue:10 animation:YES];
    });
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

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
