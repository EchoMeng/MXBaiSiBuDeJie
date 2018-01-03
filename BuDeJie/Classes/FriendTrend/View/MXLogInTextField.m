//
//  MXLogInTextField.m
//  BuDeJie
//
//  Created by mac on 2017/12/8.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MXLogInTextField.h"
#import "UITextField+MXPlaceholer.h"

@implementation MXLogInTextField

- (void)awakeFromNib{
    [super awakeFromNib];
    self.tintColor = [UIColor whiteColor];
    self.placeholderColor = [UIColor lightGrayColor];
    [self addTarget:self action:@selector(textEnd) forControlEvents:UIControlEventEditingDidEnd];
    [self addTarget:self action:@selector(textBegin) forControlEvents:UIControlEventEditingDidBegin];
}

- (void)textEnd{
    self.placeholderColor = [UIColor lightGrayColor];
}

- (void)textBegin{
    self.placeholderColor = [UIColor whiteColor];
}

@end
