//
//  MXStatusTableViewCell.m
//  BuDeJie
//
//  Created by mac on 2017/12/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MXStatusTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "MXStatusVideoView.h"
#import "MXStatusVoiceView.h"
#import "MXStautsPictureView.h"
#import "UIImageView+MXDownload.h"


@interface MXStatusTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
@property (weak, nonatomic) IBOutlet UILabel *statusText;
@property (weak, nonatomic) IBOutlet UIView *topCommentView;
@property (weak, nonatomic) IBOutlet UILabel *topCommentLabel;

@property (weak, nonatomic) MXStatusVideoView *videoView;
@property (weak, nonatomic) MXStatusVoiceView *voiceView;
@property (weak, nonatomic) MXStautsPictureView *pictureView;

@end

@implementation MXStatusTableViewCell
- (UIView *)videoView{
    if (!_videoView) {
        _videoView = [[NSBundle mainBundle]loadNibNamed:@"MXStatusVideoView" owner:nil options:nil].firstObject;
        [self addSubview:_videoView];
    }
    return _videoView;
}

- (UIView *)voiceView{
    if (!_voiceView) {
        _voiceView = [[NSBundle mainBundle]loadNibNamed:@"MXStatusVoiceView" owner:nil options:nil].firstObject;
        [self addSubview:_voiceView];
    }
    return _voiceView;
}

- (UIView *)pictureView{
    if (!_pictureView) {
        _pictureView = [[NSBundle mainBundle]loadNibNamed:@"MXStautsPictureView" owner:nil options:nil].firstObject;
        [self addSubview:_pictureView];
    }
    return _pictureView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    _iconImageView.layer.cornerRadius = self.iconImageView.bounds.size.width * 0.5;
    _iconImageView.layer.masksToBounds = YES;
}

- (void)setStatus:(MXStatusItem *)status{
    _status = status;
    self.nameLabel.text = status.name;
    self.timeLabel.text = status.passtime;
    self.statusText.text = status.text;
    
    [_iconImageView mx_setCircleHeader:status.profile_image placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    [self setUpButtonTile:self.caiBtn number:status.cai title:@"踩"];
    [self setUpButtonTile:self.dingBtn number:status.ding title:@"顶"];
    [self setUpButtonTile:self.commentBtn number:status.comment title:@"评论"];
    [self setUpButtonTile:self.shareBtn number:status.repost title:@"转发"];

    if (self.status.type == MXStatusTypeWord) {
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
    }else if (self.status.type == MXStatusTypeVideo){
        self.pictureView.hidden = YES;
        self.videoView.hidden = NO;
        self.voiceView.hidden = YES;
        self.videoView.status = status;
    }else if (self.status.type == MXStatusTypeVoice){
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        self.voiceView.hidden = NO;
        self.voiceView.status = status;
    }else if (self.status.type == MXStatusTypePicture){
        self.pictureView.hidden = NO;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.pictureView.status = status;
        
    }
}

- (void)setUpButtonTile:(UIButton *)button number:(NSInteger)number title:(NSString *)title {
    if (number > 10000) {
        [button setTitle:[NSString stringWithFormat:@"%.1f万",number / 10000.0] forState:UIControlStateNormal];
    }else if (number > 0) {
        [button setTitle:[NSString stringWithFormat:@"%zd",number] forState:UIControlStateNormal];
    }else {
        [button setTitle:title forState:UIControlStateNormal];
    }
}

- (void)setFrame:(CGRect)frame{
    frame.size.height -= 10;
    [super setFrame:frame];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.pictureView.frame = self.status.middleFrame;
    self.videoView.frame = self.status.middleFrame;
    self.voiceView.frame = self.status.middleFrame;
}

@end
