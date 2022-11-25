//
//  ViewController.m
//  36-线程组
//
//  Created by Fearless on 2020/4/6.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "ViewController.h"
#import "GCDGroupController.h"
#import "ReadWriteController.h"
#import "LockViewController.h"
#import "RunLoopViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation ViewController

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSArray arrayWithObjects:
                       @"GCD Group线程组",
                       @"Read Write读写锁",
                       @"Lock 锁",
                       @"RunLoop",
                       nil];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
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
    if (indexPath.row == 0) {
        vc = [GCDGroupController new];
    } else if (indexPath.row == 1) {
        vc = [ReadWriteController new];
    } else if (indexPath.row == 2) {
        vc = [LockViewController new];
    } else if (indexPath.row == 3) {
        vc = [RunLoopViewController new];
    }
    [self.navigationController pushViewController:vc animated:YES];
}

@end
