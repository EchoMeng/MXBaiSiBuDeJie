//
//  MXTagTableViewCell.m
//  BuDeJie
//
//  Created by mac on 2017/12/6.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MXTagTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "UIImageView+MXDownload.h"

@interface MXTagTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@end

@implementation MXTagTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setItem:(MXCellDataItem *)item{
//    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:item.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    [_iconImageView mx_setCircleHeader:item.header placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    _nameLabel.text = item.screen_name;
    if ([item.fans_count intValue] > 10000) {
        float count = item.fans_count.intValue / 10000.0;
        NSString *numStr = [NSString stringWithFormat:@"已有%.1f万人关注",count];
        [numStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
        _numLabel.text = numStr;
        
    }else{
        _numLabel.text = [NSString stringWithFormat:@"已有%@人关注",item.fans_count];
    }
}

@end
