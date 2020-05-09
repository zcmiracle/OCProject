//
//  ViewController.m
//  43-RuntimeSafeCategory
//
//  Created by XFB on 2020/5/9.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // objectAtIndexedSubscript
    NSArray *array = @[@"1", @"2", @"3"];
//    NSLog(@"%@", array[5]);
    
//    NSArray *array1 = [NSArray arrayWithObjects:nil count:10];
    NSArray *array1 = [NSArray arrayWithObject:array];
//    + (instancetype)arrayWithObjects:(const ObjectType _Nonnull [_Nonnull])objects count:(NSUInteger)cnt;

    NSArray *array2 = @[@"1"];
    array2[3];

    array1[4];
    
    NSMutableArray *mutableArray = @[].mutableCopy;
    [mutableArray addObject:@"1"];
    [mutableArray addObject:@"2"];
    [mutableArray addObject:nil];
    [mutableArray addObject:nil];
    NSLog(@"%@", mutableArray[5]);

}


@end
