//
//  MXStatusItem.h
//  BuDeJie
//
//  Created by mac on 2017/12/12.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MXStatusItem : NSObject

typedef NS_ENUM(NSInteger, MXStatusType) {
    MXStatusTypeAll = 1,
    MXStatusTypeVideo = 41,
    MXStatusTypeWord = 29,
    MXStatusTypePicture = 10,
    MXStatusTypeVoice = 31
};

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *text;
@property (copy, nonatomic) NSString *passtime;
@property (copy, nonatomic) NSString *profile_image;

@property (copy, nonatomic) NSString *image0;
@property (copy, nonatomic) NSString *image1;
@property (copy, nonatomic) NSString *image2;
@property (assign, nonatomic) NSInteger type;
@property (assign, nonatomic) NSInteger videotime;
@property (assign, nonatomic) NSInteger voicelength;
@property (copy, nonatomic) NSString *playcount;
@property (assign, nonatomic) NSInteger is_gif;

@property (assign, nonatomic) NSInteger cai;
@property (assign, nonatomic) NSInteger ding;
@property (assign, nonatomic) NSInteger repost;
@property (assign, nonatomic) NSInteger comment;
@property (assign, nonatomic) NSInteger height;
@property (assign, nonatomic) NSInteger width;

@property (assign, nonatomic) CGFloat cellHeight;
@property (assign, nonatomic) CGRect middleFrame;
@property (assign, nonatomic) NSInteger bigPicture;
@end
