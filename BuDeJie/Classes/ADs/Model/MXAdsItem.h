//
//  MXAdsItem.h
//  BuDeJie
//
//  Created by mac on 2017/12/6.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MXAdsItem : NSObject
//w_picurl w h ori_curl
@property (nonatomic, strong)NSString *w_picurl;

@property (nonatomic, strong)NSString *ori_curl;

@property (nonatomic, assign)NSString *w;

@property (nonatomic, assign)NSString *h;

+ (instancetype)adsWithDict:(NSDictionary *)dict;


@end
