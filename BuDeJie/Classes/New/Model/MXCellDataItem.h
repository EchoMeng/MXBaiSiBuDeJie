//
//  MXCellDataItem.h
//  BuDeJie
//
//  Created by mac on 2017/12/6.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MXCellDataItem : NSObject

@property (strong,nonatomic)NSString *header;
@property (strong,nonatomic)NSString *screen_name;
@property (strong,nonatomic)NSString *fans_count;

+ (instancetype)itemWithDict:(NSDictionary *)dict;

@end
