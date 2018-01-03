//
//  MXTagTableViewController.m
//  BuDeJie
//
//  Created by mac on 2017/12/6.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MXTagTableViewController.h"
#import "MXTagTableViewCell.h"
#import <AFNetworking/AFNetworking.h>
#import "MXCellDataItem.h"
#import <MJRefresh.h>

@interface MXTagTableViewController ()

@property (copy,nonatomic)NSArray *dataArray;

@end

@implementation MXTagTableViewController
static NSString * const ID = @"cell";

- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self.tableView registerNib:[UINib nibWithNibName:@"MXTagTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ID];
    self.title = @"推荐关注";
}

- (void)loadData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parametersDict = [NSMutableDictionary dictionary];
    parametersDict[@"a"] = @"friend_recommend";
    parametersDict[@"c"] = @"user";
    parametersDict[@"action"] = @"topic";
    [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parametersDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [responseObject writeToFile:@"/Users/mac/Documents/programming/Objective-CProgramme/2017.12.06/BuDeJie/tag.plist" atomically:YES];
        NSDictionary *tagDict = responseObject[@"top_list"];
        NSMutableArray *temp = [NSMutableArray array];
        for (NSDictionary *dict in tagDict) {
            MXCellDataItem *item = [MXCellDataItem itemWithDict:dict];
            [temp addObject:item];
        }
        self.dataArray = temp;
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MXTagTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    MXCellDataItem *item = self.dataArray[indexPath.row];
    cell.item = item;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}


@end
