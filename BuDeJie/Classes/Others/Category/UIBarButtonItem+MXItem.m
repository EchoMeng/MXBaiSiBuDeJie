//
//  UIBarButtonItem+MXItem.m
//  BuDeJie
//
//  Created by mac on 2017/12/5.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "UIBarButtonItem+MXItem.h"

@implementation UIBarButtonItem (MXItem)

+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action{
    UIButton *navButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [navButton setImage:image forState:UIControlStateNormal];
    [navButton setImage:highImage forState:UIControlStateHighlighted];
    [navButton sizeToFit];
    [navButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView *navView = [[UIView alloc]initWithFrame:navButton.bounds];
    [navView addSubview:navButton];
    return [[UIBarButtonItem alloc]initWithCustomView:navView];
}

+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage target:(id)target action:(SEL)action{
    UIButton *navButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [navButton setImage:image forState:UIControlStateNormal];
    [navButton setImage:selectedImage forState:UIControlStateSelected];
    [navButton sizeToFit];
    [navButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView *navView = [[UIView alloc]initWithFrame:navButton.bounds];
    [navView addSubview:navButton];
    return [[UIBarButtonItem alloc]initWithCustomView:navView];
}

+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage title:(NSString *)title target:(id)target action:(SEL)action{
    UIButton *navButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [navButton setImage:image forState:UIControlStateNormal];
    [navButton setImage:highImage forState:UIControlStateHighlighted];
    [navButton setTitle:title forState:UIControlStateNormal];
    [navButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [navButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [navButton sizeToFit];
    navButton.contentEdgeInsets = UIEdgeInsetsMake(0, -18, 0, 18);
    [navButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView *navView = [[UIView alloc]initWithFrame:navButton.bounds];
    [navView addSubview:navButton];
    return [[UIBarButtonItem alloc]initWithCustomView:navView];
}

@end
