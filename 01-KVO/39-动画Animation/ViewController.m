//
//  ViewController.m
//  39-动画Animation
//
//  Created by XFB on 2020/4/8.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "ViewController.h"
#import "AnimationDelegateController.h"
#import "BezierPathViewController.h"
#import "BasicAnimationViewController.h"
#import "CAKeyFrameViewController.h"
#import "TransitionViewController.h"
#import "CAMediaTimeViewController.h"
#import "AnimationCaseViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"动画列表";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *vc = nil;
    if (indexPath.row == 0) { // 动画代理
        vc = [AnimationDelegateController new];
    } else if (indexPath.row == 1) { // 贝塞尔曲线
        vc = [BezierPathViewController new];
    } else if (indexPath.row == 2) { // 基础动画
        vc = [BasicAnimationViewController new];
    } else if (indexPath.row == 3) { // 关键帧动画
        vc = [CAKeyFrameViewController new];
    } else if (indexPath.row == 4) { // 时间函数
        vc = [TransitionViewController new];
    } else if (indexPath.row == 5) { // 过渡转场动画
        vc = [CAMediaTimeViewController new];
    } else if (indexPath.row == 6) { // 动画案例
        vc = [AnimationCaseViewController new];
    }
    vc.title = self.dataSource[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSArray arrayWithObjects:
                       @"动画代理",
                       @"贝塞尔曲线",
                       @"基础动画",
                       @"关键帧动画",
                       @"时间函数",
                       @"过渡转场动画",
                       @"动画案例",
                       nil];
    }
    return _dataSource;
}

@end
