//
//  ViewController.m
//  42-自定义转场动画
//
//  Created by XFB on 2020/4/10.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "ViewController.h"
#import "TransformViewController.h"
#import "InteractiveTransition.h"

#import "PresentAnimator.h"
#import "DismissAnimator.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UIViewControllerTransitioningDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) InteractiveTransition *interactiveTransition;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"转场动画";
    self.interactiveTransition = [[InteractiveTransition alloc] init];
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
    
    if (indexPath.row == 0) {
        TransformViewController *vc = [[TransformViewController alloc] init];
        [self.interactiveTransition transitionToViewController:vc];
        vc.transitioningDelegate = self;
        [self presentViewController:vc animated:YES completion:nil];
    }
}


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [DismissAnimator new];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [PresentAnimator new];
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return self.interactiveTransition.isInteractive? self.interactiveTransition:nil;
}

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSArray arrayWithObjects:
                       @"自定义系统转场",
                       @"自定义容易实现转场动画",
                       nil];
    }
    return _dataSource;
}

@end
