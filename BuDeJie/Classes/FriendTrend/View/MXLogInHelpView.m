//
//  MXLogInHelpView.m
//  BuDeJie
//
//  Created by mac on 2017/12/6.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MXLogInHelpView.h"

@implementation MXLogInHelpView

+ (instancetype)fastLogIn{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

@end
