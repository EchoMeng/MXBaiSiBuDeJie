//
//  MXEssenceViewController.m
//  BuDeJie
//
//  Created by mac on 2017/12/4.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MXEssenceViewController.h"
#import "UIBarButtonItem+MXItem.h"
#import "MXTitleButton.h"
#import "UIView+MXFrame.h"
#import "MXAllTableViewController.h"
#import "MXVideoTableViewController.h"
#import "MXWordTableViewController.h"
#import "MXVoiceTableViewController.h"
#import "MXPictureTableViewController.h"


#define RandomColor [UIColor colorWithRed:arc4random() % 255 / 255.0 green:arc4random() % 255 / 255.0 blue:arc4random() % 255 / 255.0 alpha:arc4random() % 255 / 255.0]
@interface MXEssenceViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic)UIView *titleBar;
@property (weak, nonatomic)UIScrollView *scrollView;
@property (weak, nonatomic)UIButton *selectedBtn;
@property (weak, nonatomic)UIView *underlineView;
@end

@implementation MXEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavBar];
    [self setUpAllChildViewController];
    [self setUpScrollView];
    [self setUpTitleBar];
    [self addChildViewToScrollView];
   
}

- (void)setUpAllChildViewController {
    [self addChildViewController:[[MXAllTableViewController alloc]init]];
    [self addChildViewController:[[MXVideoTableViewController alloc]init]];
    [self addChildViewController:[[MXVoiceTableViewController alloc]init]];
    [self addChildViewController:[[MXPictureTableViewController alloc]init]];
    [self addChildViewController:[[MXWordTableViewController alloc]init]];
}

- (void)setUpTitleBar{
    UIView *titleBar = [[UIView alloc]init];
    titleBar.frame = CGRectMake(0, 64, self.view.frame.size.width, 44);
    titleBar.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.7];
    [self.view addSubview:titleBar];
    _titleBar = titleBar;
    [self setUpTitleButton];
    [self setUpUnderLine];
    
}

- (void)setUpUnderLine {
    UIView *underlineView = [[UIView alloc]init];
    [self.selectedBtn.titleLabel sizeToFit];
    CGFloat height = 2;
    CGFloat y = self.selectedBtn.frame.size.height - 2;
    CGFloat width = self.selectedBtn.titleLabel.frame.size.width;
    
    underlineView.mx_y = y;
    underlineView.mx_width = width + 10;
    underlineView.mx_height = height;
    underlineView.mx_centerX= self.selectedBtn.mx_centerX;
    underlineView.backgroundColor = [UIColor redColor];
    [self.titleBar addSubview:underlineView];
    self.underlineView = underlineView;
}

- (void)setUpTitleButton {
    NSArray *titleArray = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    NSInteger count = 5;
    CGFloat buttonW = self.view.bounds.size.width / count;
    CGFloat buttonH = self.titleBar.bounds.size.height;
    for (int i = 0; i < count; i++) {
        MXTitleButton *titleButton = [MXTitleButton buttonWithType:UIButtonTypeCustom];
        [titleButton setTitle:titleArray[i] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        CGFloat x = buttonW  * i;
        titleButton.frame = CGRectMake(x, 0, buttonW, buttonH);
        [titleButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0) {
            titleButton.selected = YES;
            self.selectedBtn = titleButton;
        }
        
        [self.titleBar addSubview:titleButton];
    }
}

- (void)btnClick:(UIButton *)button{
    if (self.selectedBtn == button) {
        [[NSNotificationCenter defaultCenter]postNotificationName:TitleButtonDidRepeatClicked object:nil];
    }
    
    
    self.selectedBtn.selected = NO;
    button.selected = YES;
    self.selectedBtn = button;
    self.underlineView.mx_centerX = self.selectedBtn.center.x;
    NSInteger index = [self.titleBar.subviews indexOfObject:button];
    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width * index, self.scrollView.contentOffset.y);
    [self addChildViewToScrollView];
    
    
    for (int i = 0; i < self.childViewControllers.count; i++) {
        UIViewController *viewController = self.childViewControllers[i];
        if (!viewController.isViewLoaded) continue;
        UIScrollView *childView = (UIScrollView *)viewController.view;
        if (![childView isKindOfClass:[UIScrollView class]]) continue;
        childView.scrollsToTop =(index == i);
    }
    
}

- (void)setUpScrollView{
    UIScrollView *scrolView = [[UIScrollView alloc]init];
    self.automaticallyAdjustsScrollViewInsets = NO;
    scrolView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    scrolView.showsHorizontalScrollIndicator = NO;
    scrolView.showsVerticalScrollIndicator = NO;
    NSInteger count = self.childViewControllers.count;
    scrolView.contentSize = CGSizeMake(self.view.bounds.size.width * count, 0);
    scrolView.pagingEnabled = YES;
    scrolView.delegate = self;
    _scrollView = scrolView;
    [self.view addSubview:scrolView];
}

- (void)addChildViewToScrollView{
    NSInteger i = [self.titleBar.subviews indexOfObject:self.selectedBtn];
    UIViewController *childVC = self.childViewControllers[i];
    if (childVC.isViewLoaded) return;
    UIView *childView = childVC.view;
    CGFloat x = [UIScreen mainScreen].bounds.size.width * i;
    CGFloat width = self.scrollView.mx_width;
    CGFloat height = self.scrollView.mx_height;
    childView.frame = CGRectMake(x, 0, width, height);
    childView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0];
    [self.scrollView addSubview:childView];
}


- (void)setUpNavBar{
    UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.titleView = imageV;
    
    UIBarButtonItem *leftButton = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"nav_item_game_icon"] highImage:[UIImage imageNamed:@"nav_item_game_click_icon"] target:self action:@selector(game)];
    self.navigationItem.leftBarButtonItem = leftButton;
    UIBarButtonItem *rightButton = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationButtonRandom"] highImage:[UIImage imageNamed:@"navigationButtonRandomClick"] target:self action:@selector(random)];
    self.navigationItem.leftBarButtonItem = leftButton;
    self.navigationItem.rightBarButtonItem = rightButton;
    
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    UIButton *button = self.titleBar.subviews[index];
    [self btnClick:button];
}

- (void)game{
    NSLog(@"%s",__func__);
}

- (void)random{
    NSLog(@"%s",__func__);
}
@end
