//
//  MXSettingTableViewController.m
//  BuDeJie
//
//  Created by mac on 2017/12/5.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MXSettingTableViewController.h"
#import "MXFilesTool.h"
#import <SVProgressHUD.h>

@interface MXSettingTableViewController ()

@property (assign, nonatomic)NSInteger totleSize;

@end

@implementation MXSettingTableViewController

static NSString *const ID = @"cell";
#define CachePath NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    self.title = @"设置";
    [SVProgressHUD showWithStatus:@"正在计算缓存大小..."];
    
    [MXFilesTool getFileSize:CachePath completion:^(NSInteger totalSize) {
        _totleSize = totalSize;
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.textLabel.text = [self getSizeString];
    
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [MXFilesTool removeFilesAtDirectory:CachePath];
    _totleSize = 0;
    [self.tableView reloadData];
}

- (NSString *)getSizeString{
    NSString *sizeString = @"清除缓存";
    NSInteger totalSize = self.totleSize;
    if (totalSize > 1000 * 1000) {
        CGFloat sizeMB = totalSize / 1000.0 / 1000.0;
        sizeString = [NSString stringWithFormat:@"%@(%.1fMB)",sizeString,sizeMB];
    }else if (totalSize > 1000){
        CGFloat sizeKB = totalSize / 1000.0;
        sizeString = [NSString stringWithFormat:@"%@(%.1fKB)",sizeString,sizeKB];
    }else if(totalSize > 0){
        sizeString = [NSString stringWithFormat:@"%@(%.ldB)",sizeString,totalSize];
    }
    return sizeString;
}

@end
