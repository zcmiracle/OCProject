//
//  PresentViewController.m
//  34-App启动过程
//
//  Created by XFB on 2022/1/13.
//  Copyright © 2022 XFB. All rights reserved.
//

#import "PresentViewController.h"

@interface PresentViewController ()

typedef void(^DoWork)(void);
typedef void(^DoStudent)(void);

@property (nonatomic, copy) DoWork doWork;
@property (nonatomic, copy) DoStudent doStudent;

@property (nonatomic, strong) NSMutableArray *mArray;

@end

@implementation PresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor orangeColor];
    
//    __weak typeof(self) weakSelf = self;
//    self.doWork = ^{
//        __strong typeof(self) strongSelf = weakSelf;
//        weakSelf.doStudent = ^{
//            NSLog(@"%@", strongSelf);
//        };
//       weakSelf.doStudent();
//    };
//    self.doWork();
    
//    __weak typeof(self) weakself = self;
//    self.doWork = ^{
//        __strong typeof(self) strongSelf = weakself;
//        strongSelf.doStudent = ^{
//            NSLog(@"%@", weakself);
//        };
//        strongSelf.doStudent();
//    };
//    self.doWork();
    
    
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(0, 0);
    
    // ???
    for (int i = 0; i<5000; i++) {
        dispatch_async(concurrentQueue, ^{
            NSString *imageName = [NSString stringWithFormat:@"%d.jpg", (i % 10)];
            NSURL *url = [[NSBundle mainBundle] URLForResource:imageName withExtension:nil];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *image = [UIImage imageWithData:data];
            
            dispatch_barrier_async(concurrentQueue, ^{
                [self.mArray addObject:image];
            });
            
        });
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// MARK: - dealloc
- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end
