//
//  ViewController.m
//  31-MD5
//
//  Created by XFB on 2020/3/30.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Hash.h"
#import "SSKeychain.h"

static NSString *salt = @"Fearless";
#define LoginSericeName @"Miracle"
#define KeySericeName @"Fearless"

@interface ViewController ()

// 账号输入框
@property (weak, nonatomic) IBOutlet UITextField *userNameTextF;
// 密码数据框
@property (weak, nonatomic) IBOutlet UITextField *passwordTextF;

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *password;

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
     */
    
    // 加载用户信息
    [self loadUserMessage];
}

- (void)loadUserMessage {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userName = [defaults objectForKey:LoginSericeName];

    self.userNameTextF.text = userName;
    NSLog(@"%@", [SSKeychain allAccounts]);
    
    self.passwordTextF.text = [SSKeychain passwordForService:LoginSericeName account:self.userNameTextF.text];
}

// 登录按钮点击
- (IBAction)loginButtonClick:(UIButton *)sender {

    NSString *userName = self.userNameTextF.text;
    NSString *password = self.passwordTextF.text;
    
    self.userName = userName;
    self.password = password;
    
    // 1、MD5加密  e10adc3949ba59abbe56e057f20f883e
    // password = [password md5String];
    
    // 2、MD5加盐 加密 f1f10504dd80d28f2002d06facdac83f
    // 盐是固定的，版本迭代不好修改，一旦确定改不了
    // password = [password stringByAppendingString:salt].md5String;
    
    // 3、HMAC 40d858e5318ebca11efbcf0bb371c7f0
    // (密码 + 服务器的key + 202003302010) HMAC
    // 服务器 (密码 + 服务器的key + 202003302011) HMAC 一分钟内进行
    // 实际开发中密钥来自服务器，注册的时候
    // 不是很安全，只要网络中监听到这个值就能登录，无需破解
    
    // 【HMAC(密码 + 服务器key) + 时间】.md5
    
    NSString *key = nil;
    if (key == nil) {
        // 1、发送网络请求获取密钥
        // 账号名 123，根据账号名去获取 key
        key = [self getKeyWithUserName:userName];
        // 2、加载loading
        // 3、展示授权页面
        // 4、key保存在本地(钥匙串keychain中，不能是NSUserDefault)
        
        if (key.length > 0) {
            [SSKeychain setPassword:key forService:LoginSericeName account:KeySericeName];
        }
    }
//    password = [password hmacMD5StringWithKey:key];

    // 4、密码+时间的一个混合 da8deeca6ead5a25d0f256c62be29b5b
    password = [self getPassword:password];

    if ([self loginWithUserName:userName password:password]) {
        NSLog(@"登录成功");
        [self savePasswordWithUserName:self.userName password:self.password];
    } else {
        NSLog(@"账号或密码错误");
    }
}

- (NSString *)getPassword:(NSString *)password {
    // 1、一个字符串key md5计算
    NSString *md5Key = [@"key123" md5String];
    // 2、把原密码和 生成的md5Key值进行hmac 加密
    NSString *hmacKey = [password hmacMD5StringWithKey:md5Key];
    // 3、从服务器获取当前时间 到分钟的字符串
    NSString *time = @"202003311030";
    // 第二步产生的  (hmacKey + 时间)  和第一步的md5值只进行hmac加密
    return [[hmacKey stringByAppendingString:time] hmacMD5StringWithKey:md5Key];
}

- (void)savePasswordWithUserName:(NSString *)userName
                        password:(NSString *)password {
    // 1、保存账号
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:userName forKey:LoginSericeName];
    [defaults synchronize];
    
    // 2、保存密码
    if (userName.length > 0 && password.length > 0) {
        [SSKeychain setPassword:password forService:LoginSericeName account:userName];
    }
}

// 从服务器获取key，根据用户名去获取
- (NSString *)getKeyWithUserName:(NSString *)count {
     // 1、需要授权
    // 2、直接返回密钥
    NSString *key = [SSKeychain passwordForService:LoginSericeName account:self.userNameTextF.text];
    if (key == NULL) {
        return @"Fearless";
    } else {
        return key;
    }
}

- (BOOL)loginWithUserName:(NSString *)userName
                 password:(NSString *)password {
    if ([userName isEqualToString:@"123"] &&
        [password isEqualToString:@"da8deeca6ead5a25d0f256c62be29b5b"]) {
        return YES;
    } else {
        return NO;
    }
}

@end
