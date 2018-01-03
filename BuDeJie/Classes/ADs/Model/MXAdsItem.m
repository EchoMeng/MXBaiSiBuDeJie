//
//  MXAdsItem.m
//  BuDeJie
//
//  Created by mac on 2017/12/6.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MXAdsItem.h"

@implementation MXAdsItem

+ (instancetype)adsWithDict:(NSDictionary *)dict{
    MXAdsItem *adItem = [[MXAdsItem alloc]init];
    adItem.ori_curl = dict[@"ori_curl"];
    adItem.w_picurl = dict[@"w_picurl"];
    adItem.w = dict[@"w"];
    adItem.h = dict[@"h"];
    return adItem;
}

@end
