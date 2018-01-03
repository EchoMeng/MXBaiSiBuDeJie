//
//  MXStatusVoiceView.m
//  BuDeJie
//
//  Created by mac on 2017/12/15.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MXStatusVoiceView.h"
#import "UIImageView+MXDownload.h"
#import "MXBigPictureViewController.h"

@interface MXStatusVoiceView()
@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoLengthLabel;


@end

@implementation MXStatusVoiceView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.videoImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [self.videoImageView addGestureRecognizer:tap];
}

- (void) tap{
    MXBigPictureViewController *bigPictureVC = [[MXBigPictureViewController alloc]init];
    bigPictureVC.status = self.status;
    [self.window.rootViewController presentViewController:bigPictureVC animated:YES completion:nil];
}

- (void)setStatus:(MXStatusItem *)status{
    _status = status;
    if (status.playcount.integerValue > 10000) {
        self.playCountLabel.text = [NSString stringWithFormat:@"已播放%.2f万次",status.playcount.integerValue / 10000.0];
    }else{
        self.playCountLabel.text = [NSString stringWithFormat:@"已播放%@次",status.playcount];
    }
    self.videoLengthLabel.text = [NSString stringWithFormat:@"%02zd : %02zd",status.voicelength / 60, status.voicelength % 60];
    //根据网络状态加载图片
    [self.videoImageView mx_setOriginImage:status.image1 thumbnailImage:status.image0 placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (!image) return;
    }];
    
    
}

@end
