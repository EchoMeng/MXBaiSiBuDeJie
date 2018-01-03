//
//  MXSquareItem.m
//  BuDeJie
//
//  Created by mac on 2017/12/8.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MXSquareItem.h"

@implementation MXSquareItem

+ (instancetype)itemWithDict:(NSDictionary *)dict{
    MXSquareItem *item = [[MXSquareItem alloc]init];
    item.name = dict[@"name"];
    item.icon = dict[@"icon"];
    item.url = dict[@"url"];
    
    return item;
}

@end
