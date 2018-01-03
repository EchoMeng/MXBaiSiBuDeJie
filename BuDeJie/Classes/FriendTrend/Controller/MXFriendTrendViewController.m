//
//  MXFriendTrendViewController.m
//  BuDeJie
//
//  Created by mac on 2017/12/4.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MXFriendTrendViewController.h"
#import "UIBarButtonItem+MXItem.h"
#import "MXLogInRegisterViewController.h"

@interface MXFriendTrendViewController ()

@end

@implementation MXFriendTrendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavBar];
}

- (void)setUpNavBar{
    self.navigationItem.title = @"我的关注";
    UIBarButtonItem *leftButton = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] highImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] target:self action:@selector(addFriends)];
    self.navigationItem.leftBarButtonItem = leftButton;
}

- (IBAction)logInRegisterClick:(UIButton *)sender {
    MXLogInRegisterViewController *logResViewController = [[MXLogInRegisterViewController alloc]init];
    [self presentViewController:logResViewController animated:YES completion:nil];
}

- (void)addFriends{
    NSLog(@"%s",__func__);
}


@end
