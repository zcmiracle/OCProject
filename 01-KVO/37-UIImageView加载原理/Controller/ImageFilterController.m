//
//  ImageFilterController.m
//  37-UIImageView加载原理
//
//  Created by XFB on 2020/4/7.
//  Copyright © 2020 XFB. All rights reserved.
//  图片过滤or滤镜

#import "ImageFilterController.h"
#import <CoreFoundation/CoreFoundation.h>

@interface ImageFilterController ()

@property (nonatomic, strong) UIImage *image;

@property (weak, nonatomic) IBOutlet UIImageView *filterImageView;

@end

@implementation ImageFilterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"图片处理";

    UIBarButtonItem *originImageButton = [[UIBarButtonItem alloc] initWithTitle:@"还原" style:UIBarButtonItemStylePlain target:self action:@selector(originalImage)];
    UIBarButtonItem *filterImageButton = [[UIBarButtonItem alloc] initWithTitle:@"过滤" style:UIBarButtonItemStylePlain target:self action:@selector(filterImage)];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:originImageButton, filterImageButton, nil];
    
    self.image =  [UIImage imageNamed:@"test.jpg"];
    _filterImageView.image = self.image;
}

// 还原图片
- (void)originalImage {
    self.filterImageView.image = self.image;
}

// 过滤图片
- (void)filterImage {
    
    CGImageRef imageRef = self.image.CGImage;
    // 1字节 = 8bit
    size_t width = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    size_t bits = CGImageGetBitsPerComponent(imageRef); // 8
    size_t bitsPerrow = CGImageGetBytesPerRow(imageRef); // width * bits
    
    // 颜色空间
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(imageRef);
    // AlphaInfo信息： RGBA AGBR RGB
    CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(imageRef);
    
    // 处理图片
    [self dealDataChar];
    
    // bitmap的数据
    CGDataProviderRef providerRef = CGImageGetDataProvider(imageRef);
    CFDataRef bitmapData = CGDataProviderCopyData(providerRef);

    NSInteger pixLength = CFDataGetLength(bitmapData);

    // 像素byte数组
    Byte *pixBuffer = CFDataGetMutableBytePtr((CFMutableDataRef) bitmapData);
    
    // RGBA 为一个单元
    for (int i = 0; i < pixLength; i += 4) {
        [self imageFilterPixBuffer:pixBuffer offset: i];
    }
    
    // 准备绘制图片
    CGContextRef contextRef = CGBitmapContextCreate(pixBuffer, width, height, bits, bitsPerrow, colorSpace, alphaInfo);
    CGImageRef filterImageRef = CGBitmapContextCreateImage(contextRef);
    UIImage *filterImage = [UIImage imageWithCGImage:filterImageRef];
    _filterImageView.image = filterImage;
}

// RGBA 为一个单元 彩色照变为黑白照
- (void)imageFilterPixBuffer:(Byte *)pixBuffer offset:(int)offset {
    int offsetR = offset;
    int offsetG = offset + 1;
    int offsetB = offset + 2;
    int offsetA = offset + 3;
    
    int red = pixBuffer[offsetR];
    int green = pixBuffer[offsetG];
    int blue = pixBuffer[offsetB];
//    int alpha = pixBuffer[offsetA];

    int gray = (red + green + blue) / 3;
    
    pixBuffer[offsetR] = gray;
    pixBuffer[offsetG] = gray;
    pixBuffer[offsetB] = gray;
}


// 疑问
- (void)dealDataChar {
    // RGBARGBA
    NSData *data = [@"1234567890" dataUsingEncoding:NSUTF8StringEncoding];
    NSInteger testLength = data.length;
    
    Byte *byteArray = (Byte *)[data bytes];
    for (NSInteger i = 0; i < testLength; i ++) {
        Byte byteChar = (Byte)byteArray[i]; //  当i=0 testChar=1
        byteChar = byteChar + 1;
        byteArray[i] = byteChar;
    }
    
    for (NSInteger i = 0; i < testLength; i++) {
        Byte testChar = (Byte)byteArray[i]; //  当i=0 testChar=1
        printf("%c", testChar);
    }
}


@end
