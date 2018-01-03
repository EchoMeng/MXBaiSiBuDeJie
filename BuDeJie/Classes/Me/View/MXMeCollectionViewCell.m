//
//  MXMeCollectionViewCell.m
//  BuDeJie
//
//  Created by mac on 2017/12/8.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MXMeCollectionViewCell.h"
#import <UIImageView+WebCache.h>
@interface MXMeCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


@end

@implementation MXMeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setItem:(MXSquareItem *)item{
    _item = item;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:item.icon]];
    _nameLabel.text = item.name;
}


@end
