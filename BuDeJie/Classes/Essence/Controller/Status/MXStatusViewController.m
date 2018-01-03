//
//  MXStatusViewController.m
//  BuDeJie
//
//  Created by mac on 2017/12/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MXStatusViewController.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import <MJRefresh.h>
#import "MXStatusTableViewCell.h"
#import <SDImageCache.h>

@interface MXStatusViewController ()
@property (copy, nonatomic)NSString *maxtime;
@property (strong, nonatomic)NSMutableArray *statusArray;
@end

@implementation MXStatusViewController
- (MXStatusType)type {
    return MXStatusTypeAll;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(44, 0, 0, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MXStatusTableViewCell class]) bundle:nil] forCellReuseIdentifier:ID];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tabBarRepeatedClicked) name:TabBatBtnRepeatedClick object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(titleBtnRepeatedClicked) name:TitleButtonDidRepeatClicked object:nil];
    [self setUpAdLable];
    [self setUpRefresh];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.estimatedRowHeight = 200;
}

- (void)setUpRefresh{
    self.tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [self loadNewData];
        [self.tableView.mj_header endRefreshing];
    }];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    self.tableView.mj_footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma 广告
- (void)setUpAdLable {
    UILabel *adLabel = [[UILabel alloc]init];
    adLabel.frame = CGRectMake(0, 0, self.tableView.frame.size.width, 40);
    adLabel.backgroundColor = [UIColor purpleColor];
    adLabel.text = @"我是广告";
    adLabel.textAlignment = NSTextAlignmentCenter;
    self.tableView.tableHeaderView = adLabel;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)titleBtnRepeatedClicked{
    if (self.view.window == nil) return;
    if (self.tableView.scrollsToTop == NO) return;
}

- (void)tabBarRepeatedClicked{
    [self titleBtnRepeatedClicked];
}

#pragma 加载数据
- (void)loadNewData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        [responseObject writeToFile:@"/Users/mac/Desktop/status2.plist" atomically:YES];
        self.maxtime = responseObject[@"info"][@"maxtime"];
        self.statusArray = [MXStatusItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [SVProgressHUD showErrorWithStatus:@"网络错误，请稍后重试"];
    }];
}

- (void)loadMoreData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @"1";
    parameters[@"maxtime"] = self.maxtime;
    [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *moreItems = [MXStatusItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        self.maxtime = responseObject[@"info"][@"maxtime"];
        [self.statusArray addObjectsFromArray:moreItems];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [SVProgressHUD showErrorWithStatus:@"网络错误，请稍后重试"];
    }];
}

#pragma tableView-datasourse
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.statusArray.count;
}

static NSString * const ID = @"MXStatusTableViewCell";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MXStatusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    MXStatusItem *statusItem = self.statusArray[indexPath.row];
    cell.status = statusItem;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MXStatusItem *statusItem = self.statusArray[indexPath.row];
    
    return statusItem.cellHeight;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [[SDImageCache sharedImageCache]clearMemory];
}



@end
