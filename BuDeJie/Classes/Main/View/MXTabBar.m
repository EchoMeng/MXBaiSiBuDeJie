//
//  MXTabBar.m
//  BuDeJie
//
//  Created by mac on 2017/12/5.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MXTabBar.h"
#import "UIView+MXFrame.h"

@interface MXTabBar()

@property (weak, nonatomic)UIButton *plusButton;
@property (weak, nonatomic)UIControl *selectedButton;

@end

@implementation MXTabBar

- (UIButton *)plusButton{
    if (!_plusButton) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [btn sizeToFit];
        [self addSubview:btn];
        _plusButton = btn;
    }
    return _plusButton;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self setUpMTabBarButton];
}

- (void)setUpMTabBarButton{
    NSInteger count = self.items.count;
    CGFloat tabBarW = self.frame.size.width / (count + 1);
    int i = 0;
    for (UIControl *tabBarButton in self.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (i == 2) {
                i++;
            }
            tabBarButton.mx_x = tabBarW * i;
            i++;
            
            
            [tabBarButton addTarget:self action:@selector(tabBatBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            if (i == 0 && self.selectedButton == nil) {
                self.selectedButton = tabBarButton;
            }
        }
    }
    self.plusButton.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
}

- (void)tabBatBtnClick:(UIControl *)tabBatBtn{
    if (self.selectedButton == tabBatBtn) {
        [self tabBatBtnRepeatedClick:tabBatBtn];
    }
    self.selectedButton = tabBatBtn;
}

- (void)tabBatBtnRepeatedClick:(UIControl *)tabBarButton{
    [[NSNotificationCenter defaultCenter]postNotificationName:TabBatBtnRepeatedClick object:nil];
}

@end
