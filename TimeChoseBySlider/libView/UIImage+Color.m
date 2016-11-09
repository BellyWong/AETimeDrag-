//
//  UIImage+Color.m
//  TimeChoseBySlider
//
//  Created by carshoel on 16/11/8.
//  Copyright © 2016年 carshoel. All rights reserved.
//

#import "UIImage+Color.h"

@implementation UIImage (Color)

+ (instancetype)imageWithColor:(UIColor *)color size:(CGSize)size{
    
    //开启上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //画图
    [color set];
    CGContextFillRect(ctx, CGRectMake(0, 0, size.width, size.height));
    //取图
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1)];
}

@end
