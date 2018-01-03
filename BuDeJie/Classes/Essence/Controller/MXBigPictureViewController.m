//
//  MXBigPictureViewController.m
//  BuDeJie
//
//  Created by mac on 2017/12/18.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MXBigPictureViewController.h"
#import <UIImageView+WebCache.h>
#import <Photos/Photos.h>
#import <SVProgressHUD.h>

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
@interface MXBigPictureViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *save;
@property (weak, nonatomic) UIImageView *imageView;
- (PHFetchResult *)creatAssets;
- (PHAssetCollection *)creatCollection;
@end

@implementation MXBigPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.userInteractionEnabled = YES;
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = [UIScreen mainScreen].bounds;
    [self.view insertSubview:scrollView atIndex:0];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back:)];
    [scrollView addGestureRecognizer:tap];
    
    CGFloat bigPictureW = [UIScreen mainScreen].bounds.size.width;
    CGFloat bigPictureH = bigPictureW / self.status.width * self.status.height;
    
    UIImageView *imageView = [[UIImageView alloc]init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.status.image0] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (!image) return;
        self.save.enabled = YES;
    }];
    imageView.mx_width = bigPictureW;
    imageView.mx_height = bigPictureH;
    imageView.mx_x = 0;
    if (bigPictureH >= ScreenH) {
        imageView.mx_y = 0;
        scrollView.contentSize = CGSizeMake(0, bigPictureH);
    } else {
        imageView.mx_centerY = ScreenH * 0.5;
    }
    [scrollView addSubview:imageView];
    self.imageView = imageView;
    CGFloat maxScale = self.status.width / bigPictureW;
    if (maxScale > 1) {
        scrollView.maximumZoomScale = maxScale;
        scrollView.delegate = self;
    }
}


- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)save:(id)sender {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            //后续调用函数会和UI相关，因此这里必须放在主线程里执行，默认方法是在子线程里执行的
            if (status == PHAuthorizationStatusAuthorized) {
                [self saveImageToAlbum];
                [SVProgressHUD showSuccessWithStatus:@"保存成功！"];
            } else if (status == PHAuthorizationStatusDenied) {
                [SVProgressHUD showErrorWithStatus:@"无法访问相册，请打开相册访问权限"];
            } else if (status == PHAuthorizationStatusRestricted) {
                [SVProgressHUD showErrorWithStatus:@"系统原因无法访问相册！"];
            }
        });
        
    }];
}

#pragma 获取当想app对应的自定义相册 并返回这个相册
- (PHAssetCollection *)creatCollection {
    //获取软件名称
    NSString *title = [NSBundle mainBundle].infoDictionary[(NSString *)kCFBundleNameKey];
    //抓取所有的自定义相册
    PHFetchResult *collections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *collectoin in collections) {
        if ([collectoin.localizedTitle isEqualToString:title]) {
            return collectoin;
        }
    }
    
    //当前app对应的自定义相册还没有创建过，现在创建
    NSError *error = nil;
    __block NSString *createdCollectionID = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        createdCollectionID = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title].placeholderForCreatedAssetCollection.localIdentifier;
    } error:&error];
    
    if (error) return nil;
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[createdCollectionID] options:nil].firstObject;
}

- (PHFetchResult *)creatAssets {
    NSError *error = nil;
    __block NSString *assetID = nil;
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        assetID = [PHAssetChangeRequest creationRequestForAssetFromImage:self.imageView.image].placeholderForCreatedAsset.localIdentifier;
    } error:&error];
    if (error) return nil;
    return [PHAsset fetchAssetsWithLocalIdentifiers:@[assetID] options:nil];
}

#pragma UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

#pragma 保存图片到相册
- (void)saveImageToAlbum {
    //获得照片
    PHFetchResult *createdAssets = self.creatAssets;
    if (createdAssets == nil) {
        [SVProgressHUD showErrorWithStatus:@"保存图片失败！"];
        return;
    }
    
    //获得自定义相册
    PHAssetCollection *creatCollection = self.creatCollection;
    if (creatCollection == nil) {
        [SVProgressHUD showErrorWithStatus:@"创建相册失败！"];
        return;
    }
    
    //添加获取的照片到自定义相册
    NSError *error = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:creatCollection];
        [request insertAssets:createdAssets atIndexes:[NSIndexSet indexSetWithIndex:0]];
    } error:&error];
    
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存图片失败！"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存图片成功！"];
    }
}



@end
