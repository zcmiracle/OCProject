//
//  StudentViewController.m
//  24-页面跳转
//
//  Created by Fearless on 2020/3/26.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "StudentViewController.h"

@interface StudentViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation StudentViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.label.text = [NSString stringWithFormat:@"age = %@, sex = %@", self.age, self.sex];
}

@end
