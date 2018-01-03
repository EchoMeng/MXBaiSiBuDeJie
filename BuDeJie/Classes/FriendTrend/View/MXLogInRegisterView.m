//
//  MXLogInRegisterView.m
//  BuDeJie
//
//  Created by mac on 2017/12/6.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MXLogInRegisterView.h"
@interface MXLogInRegisterView()
@property (weak, nonatomic) IBOutlet UIButton *logInBtn;
@end

@implementation MXLogInRegisterView

+ (instancetype)logInView{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

+ (instancetype)registerView{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    UIImage *bgImage = self.logInBtn.currentBackgroundImage;
    bgImage = [bgImage stretchableImageWithLeftCapWidth:bgImage.size.width * 0.5 topCapHeight:bgImage.size.height * 0.5];
    [self.logInBtn setBackgroundImage:bgImage forState:UIControlStateNormal];
}

@end
