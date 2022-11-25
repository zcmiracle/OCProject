//
//  ViewController.m
//  24-页面跳转
//
//  Created by Fearless on 2020/3/26.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

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
                @"class" : @"PersonViewController",
                @"property" : @{
                        @"name" : @"Fearless",
                }
            };
            break;
        case 1:
            dictionary = @{
                @"class" : @"StudentViewController",
                @"property" : @{
                        @"age" : @"20",
                        @"sex" : @"男"
                }
            };
            break;
        case 2:
            dictionary = @{
                @"class" : @"TeacherViewController",
                @"property" : @{
                        @"teacherID" : @"123",
                        @"money" : @"10000000",
                }
            };
            break;
        case 3:
            dictionary = @{
                @"class" : @"TestViewController",
                @"property" : @{
                        @"phoneNumber" : @"15999686187"
                }
            };
            break;
        default:
            break;
    }
    [self pushToControllerWithDict:dictionary];
}

- (void)pushToControllerWithDict:(NSDictionary *)dictionary {
    
    const char *className = [dictionary[@"class"] UTF8String];
    Class cls = objc_getClass(className);
    if (!cls) {
        // 1、创建新的类，并且添加变量、添加方法
        Class superClass = [UIViewController class];
        // 创建类
        cls = objc_allocateClassPair(superClass, className, 0);
        
        // 添加成员变量
        class_addIvar(cls, "phoneNumber", sizeof(NSString *), log2(sizeof(NSString *)), @encode(NSString *));
        class_addIvar(cls, "label", sizeof(UILabel *), log2(sizeof(UILabel *)), @encode(UILabel *));

        objc_registerClassPair(cls);
        
        // 添加方法，执行viewDidLoad加载
        Method method = class_getInstanceMethod([self class], @selector(testVcViewDidLoad));
        IMP methodIMP = method_getImplementation(method);
        const char *types = method_getTypeEncoding(method);
        class_addMethod(cls, @selector(viewDidLoad), methodIMP, types);
            
    }
    
    // 创建实例对象给属性赋值
    id instance = nil;
    @try {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        instance = [storyboard instantiateViewControllerWithIdentifier:dictionary[@"class"]];
    } @catch (NSException *exception) {
        instance = [[cls alloc] init];
    } @finally {
        
    }
    
    NSDictionary *values = dictionary[@"property"];
    [values enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        if (class_getProperty(cls, [key UTF8String])) {
            // 检测是否存在为key的属性
            [instance setValue:obj forKey:key];
        } else if (class_getInstanceVariable(cls, [key UTF8String])) {
            // 检测是否存在为key的变量
            [instance setValue:obj forKey:key];
        }
    }];
    
    // 3.跳转到对应的控制器Controller
    [self.navigationController pushViewController:instance animated:YES];
}

// 转换成C++后，默认有两个参数(id self, SEL _cmd)
- (void)testVcViewDidLoad {
    
    [super viewDidLoad];
    SEL method = _cmd;
    // self = <TestViewController: 0x7fc25e400870>
    [self setValue:[UIColor orangeColor] forKeyPath:@"view.backgroundColor"];

    // 初始化label
    [self setValue:[[UILabel alloc] initWithFrame:CGRectMake(20, 200, 300, 30)] forKey:@"label"];
    UILabel *label = [self valueForKey:@"label"];
    // 添加到视图上
    [[self valueForKey:@"view"] performSelector:@selector(addSubview:) withObject:label];
    // label属性
    label.textColor = [UIColor redColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:20];
    label.backgroundColor = [UIColor whiteColor];
    label.text = [self valueForKey:@"phoneNumber"];
}

@end
