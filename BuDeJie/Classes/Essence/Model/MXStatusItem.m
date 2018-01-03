//
//  MXStatusItem.m
//  BuDeJie
//
//  Created by mac on 2017/12/12.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MXStatusItem.h"

@implementation MXStatusItem

- (NSInteger)bigPicture{
    if (self.type != MXStatusTypeWord) {
        CGFloat pictureWidth = [UIScreen mainScreen].bounds.size.width - 20;
        CGFloat pictureHeight = pictureWidth * self.height / self.width;
        if (pictureHeight >= [UIScreen mainScreen].bounds.size.height) {
            return YES;
        } else {
            return NO;
        }
    } else {
        return NO;
    }
    
    
}

- (CGFloat)cellHeight {
    if (_cellHeight) return _cellHeight;
    //上部分高度
    _cellHeight += 55;
    
    //文字高度
    CGSize textMaxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, MAXFLOAT);
    NSMutableDictionary *attributeDict = [NSMutableDictionary dictionary];
    attributeDict[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    _cellHeight += [self.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributeDict context:nil].size.height;
    //中间图片高度
    if (self.type != MXStatusTypeWord) {
        CGFloat pictureWidth = [UIScreen mainScreen].bounds.size.width - 20;
        CGFloat pictureHeight = pictureWidth * self.height / self.width;
        CGFloat middleX = 10;
        CGFloat middleY = _cellHeight + 10;
        if (pictureHeight >= [UIScreen mainScreen].bounds.size.height) {
            pictureHeight = 200;
        }
        self.middleFrame = CGRectMake(middleX, middleY, pictureWidth, pictureHeight);
        _cellHeight += pictureHeight + 10;
    }
        
    //底部高度
    _cellHeight += 44;
    //间距高度
    _cellHeight += 30;
    return _cellHeight;
    
}



@end
