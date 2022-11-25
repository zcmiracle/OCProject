//
//  ImageCompressController.m
//  37-UIImageView加载原理
//
//  Created by XFB on 2020/4/7.
//  Copyright © 2020 XFB. All rights reserved.
//  压缩相册图片

#import "ImageCompressController.h"

@interface ImageCompressController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    // 相册图片
    UIImage *_ablumImage;
    // png图片控件
    IBOutlet UIImageView *_pngImageView;
    // jpeg图片控件
    IBOutlet UIImageView *_jpegImageView;
}

@end

@implementation ImageCompressController

#pragma mark --- View Life Cycle
// 视图已经出现
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    _ablumImage = [UIImage imageNamed:@"test.jpg"];
    _jpegImageView.image = _ablumImage;
    
    _ablumImage = [self scaleImageWith:[UIImage imageNamed:@"test.jpg"] imageSize:_pngImageView.frame.size];
    
    if (_ablumImage) {
        [self loadImageData];
    }
}

- (void)loadImageData {
    // PNG 文件属性格式并不会被压缩，压缩的是图片内容(像素)
    NSData *pngImageData = UIImagePNGRepresentation(_ablumImage);
    NSData *jpegImageData = UIImageJPEGRepresentation(_ablumImage, 0.1);
    
    _pngImageView.image = [UIImage imageWithData:pngImageData];
    _jpegImageView.image = [UIImage imageWithData:jpegImageData];
    
    NSLog(@"---png：%@", [self imageDataLength:pngImageData.length]);
    NSLog(@"---jpeg：%@", [self imageDataLength:jpegImageData.length]);
    
    [self saveImageCompressToLocal:@"compress.png" fromData:pngImageData];
    [self saveImageCompressToLocal:@"compress.jpeg" fromData:jpegImageData];
}

- (NSString *)imageDataLength:(NSInteger)length {
    if (length > 1024 * 1024) {
        NSInteger MB = length / (1024 * 1024);
        NSInteger KB = (length % (1024 * 1024)) / 1024;
        return [NSString stringWithFormat:@"%ldMB%ldKB", (long)MB, (long)KB];
    } else {
       return [NSString stringWithFormat:@"%ldKB", length/1024];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"图片压缩";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"相册" style:UIBarButtonItemStylePlain target:self action:@selector(openAlbum:)];
}


// bitmap
- (UIImage *)scaleImageWith:(UIImage *)image imageSize:(CGSize)imageSize {
    // 获取当前上下文
    UIGraphicsBeginImageContext(imageSize);
    [image drawInRect:CGRectMake(0, 0, imageSize.width, imageSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

// 保存压缩的图片到本地
- (void)saveImageCompressToLocal:(NSString *)fileName fromData:(NSData *)data {
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    filePath = [filePath stringByAppendingPathComponent:fileName];
    if ([data writeToFile:filePath atomically:YES]) {
        NSLog(@"写入成功Success!!!");
    }
}

- (IBAction)openAlbum:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark --- UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSLog(@"%s", __func__);
    
    _ablumImage = [info valueForKey:UIImagePickerControllerOriginalImage];
    [self loadImageData];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    NSLog(@"%s", __func__);
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
