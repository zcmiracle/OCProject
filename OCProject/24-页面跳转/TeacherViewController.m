//
//  TeacherViewController.m
//  24-页面跳转
//
//  Created by Fearless on 2020/3/26.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "TeacherViewController.h"

@interface TeacherViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation TeacherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.label.text = [NSString stringWithFormat:@"teacherID = %@, money = %@", self.teacherID, self.money];
}
 
@end
