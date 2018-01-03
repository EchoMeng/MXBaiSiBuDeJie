//
//  UIImageView+MXDownload.m
//  BuDeJie
//
//  Created by mac on 2017/12/17.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "UIImageView+MXDownload.h"
#import <AFNetworkReachabilityManager.h>
#import <UIImageView+WebCache.h>




@implementation UIImageView (MXDownload)


//typedef void(^SDExternalCompletionBlock)(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL);
- (void)mx_setOriginImage:(NSString *)originImage thumbnailImage:(NSString *)thumbnailImage placeholderImage:(UIImage *)placeholderImage completed:(SDExternalCompletionBlock)completedBlock{
    UIImage *originalImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:originImage];
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    if (originalImage) {
        self.image = originalImage;
        completedBlock(originalImage, nil, 0, [NSURL URLWithString:originImage]);
    } else {
        if (manager.isReachableViaWiFi) {
            [self sd_setImageWithURL:[NSURL URLWithString:originImage] placeholderImage:placeholderImage];
        }else if (manager.isReachableViaWWAN){
            BOOL downloadOriginImageWhen3GOr4G = YES;
            if (downloadOriginImageWhen3GOr4G) {
                [self sd_setImageWithURL:[NSURL URLWithString:originImage] placeholderImage:placeholderImage];
            } else {
                [self sd_setImageWithURL:[NSURL URLWithString:thumbnailImage] placeholderImage:placeholderImage];
            }
        }else { //没有网络 显示缩略图（如果缩略图已经下载）或者nil占位图
            UIImage *smallImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:thumbnailImage];
            if (smallImage) {
                self.image = smallImage;
                completedBlock(originalImage, nil, 0, [NSURL URLWithString:thumbnailImage]);
            } else {
                self.image = placeholderImage;
            }
        }
    }
}

- (void)mx_setCircleHeader:(NSString *)originImage placeholderImage:(UIImage *)placeholderimage {
    [self sd_setImageWithURL:[NSURL URLWithString:originImage] placeholderImage:placeholderimage options:0 completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (!image) return;
        self.layer.cornerRadius = self.frame.size.width * 0.5;
        self.layer.masksToBounds = YES;
    }];
    
    
}
@end
