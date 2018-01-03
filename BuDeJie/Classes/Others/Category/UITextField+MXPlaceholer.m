//
//  UITextField+MXPlaceholer.m
//  BuDeJie
//
//  Created by mac on 2017/12/8.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "UITextField+MXPlaceholer.h"
#import <objc/message.h>

@implementation UITextField (MXPlaceholer)

+ (void)load{
    Method setPlaceholderColor = class_getInstanceMethod(self, @selector(setPlaceholder:));
    Method set_mxPlaceholderColor = class_getInstanceMethod(self, @selector(set_mxPlaceholder:));
    
    method_exchangeImplementations(setPlaceholderColor, set_mxPlaceholderColor);
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    //runtime给成员属性赋值
    objc_setAssociatedObject(self, @"placeholderColor", placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    UILabel *placeholderLabel = [self valueForKey:@"placeholderLabel"];
    placeholderLabel.textColor = placeholderColor;
}

- (UIColor *)placeholderColor{
    return  objc_getAssociatedObject(self, @"placeholderColor");
}

- (void)set_mxPlaceholder:(NSString *)placeholder{
    [self set_mxPlaceholder:placeholder];
    self.placeholderColor = self.placeholderColor;
}

@end
