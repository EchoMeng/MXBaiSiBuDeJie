//
//  MXLogInRegisterViewController.m
//  BuDeJie
//
//  Created by mac on 2017/12/6.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MXLogInRegisterViewController.h"
#import "MXLogInHelpView.h"
#import "MXLogInRegisterView.h"
#import "MXLogInHelpView.h"

@interface MXLogInRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIView *logInRegisterView;
@property (weak, nonatomic) IBOutlet UIView *logInHelpView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadConstraint;

@end

@implementation MXLogInRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *loginView = [MXLogInRegisterView logInView];
    [self.logInRegisterView addSubview:loginView];
    
    UIView *registerView = [MXLogInRegisterView registerView];
    [self.logInRegisterView addSubview:registerView];
    
    UIView *fastLogInView = [MXLogInHelpView fastLogIn];
    [self.logInHelpView addSubview:fastLogInView];

}

- (IBAction)closeClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)register:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    
    self.leadConstraint.constant = self.leadConstraint.constant == 0? -[UIScreen mainScreen].bounds.size.width : 0;
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    MXLogInRegisterView *loginView = self.logInRegisterView.subviews[0];
    loginView.frame = CGRectMake(0, 0, self.logInRegisterView.bounds.size.width * 0.5, self.logInRegisterView.bounds.size.height);
    
    MXLogInRegisterView *registerView = self.logInRegisterView.subviews[1];
    registerView.frame = CGRectMake(self.logInRegisterView.bounds.size.width * 0.5, 0, self.logInRegisterView.bounds.size.width * 0.5, self.logInRegisterView.bounds.size.height);
}

@end
