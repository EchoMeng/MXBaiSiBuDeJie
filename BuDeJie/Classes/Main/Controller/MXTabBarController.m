//
//  MXTabBarController.m
//  BuDeJie
//
//  Created by mac on 2017/12/4.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MXTabBarController.h"
#import "MXMeViewController.h"
#import "MXNewViewController.h"
#import "MXEssenceViewController.h"
#import "MXPublishViewController.h"
#import "MXFriendTrendViewController.h"
#import "UIImage+MXImage.h"
#import "MXTabBar.h"
#import "MXNavViewController.h"

@interface MXTabBarController ()

@end

@implementation MXTabBarController
//需要完成的事情：第一：自定义tabbar（原有tabbar没有高亮状态，中间按钮不能满足）第二：创建一个修改frame属性的分类
//设置导航栏：第三：修改navigationitem，需要创建一个UIBarButtonItem分类，提供类方法

+ (void)load{
    UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedIn:self, nil];
    NSMutableDictionary *attriDict = [NSMutableDictionary dictionary];
    attriDict[NSForegroundColorAttributeName] = [UIColor blackColor];
    [tabBarItem setTitleTextAttributes:attriDict forState:UIControlStateSelected];
    
    NSMutableDictionary *attributeDict = [NSMutableDictionary dictionary];
    attributeDict[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [tabBarItem setTitleTextAttributes:attributeDict forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpAllChildViewController];
    [self setUpAllTabBarItem];
    MXTabBar *mxTabBar = [[MXTabBar alloc]init];
    [self setValue:mxTabBar forKey:@"tabBar"];
}

- (void)setUpAllTabBarItem{
    MXNavViewController *nv1 = self.childViewControllers[0];
    [nv1.tabBarItem setTitle:@"精品"];
    [nv1.tabBarItem setImage:[UIImage imageWithOriginRender:@"tabBar_essence_icon"]];
    [nv1.tabBarItem setSelectedImage:[UIImage imageWithOriginRender:@"tabBar_essence_click_icon"]];
    
    MXNavViewController *nv2 = self.childViewControllers[1];
    [nv2.tabBarItem setTitle:@"最新"];
    [nv2.tabBarItem setImage:[UIImage imageWithOriginRender:@"tabBar_new_icon"]];
    [nv2.tabBarItem setSelectedImage:[UIImage imageWithOriginRender:@"tabBar_new_click_icon"]];
    
//    MXPublishViewController *publishViewController = self.childViewControllers[2];
//    [publishViewController.tabBarItem setTitle:@"发布"];
//    [publishViewController.tabBarItem setImage:[UIImage imageWithOriginRender:@"tabBar_publish_icon"]];
//    [publishViewController.tabBarItem setSelectedImage:[UIImage imageWithOriginRender:@"tabBar_publish_click_icon"]];
    
    MXNavViewController *nv3 = self.childViewControllers[2];
    [nv3.tabBarItem setTitle:@"关注"];
    [nv3.tabBarItem setImage:[UIImage imageWithOriginRender:@"tabBar_friendTrends_icon"]];
    [nv3.tabBarItem setSelectedImage:[UIImage imageWithOriginRender:@"tabBar_friendTrends_click_icon"]];
    
    MXNavViewController *nv4 = self.childViewControllers[3];
    [nv4.tabBarItem setTitle:@"我的"];
    [nv4.tabBarItem setImage:[UIImage imageWithOriginRender:@"tabBar_me_icon"]];
    [nv4.tabBarItem setSelectedImage:[UIImage imageWithOriginRender:@"tabBar_me_click_icon"]];
}

- (void)setUpAllChildViewController{
    MXEssenceViewController *essenceViewController = [[MXEssenceViewController alloc]init];
    MXNavViewController *nv1 = [[MXNavViewController alloc]initWithRootViewController:essenceViewController];
    [self addChildViewController:nv1];
    
    MXNewViewController *newViewController = [[MXNewViewController alloc]init];
    MXNavViewController *nv2 = [[MXNavViewController alloc]initWithRootViewController:newViewController];
    [self addChildViewController:nv2];
    
//    MXPublishViewController *publishViewController = [[MXPublishViewController alloc]init];
//    [self addChildViewController:publishViewController];
    
    MXFriendTrendViewController *friendTrendViewController = [[MXFriendTrendViewController alloc]init];
    MXNavViewController *nv3 = [[MXNavViewController alloc]initWithRootViewController:friendTrendViewController];
    [self addChildViewController:nv3];
    
    
    UIStoryboard *meStoryBoard = [UIStoryboard storyboardWithName:@"MXMeViewController" bundle:nil];
    MXMeViewController *meViewController = [meStoryBoard instantiateInitialViewController];
    MXNavViewController *nv4 = [[MXNavViewController alloc]initWithRootViewController:meViewController];
    [self addChildViewController:nv4];
}

@end
