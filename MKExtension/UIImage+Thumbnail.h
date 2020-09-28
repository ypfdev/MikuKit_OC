//
//  UIImage+Thumbnail.h
//  MotionCamera
//
//  Created by 原鹏飞 on 2019/9/7.
//  Copyright © 2019 Apeman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Thumbnail)

/// 获取手机相册视频封面图（尺寸200*200）
/// @param asset 相片对象
+ (UIImage *)mk_thumbnailFromAsset:(PHAsset *)asset;

/// 获取手机相册视频封面图
/// @param asset 相片对象
/// @param size 图片大小（默认）
+ (UIImage *)mk_thumbnailFromAsset:(PHAsset *)asset size:(CGSize)size;

/// 获取手机相册视频封面图（通过回调）
/// @param asset 相片对象
/// @param completionHandler 完成回调
+ (void)mk_thumbnailFromAsset:(PHAsset *)asset completionHandler:(void (^)(UIImage * _Nullable thumbnail))completionHandler;

/// 获取手机相册视频封面图（通过回调）
/// @param asset 相片对象
/// @param size 图片尺寸
/// @param completionHandler 完成回调
+ (void)mk_thumbnailFromAsset:(PHAsset *)asset size:(CGSize)size completionHandler:(void (^)(UIImage * _Nullable thumbnail))completionHandler;

/// 获取网络视频第一帧（图片默认尺寸200*200）
/// @param url 视频地址
+ (nullable UIImage *)mk_firstFrameFromVideo:(NSURL *)url;

/// 获取网络视频封面图
/// @param url 视频地址
/// @param size 图片尺寸
+ (nullable UIImage *)mk_firstFrameFromVideo:(NSURL *)url size:(CGSize)size;

/// 获取网络视频封面图（图片默认尺寸200*200）
/// @param url 视频地址
+ (nullable UIImage *)mk_thumbnailFromVideo:(NSURL *)url;

/// 获取网络视频封面图
/// @param url 视频地址
/// @param size 图片尺寸
+ (nullable UIImage *)mk_thumbnailFromVideo:(NSURL *)url size:(CGSize)size;


@end

NS_ASSUME_NONNULL_END
