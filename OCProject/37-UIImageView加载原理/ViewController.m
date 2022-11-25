//
//  ViewController.m
//  37-UIImageView加载原理
//
//  Created by XFB on 2020/4/7.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "ViewController.h"
#import "ImageCompressController.h"
#import "ImageFilterController.h"
#import "ShotScreenController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"相册图片压缩";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"图片处理";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"截图";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *vc = nil;
    if (indexPath.row == 0) {
        vc = [ImageCompressController new];
    } else if (indexPath.row == 1) {
        vc = [ImageFilterController new];
    } else if (indexPath.row == 2) {
        vc = [ShotScreenController new];
    }
    [self.navigationController pushViewController:vc animated:YES];
}


@end
