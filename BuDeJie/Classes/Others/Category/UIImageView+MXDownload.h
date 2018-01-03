//
//  UIImageView+MXDownload.h
//  BuDeJie
//
//  Created by mac on 2017/12/17.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIImageView+WebCache.h>

@interface UIImageView (MXDownload)
- (void)mx_setOriginImage:(NSString *)originImage thumbnailImage:(NSString *)thumbnailImage placeholderImage:(UIImage *)placeholderImage completed:(SDExternalCompletionBlock)completedBlock;

- (void)mx_setCircleHeader:(NSString *)originImage placeholderImage:(UIImage *)placeholderimage;
@end
