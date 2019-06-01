//
//  UIImage+Category.m
//  Odin-UC
//
//  Created by zlm on 2017/8/15.
//  Copyright © 2017年 yealing. All rights reserved.
//

#import "UIImage+Category.h"

@implementation UIImage (Category)
- (UIImage *)imageGrayTranslate
{

    int width = self.size.width;
    int height = self.size.height;

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate(nil, width, height, 8, 0, colorSpace, kCGImageAlphaNone);
    CGColorSpaceRelease(colorSpace);
    if (context == NULL) {
        return nil;
    }
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), self.CGImage);
    CGImageRef grayImageRef = CGBitmapContextCreateImage(context);
    UIImage* grayImage = [UIImage imageWithCGImage:grayImageRef];
    CGContextRelease(context);
    CFRelease(grayImageRef);
    return grayImage;
}



- (UIImage *)addFilter:(NSString *)filterName
{
    //将UIImage转换成CIImage
    CIImage *ciImage = [[CIImage alloc] initWithImage:self];
    
    //创建滤镜
    CIFilter *filter = [CIFilter filterWithName:filterName keysAndValues:kCIInputImageKey, ciImage, nil];
    
    //已有的值不变，其他的设为默认值
    [filter setDefaults];
    
    [EAGLContext setCurrentContext:nil];
    
    //获取绘制上下文
    CIContext *context = [CIContext contextWithOptions:nil];
    
    //渲染并输出CIImage
    CIImage *outputImage = [filter outputImage];
    
    //创建CGImage句柄
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
    
    //获取图片
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    
    //释放CGImage句柄
    CGImageRelease(cgImage);
    cgImage = nil;
    return image;
}
@end
