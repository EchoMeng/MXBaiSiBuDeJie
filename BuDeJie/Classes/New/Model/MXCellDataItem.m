//
//  MXCellDataItem.m
//  BuDeJie
//
//  Created by mac on 2017/12/6.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MXCellDataItem.h"

@implementation MXCellDataItem
+ (instancetype)itemWithDict:(NSDictionary *)dict{
    MXCellDataItem *item = [[MXCellDataItem alloc]init];
    item.header = dict[@"header"];
    item.fans_count = dict[@"fans_count"];
    item.screen_name = dict[@"screen_name"];
    
    return item;
}

@end
