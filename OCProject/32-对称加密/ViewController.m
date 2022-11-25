//
//  ViewController.m
//  32-对称加密
//
//  Created by Fearless on 2020/3/30.
//  Copyright © 2020 XFB. All rights reserved.
//

#import "ViewController.h"
#import "EncryptionTools.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // AES - ECB 加密
    // 1> 加密过程是先加密，再base64编码
    // 2> 解密过程是先base64解码，再解密
    NSString *keystring = @"Fearless";
    
    // iv向量
    // 加密 A5/e77fDTwqd++pH2WTSbw==
    NSString *cryptResultString = [[EncryptionTools sharedEncryptionTools] encryptString:@"Miracle" keyString:keystring iv:nil];
    NSLog(@"AES_EBC加密结果 = %@", cryptResultString);
    
    // 解密
    NSString *decryptString = [[EncryptionTools sharedEncryptionTools] decryptString:@"A5/e77fDTwqd++pH2WTSbw==" keyString:keystring iv:nil];
    NSLog(@"AES_EBC解密结果 = %@", decryptString);
    
    // AES - CBC 加密 0uOegz7w8XSA3w0dCDro+A==
    uint8_t iv[8] = {1, 2, 3, 4, 5, 6, 7, 8};
    NSData *ivData = [NSData dataWithBytes:iv length:sizeof(iv)];
    NSString *cbc_EncryptString = [[EncryptionTools sharedEncryptionTools] encryptString:@"Miracle" keyString:keystring iv:ivData];
    NSLog(@"AES_CBC加密结果 = %@", cbc_EncryptString);
    
    NSString *cbc_DecryptString = [[EncryptionTools sharedEncryptionTools] decryptString:@"0uOegz7w8XSA3w0dCDro+A==" keyString:keystring iv:ivData];
    NSLog(@"AES_CBC解密结果 = %@", cbc_DecryptString);

    // DES - ECB 加密
    [EncryptionTools sharedEncryptionTools].algorithm = kCCAlgorithmDES;
    NSString *DES_ECB_EncryptString = [[EncryptionTools sharedEncryptionTools] encryptString:@"Miracle" keyString:keystring iv:nil];
    NSLog(@"DES_ECB加密字符串 = %@",DES_ECB_EncryptString);

    NSString *DES_ECB_DecryptString = [[EncryptionTools sharedEncryptionTools] decryptString:@"pNySTk5zlTk=" keyString:keystring iv:nil];
    NSLog(@"DES_ECB解密字符串 = %@",DES_ECB_DecryptString);
}

@end
