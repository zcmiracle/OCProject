//
//  PersonViewController.m
//  24-页面跳转
//
//  Created by Fearless on 2020/3/26.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "PersonViewController.h"

@interface PersonViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation PersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.label.text = [NSString stringWithFormat:@"name = %@", self.name];
}

@end
