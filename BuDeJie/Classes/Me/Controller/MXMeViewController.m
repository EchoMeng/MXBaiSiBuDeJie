//
//  MXMeViewController.m
//  BuDeJie
//
//  Created by mac on 2017/12/4.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MXMeViewController.h"
#import "UIBarButtonItem+MXItem.h"
#import "MXSettingTableViewController.h"
#import "MXMeCollectionViewCell.h"
#import <AFNetworking/AFNetworking.h>
#import "UIView+MXFrame.h"
#import "MXWebViewController.h"


#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height


@interface MXMeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong,nonatomic)NSArray *dataArray;
@property (strong,nonatomic)UICollectionView *collectionView;
@end

@implementation MXMeViewController
static NSString * const ID = @"cell";
static NSInteger const cols = 4;
static NSInteger const margin = 1;
#define itemWH  (ScreenW - margin * (cols - 1)) / cols

- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavBar];
    [self setUpFootView];
    [self loadData];
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);

}

#pragma 请求数据
- (void)loadData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";
    [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *dataArray = responseObject[@"square_list"];
        NSMutableArray *temp = [NSMutableArray array];
        for (NSDictionary *dict in dataArray) {
            MXSquareItem *item = [MXSquareItem itemWithDict:dict];
            [temp addObject:item];
        }
        self.dataArray = temp;
        NSInteger rowCount = (self.dataArray.count - 1) / cols + 1;
        self.collectionView.mx_height = itemWH * rowCount;
        self.tableView.tableFooterView = self.collectionView;
        [self.collectionView reloadData];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}

#pragma UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MXMeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.item = self.dataArray[indexPath.row];
    
    return cell;
}

#pragma UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MXSquareItem *item = self.dataArray[indexPath.row];
    if (![item.url containsString:@"http"]) return;
    MXWebViewController *webViewController = [[MXWebViewController alloc]init];
    webViewController.url = item.url;
    webViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webViewController animated:YES];
}

#pragma 设置导航栏

- (void)setUpNavBar{
    self.navigationItem.title = @"我的";
    
    UIBarButtonItem *rightButton1 = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"mine-setting-icon"] highImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:@selector(setUpDefault)];
    UIBarButtonItem *rightButton2 = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"mine-moon-icon"] selectedImage:[UIImage imageNamed:@"mine-moon-icon-click"] target:self action:@selector(setNightMode:)];
    
    self.navigationItem.rightBarButtonItems = @[rightButton1,rightButton2];
}

- (void)setUpDefault{
    MXSettingTableViewController *settingViewController = [[MXSettingTableViewController alloc]init];
    settingViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:settingViewController animated:YES];
}

- (void)setNightMode:(UIButton *)button{
    button.selected = !button.selected;
}

- (void)setUpFootView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];

    flowLayout.itemSize = CGSizeMake(itemWH, itemWH);
    flowLayout.minimumInteritemSpacing = margin;
    flowLayout.minimumLineSpacing = margin;
    
    
    UICollectionView *meCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 300) collectionViewLayout:flowLayout];
    self.tableView.tableFooterView = meCollectionView;
    meCollectionView.backgroundColor = self.tableView.backgroundColor;
    meCollectionView.dataSource = self;
    meCollectionView.delegate = self;
    meCollectionView.scrollEnabled = NO;
    
    [meCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MXMeCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:ID];
    _collectionView = meCollectionView;
}

@end
