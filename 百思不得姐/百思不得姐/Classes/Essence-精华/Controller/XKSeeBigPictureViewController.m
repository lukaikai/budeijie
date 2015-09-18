//
//  XKSeeBigPictureViewController.m
//  百思不得姐
//
//  Created by MD313  on 15/9/17.
//  Copyright (c) 2015年 xiaokai. All rights reserved.
//

#import "XKSeeBigPictureViewController.h"
#import "XKTopic.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
#import <AssetsLibrary/AssetsLibrary.h>
@interface XKSeeBigPictureViewController ()<UIScrollViewDelegate>
/** 图片 */
@property (weak, nonatomic) UIImageView *imageView;
/** 相册库 */
@property (strong, nonatomic) ALAssetsLibrary *library;
@end

@implementation XKSeeBigPictureViewController
// 保存时用到的key
static NSString * const XKGroupNameKey = @"XKGroupNameKey";
// 相册中文件夹名字
static NSString * const XKDefaultGroupName = @"百思不得姐";
#pragma mark - lazy
- (ALAssetsLibrary *)library
{
    if (!_library) {
        _library = [[ALAssetsLibrary alloc] init];
    }
    return _library;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // 滚动控件
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor blackColor];
    [self.view insertSubview:scrollView atIndex:0];
    
    // 图片
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image]];
    [scrollView addSubview:imageView];
    self.imageView = imageView;
    // 图片位置尺寸
    imageView.x = 0;
    imageView.width = XKScreenW;
    imageView.height = self.topic.height * imageView.width / self.topic.width;
    if (imageView.height > XKScreenH) {
        imageView.y = 0;
        scrollView.contentSize = CGSizeMake(0, imageView.height);
    }else{
        imageView.centerY = XKScreenH * 0.5;
    }
    
    // 伸缩
    scrollView.maximumZoomScale = 2;
}
- (IBAction)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)save
{
    // 获得文件夹的名称
    __block NSString *groupName = [self groupName];
    // 图片库
    __weak ALAssetsLibrary *weakLibrary = self.library;
    XKWeakSelf
    // 创建文件夹
    [weakLibrary addAssetsGroupAlbumWithName:groupName resultBlock:^(ALAssetsGroup *group) {
        if (group) { // 新建的文件夹
            // 添加照片到新文件夹
            [weakSelf addImageToGroup:group];
        }else{ // 文件夹已存在
            [weakLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                NSString *name = [group valueForProperty:ALAssetsGroupPropertyName];
                if ([name isEqualToString:groupName]) {
                    // 是自己创建的文件夹 存入图片
                    [weakSelf addImageToGroup:group];
                    // 停止遍历
                    *stop = YES;
                } else if ([name isEqualToString:@"Camera Roll"]){ // 文件夹被用户删除
                    groupName = [groupName stringByAppendingString:@" "];
                    // 存储新文件夹名字
                    [[NSUserDefaults standardUserDefaults] setObject:groupName forKey:XKGroupNameKey];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    // 创建新文件夹
                    [weakLibrary addAssetsGroupAlbumWithName:groupName resultBlock:^(ALAssetsGroup *group) {
                        // 添加图片到文件夹
                        [weakSelf addImageToGroup:group];
                    } failureBlock:nil];
                }
            } failureBlock:nil];
        }
    } failureBlock:^(NSError *error) {
        
    }];
}
/**
 *  保存图片到指定文件夹
 */
- (void)addImageToGroup:(ALAssetsGroup *)group
{
    // 图片库
    __weak ALAssetsLibrary *weakLibrary = self.library;
    // 需要保存的图片
    CGImageRef image = self.imageView.image.CGImage;
    // 添加图片到【相机胶卷】
    [weakLibrary writeImageToSavedPhotosAlbum:image metadata:nil completionBlock:^(NSURL *assetURL, NSError *error) {
        [weakLibrary assetForURL:assetURL resultBlock:^(ALAsset *asset) {
            // 添加一张图片到自定义的文件夹中
            [group addAsset:asset];
            [SVProgressHUD showSuccessWithStatus:@"保存成功"];
        } failureBlock:nil];
    }];
}
/**
 *  文件夹名字
 */
- (NSString *)groupName
{
    // 先从沙盒中取文件夹名字
    NSString *groupName = [[NSUserDefaults standardUserDefaults] stringForKey:XKGroupNameKey];
    if (groupName == nil) { // 沙盒中没有存储任何文件夹的名字
        groupName = XKDefaultGroupName;
        
        // 存到沙盒
        [[NSUserDefaults standardUserDefaults] setObject:groupName forKey:XKGroupNameKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    return groupName;
}
#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

//- (void)getAllPhotos
//{
//    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
//    // 遍历所有的文件夹, 一个ALAssetsGroup对象就代表一个文件夹
//    [library enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
//        // 遍历文件夹内的所有多媒体文件（图片、视频）, 一个ALAsset对象就代表一张图片
//        [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
//            // 缩略图
//            XMGLog(@"%@", [UIImage imageWithCGImage:result.thumbnail]);
//            // 获得原始图片
//            //            XMGLog(@"%@", [UIImage imageWithCGImage:result.defaultRepresentation.fullResolutionImage]);
//        }];
//
//    } failureBlock:nil];
//}

/*
 相册相关
 UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
 // 通过拍照/相册获得一张图片
 //    UIImagePickerController *pick = [[UIImagePickerController alloc] init];
 ////    pick.sourceType = UIImagePickerControllerSourceTypeCamera;
 ////    pick.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
 //    pick.sourceType =UIImagePickerControllerSourceTypeSavedPhotosAlbum;
 //    [self presentViewController:pick animated:YES completion:nil];
 
 
 - (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
 {
 if (error) {
 [SVProgressHUD showErrorWithStatus:@"保存失败"];
 }else{
 [SVProgressHUD showSuccessWithStatus:@"保存成功"];
 }
 }
 */
@end
