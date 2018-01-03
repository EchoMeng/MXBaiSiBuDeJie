//
//  MXNewViewController.m
//  BuDeJie
//
//  Created by mac on 2017/12/4.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MXNewViewController.h"
#import "UIBarButtonItem+MXItem.h"
#import "MXTagTableViewController.h"

@interface MXNewViewController ()

@end

@implementation MXNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self setUpNavBar];
}

- (void)setUpNavBar{
    UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.titleView = imageV;

    UIBarButtonItem *leftButton = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"MainTagSubIcon"] highImage:[UIImage imageNamed:@"MainTagSubIconClick"] target:self action:@selector(mainTag)];
    self.navigationItem.leftBarButtonItem = leftButton;
}

- (void)mainTag{
    MXTagTableViewController *tagViewController = [[MXTagTableViewController alloc]init];
    tagViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:tagViewController animated:YES];
}
@end
