//
//  ViewController.m
//  24-页面跳转
//
//  Created by Fearless on 2020/3/26.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

// 跳转控制器
- (IBAction)jumpVc:(UIButton *)sender {
    NSDictionary *dictionary = nil;
    switch (self.segmentControl.selectedSegmentIndex) {
        case 0:
            dictionary = @{
                @"" : @"",
                @"" : @"",
            };
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
            
        default:
            break;
    }
}

@end
