//
//  MXFilesTool.h
//  BuDeJie
//
//  Created by mac on 2017/12/8.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MXFilesTool : NSObject
+ (void)getFileSize:(NSString *)directoryPath completion:(void(^)(NSInteger))completion;
+ (void)removeFilesAtDirectory:(NSString *)directoryPath;
@end
