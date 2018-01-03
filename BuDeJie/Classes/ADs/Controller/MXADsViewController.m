//
//  MXADsViewController.m
//  BuDeJie
//
//  Created by mac on 2017/12/5.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MXADsViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "MXAdsItem.h"
#import "MXTabBarController.h"



#define MXScreenH [UIScreen mainScreen].bounds.size.height

#define code2 @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"


@interface MXADsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *lunchImageView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) UIImageView *adImageView;
@property (strong, nonatomic) MXAdsItem *adItem;
@property (weak, nonatomic) IBOutlet UIButton *jumpButton;
@property (weak, nonatomic) NSTimer *timer;

@end

@implementation MXADsViewController

- (UIImageView *)adImageView{
    if (!_adImageView) {
        UIImageView *adImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:adImageView];
        adImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        [adImageView addGestureRecognizer:tap];
        _adImageView = adImageView;
    }
    return _adImageView;
}

- (void)tap{
    NSURL *url = [NSURL URLWithString:self.adItem.ori_curl];
    UIApplication *app = [UIApplication sharedApplication];
    if ([app canOpenURL:url]) {
        [app openURL:url];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpLunchImage];
    [self loadADData];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
}

- (void)timeChange{
    static int i = 3;
    if (i == 0 ) {
        [self jumpClick:nil];
    }
    i--;
    [self.jumpButton setTitle:[NSString stringWithFormat:@"跳转（%d秒）",i] forState:UIControlStateNormal];
}

- (IBAction)jumpClick:(UIButton *)sender {
    MXTabBarController *tabBarController = [[MXTabBarController alloc]init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarController;
    [self.timer invalidate];

}


- (void)loadADData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"code2"] = code2;
    [manager GET:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [responseObject writeToFile:@"/Users/mac/Documents/programming/Objective-CProgramme/2017.12.06/BuDeJie/ads.plist" atomically:YES];
        //解析数据
        NSDictionary *adDict = [responseObject[@"ad"] lastObject];
        //w_picurl w h ori_curl
        MXAdsItem *adItem = [MXAdsItem adsWithDict:adDict];
        _adItem = adItem;
        [self setUpAdImage];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

- (void)setUpAdImage{
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.adItem.w_picurl]]];
    CGFloat height = [UIScreen mainScreen].bounds.size.width * [self.adItem.h doubleValue]/ [self.adItem.w doubleValue];
    self.adImageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, height);
    self.adImageView.image = image;
}

- (void)setUpLunchImage{
    if (MXScreenH == 736) {
        self.lunchImageView.image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
    }else if (MXScreenH == 667){
        self.lunchImageView.image = [UIImage imageNamed:@"LaunchImage-800-667h@2x"];
    }else if (MXScreenH == 568){
        self.lunchImageView.image = [UIImage imageNamed:@"LaunchImage-568h@2x"];
    }
}

@end
