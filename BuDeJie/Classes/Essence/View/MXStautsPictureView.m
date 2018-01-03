//
//  MXStautsPictureView.m
//  BuDeJie
//
//  Created by mac on 2017/12/15.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MXStautsPictureView.h"
#import "UIImageView+MXDownload.h"
#import "MXBigPictureViewController.h"

@interface MXStautsPictureView()
@property (weak, nonatomic) IBOutlet UIImageView *pictureImageView;
@property (weak, nonatomic) IBOutlet UIButton *clickForOriginImage;
@property (weak, nonatomic) IBOutlet UIImageView *isgif;

@end
@implementation MXStautsPictureView
- (void)awakeFromNib{
    [super awakeFromNib];
    self.pictureImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [self.pictureImageView addGestureRecognizer:tap];
}

- (void) tap{
    MXBigPictureViewController *bigPictureVC = [[MXBigPictureViewController alloc]init];
    bigPictureVC.status = self.status;
    [self.window.rootViewController presentViewController:bigPictureVC animated:YES completion:nil];
}

- (void)setStatus:(MXStatusItem *)status{
    _status = status;
    self.isgif.hidden = !status.is_gif;
    
    [self.pictureImageView mx_setOriginImage:status.image1 thumbnailImage:status.image0 placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (self.pictureImageView.image) {
            CGFloat imageW = [UIScreen mainScreen].bounds.size.width - 20;
            CGFloat imageH = imageW / status.width * status.height;
            UIGraphicsBeginImageContext(CGSizeMake(imageW, imageH));
            [self.pictureImageView.image drawInRect:CGRectMake(0, 0, imageW, imageH)];
            self.pictureImageView.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
    }];
    
    if (status.bigPicture) {
        self.clickForOriginImage.hidden = NO;
        self.pictureImageView.contentMode = UIViewContentModeTop;
        self.pictureImageView.clipsToBounds = YES;
    } else {
        self.clickForOriginImage.hidden = YES;
        self.pictureImageView.contentMode = UIViewContentModeScaleToFill;
        self.pictureImageView.clipsToBounds = NO;
    }
}



@end
