//
//  ViewController.m
//  31-MD5
//
//  Created by XFB on 2020/3/30.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Hash.h"

static NSString *salt = @"Fearless";

@interface ViewController ()

// 账号输入框
@property (weak, nonatomic) IBOutlet UITextField *userNameTextF;
// 密码数据框
@property (weak, nonatomic) IBOutlet UITextField *passwordTextF;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // MD5：文件完整性校验
    // 1、下载文件校验
    // 2、上传（断点续传）
    
    /**
     盐的不足之处：
     1、盐是固定的（相当于密钥）不能修改版本迭代的时候
     
     HMAC：
     
     */
    
}

// 登录按钮点击
- (IBAction)loginButtonClick:(UIButton *)sender {

    NSString *userName = self.userNameTextF.text;
    NSString *password = self.passwordTextF.text;
    
    // 1、MD5加密  e10adc3949ba59abbe56e057f20f883e
    // password = [password md5String];
    
    // 2、MD5加盐 加密 f1f10504dd80d28f2002d06facdac83f
    // 盐是固定的，版本迭代不好修改，一旦确定改不了
    // password = [password stringByAppendingString:salt].md5String;
    
    // 3、HMAC 40d858e5318ebca11efbcf0bb371c7f0
    // 实际开发中密钥来自服务器，注册的时候
    NSString *key = nil;
    if (key == nil) {
        // 1、发送网络请求获取密钥
        // 账号名 123，根据账号名去获取 key
        key = [self getKeyWithUserName:userName];
        // 2、加载loading
        // 3、展示授权页面
        // 4、key保存在本地(钥匙串keychain中，不能是NSUserDefault)
    }
    password = [password hmacMD5StringWithKey:key];

    if ([self loginWithUserName:userName password:password]) {
        NSLog(@"登录成功");
    } else {
        NSLog(@"账号或密码错误");
    }
}


// 从服务器获取key，根据用户名去获取
- (NSString *)getKeyWithUserName:(NSString *)count {
    
    // 1、需要授权
    // 2、直接返回密钥
    return @"Fearless";
}

- (BOOL)loginWithUserName:(NSString *)userName
                 password:(NSString *)password {
    if ([userName isEqualToString:@"123"] &&
        [password isEqualToString:@"40d858e5318ebca11efbcf0bb371c7f0"]) {
        return YES;
    } else {
        return NO;
    }
}

@end
