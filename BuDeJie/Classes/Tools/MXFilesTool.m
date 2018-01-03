//
//  MXFilesTool.m
//  BuDeJie
//
//  Created by mac on 2017/12/8.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MXFilesTool.h"

@implementation MXFilesTool
+ (void)getFileSize:(NSString *)directoryPath completion:(void(^)(NSInteger))completion{
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL isDirectory;
    BOOL isExist = [manager fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    if (!isDirectory || !isExist) {
        NSException *exception = [NSException exceptionWithName:@"pathError" reason:@"must be correct directory" userInfo:nil];
        [exception raise];
    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray *subPaths = [manager subpathsAtPath:directoryPath];
        NSInteger totalSize = 0;
        for (NSString *subPath in subPaths) {
            NSString *fullSubPath = [directoryPath stringByAppendingPathComponent:subPath];
            
            BOOL isDirectory;
            BOOL isExist = [manager fileExistsAtPath:directoryPath isDirectory:&isDirectory];
            if (!isDirectory || !isExist) continue;
            
            NSDictionary *attributeDict = [manager attributesOfItemAtPath:fullSubPath error:nil];
            totalSize += [attributeDict fileSize];
        }
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(totalSize);
            }
        });
    });
    
    
}

+ (void)removeFilesAtDirectory:(NSString *)directoryPath{
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL isDirectory;
    BOOL isExist = [manager fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    if (!isDirectory || !isExist) {
        NSException *exception = [NSException exceptionWithName:@"pathError" reason:@"must be correct directory" userInfo:nil];
        [exception raise];
    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray *subPaths = [manager subpathsAtPath:directoryPath];
        for (NSString *subPath in subPaths) {
            NSString *fullSubPath = [directoryPath stringByAppendingPathComponent:subPath];
            [manager removeItemAtPath:fullSubPath error:nil];
        }
    });
}
@end
