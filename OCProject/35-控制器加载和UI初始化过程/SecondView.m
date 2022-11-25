//
//  SecondView.m
//  35-控制器加载和UI初始化过程
//
//  Created by Fearless on 2020/4/5.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "SecondView.h"

@interface SecondView ()

@property (nonatomic, strong) UIButton *button;

@end

@implementation SecondView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor purpleColor];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (!self.button) {
        self.button = [[UIButton alloc] initWithFrame:CGRectMake(30, 100, 100, 100)];
        [self.button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchDown];
        self.button.backgroundColor = [UIColor blueColor];
        [self addSubview:self.button];
    }
}


- (void)buttonClick {
    
    self.pushToThreeVC = YES;
}

@end
