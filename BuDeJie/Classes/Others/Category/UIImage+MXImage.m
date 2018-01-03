//
//  UIImage+MXImage.m
//  BuDeJie
//
//  Created by mac on 2017/12/4.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "UIImage+MXImage.h"

@implementation UIImage (MXImage)

+ (UIImage *)imageWithOriginRender:(NSString *)imageName{
    UIImage *originImage = [UIImage imageNamed:imageName];
    return [originImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
}

@end
