//
//  MXSquareItem.h
//  BuDeJie
//
//  Created by mac on 2017/12/8.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MXSquareItem : NSObject

@property (strong,nonatomic)NSString *icon;
@property (strong,nonatomic)NSString *name;
@property (strong,nonatomic)NSString *url;
+ (instancetype)itemWithDict:(NSDictionary *)dict;
@end
