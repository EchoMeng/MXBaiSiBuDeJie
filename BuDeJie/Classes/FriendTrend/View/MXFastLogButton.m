//
//  MXFastLogButton.m
//  BuDeJie
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MXFastLogButton.h"
#import "UIView+MXFrame.h"

@implementation MXFastLogButton

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.mx_y = 0;
    self.imageView.mx_centerX = self.mx_width * 0.5;
    
    self.titleLabel.mx_y = self.mx_height - self.titleLabel.mx_height-40;
    [self.titleLabel sizeToFit];
    self.titleLabel.mx_centerX = self.mx_width * 0.5;
}
@end
